From: hejianet@gmail.com (Jia He)
Date: Thu, 5 Apr 2018 20:44:12 +0800
Subject: [PATCH v7 2/5] arm: arm64: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
In-Reply-To: <20180405113444.GB2647@bombadil.infradead.org>
References: <1522915478-5044-1-git-send-email-hejianet@gmail.com>
 <1522915478-5044-3-git-send-email-hejianet@gmail.com>
 <20180405113444.GB2647@bombadil.infradead.org>
Message-ID: <1f809296-e88d-1090-0027-890782b91d6e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/5/2018 7:34 PM, Matthew Wilcox Wrote:
> On Thu, Apr 05, 2018 at 01:04:35AM -0700, Jia He wrote:
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But there is
>> still some room for improvement. E.g. if pfn and pfn+1 are in the same
>> memblock region, we can simply pfn++ instead of doing the binary search
>> in memblock_next_valid_pfn.
> Sure, but I bet if we are >end_pfn, we're almost certainly going to the
> start_pfn of the next block, so why not test that as well?
>
>> +	/* fast path, return pfn+1 if next pfn is in the same region */
>> +	if (early_region_idx != -1) {
>> +		start_pfn = PFN_DOWN(regions[early_region_idx].base);
>> +		end_pfn = PFN_DOWN(regions[early_region_idx].base +
>> +				regions[early_region_idx].size);
>> +
>> +		if (pfn >= start_pfn && pfn < end_pfn)
>> +			return pfn;
> 		early_region_idx++;
> 		start_pfn = PFN_DOWN(regions[early_region_idx].base);
> 		if (pfn >= end_pfn && pfn <= start_pfn)
> 			return start_pfn;
Thanks, thus the binary search in next step can be discarded?

-- 
Cheers,
Jia
