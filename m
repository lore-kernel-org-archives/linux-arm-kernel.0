From: dwoods@ezchip.com (David Woods)
Date: Fri, 20 Nov 2015 11:20:49 -0500
Subject: [PATCH v3] arm64: Add support for PTE contiguous bit.
In-Reply-To: <5D0C7112-063F-4116-9585-ADF4ADF97AAE@gmail.com>
References: <1447952231-17631-1-git-send-email-dwoods@ezchip.com>
 <5D0C7112-063F-4116-9585-ADF4ADF97AAE@gmail.com>
Message-ID: <564F4861.5020002@ezchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2015 05:07 AM, yalin wang wrote:
>> +
>> +void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>> +			    pte_t *ptep, pte_t pte)
>> +{
>> +	size_t pgsize;
>> +	int i;
>> +	int ncontig = find_num_contig(mm, addr, ptep, pte, &pgsize);
>> +	unsigned long pfn;
>> +	pgprot_t hugeprot;
>> +
>> +	if (ncontig == 1) {
>> +		set_pte_at(mm, addr, ptep, pte);
>> +		return;
>> +	}
>> +
>> +	pfn = pte_pfn(pte);
>> +	hugeprot = __pgprot(pte_val(pfn_pte(pfn, 0) ^ pte_val(pte)));
> is this should be pte_val(pfn_pte(pfn, 0)) ^ pte_val(pte)  ?
>
The code generated is identical either way, but I agree your way looks 
better.

-Dave
