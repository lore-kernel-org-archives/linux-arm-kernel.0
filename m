From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Apr 2013 11:59:02 +0100
Subject: [PATCH v4 1/7] ARM: KVM: simplify HYP mapping population
In-Reply-To: <20130426104506.GD5007@localhost.cambridge.arm.com>
References: <1365790327-2138-1-git-send-email-marc.zyngier@arm.com>
 <1365790327-2138-2-git-send-email-marc.zyngier@arm.com>
 <20130426104506.GD5007@localhost.cambridge.arm.com>
Message-ID: <517A5DF6.1070009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/13 11:45, Catalin Marinas wrote:
> On Fri, Apr 12, 2013 at 07:12:01PM +0100, Marc Zyngier wrote:
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 2f12e40..3003321 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
> ...
>> -static int __create_hyp_mappings(void *from, void *to, unsigned long *pfn_base)
>> +static int __create_hyp_mappings(pgd_t *pgdp,
>> +				 unsigned long start, unsigned long end,
>> +				 unsigned long pfn, pgprot_t prot)
>>  {
>> -	unsigned long start = (unsigned long)from;
>> -	unsigned long end = (unsigned long)to;
>>  	pgd_t *pgd;
>>  	pud_t *pud;
>>  	pmd_t *pmd;
>> @@ -209,21 +181,14 @@ static int __create_hyp_mappings(void *from, void *to, unsigned long *pfn_base)
>>  
>>  	if (start >= end)
>>  		return -EINVAL;
>> -	/* Check for a valid kernel memory mapping */
>> -	if (!pfn_base && (!virt_addr_valid(from) || !virt_addr_valid(to - 1)))
>> -		return -EINVAL;
>> -	/* Check for a valid kernel IO mapping */
>> -	if (pfn_base && (!is_vmalloc_addr(from) || !is_vmalloc_addr(to - 1)))
>> -		return -EINVAL;
>>  
>>  	mutex_lock(&kvm_hyp_pgd_mutex);
>> -	for (addr = start; addr < end; addr = next) {
>> -		unsigned long hyp_addr = KERN_TO_HYP(addr);
>> -		pgd = hyp_pgd + pgd_index(hyp_addr);
>> -		pud = pud_offset(pgd, hyp_addr);
>> +	for (addr = start & PAGE_MASK; addr < end; addr = next) {
>> +		pgd = pgdp + pgd_index(addr);
>> +		pud = pud_offset(pgd, addr);
>>  
>>  		if (pud_none_or_clear_bad(pud)) {
>> -			pmd = pmd_alloc_one(NULL, hyp_addr);
>> +			pmd = pmd_alloc_one(NULL, addr);
>>  			if (!pmd) {
>>  				kvm_err("Cannot allocate Hyp pmd\n");
>>  				err = -ENOMEM;
>> @@ -233,9 +198,10 @@ static int __create_hyp_mappings(void *from, void *to, unsigned long *pfn_base)
>>  		}
>>  
>>  		next = pgd_addr_end(addr, end);
>> -		err = create_hyp_pmd_mappings(pud, addr, next, pfn_base);
>> +		err = create_hyp_pmd_mappings(pud, addr, next, pfn, prot);
> 
> I would add another indirection function here like
> create_hyp_pud_mappings() if we are to share this code with arm64. If
> written correctly, the compiler should turn it into no-op. But here you
> just make the assumption that pgd/pud are the same.

Yes, it is a problem that is present across most of KVM/arm[64]. In
general, the code assumes that PUD is folded into PGD.

0> (it can be additional patch at some point if you already prepared these
> patches for upstream)

It is my intention to have an additional patch series that adds proper
PUD handling, so we could properly support 4 level page tables without
any other change.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
