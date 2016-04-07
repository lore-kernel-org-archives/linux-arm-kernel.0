From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 7 Apr 2016 15:24:30 +0200
Subject: [PATCH 1/2] iommu: Support dynamic pgsize_bitmap
In-Reply-To: <1459890090-16040-1-git-send-email-mitchelh@codeaurora.org>
References: <1459890090-16040-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <20160407132430.GE31146@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 02:01:29PM -0700, Mitchel Humpherys wrote:
> Currently we use a single pgsize_bitmap per IOMMU driver.  However, some
> IOMMU drivers might service different IOMMUs with different supported
> page sizes.  Some drivers might also want to restrict page sizes for
> different use cases.  Support these use cases by adding a
> .get_pgsize_bitmap function to the iommu_ops which can optionally be
> used by the driver to return a domain-specific pgsize_bitmap.

No, at least not this way. I said it before and I say it again: We are
not going to lift the iommu-api requirements in this undetectable way.

The iommu-api works with domains/groups and devices. The general
expectation is that every group can be part of every domain. I know that
this is not the case already with some drivers, but I am not going to
move the code further into the wrong direction.

The way I'd like to see that solved is:

	* Introduce per-group pgsize-bitmaps (group->pgsize_bmp)

	* Calculate a global pgsize-bitmap from all groups
	  pgsize-bitmaps

	* Also store a pgsize_bitmap in each domain on allocation

	* Modify iommu_domain_alloc to set domain->pgsize_bmp to the
	  global pgsize_bitmap

	* Introduce an iommu_group_alloc_domain(group) function which
	  allocates a new domain only for the given group. This function
	  sets domain->pgsize_bitmap to group->pgsize_bmp.

	* Note that now you can have multiple page-tables per domain,
	  one page-table for each required format.


Regards,

	Joerg
