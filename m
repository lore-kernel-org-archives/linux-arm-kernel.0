From: hejianet@gmail.com (Jia He)
Date: Sun, 8 Apr 2018 10:05:08 +0800
Subject: [PATCH v7 2/5] arm: arm64: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
In-Reply-To: <20180406090920.GM16141@n2100.armlinux.org.uk>
References: <1522915478-5044-1-git-send-email-hejianet@gmail.com>
 <1522915478-5044-3-git-send-email-hejianet@gmail.com>
 <20180405113444.GB2647@bombadil.infradead.org>
 <1f809296-e88d-1090-0027-890782b91d6e@gmail.com>
 <20180405125054.GC2647@bombadil.infradead.org>
 <20180406090920.GM16141@n2100.armlinux.org.uk>
Message-ID: <3308d7f2-e793-8f8e-7811-448b808bf736@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your comments, Russell


On 4/6/2018 5:09 PM, Russell King - ARM Linux Wrote:
> On Thu, Apr 05, 2018 at 05:50:54AM -0700, Matthew Wilcox wrote:
>> On Thu, Apr 05, 2018 at 08:44:12PM +0800, Jia He wrote:
>>>
>>> On 4/5/2018 7:34 PM, Matthew Wilcox Wrote:
>>>> On Thu, Apr 05, 2018 at 01:04:35AM -0700, Jia He wrote:
>>>>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>>>>> where possible") optimized the loop in memmap_init_zone(). But there is
>>>>> still some room for improvement. E.g. if pfn and pfn+1 are in the same
>>>>> memblock region, we can simply pfn++ instead of doing the binary search
>>>>> in memblock_next_valid_pfn.
>>>> Sure, but I bet if we are >end_pfn, we're almost certainly going to the
>>>> start_pfn of the next block, so why not test that as well?
>>>>
>>>>> +	/* fast path, return pfn+1 if next pfn is in the same region */
>>>>> +	if (early_region_idx != -1) {
>>>>> +		start_pfn = PFN_DOWN(regions[early_region_idx].base);
>>>>> +		end_pfn = PFN_DOWN(regions[early_region_idx].base +
>>>>> +				regions[early_region_idx].size);
>>>>> +
>>>>> +		if (pfn >= start_pfn && pfn < end_pfn)
>>>>> +			return pfn;
>>>> 		early_region_idx++;
>>>> 		start_pfn = PFN_DOWN(regions[early_region_idx].base);
>>>> 		if (pfn >= end_pfn && pfn <= start_pfn)
>>>> 			return start_pfn;
>>> Thanks, thus the binary search in next step can be discarded?
>> I don't know all the circumstances in which this is called.  Maybe a linear
>> search with memo is more appropriate than a binary search.
> That's been brought up before, and the reasoning appears to be
> something along the lines of...
>
> Academics and published wisdom is that on cached architectures, binary
> searches are bad because it doesn't operate efficiently due to the
> overhead from having to load cache lines.  Consequently, there seems
> to be a knee-jerk reaction that "all binary searches are bad, we must
> eliminate them."
IIUC, are you opposed to entirely removing the binary search instead of my
previous patch set?
>
> What is failed to be grasped here, though, is that it is typical that
> the number of entries in this array tend to be small, so the entire
> array takes up one or two cache lines, maybe a maximum of four lines
> depending on your cache line length and number of entries.
>
> This means that the binary search expense is reduced, and is lower
> than a linear search for the majority of cases.
>
> What is key here as far as performance is concerned is whether the
> general usage of pfn_valid() by the kernel is optimal.  We should
> not optimise only for the boot case, which means evaluating the
> effect of these changes with _real_ workloads, not just "does my
> machine boot a milliseconds faster".
hmm.. But pfn is linearly increased during the booting time. This assumption
is not correct in real workload for pfn_valid out of booting time. So in my
patchset, I defined another pfn_valid_region for booting time only.

I didn't have many arm/arm64 boxes to verifed. What I can do is guaranteeing
the improvemnet in my armv8a (qualcom centriq 2400). Sorry about it.

  --
Cheers,
Jia
