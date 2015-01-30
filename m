From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 30 Jan 2015 13:22:34 +0100
Subject: [PATCH 02/15] iommu: Introduce iommu domain types
In-Reply-To: <20150128141934.GP1569@arm.com>
References: <1422316305-19216-1-git-send-email-joro@8bytes.org>
 <1422316305-19216-3-git-send-email-joro@8bytes.org>
 <20150128141934.GP1569@arm.com>
Message-ID: <20150130122233.GA3702@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, Jan 28, 2015 at 02:19:34PM +0000, Will Deacon wrote:
> > +/* This are the possible domain-types */
> > +enum iommu_domain_type {
> > +	IOMMU_DOMAIN_DMA,	/* Domain used for DMA-API */
> > +	IOMMU_DOMAIN_IDENTITY,	/* Identity mapped domain  */
> 
> What happens if somebody calls map or unmap on an identity-mapping domain?
> Can we catch that in the IOMMU core before calling the IOMMU driver? That
> also implies we need something extra to parameterise the attributes for
> the mapping (e.g. cacheable, read-only) and also potentially the address
> range.

The domain type is only used by the IOMMU drivers to do be able to enter
special allocation paths (the AMD-Vi driver for example could allocate a
special internal domain type for IOMMU_DOMAIN_DMA).
But I think you are right, a couple of the current domain attributes we
have could be moved here, turning the domain-type into a bit-field. So
we could have bits for PAGING, CACHABLE, DMA_API and NESTING and build
the domain types above from those bits.

> > +	IOMMU_DOMAIN_UNMANAGED, /* Domain mappings are managed by a third party
> > +				   user (like KVM or VFIO) */
> 
> We already have the domain attributes (iommu_attr) to describe features
> of a domain. Is there really a need for this extra type, or can we extend
> the attribute set and allow for domain allocation with attributes?

I don't think that domains attributed will become obsolete with this
domain-type field. Some of the attributes should stay there for now,
like all the PAMU specific stuff. But I agree, some could be moved over.

	
	Joerg
