From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Mar 2013 14:20:50 +0000
Subject: [PATCH v2 02/30] arm64: KVM: define HYP and Stage-2 translation
 page flags
In-Reply-To: <20130327141123.GE1863@MacBook-Pro.local>
References: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
 <1364317285-20937-3-git-send-email-marc.zyngier@arm.com>
 <20130327141123.GE1863@MacBook-Pro.local>
Message-ID: <51530042.1030201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/13 14:11, Catalin Marinas wrote:
> On Tue, Mar 26, 2013 at 05:00:57PM +0000, Marc Zyngier wrote:
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -44,6 +44,7 @@ struct page *empty_zero_page;
>>  EXPORT_SYMBOL(empty_zero_page);
>>  
>>  pgprot_t pgprot_default;
>> +pgprot_t pgprot_device;
>>  EXPORT_SYMBOL(pgprot_default);
>>  
>>  static pmdval_t prot_sect_kernel;
>> @@ -127,10 +128,11 @@ early_param("cachepolicy", early_cachepolicy);
>>   */
>>  static void __init init_mem_pgprot(void)
>>  {
>> -	pteval_t default_pgprot;
>> +	pteval_t default_pgprot, device_pgprot;
>>  	int i;
>>  
>>  	default_pgprot = PTE_ATTRINDX(MT_NORMAL);
>> +	device_pgprot = PTE_ATTRINDX(MT_DEVICE_nGnRE) | PTE_PXN | PTE_UXN;
>>  	prot_sect_kernel = PMD_TYPE_SECT | PMD_SECT_AF | PMD_ATTRINDX(MT_NORMAL);
>>  
>>  #ifdef CONFIG_SMP
>> @@ -138,6 +140,7 @@ static void __init init_mem_pgprot(void)
>>  	 * Mark memory with the "shared" attribute for SMP systems
>>  	 */
>>  	default_pgprot |= PTE_SHARED;
>> +	device_pgprot |= PTE_SHARED;
>>  	prot_sect_kernel |= PMD_SECT_S;
>>  #endif
>>  
>> @@ -147,6 +150,7 @@ static void __init init_mem_pgprot(void)
>>  	}
>>  
>>  	pgprot_default = __pgprot(PTE_TYPE_PAGE | PTE_AF | default_pgprot);
>> +	pgprot_device = __pgprot(PTE_TYPE_PAGE | PTE_AF | device_pgprot);
>>  }
> 
> I don't think all this pgprot_device addition is needed. According to
> the ARMv8 Translation spec, any shareability attributes for Device
> memory are ignored as the memory is always regarded as Outer Shareable.
> That's why the ioremap() implementation on arm64 only uses pre-defined
> constants.

Right. That makes it much simpler then. I'll drop this part and update
the relevant definitions with PROT_DEVICE_nGnRE instead.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
