From: cpandya@codeaurora.org (Chintan Pandya)
Date: Tue, 27 Mar 2018 10:08:02 +0530
Subject: [PATCH v4 2/3] arm64: Implement page table free interfaces
In-Reply-To: <20180326095541.izogc4iak6d7nerm@lakrids.cambridge.arm.com>
References: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
 <1521546314-31753-3-git-send-email-cpandya@codeaurora.org>
 <20180326095541.izogc4iak6d7nerm@lakrids.cambridge.arm.com>
Message-ID: <b5427cbd-28f8-e561-cfca-751006e60da1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/26/2018 3:25 PM, Mark Rutland wrote:
> On Tue, Mar 20, 2018 at 05:15:13PM +0530, Chintan Pandya wrote:
>> +static int __pmd_free_pte_page(pmd_t *pmd, unsigned long addr, bool tlb_inv)
>> +{
>> +	pmd_t *table;
>> +
>> +	if (pmd_val(*pmd)) {
>> +		table = __va(pmd_val(*pmd));
>> +		pmd_clear(pmd);
>> +		/*
>> +		 * FIXME: __flush_tlb_pgtable(&init_mm, addr) is
>> +		 *        ideal candidate here, which exactly
>> +		 *        flushes intermediate pgtables. But,
>> +		 *        this is broken (evident from tests).
>> +		 *        So, use safe TLB op unless that is fixed.
>> +		 */
>> +		if (tlb_inv)
>> +			flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> 
> I don't think that __flush_tlb_pgtable() is broken. It's only valid to
> call it for user page tables, since it doesn't affect all ASIDs.
> 
> We can add a simlar helper for kernel mappings, which affects all ASIDs,
> e.g.
> 
Okay. I will test it and update v5.

> static inline void __flush_tlb_kernel_pgtable(unsigned long addr)
> {
> 	addr >>= 12;
> 	__tlbi(vaae1is, addr);
> 	dsb(ish);
> }
> 
> Thanks,
> Mark.
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
