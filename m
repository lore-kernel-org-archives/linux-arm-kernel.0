From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 5 Dec 2017 17:08:41 +0000
Subject: [PATCH 06/11] change memory_is_poisoned_16 for aligned error
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C006EF9B@dggemm510-mbs.china.huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-7-liuwenliang@huawei.com>
 <20171011162345.f601c29d12c81af85bf38565@linux-foundation.org>
 <CACT4Y+Ym3kq5RZ-4F=f97bvT2pNpzDf0kerf6tebzLOY_crR8Q@mail.gmail.com>
 <B8AC3E80E903784988AB3003E3E97330B2528234@dggemm510-mbs.china.huawei.com>
 <20171019125133.GA20805@n2100.armlinux.org.uk>
 <B8AC3E80E903784988AB3003E3E97330C006EF9B@dggemm510-mbs.china.huawei.com>
Message-ID: <CAKv+Gu94wgvC-yNHdpOr-Jyo6kC_ovA94=ik0mQYUMNV9Miahg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2017 at 14:19, Liuwenliang (Abbott Liu)
<liuwenliang@huawei.com> wrote:
> On Nov 23, 2017  20:30  Russell King - ARM Linux [mailto:linux at armlinux.org.uk]  wrote:
>>On Thu, Oct 12, 2017 at 11:27:40AM +0000, Liuwenliang (Lamb) wrote:
>>> >> - I don't understand why this is necessary.  memory_is_poisoned_16()
>>> >>   already handles unaligned addresses?
>>> >>
>>> >> - If it's needed on ARM then presumably it will be needed on other
>>> >>   architectures, so CONFIG_ARM is insufficiently general.
>>> >>
>>> >> - If the present memory_is_poisoned_16() indeed doesn't work on ARM,
>>> >>   it would be better to generalize/fix it in some fashion rather than
>>> >>   creating a new variant of the function.
>>>
>>>
>>> >Yes, I think it will be better to fix the current function rather then
>>> >have 2 slightly different copies with ifdef's.
>>> >Will something along these lines work for arm? 16-byte accesses are
>>> >not too common, so it should not be a performance problem. And
>>> >probably modern compilers can turn 2 1-byte checks into a 2-byte check
>>> >where safe (x86).
>>>
>>> >static __always_inline bool memory_is_poisoned_16(unsigned long addr)
>>> >{
>>> >        u8 *shadow_addr = (u8 *)kasan_mem_to_shadow((void *)addr);
>>> >
>>> >        if (shadow_addr[0] || shadow_addr[1])
>>> >                return true;
>>> >        /* Unaligned 16-bytes access maps into 3 shadow bytes. */
>>> >        if (unlikely(!IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE)))
>>> >                return memory_is_poisoned_1(addr + 15);
>>> >        return false;
>>> >}
>>>
>>> Thanks for Andrew Morton and Dmitry Vyukov's review.
>>> If the parameter addr=0xc0000008, now in function:
>>> static __always_inline bool memory_is_poisoned_16(unsigned long addr)
>>> {
>>>  ---     //shadow_addr = (u16 *)(KASAN_OFFSET+0x18000001(=0xc0000008>>3)) is not
>>>  ---     // unsigned by 2 bytes.
>>>         u16 *shadow_addr = (u16 *)kasan_mem_to_shadow((void *)addr);
>>>
>>>         /* Unaligned 16-bytes access maps into 3 shadow bytes. */
>>>         if (unlikely(!IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE)))
>>>                 return *shadow_addr || memory_is_poisoned_1(addr + 15);
>>> ----      //here is going to be error on arm, specially when kernel has not finished yet.
>>> ----      //Because the unsigned accessing cause DataAbort Exception which is not
>>> ----      //initialized when kernel is starting.
>>>         return *shadow_addr;
>>> }
>>>
>>> I also think it is better to fix this problem.
>
>>What about using get_unaligned() ?
>
> Thanks for your review.
>
> I think it is good idea to use get_unaligned. But ARMv7 support CONFIG_ HAVE_EFFICIENT_UNALIGNED_ACCESS
> (arch/arm/Kconfig : select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU).
> So on ARMv7, the code:
> u16 *shadow_addr = get_unaligned((u16 *)kasan_mem_to_shadow((void *)addr));
> equals the code:000
> u16 *shadow_addr = (u16 *)kasan_mem_to_shadow((void *)addr);
>

No it does not. The compiler may merge adjacent accesses into ldm or
ldrd instructions, which do not tolerate misalignment regardless of
the SCTLR.A bit.

This is actually something we may need to fix for ARM, i.e., drop
HAVE_EFFICIENT_UNALIGNED_ACCESS altogether, or carefully review the
way it is used currently.

> On ARMv7, if SCRLR.A is 0, unaligned access is OK.  Here is the description comes from ARM(r) Architecture Reference
> Manual ARMv7-A and ARMv7-R edition :
>
<snip>

Could you *please* stop quoting the ARM ARM at us? People who are
seeking detailed information like that will know where to find it.

-- 
Ard.
