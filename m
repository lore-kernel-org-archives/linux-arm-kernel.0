From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 8 Nov 2010 19:15:58 +0100
Subject: Using non-Global mappings for kernel address space
In-Reply-To: <1289236418.3541.117.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTi=f+s4GAKLSESK=WSjxmUDCCvog21z1XxW73nU3@mail.gmail.com>
	<1289236418.3541.117.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTi=JDTvMgJZWLiE31=PhOS0D+m+SAFU5mxAR6ZJV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]
> I'm not familiar with the KVM implementation for ARMv6(so it has been on
> my list to look at for some time). Does the guest OS use a full 4GB
> virtual address space?

The guest OS is (almost) unmodified, so it uses the full virtual address space.

> Does it only run in user mode or both
> user/kernel?

Depends on what you mean. When the guest is running, the CPU is always
in user mode. But both user space code and kernel code is executed in
the guest.

>
> Do you target SMP? That may get even trickier with the ASIDs because of
> the roll-over event being broadcast via IPI.

Eventually we will definitely target SMP, but it is not currently a
priority. Perhaps SMP support is going to be built on hardware
virtualization features if those i the Cortex-A15 support that?
>
[snip]
> Why do you need a different ASID for the kernel? Can you not use the
> same ASID for both user and kernel (while in the same context) and avoid
> switching the ASID when entering/exiting the kernel? This way you could
> even move the switch_mm() function to the vectors page (global), though
> it may not be a problem.

Yes, that's what I have working now. But I figured it would impose an
unreasonable overhead on host context switches, since the host kernel
memory accesses would take up several entries in the TLB for the same
page - only with different ASIDs. From my measurements so far it seems
that avoiding to do TLB flushed on world-switches in KVM/ARM gives a
33% overall performance benefit. I am not like to make up for that in
any other way.

Alternatively I could change the host page tables of only the QEMU
process to use non-global mappings and the flush the TLB every time
another process was scheduled (thereby using the ASID of the user
space process to run the KVM kernel code). I spent a little time
trying out this solution, but it came with its own set of problems.

[snip]
> There is local_flush_tlb_mm() that uses the ASID as well.
>
thanks.

>
> I think there is fundamental problem with your approach. Basically the
> kernel always runs with ASID 0 no matter which thread is the active one.
> If it gets a TLB entry for a user page (either because of explicit
> get_user etc. or just speculative access), the TLB will have ASID 0
> associated with a user space address. When you switch tasks, even if
> user space has a new ASID, the kernel would still use ASID 0 when
> accessing the new user space address. If it hits a previously loaded
> TLB, that would have the wrong translation.
>
> So the kernel must use the same ASID as the user space application, or
> at least have a different one for each application rather than the
> common 0 value.

I see. I don't know the kernel well enough to say whether it's
possible to wrap all user space accesses in a way so they would use
dedicated ASIDs for accessing user space. Also, I cannot quite
estimate the performance implications, but it would definitely place a
few duplicate entries in the TLB.
>
> In Linux we use ASID 0 but only for brief periods of time when switching
> the context or at roll-over but there is no active user space access
> with ASID 0.
>
> Some more comments on the patch below:
>
Thanks, I only have the question below.

[snip]
>> ? ? ? ? if (unlikely((asid & ~ASID_MASK) == 0)) {
>> ? ? ? ? ? ? ? ? asid = ++cpu_last_asid;
>> - ? ? ? ? ? ? ? /* set the reserved ASID before flushing the TLB */
>> - ? ? ? ? ? ? ? asm("mcr ? ? ? ?p15, 0, %0, c13, c0, 1 ?@ set reserved context ID\n"
>> - ? ? ? ? ? ? ? ? ? :
>> - ? ? ? ? ? ? ? ? ? : "r" (0));
>> ? ? ? ? ? ? ? ? isb();
>> ? ? ? ? ? ? ? ? flush_tlb_all();
>> ? ? ? ? ? ? ? ? if (icache_is_vivt_asid_tagged()) {
>
> How do you handle the ASID roll-over since you removed this?
>
Maybe I don't understand the point of this. I thought the idea was to
avoid having "old" entries in the TLB from before beginning a new run
of ASIDs. But then again, the code that handles this is all globally
mapped anyway. Is it in case there's an interrupt that touches some
user data? I'm confused... :)

>
> BTW, Cortex-A15 has full hardware virtualisation available, so this way
> you could avoid many of the above problems.
>
Yes, I am very excited about this and would love to let KVM support
this platform as soon as possible. Do you know anything about when
it's possible to get simulators / development boards?

Thanks!

-Christoffer
