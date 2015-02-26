From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Feb 2015 17:31:45 +0000
Subject: [RFC PATCH 1/3] ARM, arm64: kvm: get rid of the bounce page
In-Reply-To: <54EF458A.4090205@arm.com>
References: <1424964547-2118-1-git-send-email-ard.biesheuvel@linaro.org>
 <1424964547-2118-2-git-send-email-ard.biesheuvel@linaro.org>
 <54EF458A.4090205@arm.com>
Message-ID: <CAKv+Gu_HuVuh7VE8shn4WnLfq0ankvkt2uSP2eG_2cczRAfApw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2015 at 16:10, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 26/02/15 15:29, Ard Biesheuvel wrote:
>> The HYP init bounce page is a runtime construct that ensures that the
>> HYP init code does not cross a page boundary. However, this is something
>> we can do perfectly well at build time, by aligning the code appropriately.
>>
>> For arm64, we just align to 4 KB, and enforce that the code size is less
>> than 4 KB, regardless of the chosen page size.
>>
>> For ARM, the whole code is less than 256 bytes, so we tweak the linker
>> script to align at a power of 2 upper bound of the code size
>>
>> Note that this also fixes a benign off-by-one error in the original bounce
>> page code, where a bounce page would be allocated unnecessarily if the code
>> was exactly 1 page in size.
>
> I really like this simplification. Can you please check that it still
> work on 32bit with this patch from Arnd?
>
> https://www.mail-archive.com/kvm at vger.kernel.org/msg112364.html
>

Yes, it does.

Note that the kernel's RODATA permissions shouldn't affect whether
this code is executable or not in HYP mode, so I think this code
belongs in RODATA in the 1st place.

> Another question below:
>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm/kernel/vmlinux.lds.S   | 12 +++++++++---
>>  arch/arm/kvm/init.S             | 11 +++++++++++
>>  arch/arm/kvm/mmu.c              | 42 +++++------------------------------------
>>  arch/arm64/kernel/vmlinux.lds.S | 18 ++++++++++++------
>>  4 files changed, 37 insertions(+), 46 deletions(-)
>>
>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>> index b31aa73e8076..8179d3903dee 100644
>> --- a/arch/arm/kernel/vmlinux.lds.S
>> +++ b/arch/arm/kernel/vmlinux.lds.S
>> @@ -23,7 +23,7 @@
>>       VMLINUX_SYMBOL(__idmap_text_start) = .;                         \
>>       *(.idmap.text)                                                  \
>>       VMLINUX_SYMBOL(__idmap_text_end) = .;                           \
>> -     . = ALIGN(32);                                                  \
>> +     . = ALIGN(1 << __hyp_idmap_align_order);                        \
>>       VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;                     \
>>       *(.hyp.idmap.text)                                              \
>>       VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
>> @@ -346,8 +346,14 @@ SECTIONS
>>   */
>>  ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
>>  ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
>> +
>>  /*
>> - * The HYP init code can't be more than a page long.
>> + * The HYP init code can't be more than a page long,
>> + * and should not cross a page boundary.
>>   * The above comment applies as well.
>>   */
>> -ASSERT(((__hyp_idmap_text_end - __hyp_idmap_text_start) <= PAGE_SIZE), "HYP init code too big")
>> +ASSERT(((__hyp_idmap_text_end - 1) & PAGE_MASK) -
>> +     (__hyp_idmap_text_start & PAGE_MASK) == 0,
>> +     "HYP init code too big or unaligned")
>> +ASSERT(__hyp_idmap_size <= (1 << __hyp_idmap_align_order),
>> +     "__hyp_idmap_size should be <= (1 << __hyp_idmap_align_order)")
>> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
>> index 3988e72d16ff..7a279bc8e0e1 100644
>> --- a/arch/arm/kvm/init.S
>> +++ b/arch/arm/kvm/init.S
>> @@ -157,3 +157,14 @@ target:  @ We're now in the trampoline code, switch page tables
>>  __kvm_hyp_init_end:
>>
>>       .popsection
>> +
>> +     /*
>> +      * When making changes to this file, make sure that the value of
>> +      * __hyp_idmap_align_order is updated if the size of the code ends up
>> +      * exceeding (1 << __hyp_idmap_align_order). This helps ensure that the
>> +      * code never crosses a page boundary, without wasting too much memory
>> +      * on aligning to PAGE_SIZE.
>> +      */
>> +     .global __hyp_idmap_size, __hyp_idmap_align_order
>> +     .set    __hyp_idmap_size, __kvm_hyp_init_end - __kvm_hyp_init
>> +     .set    __hyp_idmap_align_order, 8
>
> Is there a way to generate this __hyp_idmap_align_order automatically?
> We're already pretty close to this 8 bit limit...
>

This seems to work:

#define HYP_IDMAP_ALIGN \
__hyp_idmap_size <= 0x100 ? 0x100 : \
__hyp_idmap_size <= 0x200 ? 0x200 : \
__hyp_idmap_size <= 0x400 ? 0x400 : \
__hyp_idmap_size <= 0x800 ? 0x800 : 0x1000

and

. = ALIGN(HYP_IDMAP_ALIGN); \

and we are limited at 1 page anyway.

Should I respin and include the move to RODATA@the same time?
Or would you like me to rebase onto Arnd's patch?

-- 
Ard.

>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 3e6859bc3e11..42a24d6b003b 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -37,7 +37,6 @@ static pgd_t *boot_hyp_pgd;
>>  static pgd_t *hyp_pgd;
>>  static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
>>
>> -static void *init_bounce_page;
>>  static unsigned long hyp_idmap_start;
>>  static unsigned long hyp_idmap_end;
>>  static phys_addr_t hyp_idmap_vector;
>> @@ -405,9 +404,6 @@ void free_boot_hyp_pgd(void)
>>       if (hyp_pgd)
>>               unmap_range(NULL, hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
>>
>> -     free_page((unsigned long)init_bounce_page);
>> -     init_bounce_page = NULL;
>> -
>>       mutex_unlock(&kvm_hyp_pgd_mutex);
>>  }
>>
>> @@ -1498,39 +1494,11 @@ int kvm_mmu_init(void)
>>       hyp_idmap_end = kvm_virt_to_phys(__hyp_idmap_text_end);
>>       hyp_idmap_vector = kvm_virt_to_phys(__kvm_hyp_init);
>>
>> -     if ((hyp_idmap_start ^ hyp_idmap_end) & PAGE_MASK) {
>> -             /*
>> -              * Our init code is crossing a page boundary. Allocate
>> -              * a bounce page, copy the code over and use that.
>> -              */
>> -             size_t len = __hyp_idmap_text_end - __hyp_idmap_text_start;
>> -             phys_addr_t phys_base;
>> -
>> -             init_bounce_page = (void *)__get_free_page(GFP_KERNEL);
>> -             if (!init_bounce_page) {
>> -                     kvm_err("Couldn't allocate HYP init bounce page\n");
>> -                     err = -ENOMEM;
>> -                     goto out;
>> -             }
>> -
>> -             memcpy(init_bounce_page, __hyp_idmap_text_start, len);
>> -             /*
>> -              * Warning: the code we just copied to the bounce page
>> -              * must be flushed to the point of coherency.
>> -              * Otherwise, the data may be sitting in L2, and HYP
>> -              * mode won't be able to observe it as it runs with
>> -              * caches off at that point.
>> -              */
>> -             kvm_flush_dcache_to_poc(init_bounce_page, len);
>> -
>> -             phys_base = kvm_virt_to_phys(init_bounce_page);
>> -             hyp_idmap_vector += phys_base - hyp_idmap_start;
>> -             hyp_idmap_start = phys_base;
>> -             hyp_idmap_end = phys_base + len;
>> -
>> -             kvm_info("Using HYP init bounce page @%lx\n",
>> -                      (unsigned long)phys_base);
>> -     }
>> +     /*
>> +      * We rely on the linker script to ensure at build time that the HYP
>> +      * init code does not cross a page boundary.
>> +      */
>> +     BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
>>
>>       hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, hyp_pgd_order);
>>       boot_hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, hyp_pgd_order);
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 5d9d2dca530d..17383c257a7d 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -23,10 +23,14 @@ jiffies = jiffies_64;
>>
>>  #define HYPERVISOR_TEXT                                      \
>>       /*                                              \
>> -      * Force the alignment to be compatible with    \
>> -      * the vectors requirements                     \
>> +      * Align to 4K so that                          \
>> +      * a) the HYP vector table is at its minimum    \
>> +      *    alignment of 2048 bytes                   \
>> +      * b) the HYP init code will not cross a page   \
>> +      *    boundary if its size does not exceed      \
>> +      *    4K (see related ASSERT() below)           \
>>        */                                             \
>> -     . = ALIGN(2048);                                \
>> +     . = ALIGN(SZ_4K);                               \
>>       VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;     \
>>       *(.hyp.idmap.text)                              \
>>       VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;       \
>> @@ -163,10 +167,12 @@ SECTIONS
>>  }
>>
>>  /*
>> - * The HYP init code can't be more than a page long.
>> + * The HYP init code can't be more than a page long,
>> + * and should not cross a page boundary.
>>   */
>> -ASSERT(((__hyp_idmap_text_start + PAGE_SIZE) > __hyp_idmap_text_end),
>> -       "HYP init code too big")
>> +ASSERT(((__hyp_idmap_text_end - 1) & ~(SZ_4K - 1)) -
>> +     (__hyp_idmap_text_start & ~(SZ_4K - 1)) == 0,
>> +     "HYP init code too big or unaligned")
>>
>>  /*
>>   * If padding is applied before .head.text, virt<->phys conversions will fail.
>>
>
> Otherwise looks pretty good.
>
>         M.
> --
> Jazz is not dead. It just smells funny...
