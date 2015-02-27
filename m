From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 27 Feb 2015 13:15:57 -0800
Subject: tlbi  va, vaa vs. val, vaal
In-Reply-To: <20150227102435.GC3628@arm.com>
References: <54EFB670.2070501@samsung.com> <20150227102435.GC3628@arm.com>
Message-ID: <54F0DE8D.3030306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2015 02:24 AM, Will Deacon wrote:
> On Fri, Feb 27, 2015 at 12:12:32AM +0000, Mario Smarduch wrote:
>> I noticed kernel tlbflush.h use tlbi va*, vaa* variants instead of
>> val, vaal ones. Reading the manual D.5.7.2 it appears that
>> va*, vaa* versions invalidate intermediate caching of
>> translation structures.
>>
>> With stage2 enabled that may result in 20+ memory lookups
>> for a 4 level page table walk. That's assuming that intermediate
>> caching structures cache mappings from stage1 table entry to
>> host page.
> 
> Yeah, Catalin and I discussed improving the kernel support for this,
> but it requires some changes to the generic mmu_gather code so that we
> can distinguish the leaf cases. I'd also like to see that done in a way
> that takes into account different granule sizes (we currently iterate
> over huge pages in 4k chunks). Last time I touched that, I entered a
> world of pain and don't plan to return there immediately :)
> 
> Catalin -- feeling brave?
> 
> FWIW: the new IOMMU page-table stuff I just got merged *does* make use
> of leaf-invalidation for the SMMU.
> 
> Will
> 
Hi Will,
  thanks for the background. I'm guessing how much of PTWalk
is cached is implementation dependent. One old paper quotes upto 40%
improvement for some industry benchmarks that cache all stage1/2 PTWalk
entries.
I guess something to benchmark.

- Mario
