From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Thu, 10 Nov 2011 13:12:00 -0800
Subject: [PATCH v4 2/7] iommu/core: split mapping to page sizes as
 supported by the hardware
In-Reply-To: <20111110170918.GE13213@amd.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
 <1318850846-16066-3-git-send-email-ohad@wizery.com>
 <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
 <1320938930.22195.17.camel@i7.infradead.org> <20111110170918.GE13213@amd.com>
Message-ID: <4EBC3E20.20301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2011 9:09 AM, Joerg Roedel wrote:
> The plan is to have a single DMA-API implementation for all IOMMU 
> drivers (X86 and ARM) which just uses the IOMMU-API. But to make this 
> performing reasonalbly well a few changes to the IOMMU-API are 
> required. I already have some ideas which we can discuss if you want.

I have been experimenting with an iommu_map_range call, which maps a 
given scatterlist of discontiguous physical pages into a contiguous 
virtual region at a given IOVA. This has some performance advantages 
over just calling iommu_map iteratively. First, it reduces the amount of 
table walking / calculation needed for mapping each page, given how you 
know that all the pages will be mapped into a single 
virtually-contiguous region (so in most cases, the first-level table 
calculation can be reused). Second, it allows one to defer the TLB (and 
sometimes cache) maintenance operations until the entire scatterlist has 
been mapped, rather than doing a TLB invalidate after mapping each page, 
as would have been the case if iommu_map were just being called from 
within a loop. Granted, just using iommu_map many times may be 
acceptable on the slow path, but I have seen significant performance 
gains when using this approach on the fast path.

Steve
