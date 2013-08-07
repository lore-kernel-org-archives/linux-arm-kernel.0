From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 07 Aug 2013 11:34:04 +0100
Subject: [PATCH] arm64: KVM: fix 2-level page tables unmapping
In-Reply-To: <20130806204943.GK16694@cbox>
References: <1375790748-10296-1-git-send-email-marc.zyngier@arm.com>
 <20130806204943.GK16694@cbox>
Message-ID: <5202229C.5040007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/13 21:49, Christoffer Dall wrote:
> On Tue, Aug 06, 2013 at 01:05:48PM +0100, Marc Zyngier wrote:
>> When using 64kB pages, we only have two levels of page tables,
>> meaning that PGD, PUD and PMD are fused. In this case, trying
>> to refcount PUDs and PMDs independantly is a a complete disaster,
> 
> independently
> 
>> as they are the same.
>>
>> We manage to get it right for the allocation (stage2_set_pte uses
>> {pmd,pud}_none), but the unmapping path clears both pud and pmd
>> refcounts, which fails spectacularly with 2-level page tables.
>>
>> The fix is to avoid calling clear_pud_entry when both the pmd and
>> pud pages are empty. For this, and instead of introducing another
>> pud_empty function, consolidate both pte_empty and pmd_empty into
>> page_empty (the code is actually identical) and use that to also
>> test the validity of the pud.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/kvm/mmu.c | 22 ++++++++--------------
>>  1 file changed, 8 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index ca6bea4..7e1d899 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -85,6 +85,12 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
>>  	return p;
>>  }
>>  
>> +static bool page_empty(void *ptr)
>> +{
>> +	struct page *ptr_page = virt_to_page(ptr);
>> +	return page_count(ptr_page) == 1;
>> +}
>> +
>>  static void clear_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
>>  {
>>  	pmd_t *pmd_table = pmd_offset(pud, 0);
>> @@ -103,12 +109,6 @@ static void clear_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr)
>>  	put_page(virt_to_page(pmd));
>>  }
>>  
>> -static bool pmd_empty(pmd_t *pmd)
>> -{
>> -	struct page *pmd_page = virt_to_page(pmd);
>> -	return page_count(pmd_page) == 1;
>> -}
>> -
>>  static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
>>  {
>>  	if (pte_present(*pte)) {
>> @@ -118,12 +118,6 @@ static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
>>  	}
>>  }
>>  
>> -static bool pte_empty(pte_t *pte)
>> -{
>> -	struct page *pte_page = virt_to_page(pte);
>> -	return page_count(pte_page) == 1;
>> -}
>> -
>>  static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>>  			unsigned long long start, u64 size)
>>  {
>> @@ -153,10 +147,10 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>>  		range = PAGE_SIZE;
>>  
>>  		/* If we emptied the pte, walk back up the ladder */
>> -		if (pte_empty(pte)) {
>> +		if (page_empty(pte)) {
>>  			clear_pmd_entry(kvm, pmd, addr);
>>  			range = PMD_SIZE;
>> -			if (pmd_empty(pmd)) {
>> +			if (page_empty(pmd) && !page_empty(pud)) {
>>  				clear_pud_entry(kvm, pud, addr);
>>  				range = PUD_SIZE;
>>  			}
> 
> looks right, an alternative would be to check in clear_pud_entry if the
> entry actually had a value, but I don't think it's really clearer.
> 
> However, this got me thinking a bit.  What happens if we pass a non-pmd
> aligned address to unmap_range, and let's assume the size of the range
> is more than 2MB, won't we be leaking memory by incrementing with
> PMD_SIZE?  (same argument goes for PUD_SIZE).  See the patch below:
> 
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index ca6bea4..80a83ec 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -132,37 +132,37 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>  	pmd_t *pmd;
>  	pte_t *pte;
>  	unsigned long long addr = start, end = start + size;
> -	u64 range;
> +	u64 next;
>  
>  	while (addr < end) {
>  		pgd = pgdp + pgd_index(addr);
>  		pud = pud_offset(pgd, addr);
>  		if (pud_none(*pud)) {
> -			addr += PUD_SIZE;
> +			addr = pud_addr_end(addr, end);
>  			continue;
>  		}
>  
>  		pmd = pmd_offset(pud, addr);
>  		if (pmd_none(*pmd)) {
> -			addr += PMD_SIZE;
> +			addr = pmd_addr_end(addr, end);
>  			continue;
>  		}
>  
>  		pte = pte_offset_kernel(pmd, addr);
>  		clear_pte_entry(kvm, pte, addr);
> -		range = PAGE_SIZE;
> +		next = addr + PAGE_SIZE;
>  
>  		/* If we emptied the pte, walk back up the ladder */
>  		if (pte_empty(pte)) {
>  			clear_pmd_entry(kvm, pmd, addr);
> -			range = PMD_SIZE;
> +			next = pmd_addr_end(addr, end);
>  			if (pmd_empty(pmd)) {
>  				clear_pud_entry(kvm, pud, addr);
> -				range = PUD_SIZE;
> +				next = pud_addr_end(addr, end);
>  			}
>  		}
>  
> -		addr += range;
> +		addr = next;
>  	}
>  }

That looks sensible. Would you prepare a patch on which I could rebase
the above?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
