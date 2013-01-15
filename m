From: gleb@redhat.com (Gleb Natapov)
Date: Tue, 15 Jan 2013 17:31:00 +0200
Subject: [PATCH v5 13/14] KVM: ARM: Handle I/O aborts
In-Reply-To: <50F56C3B.6040308@arm.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108184005.46302.38495.stgit@ubuntu>
 <20130115131855.GL11529@redhat.com> <50F559C4.8080900@arm.com>
 <20130115133455.GN11529@redhat.com> <50F55D9C.8070007@arm.com>
 <20130115142747.GP11529@redhat.com> <50F56C3B.6040308@arm.com>
Message-ID: <20130115153100.GE12489@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 02:48:27PM +0000, Marc Zyngier wrote:
> On 15/01/13 14:27, Gleb Natapov wrote:
> > On Tue, Jan 15, 2013 at 01:46:04PM +0000, Marc Zyngier wrote:
> >> On 15/01/13 13:34, Gleb Natapov wrote:
> >>> On Tue, Jan 15, 2013 at 01:29:40PM +0000, Marc Zyngier wrote:
> >>>> On 15/01/13 13:18, Gleb Natapov wrote:
> >>>>> On Tue, Jan 08, 2013 at 01:40:05PM -0500, Christoffer Dall wrote:
> >>>>>> When the guest accesses I/O memory this will create data abort
> >>>>>> exceptions and they are handled by decoding the HSR information
> >>>>>> (physical address, read/write, length, register) and forwarding reads
> >>>>>> and writes to QEMU which performs the device emulation.
> >>>>>>
> >>>>>> Certain classes of load/store operations do not support the syndrome
> >>>>>> information provided in the HSR and we therefore must be able to fetch
> >>>>>> the offending instruction from guest memory and decode it manually.
> >>>>>>
> >>>>>> We only support instruction decoding for valid reasonable MMIO operations
> >>>>>> where trapping them do not provide sufficient information in the HSR (no
> >>>>>> 16-bit Thumb instructions provide register writeback that we care about).
> >>>>>>
> >>>>>> The following instruction types are NOT supported for MMIO operations
> >>>>>> despite the HSR not containing decode info:
> >>>>>>  - any Load/Store multiple
> >>>>>>  - any load/store exclusive
> >>>>>>  - any load/store dual
> >>>>>>  - anything with the PC as the dest register
> >>>>>>
> >>>>>> This requires changing the general flow somewhat since new calls to run
> >>>>>> the VCPU must check if there's a pending MMIO load and perform the write
> >>>>>> after userspace has made the data available.
> >>>>>>
> >>>>>> Rusty Russell fixed a horrible race pointed out by Ben Herrenschmidt:
> >>>>>> (1) Guest complicated mmio instruction traps.
> >>>>>> (2) The hardware doesn't tell us enough, so we need to read the actual
> >>>>>>     instruction which was being exectuted.
> >>>>>> (3) KVM maps the instruction virtual address to a physical address.
> >>>>>> (4) The guest (SMP) swaps out that page, and fills it with something else.
> >>>>>> (5) We read the physical address, but now that's the wrong thing.
> >>>>> How can this happen?! The guest cannot reuse physical page before it
> >>>>> flushes it from all vcpus tlb cache. For that it needs to send
> >>>>> synchronous IPI to all vcpus and IPI will not be processed by a vcpu
> >>>>> while it does emulation.
> >>>>
> >>>> I don't know how this works on x86, but a KVM/ARM guest can definitely
> >>>> handle an IPI.
> >>>>
> >>> How can a vcpu handle an IPI while it is not in a guest mode?
> >>
> >> I think there is some misunderstanding. A guest IPI is of course handled
> >> while running the guest. You completely lost me here.
> > You need IPI from one guest vcpu to another to invalidate its TLB on
> > x86. That prevents the race from happening there.
> 
> We don't need this on ARM (starting with v7, v6 is an entirely different
> story, and we do not support KVM on v6).
> 
> The TLB is propagated by the HW using the following (pseudocode) sequence:
> 	tlb_invalidate VA
> 	barrier
> 
> Leaving the barrier guaranties that all TLB invalidations have been
> propagated.
> 
That explains why __get_user_pages_fast() is missing on ARM :)

> >>
> >>>> Furthermore, TLB invalidation doesn't require an IPI on ARMv7 (unless
> >>>> we're doing some set/way operation which is handled separately).
> >>>>
> >>> What prevents a page to be swapped out while code is fetched from it?
> >>
> >> Why would you prevent it? TLB invalidation is broadcast by the HW. If
> >> you swap a page out, you flag the entry as invalid and invalidate the
> >> corresponding TLB. If you hit it, you swap the page back in.
> >>
> > There is no IPI (or anything that requires response from cpu whose TLB
> > is invalidated) involved in invalidating remote TLB?
> 
> No. The above sequence is all you have to do.
> 
> This is why the above race is a bit hairy. A vcpu will happily
> invalidate TLBs, but as the faulting vcpu already performed the
> translation, we're screwed.
> 
> Thankfully, this is a case that only matters when we have to emulate an
> MMIO operation that is not automatically decoded by the HW. They are
> rare (the Linux kernel doesn't use them). In this case, we stop the
> world (IPI).
> 
Got it. Thanks.

--
			Gleb.
