From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 25 Feb 2015 14:47:02 +0000
Subject: [PATCH v2] arm64: mm: increase VA range of identity map
In-Reply-To: <20150225142454.GH12377@arm.com>
References: <1424797703-2804-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150225140130.GF12377@arm.com>
 <CAKv+Gu8gYV9Zr3SS6fUda=MKo5DR_=megy1aOAkUOoc4-4RgMA@mail.gmail.com>
 <20150225142454.GH12377@arm.com>
Message-ID: <CAKv+Gu9Yptg_AE1hv6H+D-xXoudTNQk-vu5gkSn8=YwOnPc7hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2015 at 14:24, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Feb 25, 2015 at 02:15:52PM +0000, Ard Biesheuvel wrote:
>> On 25 February 2015 at 14:01, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Feb 24, 2015 at 05:08:23PM +0000, Ard Biesheuvel wrote:
>> >> +static inline void __cpu_set_tcr_t0sz(u64 t0sz)
>> >> +{
>> >> +     unsigned long tcr;
>> >> +
>> >> +     if (!IS_ENABLED(CONFIG_ARM64_VA_BITS_48)
>> >> +         && unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)))
>> >> +             asm volatile(
>> >> +             "       mrs     %0, tcr_el1             ;"
>> >> +             "       bfi     %0, %1, #%2, #%3        ;"
>> >
>> > It's odd that you need these '#'s. Do you see issues without them?
>> >
>>
>> I actually haven't tried without them. I can remove them if you prefer
>
> Yes, please.
>
>> >> +             "       msr     tcr_el1, %0             ;"
>> >> +             "       isb"
>> >> +             : "=&r" (tcr)
>> >> +             : "r"(t0sz), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
>> >> +}
>> >
>> > Hmm, do we need a memory clobber here, or can we rely on the caller doing
>> > having the appropriate compiler barriers?
>> >
>>
>> The TCR_EL1 update only affects the lower TTBR0 mapping, so I don't
>> think it would matter in this particular case if any memory accesses
>> are reordered across it, would it?
>
> What if those accesses were intended for the identity mapping and ended
> up being translated with stale user mappings? It could be that the
> preempt_disable() is enough, but if so, a comment would be helpful.
>

Sorry, I don't quite follow. First of all, if that concern is valid,
then it is equally valid without this patch. This just updates TCR_EL1
in places where we were already assigning TTBR0_EL1 a new value.
(Although I am not saying that means it is not my problem if there is
an issue here.)

The function cpu_set_default_tcr_t0sz() is called from paging_init()
and secondary_start_kernel() to set the default T0SZ value after
having deactivated the ID map. Catalin made a point about how to order
those operations wrt the TLB flush, and I am pretty sure the compiler
emits the asm() blocks in program order. In either case, there is no
user mapping, just the old mapping (the ID map) and the new invalid
mapping (the zero page). IIUC, we would only need compiler barriers
here to prevent it from deferring a read via the ID map until it has
already been deactivated, if such a read was present in the code.

Then there is setup_mm_for_reboot() [which may be dead code, I think?
It is only called from soft_restart() which doesn't seem to have any
callers itself], which just reads some global kernel vars.

Apologies if I am being thick here
