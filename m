From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 20 Jun 2013 10:24:39 +0200
Subject: [Linaro-mm-sig] [RFC 2/3] ARM: dma-mapping: Pass DMA attrs as
 IOMMU prot
In-Reply-To: <CAMcxFTRnnCnPnvMi89r7rUsN4xeYzZGqy9s5v5ukm_fJ_d_RGg@mail.gmail.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com><1371707384-30037-3-git-send-email-hdoyu@nvidia.com><CAMcxFTRnnCnPnvMi89r7rUsN4xeYzZGqy9s5v5ukm_fJ_d_RGg@mail.gmail.com>
Message-ID: <20130620.112439.1330557591655135630.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

Nishanth Peethambaran <nishanth.p@gmail.com> wrote @ Thu, 20 Jun 2013 10:07:00 +0200:

> It would be better to define a prot flag bit in iommu API and convert
> the attrs to prot flag bit in dma-mapping aPI before calling the iommu
> API.

That's the 1st option.

> On Thu, Jun 20, 2013 at 11:19 AM, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
....
> > @@ -1280,7 +1281,7 @@ ____iommu_create_mapping(struct device *dev, dma_addr_t *req,
> >                                 break;
> >
> >                 len = (j - i) << PAGE_SHIFT;
> > -               ret = iommu_map(mapping->domain, iova, phys, len, 0);
> > +               ret = iommu_map(mapping->domain, iova, phys, len, (int)attrs);
> 
> Use dma_get_attr and translate the READ_ONLY attr to a new READ_ONLY
> prot flag bit which needs to be defined in iommu.h

Both DMA_ATTR_READ_ONLY and IOMMU_READ are just logical bit in their
layers respectively and eventually it's converted to H/W dependent
bit.

If IOMMU is considered as one of specific case of DMA, sharing
dma_attr between IOMMU and DMA may not be so bad. IIRC, ARM:
dma-mapping API was implemented based on this concept(?).

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d8f98b1..161a1b0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -755,7 +755,7 @@ int iommu_domain_has_cap(struct iommu_domain *domain,
 EXPORT_SYMBOL_GPL(iommu_domain_has_cap);
 
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot)
+	      phys_addr_t paddr, size_t size, struct dma_attr *attrs)
 {
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
