From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 29 May 2015 16:40:43 +0200
Subject: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
 SMMUv3 devices
In-Reply-To: <55684F1C.3050702@arm.com>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
 <1431108046-9675-3-git-send-email-will.deacon@arm.com>
 <20150519152435.GL20611@8bytes.org>
 <20150520170926.GI11498@arm.com>
 <20150529064337.GN20611@8bytes.org> <55684F1C.3050702@arm.com>
Message-ID: <20150529144043.GA20384@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 12:35:56PM +0100, Robin Murphy wrote:
> The trouble with this is, what about the CPU page size? Say you have
> some multimedia subsystem with its own integrated SMMU and for that
> they've only implemented the 16K granule scheme because it works
> best for the video hardware (and the GPU driver is making direct
> IOMMU API calls to remap carved-out RAM rather than using
> DMA-mapping). Now, the SMMU on the compute side of the SoC serving
> the general peripherals will be rendered useless by bumping the
> system-wide minimum page size up to 16K, because it then can't map
> that scatterlist of discontiguous 4K pages that the USB controller
> needs...
> 
> I think this really represents another push to get away from (or at
> least around) the page-at-a-time paradigm - if the IOMMU API itself
> wasn't too fussed about page sizes and could let drivers handle the
> full map/unmap requests however they see fit, I think we could
> bypass a lot of these issues. We've already got the Intel IOMMU
> driver doing horrible hacks with the pgsize_bitmap to cheat the
> system, I'm sure we don't want to add any more of that. How about
> something like the below diff as a first step?

Moving functionality out of the iommu core code into the drivers is the
wrong direction imo. It is better to solve it with something like

	struct iommu_domain *iommu_domain_alloc_for_group(struct iommu_group *group);

Which gets us a domain that can only be assigned to that particular
group. Since there is a clear one-to-many relationship between a
hardware iommu and the groups of devices behind it, we could propagate
the pgsize_bitmap from the iommu to the group and then to the domain.

Domains allocated via iommu_domain_alloc() would get the merged
pgsize_bitmap like I described in my previous mail.

But to make this happen we need a representation of single hardware
iommu instances in the iommu core first.


	Joerg
