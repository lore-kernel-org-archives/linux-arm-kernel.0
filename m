From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 13 Oct 2016 13:25:53 +0100
Subject: [PATCH v3 1/5] arm64: mm: BUG on unsupported manipulations of
 live kernel mappings
In-Reply-To: <20161012150428.s4gajqlnnivo6bld@localhost>
References: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
 <1476271425-19401-2-git-send-email-ard.biesheuvel@linaro.org>
 <20161012150428.s4gajqlnnivo6bld@localhost>
Message-ID: <CAKv+Gu8p06DBaDgmJ3KSSfNVDox=wOTav48kti+Y0gYtQhEC_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 October 2016 at 16:04, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Oct 12, 2016 at 12:23:41PM +0100, Ard Biesheuvel wrote:
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -28,8 +28,6 @@
>>  #include <linux/memblock.h>
>>  #include <linux/fs.h>
>>  #include <linux/io.h>
>> -#include <linux/slab.h>
>> -#include <linux/stop_machine.h>
>>
>>  #include <asm/barrier.h>
>>  #include <asm/cputype.h>
>> @@ -95,6 +93,12 @@ static phys_addr_t __init early_pgtable_alloc(void)
>>       return phys;
>>  }
>>
>> +/*
>> + * The following mapping attributes may be updated in live
>> + * kernel mappings without the need for break-before-make.
>> + */
>> +static const pteval_t modifiable_attr_mask = PTE_PXN | PTE_RDONLY | PTE_WRITE;
>> +
>>  static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>                                 unsigned long end, unsigned long pfn,
>>                                 pgprot_t prot,
>> @@ -115,8 +119,18 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>
>>       pte = pte_set_fixmap_offset(pmd, addr);
>>       do {
>> +             pte_t old_pte = *pte;
>> +
>>               set_pte(pte, pfn_pte(pfn, prot));
>>               pfn++;
>> +
>> +             /*
>> +              * After the PTE entry has been populated once, we
>> +              * only allow updates to the permission attributes.
>> +              */
>> +             BUG_ON(pte_val(old_pte) != 0 &&
>> +                    ((pte_val(old_pte) ^ pte_val(*pte)) &
>> +                     ~modifiable_attr_mask) != 0);
>
> Please turn this check into a single macro. You have it in three places
> already (though with different types but a macro would do). Something
> like below (feel free to come up with a better macro name):
>
>                 BUG_ON(!safe_pgattr_change(old_pte, *pte));
>

Something like below? With that, I can also fold the PMD and PUD
versions of the BUG() together.

"""
/*
 * Returns whether updating a live page table entry is safe:
 * - if the old and new values are identical,
 * - if an invalid mapping is turned into a valid one (or vice versa),
 * - if the entry is a block or page mapping, and the old and new values
 *   only differ in the PXN/RDONLY/WRITE bits.
 *
 * NOTE: 'safe' does not imply that no TLB maintenance is required, it only
 *       means that no TLB conflicts should occur as a result of the update.
 */
#define __set_pgattr_is_safe(type, old, new, blocktype) \
(type ## _val(old) == type ## _val(new) || \
((type ## _val(old) ^ type ## _val(new)) & PTE_VALID) != 0 || \
(((type ## _val(old) & PTE_TYPE_MASK) == blocktype) && \
 (((type ## _val(old) ^ type ## _val(new)) & \
   ~(PTE_PXN | PTE_RDONLY | PTE_WRITE)) == 0)))

static inline bool set_live_pte_is_safe(pte_t old, pte_t new)
{
return __set_pgattr_is_safe(pte, old, new, PTE_TYPE_PAGE);
}

static inline bool set_live_pmd_is_safe(pmd_t old, pmd_t new)
{
return __set_pgattr_is_safe(pmd, old, new, PMD_TYPE_SECT);
}

static inline bool set_live_pud_is_safe(pud_t old, pud_t new)
{
return __set_pgattr_is_safe(pud, old, new, PUD_TYPE_SECT);
}
"""
