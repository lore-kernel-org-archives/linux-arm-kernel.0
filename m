From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Tue, 11 Aug 2015 19:25:12 +0300
Subject: [PATCH v5 2/6] x86/kasan, mm: introduce generic
 kasan_populate_zero_shadow()
In-Reply-To: <20150811154117.GH23307@e104818-lin.cambridge.arm.com>
References: <1439259499-13913-1-git-send-email-ryabinin.a.a@gmail.com>
 <1439259499-13913-3-git-send-email-ryabinin.a.a@gmail.com>
 <20150811154117.GH23307@e104818-lin.cambridge.arm.com>
Message-ID: <55CA21E8.2060704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/11/2015 06:41 PM, Catalin Marinas wrote:
> On Tue, Aug 11, 2015 at 05:18:15AM +0300, Andrey Ryabinin wrote:
>> --- /dev/null
>> +++ b/mm/kasan/kasan_init.c
> [...]
>> +#if CONFIG_PGTABLE_LEVELS > 3
>> +pud_t kasan_zero_pud[PTRS_PER_PUD] __page_aligned_bss;
>> +#endif
>> +#if CONFIG_PGTABLE_LEVELS > 2
>> +pmd_t kasan_zero_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> +#endif
>> +pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
> 
> Is there any problem if you don't add the #ifs here? Wouldn't the linker
> remove them if they are not used?
> 


> Original hunk copied here for easy comparison:
> 
>> -static int __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
>> -				unsigned long end)
>> -{
>> -	pte_t *pte = pte_offset_kernel(pmd, addr);
>> -
>> -	while (addr + PAGE_SIZE <= end) {
>> -		WARN_ON(!pte_none(*pte));
>> -		set_pte(pte, __pte(__pa_nodebug(kasan_zero_page)
>> -					| __PAGE_KERNEL_RO));
>> -		addr += PAGE_SIZE;
>> -		pte = pte_offset_kernel(pmd, addr);
>> -	}
>> -	return 0;
>> -}
> [...]
>> +static void __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
>> +				unsigned long end)
>> +{
>> +	pte_t *pte = pte_offset_kernel(pmd, addr);
>> +	pte_t zero_pte;
>> +
>> +	zero_pte = pfn_pte(PFN_DOWN(__pa(kasan_zero_page)), PAGE_KERNEL);
>> +	zero_pte = pte_wrprotect(zero_pte);
>> +
>> +	while (addr + PAGE_SIZE <= end) {
>> +		set_pte_at(&init_mm, addr, pte, zero_pte);
>> +		addr += PAGE_SIZE;
>> +		pte = pte_offset_kernel(pmd, addr);
>> +	}
>> +}
> 
> I think there are some differences with the original x86 code. The first
> one is the use of __pa_nodebug, does it cause any problems if
> CONFIG_DEBUG_VIRTUAL is enabled?
> 
__pa_nodebug() should be used before kasan_early_init(), this piece of code
executed far later, so it's ok to use __pa() here.
This was actually a mistake in original code to use __pa_nodebug().

> The second is the use of a read-only attribute when mapping
> kasan_zero_page on x86. Can it cope with a writable mapping?
> 

Did you miss this line:

+	zero_pte = pte_wrprotect(zero_pte);

?


> If there are no issues, it should be documented in the commit log.
> 
