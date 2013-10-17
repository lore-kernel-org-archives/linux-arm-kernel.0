From: anup@brainfault.org (Anup Patel)
Date: Thu, 17 Oct 2013 09:49:01 +0530
Subject: [RFC PATCH] arm64: KVM: honor cacheability attributes on S2 page
 fault
In-Reply-To: <20131015143848.GA1591@arm.com>
References: <20131010112425.GB21380@arm.com>
 <CAAhSdy20=U3+LZd=3i8dfqfSEaX7V+2z_y641NBLj7PkYZBadQ@mail.gmail.com>
 <20131011123839.GH12308@darko.cambridge.arm.com>
 <CAAhSdy1Sm2N68ZB5r9BmansGYnUgFO0ZFdUL=XB7RhJ258AAFA@mail.gmail.com>
 <20131011143721.GD15803@arm.com>
 <CAAhSdy1RS58HxDD2sKC5NP=vZ-fn=Zc4qEYZoFHR2usGqiQMFA@mail.gmail.com>
 <5258125E.4040709@arm.com>
 <CAAhSdy2nfnDuAZW6XWz0Xc4ehcU9YcHKLv7WVSCgk3+b8AD7Hw@mail.gmail.com>
 <20131011154401.GE15803@arm.com>
 <CAAhSdy3u2KUwdSWniDq=vCfXi6u44FhjKUA96RZPjCMiDaDA5A@mail.gmail.com>
 <20131015143848.GA1591@arm.com>
Message-ID: <CAAhSdy3X1y6Lgni47NQu0ozUbTv3902RaMyBGyjD7OZ9p1=iJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 8:08 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Sat, Oct 12, 2013 at 07:24:17PM +0100, Anup Patel wrote:
>> On Fri, Oct 11, 2013 at 9:14 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Fri, Oct 11, 2013 at 04:32:48PM +0100, Anup Patel wrote:
>> >> On Fri, Oct 11, 2013 at 8:29 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> >> > On 11/10/13 15:50, Anup Patel wrote:
>> >> >> On Fri, Oct 11, 2013 at 8:07 PM, Catalin Marinas
>> >> >> <catalin.marinas@arm.com> wrote:
>> >> >>> On Fri, Oct 11, 2013 at 03:27:16PM +0100, Anup Patel wrote:
>> >> >>>> On Fri, Oct 11, 2013 at 6:08 PM, Catalin Marinas
>> >> >>>> <catalin.marinas@arm.com> wrote:
>> >> >>>>> On Thu, Oct 10, 2013 at 05:09:03PM +0100, Anup Patel wrote:
>> >> >>>>>> Coming back to where we started, the actual problem was that when
>> >> >>>>>> Guest starts booting it sees wrong contents because it is runs with
>> >> >>>>>> MMU disable and correct contents are still in external L3 cache of X-Gene.
>> >> >>>>>
>> >> >>>>> That's one of the problems and I think the easiest to solve. Note that
>> >> >>>>> contents could still be in the L1/L2 (inner) cache since whole cache
>> >> >>>>> flushing by set/way isn't guaranteed in an MP context.
>> >> >>>>>
>> >> >>>>>> How about reconsidering the approach of flushing Guest RAM (entire or
>> >> >>>>>> portion of it) to PoC by VA once before the first run of a VCPU ?
>> >> >>>>>
>> >> >>>>> Flushing the entire guest RAM is not possible by set/way
>> >> >>>>> (architecturally) and not efficient by VA (though some benchmark would
>> >> >>>>> be good). Marc's patch defers this flushing when a page is faulted in
>> >> >>>>> (at stage 2) and I think it covers the initial boot.
>> >> >>>>>
>> >> >>>>>> OR
>> >> >>>>>> We can also have KVM API using which user space can flush portions
>> >> >>>>>> of Guest RAM before running the VCPU. (I think this was a suggestion
>> >> >>>>>> from Marc Z initially)
>> >> >>>>>
>> >> >>>>> This may not be enough. It indeed flushes the kernel image that gets
>> >> >>>>> loaded but the kernel would write other pages (bss, page tables etc.)
>> >> >>>>> with MMU disabled and those addresses may contain dirty cache lines that
>> >> >>>>> have not been covered by the initial kvmtool flush. So you basically
>> >> >>>>> need all guest non-cacheable accesses to be flushed.
>> >> >>>>>
>> >> >>>>> The other problems are the cacheable aliases that I mentioned, so even
>> >> >>>>> though the guest does non-cacheable accesses with the MMU off, the
>> >> >>>>> hardware can still allocate into the cache via the other mappings. In
>> >> >>>>> this case the guest needs to invalidate the areas of memory that it
>> >> >>>>> wrote with caches off (or just use the DC bit to force memory accesses
>> >> >>>>> with MMU off to be cacheable).
>> >> >>>>
>> >> >>>> Having looked at all the approaches, I would vote for the approach taken
>> >> >>>> by this patch.
>> >> >>>
>> >> >>> But this patch alone doesn't solve the other issues. OTOH, the DC bit
>> >> >>> would solve your initial problem and a few others.
>> >> >>
>> >> >> DC bit might solve the initial problem but it can be problematic because
>> >> >> setting DC bit would mean Guest would have Caching ON even when Guest
>> >> >> MMU is disabled. This will be more problematic if Guest is running a
>> >> >> bootloader (uboot, grub, UEFI, ..) which does pass-through access to a
>> >> >> DMA-capable device and we will have to change the bootloader in this
>> >> >> case and put explicit flushes in bootloader for running inside Guest.
>> >> >
>> >> > Well, as Catalin mentioned, we'll have to do some cache maintenance in
>> >> > the guest in any case.
>> >>
>> >> This would also mean that we will have to change Guest bootloader for
>> >> running as Guest under KVM ARM64.
>> >
>> > Yes.
>> >
>> >> In x86 world, everything that can run natively also runs as Guest OS
>> >> even if the Guest has pass-through devices.
>> >
>> > I guess on x86 the I/O is also coherent, in which case we could use the
>> > DC bit.
>>
>> We need to go ahead with some approach hence, if you are inclined
>> towards DC bit approach then let us go with that approach.
>>
>> For the DC bit approach, I request to document somewhere the limitation
>> (or corner case) about Guest bootloader accessing DMA-capable device.
>
> I think we could avoid the DC bit but still use some part of that patch.
> Another problem with DC is run-time code patching where the guest MMU is
> disabled, the guest may not do D-cache maintenance.
>
> So, the proposal:
>
> 1. Clean+invalidate D-cache for pages mapped into the stage 2 for the
>    first time (if the access is non-cacheable). Covered by this patch.
> 2. Track guest's use of the MMU registers (SCTLR etc.) and detect when
>    the stage 1 is enabled. When stage 1 is enabled, clean+invalidate the
>    D-cache again for the all pages already mapped in stage 2 (in case we
>    had speculative loads).

I agree on both point1 & poin2.

The point2 is for avoiding speculative cache loads for Host-side mappings
of the Guest RAM. Right?

>
> The above allow the guest OS to run the boot code with MMU disabled and
> then enable the MMU. If the guest needs to disable the MMU or caches
> after boot, we either ask the guest for a Hyp call or we extend point 2
> above to detect disabling (though that's not very efficient). Guest
> power management via PSCI already implies Hyp calls, it's more for kexec
> where you have a soft reset.

Yes, Guest disabling MMU after boot could be problematic.

The Hyp call (or PSCI call) approach can certainly be efficient but we need
to change Guest OS for this. On the other hand, extending point2 (though
inefficient) could save us the pain of changing Guest OS.

Can we come-up with a way of avoiding Hyp call (or PSCI call) here ?

>
> This only needs to be done for the primary CPU (or until the first CPU
> enabled the MMU). Once a CPU enabled its MMU, the others will have
> to cope with speculative loads into the cache anyway (if secondary VCPU
> are started by a PSCI HVC call, we can probably ignore the trapping of
> MMU register access anyway).

Also, this would be a nice way of reducing Clean-invalidate D-cache upon
non-cacheable accesses for SMP Guest (i.e. An enhancement to this patch).

>
> Note that we don't cover the I-cache. On ARMv8 you can get speculative
> loads into the I-cache even if it is disabled, so it needs to be
> invalidated explicitly before the MMU or the I-cache is enabled.

I think it should be responsibility of Guest OS to invalidate I-cache before
enabling MMU or I-cache enable. Right?

>
> Comments?

Sorry, for little delay in reply.

>
> --
> Catalin

--
Anup
