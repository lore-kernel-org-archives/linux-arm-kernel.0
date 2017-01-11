From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Jan 2017 18:23:10 +0000
Subject: [RFC PATCH 1/2] ARM: vfp - allow kernel mode NEON in softirq
 context
In-Reply-To: <20170111175649.GK14217@n2100.armlinux.org.uk>
References: <1483991849-32448-1-git-send-email-ard.biesheuvel@linaro.org>
 <1483991849-32448-2-git-send-email-ard.biesheuvel@linaro.org>
 <20170111175649.GK14217@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu9S66y0QuOcJdwrT-WoQOCJged-MzfXqdm20RYVGg9w8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 January 2017 at 17:56, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Jan 09, 2017 at 07:57:28PM +0000, Ard Biesheuvel wrote:
>> This updates the kernel mode NEON handling to allow the NEON to be used
>> in softirq context as well as process context. This involves disabling
>> softirq processing when the NEON is used in kernel mode in process context,
>> and dealing with the situation where 'current' is not the owner of the
>> userland context that is present in the NEON register file when the NEON
>> is enabled in kernel mode.
>
> I really don't like this idea as-is.
>
> We have cases where kernel code accesses VFP to (eg) save or restore
> register state, such as during signal handling.  We assume that this
> will not be interrupted by another user, and that if we enable access
> to the VFP, it will stay enabled.  If it gets disabled beneath us, then
> things won't go well.
>
> For example, consider vfp_sync_hwstate():
>
> vfp_sync_hwstate()
>   vfp_state_in_hw() => true
>     fpexc read
>         softirq happens
>                 kernel_neon_begin()
>                 kernel_neon_end()
>     fpexc re-enabled
>     current register state saved out (corrupting what was there)
>     fpexc restored, possible in an enabled state
>
> Or we could have:
>
> vfp_sync_hwstate()
>   vfp_state_in_hw() => true
>         softirq happens
>                 kernel_neon_begin()
>                 kernel_neon_end()
>     fpexc read
>     fpexc re-enabled
>     current register state saved out (corrupting what was there)
>     fpexc disabled
>
> Or worse:
>
> vfp_sync_hwstate()
>   vfp_state_in_hw() => true
>     fpexc read
>     fpexc re-enabled
>         softirq happens
>                 kernel_neon_begin()
>                 kernel_neon_end()
>     current register state saved out, blowing up because VFP is
>      unexpectedly disabled
>
> So we would need to disable softirqs around every sensitive point in the
> VFP support code, and over all VFP instruction emulations for those VFPs
> which bounce "difficult" operations to the kernel support code.
>

Ah yes, I should have known it couldn't be that simple.

Thanks for the critique: i will look into the impact of making these changes.

>> The rationale for this change is that the NEON is shared with the ARMv8
>> Crypto Extensions (which are also defined for the AArch32 execution state),
>> which can give a huge performance boost (15x) to use cases like mac80211
>> CCMP processing, which executes in softirq context.
>
> I think, once the implementation is more correct, this would need to
> be re-evaluated, and I'd also like other more general performance
> measurements as well (eg, latency.)
>

Re latency, I thought about adding a kernel_neon_yield(), which does a
kernel_neon_end()/do_softirq()/kernel_neon_begin() sequence if any
softirqs are pending, to be invoked by kernel mode NEON users at times
when there are no live NEON registers. But in-kernel users of the
crypto API are naturally quantised into disk sectors, pages or network
packets, so I would not expect any noticeable starvation to occur. But
that does mean such algorithms should not be exposed to userland
(which sounds like a bad idea in any case, given that userland can
simply execute the same instructions)
