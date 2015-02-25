From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 25 Feb 2015 13:10:52 +0000
Subject: [PATCH v2] arm64: mm: increase VA range of identity map
In-Reply-To: <20150225123814.GC1105@localhost>
References: <1424797703-2804-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150225123814.GC1105@localhost>
Message-ID: <CAKv+Gu8hxTtM4v9jZP+dwkW_WMJz9HzmutRVSQg-oPXwDKqZzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2015 at 12:38, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Feb 24, 2015 at 05:08:23PM +0000, Ard Biesheuvel wrote:
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -387,6 +387,28 @@ __create_page_tables:
>>       mov     x0, x25                         // idmap_pg_dir
>>       ldr     x3, =KERNEL_START
>>       add     x3, x3, x28                     // __pa(KERNEL_START)
>> +
>> +#ifndef CONFIG_ARM64_VA_BITS_48
>> +#define EXTRA_SHIFT  (PGDIR_SHIFT + PAGE_SHIFT - 3)
>> +     /*
>> +      * If VA_BITS < 48, it may be too small to allow for an ID mapping to be
>> +      * created that covers system RAM if that is located sufficiently high
>> +      * in the physical address space. So for the ID map, use an extended
>> +      * virtual range in that case, by configuring an additional translation
>> +      * level.
>> +      */
>> +     adrp    x5, KERNEL_END
>> +     clz     x5, x5                  // # of leading 0's in __pa(KERNEL_END)
>> +     cmp     x5, #TCR_T0SZ(VA_BITS)  // VA_BITS sufficiently large?
>
> I think we need some better comment here for people looking at this code
> again in the future (including myself). So the VA bits needed to cover
> KERNEL_END are calculated as (64 - clz(__pa(KERNEL_END))). T0SZ is
> calculated as (64 - VA_BITS) which means that T0SZ is
> clz(__pa(KERNEL_END)).
>

OK.

>> +     b.ge    1f                      // .. then skip additional level
>> +
>> +     adrp    x6, idmap_t0sz
>> +     str     x5, [x6, #:lo12:idmap_t0sz]
>> +
>> +     create_table_entry x0, x3, EXTRA_SHIFT, PTRS_PER_PGD, x5, x6
>
> EXTRA_SHIFT is correctly calculated (one level more than PGDIR_SHIFT)
> but I don't think PTRS_PER_PGD is appropriate here. For example, we had
> in the past 39-bit VA with 64KB pages which made PTRS_PER_PGD pretty
> small (well, it may cover the 40-bit case you are trying to fix but not
> up to 48). So maybe define something like:
>
> #define EXTRA_PTRS      (1 << (48 - EXTRA_SHIFT))
>

My assumption was that, if you are running with fewer translation
levels than required to map all 48 bits, it makes little sense to use
only half a page or less at the top level, and PTRS_PER_PGD will
always cover a full page (which is what we reserve at the root level
anyway). But perhaps this is not universally true.

I will change it.

> Otherwise the patch looks fine to me. We have to look into fixing KVM as
> well, ideally with sharing the same idmap with the kernel.
>

Yes, but much of that code is shared with ARM as well, so it is not as
straight-forward, unfortunately.

Thanks,
Ard.
