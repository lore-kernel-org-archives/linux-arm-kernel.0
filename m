From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 26 Feb 2017 14:44:08 +0000
Subject: [RFC PATCH] arm: Fix cache inconsistency when using fixmap
In-Reply-To: <CAKv+Gu9YeJ+WN1TETjh5G73=tCOK9fDW21VOw0E1XYy=UJcBkg@mail.gmail.com>
References: <1487778678.18810.8.camel@linaro.org>
 <5497800b3271f13583e78710ac39a48e@agner.ch>
 <CAKv+Gu9YeJ+WN1TETjh5G73=tCOK9fDW21VOw0E1XYy=UJcBkg@mail.gmail.com>
Message-ID: <CAKv+Gu__kwhPGdQ4XzPF9WvkDQimh0kbGvrORs9PuDPTNsnE2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2017 at 14:35, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 25 February 2017 at 01:06, Stefan Agner <stefan@agner.ch> wrote:
[...]
>> Early fixmap gets shut down before going SMP, so non shared mappings are
>> not an issue there. But FIXMAP_PAGE_NORMAL is also used for regular
>> fixmap, which is essentially the problem. Also, regular fixmap does not
>> make sure of the cache policy due to that, but just uses the hardcoded
>> writeback policy...
>>
>> With that in mind, populating kern_pgprot with a reasonable default
>> which works for early fixmap might be a reasonable approach. Later
>> kern_pgprot gets setup with the appropriate shared attribute and cache
>> policy...
>>
>> diff --git a/arch/arm/include/asm/fixmap.h
>> b/arch/arm/include/asm/fixmap.h
>> index 5c17d2dec777..c663e562716c 100644
>> --- a/arch/arm/include/asm/fixmap.h
>> +++ b/arch/arm/include/asm/fixmap.h
>> @@ -39,12 +39,11 @@ static const enum fixed_addresses
>> __end_of_fixed_addresses =
>>         __end_of_fixmap_region > __end_of_early_ioremap_region ?
>>         __end_of_fixmap_region : __end_of_early_ioremap_region;
>>
>> -#define FIXMAP_PAGE_COMMON     (L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN
>> | L_PTE_DIRTY)
>> -
>> -#define FIXMAP_PAGE_NORMAL     (FIXMAP_PAGE_COMMON |
>> L_PTE_MT_WRITEBACK)
>> +#define FIXMAP_PAGE_NORMAL     (pgprot_kernel | L_PTE_XN)
>>  #define FIXMAP_PAGE_RO         (FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
>>
>>  /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
>> +#define FIXMAP_PAGE_COMMON     (L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN
>> | L_PTE_DIRTY)
>>  #define FIXMAP_PAGE_IO         (FIXMAP_PAGE_COMMON |
>> L_PTE_MT_DEV_SHARED | L_PTE_SHARED)
>>  #define FIXMAP_PAGE_NOCACHE    FIXMAP_PAGE_IO
>>
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index 4001dd15818d..9cb7c559263f 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -65,7 +65,8 @@ pmdval_t user_pmd_table = _PAGE_USER_TABLE;
>>  static unsigned int cachepolicy __initdata = CPOLICY_WRITEBACK;
>>  static unsigned int ecc_mask __initdata = 0;
>>  pgprot_t pgprot_user;
>> -pgprot_t pgprot_kernel;
>> +pgprot_t pgprot_kernel = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG |
>> +                                 L_PTE_DIRTY | L_PTE_MT_WRITEBACK);
>>  pgprot_t pgprot_hyp_device;
>>  pgprot_t pgprot_s2;
>>  pgprot_t pgprot_s2_device;
>>
>
> This looks correct to me, and avoids using shareable attributes inadvertently.
>
> However, we could make this a bit more private to the fixmap code by
> using something like
>
>
> diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
> index 5c17d2dec777..6c375aea8f22 100644
> --- a/arch/arm/include/asm/fixmap.h
> +++ b/arch/arm/include/asm/fixmap.h
> @@ -41,11 +41,14 @@ static const enum fixed_addresses __end_of_fixed_addresses =
>
>  #define FIXMAP_PAGE_COMMON     (L_PTE_YOUNG | L_PTE_PRESENT |
> L_PTE_XN | L_PTE_DIRTY)
>
> -#define FIXMAP_PAGE_NORMAL     (FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
> -#define FIXMAP_PAGE_RO         (FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
> +#define __FIXMAP_MT_NORMAL     ((pgprot_val(pgprot_kernel) ?:
> FIXMAP_PAGE_COMMON) | \
> +                                L_PTE_MT_WRITEBACK)

... only this L_PTE_MT_WRITEBACK belongs next to FIXMAP_PAGE_COMMON,
since pgprot_kernel will already have a memory type index set, which
may conflict with MT_WRITEBACK



> +#define FIXMAP_PAGE_NORMAL     __pgprot(__FIXMAP_MT_NORMAL)
> +#define FIXMAP_PAGE_RO         __pgprot(__FIXMAP_MT_NORMAL | L_PTE_RDONLY)
>
>  /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
> -#define FIXMAP_PAGE_IO         (FIXMAP_PAGE_COMMON |
> L_PTE_MT_DEV_SHARED | L_PTE_SHARED)
> +#define FIXMAP_PAGE_IO         __pgprot(FIXMAP_PAGE_COMMON |
> L_PTE_MT_DEV_SHARED | \
> +                                        L_PTE_SHARED)
>  #define FIXMAP_PAGE_NOCACHE    FIXMAP_PAGE_IO
>
>  #define __early_set_fixmap     __set_fixmap
>
> (and drop the change to mm/mmu.c), which boils down to the same for
> fixmap but does not affect other users of pgprot_kernel. Also, it
> appears these definitions are broken under STRICT_MM_TYPECHECKS so
> this is a good opportunity to get that fixed as well.
>
> Thank,
> Ard.
>
>
>>
>>
>>> That's why I'm marking this as an RFC, perhaps the correct fix is to
>>> rework the code to use the defines from arch/arm/include/asm/pgtable.h
>>>
>>>  arch/arm/include/asm/fixmap.h       | 2 +-
>>>  arch/arm/probes/kprobes/test-core.h | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
>>> index 5c17d2dec777..26d4a4677cd7 100644
>>> --- a/arch/arm/include/asm/fixmap.h
>>> +++ b/arch/arm/include/asm/fixmap.h
>>> @@ -41,7 +41,7 @@ static const enum fixed_addresses __end_of_fixed_addresses =
>>>
>>>  #define FIXMAP_PAGE_COMMON   (L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN |
>>> L_PTE_DIRTY)
>>>
>>> -#define FIXMAP_PAGE_NORMAL   (FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
>>> +#define FIXMAP_PAGE_NORMAL   (FIXMAP_PAGE_COMMON | L_PTE_SHARED |
>>> L_PTE_MT_WRITEBACK)
>>>  #define FIXMAP_PAGE_RO               (FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
>>>
>>>  /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
>>> diff --git a/arch/arm/probes/kprobes/test-core.h
>>> b/arch/arm/probes/kprobes/test-core.h
>>> index 94285203e9f7..cde2b4e9358a 100644
>>> --- a/arch/arm/probes/kprobes/test-core.h
>>> +++ b/arch/arm/probes/kprobes/test-core.h
>>> @@ -8,7 +8,7 @@
>>>   * published by the Free Software Foundation.
>>>   */
>>>
>>> -#define VERBOSE 0 /* Set to '1' for more logging of test cases */
>>> +#define VERBOSE 1 /* Set to '1' for more logging of test cases */
>>
>> That seems to be unrelated.
>>
>> --
>> Stefan
>>
>>>
>>>  #ifdef CONFIG_THUMB2_KERNEL
>>>  #define NORMAL_ISA "16"
