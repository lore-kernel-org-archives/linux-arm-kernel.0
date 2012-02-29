From: bill4carson@gmail.com (bill4carson)
Date: Wed, 29 Feb 2012 19:28:30 +0800
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <20120229103207.GB17745@arm.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
 <20120229103207.GB17745@arm.com>
Message-ID: <4F4E0BDE.6040708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?02?29? 18:32, Catalin Marinas wrote:
> On Mon, Feb 13, 2012 at 09:44:22AM +0000, Bill Carson wrote:
>> --- /dev/null
>> +++ b/arch/arm/include/asm/hugetlb.h
> ...
>> +#include<asm/page.h>
>> +#include<asm/pgtable-2level.h>
>
> Just include asm/pgtable.h, it includes the right 2level.h file
> automatically (and I plan to add LPAE support as well).
>
>> +static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>> +				   pte_t *ptep, pte_t pte)
>> +{
>> +	pgd_t *pgd;
>> +	pud_t *pud;
>> +	pmd_t *pmd;
>> +	pte_t *linuxpte = mm->context.huge_linux_pte;
>> +
>> +	BUG_ON(linuxpte == NULL);
>> +	BUG_ON(HUGE_LINUX_PTE_INDEX(addr)>= HUGE_LINUX_PTE_COUNT);
>> +	BUG_ON(ptep !=&linuxpte[HUGE_LINUX_PTE_INDEX(addr)]);
>> +
>> +	/* set huge linux pte first */
>> +	*ptep = pte;
>> +	
>> +	/* then set hardware pte */
>> +	addr&= HPAGE_MASK;
>> +	pgd = pgd_offset(mm, addr);
>> +	pud = pud_offset(pgd, addr);
>> +	pmd = pmd_offset(pud, addr);
>> +	set_hugepte_at(mm, addr, pmd, pte);
>
> You may want to add a comment here that we only have two levels of page
> tables (and there is no need for pud_none() checks).
>
I will add a comment to clarify this.

> Also I would say the set_hugepte_at function name is easily confused
> with set_huge_pte_at(), maybe change it to __set_huge_pte_at() or
> something else.
>
yes, I will make that change.


>> +static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>> +					    unsigned long addr, pte_t *ptep)
>> +{
>> +	pte_t pte = *ptep;
>> +	pte_t fake = L_PTE_YOUNG;
>> +	pgd_t *pgd;
>> +	pud_t *pud;
>> +	pmd_t *pmd;
>> +
>> +	/* clear linux pte */
>> +	*ptep = 0;
>> +
>> +	/* let set_hugepte_at clear HW entry */
>> +	addr&= HPAGE_MASK;
>> +	pgd = pgd_offset(mm, addr);
>> +	pud = pud_offset(pgd, addr);
>> +	pmd = pmd_offset(pud, addr);
>> +	set_hugepte_at(mm, addr, pmd, fake);
>
> Same here.
>
>> +static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>> +					   unsigned long addr, pte_t *ptep)
>> +{
>> +	pte_t old_pte = *ptep;
>> +	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(old_pte));
>> +}
>
> You could use the generic ptep_set_wrprotect()

I'm a bit of confused about this.

generic ptep_set_wrprotect() can not set huge pte, that's why
set_huge_pte_at is used instead here.


>
>> +static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>> +					     unsigned long addr,
>> +					     pte_t *ptep, pte_t pte,
>> +					     int dirty)
>> +{
>> +	int changed = !pte_same(huge_ptep_get(ptep), pte);
>> +	if (changed) {
>> +		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>> +		huge_ptep_clear_flush(vma, addr,&pte);
>> +	}
>> +
>> +	return changed;
>> +}
>
> I could also use the generic ptep_set_access_flags().

Same as above.

IMHO, cannot use generic hooks here, cause we are setting huge pte
with a different set pte API than set_pte_at.


>
>> --- /dev/null
>> +++ b/arch/arm/mm/hugetlb.c
> ...
>> +pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr,
>> +		      unsigned long sz)
>> +{
>> +	pte_t *linuxpte = mm->context.huge_linux_pte;
>> +	int index;
>> +
>> +	if (linuxpte == NULL) {
>> +		linuxpte = kzalloc(HUGE_LINUX_PTE_SIZE, GFP_ATOMIC);
>> +		if (linuxpte == NULL) {
>> +			printk(KERN_ERR "Cannot allocate memory for huge linux pte\n");
>
> pr_err()?
Yes, pr_err should be used in here.
thanks


>
>> +			return NULL;
>> +		}
>> +		mm->context.huge_linux_pte = linuxpte;
>> +	}
>> +	/* huge page mapping only cover user space address */
>> +	BUG_ON(HUGE_LINUX_PTE_INDEX(addr)>= HUGE_LINUX_PTE_COUNT);
>> +	index = HUGE_LINUX_PTE_INDEX(addr);
>> +	return&linuxpte[HUGE_LINUX_PTE_INDEX(addr)];
>> +}
>> +
>> +pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	pgd_t *pgd;
>> +	pud_t *pud;
>> +	pmd_t *pmd = NULL;
>> +	pte_t *linuxpte = mm->context.huge_linux_pte;
>> +
>> +	/* check this mapping exist at pmd level */
>> +	pgd = pgd_offset(mm, addr);
>> +	if (pgd_present(*pgd)) {
>> +		pud = pud_offset(pgd, addr);
>> +		pmd = pmd_offset(pud, addr);
>> +		if (!pmd_present(*pmd))
>> +			return NULL;
>> +	}
>
> You could add checks for the pud as well, they would be optimised out by
> the compiler but it would be easier to add support for LPAE as well. In
> my LPAE hugetlb implementation, I have something like this:
>
> 	pgd = pgd_offset(mm, addr);
> 	if (pgd_present(*pgd)) {
> 		pud = pud_offset(pgd, addr);
> 		if (pud_present(*pud))
> 			pmd = pmd_offset(pud, addr);
> 	}
>
Ok, I will add the pud checks as per your comment.



>> +	BUG_ON(HUGE_LINUX_PTE_INDEX(addr)>= HUGE_LINUX_PTE_COUNT);
>> +	BUG_ON((*pmd&  PMD_TYPE_MASK) != PMD_TYPE_SECT);
>> +	return&linuxpte[HUGE_LINUX_PTE_INDEX(addr)];
>
> You could add a macro to make it easier for LPAE:
>
> #define huge_pte(mm, pmd, addr)		\
> 	(&mm->context.huge_linux_pte(HUGE_LINUX_PTE_INDEX(addr)))
>
Nice, I will keep this in V3.


> With LPAE, it would simply be a (pte_t *)pmd cast.
>
>> +int pud_huge(pud_t pud)
>> +{
>> +	return  0; } struct page * follow_huge_pmd(struct mm_struct *mm, unsigned long address, pmd_t *pmd, int write)
>
> Something went wrong around here.
>
crap! I will make it cleaner next time. I promise!


>> +{
>> +	struct page *page = NULL;
>
> You don't need to initialise page here.
OK, I will drop the "NULL".

>
>> +	unsigned long pfn;
>> +
>> +	BUG_ON((pmd_val(*pmd)&  PMD_TYPE_MASK) != PMD_TYPE_SECT);
>> +	pfn = ((pmd_val(*pmd)&  HPAGE_MASK)>>  PAGE_SHIFT);
>> +	page = pfn_to_page(pfn);
>> +	return page;
>> +}
>> +
>> +static int __init add_huge_page_size(unsigned long long size)
>> +{
>> +	int shift = __ffs(size);
>> +	u32 mmfr3 = 0;
>> +
>> +	/* Check that it is a page size supported by the hardware and
>> +	 * that it fits within pagetable and slice limits. */
>> +	if (!is_power_of_2(size) || (shift != HPAGE_SHIFT))
>> +		return -EINVAL;
>
> You could use get_order() instead of __ffs(), the latter just finds the
> first bit set.
With all due respect, I'm afraid I can't agree with you on this.
here, we should use __ffs to return this "shift" not the order.

For "hugepagesz=2M", hpage_shift/HPAGE_SHIFT should be set to 21,
*not* the order 9(21-12), that's what HUGETLB_PAGE_ORDER for.


>
> But here you should have set hpage_shift.
>

-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
