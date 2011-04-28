From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 19:45:38 +0100
Subject: [PATCH] ARM: The mandatory barrier rmb() must be a dsb() in
	for device accesses
In-Reply-To: <BANLkTimh_TD-6gvbYC4UBCmqvkH8DpbKpQ@mail.gmail.com>
References: <20110325101651.27120.56045.stgit@e102109-lin.cambridge.arm.com>
	<AANLkTi=vx7fttc0B08dcfB_s9ya-98Rt-=a8Hr0QGvsM@mail.gmail.com>
	<1301412104.583.85.camel@e102109-lin.cambridge.arm.com>
	<BANLkTi=SgC3sT5aHpFc8Yi-JZrc1PPcVwA@mail.gmail.com>
	<BANLkTi=37p-BWpzF2KT4J8PO+xEWrRjDfA@mail.gmail.com>
	<BANLkTikcy_eut-HGexziTnoUcXOPLdyVfA@mail.gmail.com>
	<BANLkTin4rfDMUB-Fa=AsL==SfJgaY0C2Zw@mail.gmail.com>
	<BANLkTimh_TD-6gvbYC4UBCmqvkH8DpbKpQ@mail.gmail.com>
Message-ID: <20110428184538.GL17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, what am I supposed to do with 6870/1 (rmb) and the wmb patch?
One or other is wrong - they certainly are not both correct as rmb()
can not be stronger than wmb().

On Mon, Apr 11, 2011 at 01:43:35PM +0800, Ming Lei wrote:
> Hi Catalin,
> 
> 2011/4/10 Catalin Marinas <catalin.marinas@arm.com>:
> > On 9 April 2011 20:03, Ming Lei <tom.leiming@gmail.com> wrote:
> >> 2011/4/9 Catalin Marinas <catalin.marinas@arm.com>:
> >>> Probably the above document isn't comprehensive enough. It mainly
> >>> targets memory ordering between processors. I think another example
> >>> that mentions DSB is the mailbox scenario.
> >>
> >> I also saw this example of 8.1, but I don't think it is related with
> >> linux read memory barrier, see below:
> >>
> >> ? ? ? ?- 8.1 requires that the 'STR R5, [R1]' in P1 is completed before
> >> ? ? ? ?'LDR R5, [R1]' in P2;
> >
> > Its not related to the read memory barrier but it refers to ordering
> > between accesses to Normal memory and Device memory. The mailbox here
> > at [R4] can be a device. I'm copying the relevant code here for others
> > following this thread:
> >
> > P1:
> > ? ?STR R5, [R1] ; message stored to shared memory location
> > ? ?DSB [ST]
> > ? ?STR R1, [R4] ; R4 contains the address of a mailbox
> >
> > P2:
> > ? ?; interrupt service routine
> > ? ?LDR R5, [R1]
> >
> >> ? ? ? ?- Documentation/memory-barriers.txt said:
> >> ? ? ? ?1), Memory barriers are such interventions. ?They impose a
> >> ? ? ? ?perceived partial ordering over the memory operations on either
> >> ? ? ? ?side of the barrier.
> >>
> >> ? ? ? ?2),There is no guarantee that any of the memory accesses specified
> >> ? ? ? ?before a memory barrier will be _complete_ by the completion of a
> >> ? ? ? ?memory barrier instruction; the barrier can be considered to draw a
> >> ? ? ? ?line in that CPU's access queue that accesses of the appropriate type
> >> ? ? ? ?may not cross.
> >
> > While the above is correct, the Linux document is quite vague in
> > relation to the mandatory barriers and it's not clear whether the
> > above only refers to the SMP barriers.
> 
> Yes, I agree it is vague about mandatory barriers, so make Paul involved in.
> 
> >
> >> In fact, IMO, the 'DSB' should be used before 'LDR R5, [R1]' in P2 instead
> >> of in P1 because of the belows:
> >
> > A DSB on one CPU does not control the ordering on another CPU. So the
> > DSB on P2 is useless. Note that the P2 code is executed in an
> 
> Yes, your are right, sorry for the noise about this part.
> 
> > interrupt routine raised as a result of STR R1, [R4]. If P2 had a loop
> > polling for [R4] to get a valid address, we would indeed need a DSB
> > before LDR R5, [R1].
> >
> >> ? ? ? ?- out of order of the two stores in P1 is allowable
> >
> > That's why we have a DSB in there, to ensure that the [R1] location is
> > written before we store the R1 to the [R4] device.
> 
> Yes, I see now, I didn't know the interrupt is triggered by this before.
> 
> >
> >> ? ? ? ?- P2 should get message address from the mailbox pointed by R4 first,
> >> ? ? ? ?so how can we make sure the 'STR R1, [R4]' in P1 is completed if
> >> ? ? ? ?R4 doesn't point to a Strongly-Ordered memory.
> >
> > Even if the memory is SO, on newer CPUs I don't think it guarantees
> > the completion (pretty much acting like Device memory). But here we
> > don't care when the store to [R4] completes. When this happen, P2 will
> > get an interrupt. P2 does not execute the LDR R5, [R1] in interrupt
> > routine speculatively (i.e. before the interrupt was received).
> >>> Let's assume we have a device that performs the two steps below:
> >>>
> >>> 1. Writes data to RAM
> >>> 2. Updates its status register
> >>>
> >>> A driver running on the CPU has some code as below:
> >>>
> >>> ? ?LDR [Device] ? ?@ read the device status
> >>> ? ?DMB ? ? ? ? ? ? ? @ current barrier that we have in readl
> >>> ? ?TST ? ? ? ? ? ? ? ? @ check whether the DMA transfer is ready
> >>> ? ?BEQ out
> >>> ? ?LDR [Normal] ? ?@ read the DMA buffer
> >>> ? ?...
> >>> out:
> >>>
> >>> With the code above, the CPU may do the following steps:
> >>>
> >>> 1. Issue read from the device. Note that it does not wait for the read
> >>> to complete.
> >>> 2. DMB - ensures that no subsequent memory accesses happen before the
> >>> previous ones.
> >>> 3. Issues read from normal memory speculatively. This is allowed
> >>> because the TST/BEQ are only flow control dependency. In case the
> >>> condition fails, the read is discarded.
> >>> 4. The read from Normal memory (DMA buffer) completes. This could
> >>> happen before the I/O read at point 1 depending on the bus speeds.
> >>> 5. The Device read completes. This can happen after the Normal read
> >>> because of different bus speeds.
> >>> 6. TST clears CPSR.Z
> >>> 7. BEQ not executed.
> >>> 8. Normal read data moved to register.
> >>>
> >>> So, even if the CPU issues the read from Device and Normal memory in
> >>> order (steps 1, 3), they can happen at the device and RAM level out of
> >>> order (steps 4, 5) and the CPU could read data not yet written by the
> >>> device.
> >>>
> >>> The solution is to use a DSB which ensures the completion of the
> >>> Device read before issuing the Normal memory read.
> >>
> >> I agree a DSB is needed in such case, but I am not sure the patch is
> >> good. Maybe we should keep rmb not changed and only replace __iormb
> >> as DSB if this issue only happens between device io memory and normal
> >> memory, then rmb will not degrade performance a little as does by your
> >> patch.
> >
> > What other use do you see for the mandatory barriers if not in
> > relation to I/O? They are not for SMP configurations. We already have
> > a DSB in wmb().
> 
> Yes, there are some usage of rmb/wmb not in relation to I/O, and you can find
> the uses in fs, kernel directory. Also rmb/wmb has been used to order coherent
> memory accesses, such as dma descriptor(see tg3, fireware/ohci, musb,
> ehci/ohci, ...)
> 
> So your patch may have performance effect on these drivers and others...
> 
> >
> > The mandatory barriers could be present in device drivers that use the
> > relaxed I/O accessors and mandatory barriers explicitly as
> > optimisation. This was the approach recommended in past mailing list
> > discussions.
> 
> I think the focus of the discussion is on your change to rmb.
> 
> -- 
> Ming Lei
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
