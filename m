From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 20 Oct 2013 10:06:44 +0100
Subject: [RFC PATCH] arm64: KVM: honor cacheability attributes on S2 page
 fault
In-Reply-To: <20131019144534.GA39411@lvm>
References: <CAAhSdy1Sm2N68ZB5r9BmansGYnUgFO0ZFdUL=XB7RhJ258AAFA@mail.gmail.com>
 <20131011143721.GD15803@arm.com>
 <CAAhSdy1RS58HxDD2sKC5NP=vZ-fn=Zc4qEYZoFHR2usGqiQMFA@mail.gmail.com>
 <5258125E.4040709@arm.com>
 <CAAhSdy2nfnDuAZW6XWz0Xc4ehcU9YcHKLv7WVSCgk3+b8AD7Hw@mail.gmail.com>
 <20131011154401.GE15803@arm.com>
 <CAAhSdy3u2KUwdSWniDq=vCfXi6u44FhjKUA96RZPjCMiDaDA5A@mail.gmail.com>
 <20131015143848.GA1591@arm.com>
 <CAAhSdy3X1y6Lgni47NQu0ozUbTv3902RaMyBGyjD7OZ9p1=iJw@mail.gmail.com>
 <20131017111601.GK23462@arm.com> <20131019144534.GA39411@lvm>
Message-ID: <2E32ECEC-981D-40BF-86CA-0A24BFA2C0B4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 Oct 2013, at 15:45, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Thu, Oct 17, 2013 at 12:16:02PM +0100, Catalin Marinas wrote:
>> On Thu, Oct 17, 2013 at 05:19:01AM +0100, Anup Patel wrote:
>>> On Tue, Oct 15, 2013 at 8:08 PM, Catalin Marinas
>>> <catalin.marinas@arm.com> wrote:
>>>> So, the proposal:
>>>> 
>>>> 1. Clean+invalidate D-cache for pages mapped into the stage 2 for the
>>>>   first time (if the access is non-cacheable). Covered by this patch.
>>>> 2. Track guest's use of the MMU registers (SCTLR etc.) and detect when
>>>>   the stage 1 is enabled. When stage 1 is enabled, clean+invalidate the
>>>>   D-cache again for the all pages already mapped in stage 2 (in case we
>>>>   had speculative loads).
>>> 
>>> I agree on both point1 & poin2.
>>> 
>>> The point2 is for avoiding speculative cache loads for Host-side mappings
>>> of the Guest RAM. Right?
>> 
>> Yes.
> 
> I'm having a hard time imagining a scenario where (2) is needed, can you
> give me a concrete example of a situation that we're addressing here?

As Anup said, to avoid speculative cache loads from the host-side
mappings of the guest RAM.  Host Linux has a cacheable mapping of the
RAM while the guest assume non-cacheable.  Concrete example:

a) Guest starts populating the page table in head.S
b) Corresponding stage 2 page is faulted in, the caches are cleaned and
   invalidated (as per point 1 above)
c) Mid-way through, it is preempted and a switch to host occurs
d) CPU loads the cache speculatively for the page mapped at point (b)
   (since the host has a cacheable mapping of that page already)
e) The guest continues the page table population via non-cacheable
   accesses (at this point, RAM and cache for this page differ)
f) Guest enables the MMU with cacheable page table walks
g) The MMU (stage 1) sees stale data in the cache for the page table
   (because of (d))

Also note that even if you don't get a preemption as per point c,
another physical CPU can do the speculative cache load and because of
the snooping, point f is the same.

On a host OS, point (d) does not happen when the MMU is off for all the
CPUs.  This is not enough when all VCPUs have the MMU off.

>>>> The above allow the guest OS to run the boot code with MMU disabled and
>>>> then enable the MMU. If the guest needs to disable the MMU or caches
>>>> after boot, we either ask the guest for a Hyp call or we extend point 2
>>>> above to detect disabling (though that's not very efficient). Guest
>>>> power management via PSCI already implies Hyp calls, it's more for kexec
>>>> where you have a soft reset.
> 
> Why would we need to do anything if the guest disables the MMU?  Isn't it
> completely the responsibility of the guest to flush whatever it needs in
> physical memory before doing ?

It's not necessarily about what the guest does with the caches but
whether its assumptions after disable the MMU are still valid.  As per
point 2 above, we need to track again whether the guest simply assumes
MMU and caches are off.

Regarding what the guest does with the caches, it most likely performs a
full cache flush by set/way which is not guaranteed to work unless the
caches are disabled on all the physical CPUs (no snooping).

>>> Yes, Guest disabling MMU after boot could be problematic.
>>> 
>>> The Hyp call (or PSCI call) approach can certainly be efficient but we need
>>> to change Guest OS for this. On the other hand, extending point2 (though
>>> inefficient) could save us the pain of changing Guest OS.
>>> 
>>> Can we come-up with a way of avoiding Hyp call (or PSCI call) here ?
>> 
>> It could probably be done more efficiently by decoding the MMU register
>> access fault at the EL2 level and emulating it there to avoid a switch
>> to host Linux. But that's not a trivial task and I can't tell about the
>> performance impact.
> 
> That would be trapping to Hyp mode on every context switch for example,
> multiple times probably, and that sounds horrible.  Yes, this should be
> isolated to EL2, but even then this will add overhead.

There is an overhead and I'm not proposing that we do this now.  But as
soon as you have some bootloader or UEFI running before Linux, you
already have some more MMU enable/disable events.

> We could measure this though, but it sounds like something that will
> hurt the system significantly overall in both performance and complexity
> to solve and extremely rare situation.

It may not be so rare if the window from MMU disabling to re-enabling it
is extended.  But as long as you run Linux as the first thing in a guest
and you ignore kexec, it should be OK.

> A Hyp call sounds equally icky and quite different from PSCI imho, since
> PSCI is used on native systems and support by a "standard", so we're not
> doing paravirtualization there.

It is different from PSCI indeed, so we either change the guest
assumptions about caches or we add some for of detection into EL2.  I
agree, it looks like paravirtualisation.

Another option could be to start trapping the MMU reg accesses only if
you detect a full cache flush by set/way where all the VCPUs either have
the MMU or caches disabled.  That's a typical MMU off scenario in OS
(kexec) and boot loaders.

>> We still have an issue here since normally the guest disables the caches
>> and flushes them by set/way (usually on the last standing CPU, the
>> others being parked via PSCI). Such guest set/way operation isn't safe
>> when physical CPUs are up, even if you trap it in Hyp (unless you do it
>> via other complications like stop_machine() but even that may not be
>> entirely race-free and it opens the way for DoS attacks). The safest
>> here would be to do the cache maintenance by VA for all the guest
>> address space (probably fine if you do it in a preemptible way).
> 
> This should be handled properly already (see access_dcsw in
> arch/arm/kvm/coproc.c) or am I missing something?

DC CISW and friends only work when the physical caches are off on all
CPUs.  Otherwise you either get cache lines migrating between levels or
across to other CPUs.  On arm64 I plan to remove such calls and probably
only keep them for kexec when only one CPU is active.

>From the ARMv8 ARM (same as on ARMv7) page D4-1690:

  The cache maintenance instructions by set/way can clean or invalidate,
  or both, the entirety of one or more levels of cache attached to a
  processing element.  However, unless all processing elements attached
  to the caches regard all memory locations as Non-cacheable, it is not
  possible to prevent locations being allocated into the cache during
  such a sequence of the cache maintenance instructions.

  ----- Note -----
  In multi-processing environments, the cache maintenance instructions
  that operate by set/way are not broadcast within the shareability
  domains, and so allocations can occur from other, unmaintained,
  locations, in caches in other locations.  For this reason, the use of
  cache maintenance instructions that operate by set/way for the
  maintenance of large buffers of memory is not recommended in the
  architectural sequence.  The expected usage of the cache maintenance
  instructions that operate by set/way is associated with the cache
  maintenance instructions associated with the powerdown and powerup of
  caches, if this is required by the implementation.
  ----------------

None of the above requirements are met in a virtual environment.

Catalin
