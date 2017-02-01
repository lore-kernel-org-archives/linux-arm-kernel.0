From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 1 Feb 2017 14:36:17 +0000
Subject: [PATCH 2/2] arm64/dma-mapping: validate dma_masks against IORT
 defined limits
In-Reply-To: <115903ce-6c1d-faa9-cbe4-e67a3d41f5c9@arm.com>
References: <1485893763-20671-1-git-send-email-nwatters@codeaurora.org>
 <1485893763-20671-2-git-send-email-nwatters@codeaurora.org>
 <115903ce-6c1d-faa9-cbe4-e67a3d41f5c9@arm.com>
Message-ID: <20170201143617.GB20423@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 01:44:02PM +0000, Robin Murphy wrote:
> Hi Nate,
> 
> On 31/01/17 20:16, Nate Watterson wrote:
> > Some drivers set the dma_mask of client devices based solely on values
> > read from capability registers which may not account for platform
> > specific bus address width limitations. Fortunately, the ACPI IORT table
> > provides a way to report the effective number of address bits a device
> > can use to access memory. This information, when present, is used to
> > supplement the checks already being done in dma_supported() to avoid
> > setting overly generous dma_masks.
> 
> This is equally a problem for DT, and I think in general we'd prefer not
> to be dragging ACPI/DT specifics in at this level when there's a clean
> way to address it more generally. There is some recent ongoing
> discussion and work in this area (latest part at [1]) - I have a local
> branch somewhere implementing the stricter "don't special case default
> masks" version (after I came around to Arnd's viewpoint), which I must
> refresh myself on because there was some anomaly in the core DT code
> which that brought to light.

Agreed. I can prototype the ACPI version by using the _DMA object in the
ACPI specs instead of IORT specific bindings (what to do for named
components has to be seen given that _DMA object and IORT bindings can
provide different information - though _DMA object usage at least on x86
seems non-existent, whether we should use it or not on ARM is still a
question mark). Anyway, the IORT parsing code in patch 1 is simple, we
have to decide how to handle the information retrieved. I will have a
look at [1] let me know if you need help prototyping and testing it with
ACPI.

Lorenzo

> > Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> > ---
> >  arch/arm64/mm/dma-mapping.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> > index e040827..467fd23 100644
> > --- a/arch/arm64/mm/dma-mapping.c
> > +++ b/arch/arm64/mm/dma-mapping.c
> > @@ -19,6 +19,7 @@
> >  
> >  #include <linux/gfp.h>
> >  #include <linux/acpi.h>
> > +#include <linux/acpi_iort.h>
> >  #include <linux/bootmem.h>
> >  #include <linux/cache.h>
> >  #include <linux/export.h>
> > @@ -347,6 +348,12 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
> >  
> >  static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
> >  {
> > +	int dma_limit;
> > +
> > +	dma_limit = iort_get_memory_address_limit(hwdev);
> > +	if (dma_limit >= 0 && DMA_BIT_MASK(dma_limit) < mask)
> > +		return 0;
> > +
> >  	if (swiotlb)
> >  		return swiotlb_dma_supported(hwdev, mask);
> >  	return 1;
> > @@ -784,6 +791,17 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
> >  	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
> >  }
> >  
> > +static int __iommu_dma_supported(struct device *hwdev, u64 mask)
> > +{
> > +	int dma_limit;
> > +
> > +	dma_limit = iort_get_memory_address_limit(hwdev);
> > +	if (dma_limit >= 0 && DMA_BIT_MASK(dma_limit) < mask)
> > +		return 0;
> > +
> > +	return iommu_dma_supported(hwdev, mask);
> 
> Either way, this reminds me that iommu_dma_supported() is another thing
> I got completely wrong - time to write yet another patch...
> 
> Robin.
> 
> [1]:http://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg10637.html
> 
> > +}
> > +
> >  static struct dma_map_ops iommu_dma_ops = {
> >  	.alloc = __iommu_alloc_attrs,
> >  	.free = __iommu_free_attrs,
> > @@ -799,7 +817,7 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
> >  	.sync_sg_for_device = __iommu_sync_sg_for_device,
> >  	.map_resource = iommu_dma_map_resource,
> >  	.unmap_resource = iommu_dma_unmap_resource,
> > -	.dma_supported = iommu_dma_supported,
> > +	.dma_supported = __iommu_dma_supported,
> >  	.mapping_error = iommu_dma_mapping_error,
> >  };
> >  
> > 
> 
