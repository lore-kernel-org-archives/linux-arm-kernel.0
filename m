From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jun 2014 12:58:15 +0200
Subject: [RFC 09/10] drm/tegra: Add IOMMU support
In-Reply-To: <20140627124614.050be2e406a4b9a02d9fe97c@nvidia.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-10-git-send-email-thierry.reding@gmail.com>
 <20140627124614.050be2e406a4b9a02d9fe97c@nvidia.com>
Message-ID: <20140627105814.GB2797@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 12:46:14PM +0300, Hiroshi DOyu wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
[...]
> > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
[...]
> > +       if (tegra->domain) {
> > +               err = iommu_attach_device(tegra->domain, dc->dev);
> 
> I wanted to keep device drivers iommu-free with the following:
> 
> http://patchwork.ozlabs.org/patch/354074/

That patch only addresses the probe ordering problem that happens if the
user of an IOMMU is probed before the IOMMU. What this patch does is a
whole lot more.

> > diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> > index 59736bb810cd..1d2bbafad982 100644
> > --- a/drivers/gpu/drm/tegra/drm.c
> > +++ b/drivers/gpu/drm/tegra/drm.c
> > @@ -8,6 +8,7 @@
> >   */
> >
> >  #include <linux/host1x.h>
> > +#include <linux/iommu.h>
> >
> >  #include "drm.h"
> >  #include "gem.h"
> > @@ -33,6 +34,16 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
> >         if (!tegra)
> >                 return -ENOMEM;
> >
> > +       if (iommu_present(&platform_bus_type)) {
> > +               tegra->domain = iommu_domain_alloc(&platform_bus_type);
> 
> Can we use "dma_iommu_mapping" instead of domain?
> 
> I thought that DMA API is on the top of IOMMU API so that it may be
> cleaner to use only DMA API.

Using the DMA API doesn't work for Tegra DRM because it assumes a 1:1
mapping between a device and an IOMMU domain. For Tegra DRM we have two
devices (two display controllers) that need to be able to access the
same buffers, therefore they need to share one IOMMU domain. This can't
be done using the DMA API.

The DMA API is fine to be used by devices that operate on "private" DMA
buffers (SDMMC, USB, ...).

> iommu_map_sg() could be implemented as iommu_ops->map_sg() for the
> better perf since iommu_map() needs some pagetable cache operations. If
> we do those cache operations at once, it would bring some perf benefit.

Yes, I agree that eventually this should be moved into the IOMMU core.
We could add a .map_sg() to IOMMU ops for devices where mapping a whole
sg_table at once would have significant performance benefits and change
this generic implementation to be used by devices that don't implement
.map_sg(). Then the IOMMU core's iommu_map_sg() can call into the driver
directly or fallback to the generic implementation.

> I think that we don't need unmap_sg(), instead normal iommu_unmap() for
> a whole area could do the same at once?

Yes, I suppose that's true. I'll see if it can be safely dropped. It
might give us the same benefit as the iommu_map_sg() regarding cache
maintenance, though.

> > +static int iommu_unmap_sg(struct iommu_domain *domain, struct sg_table *sgt,
> > +                         dma_addr_t iova)
> > +{
> > +       unsigned long offset = 0;
> > +       struct scatterlist *sg;
> > +       unsigned int i;
> > +
> > +       for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> > +               dma_addr_t phys = sg_phys(sg);
> > +               size_t length = sg->offset;
> > +
> > +               phys = sg_phys(sg) - sg->offset;
> > +               length = sg->length + sg->offset;
> > +
> > +               iommu_unmap(domain, iova + offset, length);
> > +               offset += length;
> > +       }
> > +
> > +       return 0;
> > +}
> 
> Can the rest of IOMMU API be replaced with DMA API too?

As I explained above, I don't see how it could be done for this driver.
But I don't think it has to. After all the IOMMU API does exist, so we
shouldn't shy away from using it when appropriate.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140627/2760e5d8/attachment-0001.sig>
