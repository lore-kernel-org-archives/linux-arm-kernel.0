From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 24 Dec 2014 00:37:14 +0900
Subject: [PATCH] arm64: mm: Add pgd_page to support RCU fast_gup
In-Reply-To: <20141222162823.GB15240@e104818-lin.cambridge.arm.com>
References: <11B98DF8-2B98-414B-88E5-14C97ADAA60E@gmail.com>
 <20141221105633.GJ23242@arm.com>
 <20141222123051.GC20269@e104818-lin.cambridge.arm.com>
 <374BBC79-DD7B-4FEC-A1B3-DD6D14ED30A8@gmail.com>
 <20141222153111.GA15240@e104818-lin.cambridge.arm.com>
 <20141222162823.GB15240@e104818-lin.cambridge.arm.com>
Message-ID: <0341C428-A85D-4085-9F75-893576D42A65@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 23, 2014, at 1:28 AM, Catalin Marinas wrote:
> On Mon, Dec 22, 2014 at 03:31:12PM +0000, Catalin Marinas wrote:
>> On Mon, Dec 22, 2014 at 03:11:37PM +0000, Jungseok Lee wrote:
>>> On Dec 22, 2014, at 9:30 PM, Catalin Marinas wrote:
>>>> On Sun, Dec 21, 2014 at 10:56:33AM +0000, Will Deacon wrote:
>>>>> On Sat, Dec 20, 2014 at 12:49:40AM +0000, Jungseok Lee wrote:
>>>>>> This patch adds pgd_page definition in order to keep supporting
>>>>>> HAVE_GENERIC_RCU_GUP configuration. In addition, it changes pud_page
>>>>>> expression to align with pmd_page for readability.
>>>>>> 
>>>>>> An introduction of pgd_page resolves the following build breakage
>>>>>> under 4KB + 4Level memory management combo.
>>>>>> 
>>>>>> mm/gup.c: In function 'gup_huge_pgd':
>>>>>> mm/gup.c:889:2: error: implicit declaration of function 'pgd_page' [-Werror=implicit-function-declaration]
>>>>>> head = pgd_page(orig);
>>>>>> ^
>>>>>> mm/gup.c:889:7: warning: assignment makes pointer from integer without a cast
>>>>>> head = pgd_page(orig);
>>>>>> 
>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>> Cc: Steve Capper <steve.capper@linaro.org>
>>>>>> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
>>>>>> ---
>>>>>> arch/arm64/include/asm/pgtable.h | 4 +++-
>>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>> 
>>>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>>>> index df22314..a1fe927 100644
>>>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>>>> @@ -401,7 +401,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>>>>>> 	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(addr);
>>>>>> }
>>>>>> 
>>>>>> -#define pud_page(pud)           pmd_page(pud_pmd(pud))
>>>>>> +#define pud_page(pud)		pfn_to_page(__phys_to_pfn(pud_val(pud) & PHYS_MASK))
>>>>> 
>>>>> It would be cleaner to use pud_pfn here, otherwise we end up passing a
>>>>> physical address with the lower attributes present to __phys_to_pfn, which
>>>>> "knows" to shift them away.
>>>> 
>>>> It looks like we did the same with pmd_page() but not with pte_page(),
>>>> the latter using pte_pfn().
>>>> 
>>>> It's not a problem with lower attributes because they are within the
>>>> first 12 bits, so the shifting gets rid of them. For pmd/pud/pgd, bits
>>>> above 12 and up to the actual address must be 0.
>>>> 
>>>> I agree with changing all of them to use pte/pmd/pud/pgd_pfn but I'm
>>>> inclined to merge this patch now to fix the kernel build and we'll look
>>>> at the clean-up after Christmas.
>>> 
>>> Either way, I'm fine.
>> 
>> Unless you post an updated patch quickly enough ;)
> 
> Actually, don't worry, I'll fold Will's suggestions into your patch. I
> found another problem with pmd_page being defined twice.

Yeah. One of them should be removed.

I tried to rework the patch with Will's suggestion, but I've failed to figure
out a full story of pmd_pfn and pmd_page.

It looks like that pmd_page cannot be written using pmd_pfn unless pmd_pfn is
changed since pmd_pfn masks an input value with PMD_MASK, but pmd_page does not.
Additionally, I'm not sure about whether pmd_pfn with PMD_MASK works well for an
user process page table.

So, my change on pmd_pfn and pmd_page is as follows. Please correct me if I am wrong.


-----8<-----

--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -294,11 +294,11 @@ void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned long address,
 
 #define pmd_mkhuge(pmd)                (__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
 
-#define pmd_pfn(pmd)           (((pmd_val(pmd) & PMD_MASK) & PHYS_MASK) >> PAGE_SHIFT)
+#define pmd_pfn(pmd)           ((pmd_val(pmd) & PHYS_MASK) >> PAGE_SHIFT)
 #define pfn_pmd(pfn,prot)      (__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
 #define mk_pmd(page,prot)      pfn_pmd(page_to_pfn(page),prot)
 
-#define pmd_page(pmd)           pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
+#define pmd_page(pmd)          pfn_to_page(pmd_pfn(pmd))
 #define pud_write(pud)         pte_write(pud_pte(pud))
 #define pud_pfn(pud)           (((pud_val(pud) & PUD_MASK) & PHYS_MASK) >> PAGE_SHIFT)


Thanks for a kind response, Catalin and Will!

Best Regards
Jungseok Lee
