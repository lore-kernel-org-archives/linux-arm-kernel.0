From: tom.leiming@gmail.com (Ming Lei)
Date: Sun, 10 Apr 2011 01:03:02 +0800
Subject: [PATCH] ARM: The mandatory barrier rmb() must be a dsb() in for
	device accesses
In-Reply-To: <BANLkTi=37p-BWpzF2KT4J8PO+xEWrRjDfA@mail.gmail.com>
References: <20110325101651.27120.56045.stgit@e102109-lin.cambridge.arm.com>
	<AANLkTi=vx7fttc0B08dcfB_s9ya-98Rt-=a8Hr0QGvsM@mail.gmail.com>
	<1301412104.583.85.camel@e102109-lin.cambridge.arm.com>
	<BANLkTi=SgC3sT5aHpFc8Yi-JZrc1PPcVwA@mail.gmail.com>
	<BANLkTi=37p-BWpzF2KT4J8PO+xEWrRjDfA@mail.gmail.com>
Message-ID: <BANLkTikcy_eut-HGexziTnoUcXOPLdyVfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

2011/4/9 Catalin Marinas <catalin.marinas@arm.com>:

> Probably the above document isn't comprehensive enough. It mainly
> targets memory ordering between processors. I think another example
> that mentions DSB is the mailbox scenario.

I also saw this example of 8.1, but I don't think it is related with
linux read memory barrier, see below:

	- 8.1 requires that the 'STR R5, [R1]' in P1 is completed before
	'LDR R5, [R1]' in P2;

	- Documentation/memory-barriers.txt said:
	1), Memory barriers are such interventions.  They impose a
	perceived partial ordering over the memory operations on either
	side of the barrier.

	2),There is no guarantee that any of the memory accesses specified
	before a memory barrier will be _complete_ by the completion of a
	memory barrier instruction; the barrier can be considered to draw a
	line in that CPU's access queue that accesses of the appropriate type
	may not cross.

In fact, IMO, the 'DSB' should be used before 'LDR R5, [R1]' in P2 instead
of in P1 because of the belows:

	- out of order of the two stores in P1 is allowable
	- P2 should get message address from the mailbox pointed by R4 first,
	so how can we make sure the 'STR R1, [R4]' in P1 is completed if
	R4 doesn't point to a Strongly-Ordered memory.

> Anyway, my patch is based on the discussions I had with the person
> that wrote the above document (and the ARM ARM).
>
>>>> I have been under the impression that DMB is a barrier for all memory
>>>> accesses. I find no support in ARMv7, for the hypothesis that DSB is
>>>> needed to order between Device and Normal.
>>>
>>> The key point is that DMB only ensures the *observability* of memory
>>> accesses by the processors and not arrival to the device or block of
>>
>> How could you conclude that the memory accesses order is different with
>> the order of memory requests observed on the same type of memory?
>
> I don't fully understand your question. But I'll give an example where
> the DMB fails.
>
> Let's assume we have a device that performs the two steps below:
>
> 1. Writes data to RAM
> 2. Updates its status register
>
> A driver running on the CPU has some code as below:
>
> ? ?LDR [Device] ? ?@ read the device status
> ? ?DMB ? ? ? ? ? ? ? @ current barrier that we have in readl
> ? ?TST ? ? ? ? ? ? ? ? @ check whether the DMA transfer is ready
> ? ?BEQ out
> ? ?LDR [Normal] ? ?@ read the DMA buffer
> ? ?...
> out:
>
> With the code above, the CPU may do the following steps:
>
> 1. Issue read from the device. Note that it does not wait for the read
> to complete.
> 2. DMB - ensures that no subsequent memory accesses happen before the
> previous ones.
> 3. Issues read from normal memory speculatively. This is allowed
> because the TST/BEQ are only flow control dependency. In case the
> condition fails, the read is discarded.
> 4. The read from Normal memory (DMA buffer) completes. This could
> happen before the I/O read at point 1 depending on the bus speeds.
> 5. The Device read completes. This can happen after the Normal read
> because of different bus speeds.
> 6. TST clears CPSR.Z
> 7. BEQ not executed.
> 8. Normal read data moved to register.
>
> So, even if the CPU issues the read from Device and Normal memory in
> order (steps 1, 3), they can happen at the device and RAM level out of
> order (steps 4, 5) and the CPU could read data not yet written by the
> device.
>
> The solution is to use a DSB which ensures the completion of the
> Device read before issuing the Normal memory read.

I agree a DSB is needed in such case, but I am not sure the patch is
good. Maybe we should keep rmb not changed and only replace __iormb
as DSB if this issue only happens between device io memory and normal
memory, then rmb will not degrade performance a little as does by your
patch.

thanks,
-- 
Ming Lei
