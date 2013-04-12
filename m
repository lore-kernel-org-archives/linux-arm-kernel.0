From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 16:22:46 +0100
Subject: [PATCH v3 02/32] arm64: KVM: define HYP and Stage-2 translation
 page flags
In-Reply-To: <20130410140706.GF26992@mudshark.cambridge.arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-3-git-send-email-marc.zyngier@arm.com>
 <20130410140706.GF26992@mudshark.cambridge.arm.com>
Message-ID: <516826C6.60603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/13 15:07, Will Deacon wrote:
> On Mon, Apr 08, 2013 at 05:17:04PM +0100, Marc Zyngier wrote:
>> Add HYP and S2 page flags, for both normal and device memory.
>>
>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/include/asm/pgtable-hwdef.h | 13 +++++++++++++
>>  arch/arm64/include/asm/pgtable.h       | 12 ++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index 75fd13d..acb4ee5 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -35,6 +35,7 @@
>>  /*
>>   * Section
>>   */
>> +#define PMD_SECT_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
>>  #define PMD_SECT_S		(_AT(pmdval_t, 3) << 8)
>>  #define PMD_SECT_AF		(_AT(pmdval_t, 1) << 10)
>>  #define PMD_SECT_NG		(_AT(pmdval_t, 1) << 11)
>> @@ -68,6 +69,18 @@
>>  #define PTE_ATTRINDX_MASK	(_AT(pteval_t, 7) << 2)
>>  
>>  /*
>> + * 2nd stage PTE definitions
>> + */
>> +#define PTE_S2_RDONLY		 (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
>> +#define PTE_S2_RDWR		 (_AT(pteval_t, 2) << 6)   /* HAP[2:1] */
> 
> Is this correct? My reading of the translation spec is that this is
> write-only.

Mumble mumble... This is wrong, hidden by some other bug, and 32bit
suffers from the same defect (though it seems to work fine...). Irk!

>> +
>> +/*
>> + * EL2/HYP PTE/PMD definitions
>> + */
>> +#define PMD_HYP			PMD_SECT_USER
>> +#define PTE_HYP			PTE_USER
>> +
>> +/*
>>   * 40-bit physical address supported.
>>   */
>>  #define PHYS_MASK_SHIFT		(40)
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index e333a24..7c84ab4 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -76,6 +76,12 @@ extern pgprot_t pgprot_default;
>>  #define PAGE_KERNEL		_MOD_PROT(pgprot_default, PTE_PXN | PTE_UXN | PTE_DIRTY)
>>  #define PAGE_KERNEL_EXEC	_MOD_PROT(pgprot_default, PTE_UXN | PTE_DIRTY)
>>  
>> +#define PAGE_HYP		_MOD_PROT(pgprot_default, PTE_HYP)
>> +#define PAGE_HYP_DEVICE		_MOD_PROT(__pgprot(PROT_DEVICE_nGnRE), PTE_HYP)
> 
> You're dragging in UXN and PXN bits from PROT_DEVICE_nGnRE, which I don't
> think exist at EL2.

They do exist at EL2, but not in S2. I'll fix that as well.

>> +#define PAGE_S2			_MOD_PROT(pgprot_default, PTE_USER | PTE_S2_RDONLY)
>> +#define PAGE_S2_DEVICE		_MOD_PROT(__pgprot(PROT_DEVICE_nGnRE), PTE_USER | PTE_S2_RDWR)
> 
> You shouldn't set the user bit for stage-2 entries.

Yeah, I already fixed that one.

Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...
