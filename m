From: alex.williamson@redhat.com (Alex Williamson)
Date: Fri, 27 Mar 2015 22:24:22 -0600
Subject: [PATCH 00/16 v2] iommu: Move domain allocation into drivers
In-Reply-To: <1427373799-18662-1-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Message-ID: <1427516662.3643.906.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-03-26 at 13:43 +0100, Joerg Roedel wrote:
> Changes v1-v2:
> 
> 	* Rebased to v4.0-rc5
> 	* Converted domain-types to a bit-field
> 
> Hi,
> 
> here is patch-set to replace the existing domain_init and
> domain_destroy iommu-ops with the new domain_alloc and
> domain_free callbacks
> 
> The new callbacks move the allocation of iommu domains into
> the iommu driver, allowing them to put a generic
> iommu_domain struct into their own domain struct. This makes
> domain handling in the drivers more cache efficient and
> prepares the introduction of default domains in another
> patch-set.
> 
> While at it, this patch-set also introduces domain types.
> These are internal to the iommu core code for now, there are
> three of them:
> 
> 	* DMA-API domains
> 	* Identity mapped domains
> 	* Domains unmanaged by the iommu-core, used for
> 	  iommu-api so that the users can create their own
> 	  mappings
> 
> The patches have been compile tested for x86, ARM and PPC
> and runtime tested on x86 (Intel VT-d and AMD IOMMU).
> 
> Please review.

For 1-5,16

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

My only comment/question is whether you'd want to consider using
ERR_PTR() return values from domain_alloc().  It's an alloc functions,
so NULL == -ENOMEM is pretty standard, but we could at least have the
interface to the iommu driver return more info even if we continue to
mask that as NULL out to the IOMMU API users for now.  Thanks,

Alex
