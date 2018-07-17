From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Tue, 17 Jul 2018 14:19:49 -0600
Subject: [PATCH 04/16] iommu: sva: Add support for private PASIDs
In-Reply-To: <c87ae21f-ac02-17fe-6d11-48d2840911e1@arm.com>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
 <20180518213500.31595-5-jcrouse@codeaurora.org>
 <c87ae21f-ac02-17fe-6d11-48d2840911e1@arm.com>
Message-ID: <20180717201949.GA7632@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 12:21:03PM +0100, Jean-Philippe Brucker wrote:
> Hi Jordan,
> 
> Thanks for the patches, I finally got around testing them with SMMUv3.
> It's an important feature, arguably more than SVA itself. I could pick
> this one as part of the SVA series, what do you think?

I'm good with whatever is the easiest.

> Although I probably would have done the same, I dislike the interface
> because it forces us to duplicate functions and IOMMU ops. The list is
> small but growing:
> 
> iommu_map
> iommu_map_sg
> iommu_unmap
> iommu_unmap_fast
> iommu_iova_to_phys
> iommu_tlb_range_add
> iommu_flush_tlb_all
> 
> Each of these and their associated IOMMU op will have an iommu_sva_X
> counterpart that takes one different argument. Modifying these functions
> to take both a domain and a PASID argument would be more elegant. Or as
> an intermediate solution, perhaps we could only change the IOMMU ops to
> take an additional argument, like you did for map_sg?
> 
> In any case it requires invasive changes in lots of drivers and we can
> always tidy up later, so unless Joerg has a preference I'd keep the
> duplicates for now.

I agree.

> However, having to lookup pasid-to-io_mm on every map/unmap call is
> cumbersome, especially since map/unmap are supposed to be as fast as
> possible. iommu_sva_alloc_pasid should return a structure representing
> the PASID instead of the value alone. The io_mm structure seems like a
> good fit, and the device driver can access io_mm->pasid directly or via
> an io_mm_get_pasid() function.
> 
> The new functions would then be:
> 
> struct io_mm *iommu_sva_alloc_pasid(domain, dev)
> void iommu_sva_free_pasid(domain, io_mm)
> 
> int iommu_sva_map(io_mm, iova, paddr, size, prot)
> size_t iommu_map_sg(io_mm, iova, sg, nents, prot)
> size_t iommu_sva_unmap(io_mm, iova, size)
> size_t iommu_sva_unmap_fast(io_mm, iova, size)
> phys_addr_t iommu_sva_iova_to_phys(io_mm, iova)
> void iommu_sva_flush_tlb_all(io_mm)
> void iommu_sva_tlb_range_add(io_mm, iova, size)

Okay - this sounds reasonable - a simplification like that could
even lead to making all the new functions static inlines which
would cut down on the exported symbols.

> A few more comments inline

All those sound like good ideas to me. I'll take a bit of time to bash on this
and send out an updated revision soonish.

Jordan

<snip>

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
