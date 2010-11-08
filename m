From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 08 Nov 2010 21:38:03 +0000
Subject: Using non-Global mappings for kernel address space
In-Reply-To: <AANLkTi=JDTvMgJZWLiE31=PhOS0D+m+SAFU5mxAR6ZJV@mail.gmail.com>
References: <AANLkTi=f+s4GAKLSESK=WSjxmUDCCvog21z1XxW73nU3@mail.gmail.com>
	<1289236418.3541.117.camel@e102109-lin.cambridge.arm.com>
	<AANLkTi=JDTvMgJZWLiE31=PhOS0D+m+SAFU5mxAR6ZJV@mail.gmail.com>
Message-ID: <1289252283.26399.45.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-08 at 18:15 +0000, Christoffer Dall wrote:
> > I'm not familiar with the KVM implementation for ARMv6(so it has been on
> > my list to look at for some time). Does the guest OS use a full 4GB
> > virtual address space?
> 
> The guest OS is (almost) unmodified, so it uses the full virtual
> address space.

So when you return to user (to the guest OS), does it switch the TTBR0
so that the guest OS can get 4GB of virtual space?

> > Does it only run in user mode or both
> > user/kernel?
> 
> Depends on what you mean. When the guest is running, the CPU is always
> in user mode. But both user space code and kernel code is executed in
> the guest.

I was referring to the USR/SVC modes but it's clear now.

> > Do you target SMP? That may get even trickier with the ASIDs because of
> > the roll-over event being broadcast via IPI.
> 
> Eventually we will definitely target SMP, but it is not currently a
> priority. Perhaps SMP support is going to be built on hardware
> virtualization features if those i the Cortex-A15 support that?

C-A15 has several features that help with getting full virtualisation.
Access to several system registers is trapped in the hypervisor and you
can even emulate several CPUs on a single one (or more). There are
virtual timers as well.

But the main advantage I think is another stage of MMU translation. So
basically the virtual space of Qemu can become the physical address of
the guest OS (Intermediate Physical Address). The guest OS can use both
USR and SVC modes and set up its own page tables freely.

> > Why do you need a different ASID for the kernel? Can you not use the
> > same ASID for both user and kernel (while in the same context) and avoid
> > switching the ASID when entering/exiting the kernel? This way you could
> > even move the switch_mm() function to the vectors page (global), though
> > it may not be a problem.
> 
> Yes, that's what I have working now. But I figured it would impose an
> unreasonable overhead on host context switches, since the host kernel
> memory accesses would take up several entries in the TLB for the same
> page - only with different ASIDs. From my measurements so far it seems
> that avoiding to do TLB flushed on world-switches in KVM/ARM gives a
> 33% overall performance benefit. I am not like to make up for that in
> any other way.

For my understanding, you can't use global mappings for the host kernel
because the guest OS would use the same virtual address (above
PAGE_OFFSET) but with non-global pages?

> > I think there is fundamental problem with your approach. Basically the
> > kernel always runs with ASID 0 no matter which thread is the active one.
> > If it gets a TLB entry for a user page (either because of explicit
> > get_user etc. or just speculative access), the TLB will have ASID 0
> > associated with a user space address. When you switch tasks, even if
> > user space has a new ASID, the kernel would still use ASID 0 when
> > accessing the new user space address. If it hits a previously loaded
> > TLB, that would have the wrong translation.
> >
> > So the kernel must use the same ASID as the user space application, or
> > at least have a different one for each application rather than the
> > common 0 value.
> 
> I see. I don't know the kernel well enough to say whether it's
> possible to wrap all user space accesses in a way so they would use
> dedicated ASIDs for accessing user space. 

There are only a few places where the kernel accesses the user space, so
you could temporarily set the ASID (accessing user space may fault, so
some care would be needed).

> >>         if (unlikely((asid & ~ASID_MASK) == 0)) {
> >>                 asid = ++cpu_last_asid;
> >> -               /* set the reserved ASID before flushing the TLB */
> >> -               asm("mcr        p15, 0, %0, c13, c0, 1  @ set reserved context ID\n"
> >> -                   :
> >> -                   : "r" (0));
> >>                 isb();
> >>                 flush_tlb_all();
> >>                 if (icache_is_vivt_asid_tagged()) {
> >
> > How do you handle the ASID roll-over since you removed this?
> >
> Maybe I don't understand the point of this. I thought the idea was to
> avoid having "old" entries in the TLB from before beginning a new run
> of ASIDs. But then again, the code that handles this is all globally
> mapped anyway. Is it in case there's an interrupt that touches some
> user data? I'm confused... :)

At every context switch, Linux checks the ASID of the newly switched in
context. If it is from an older generation (top 24 bits of context.id),
it allocates a new ASID from the global cpu_last_asid variable. When
Linux runs out of ASIDs (bottom 8 bits of cpu_last_asid become 0), it
sends an IPI to all the CPUs to reset the ASID counting and flushes the
full TLB.

But looking at your code again, you were already using the reserved
kernel ASID (with its own problems), so removing the asm() lines
wouldn't make any difference. I had the impression that you removed
more.

Catalin
