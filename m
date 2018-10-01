From: daeinki@gmail.com (Inki Dae)
Date: Mon, 1 Oct 2018 19:55:57 +0900
Subject: [PATCH v2 2/3] iommu/dma: Use fast DMA domain lookup
In-Reply-To: <20180928161835eucas1p283072c72df1043b180ba55bba32bce65~YnKdLKRbM0111401114eucas1p2P@eucas1p2.samsung.com>
References: <cover.1536764440.git.robin.murphy@arm.com>
 <CGME20180912152438epcas5p175098b44c3f7232302e10b087279bd3c@epcas5p1.samsung.com>
 <e42771992a73620f23128c0479b2ae91b3e177bf.1536764440.git.robin.murphy@arm.com>
 <20180928132605eucas1p1d39fedc3be3e4e2c16035c01a40cfab6~Ykz2Rax6e0538205382eucas1p17@eucas1p1.samsung.com>
 <78a5b373-d569-4461-e258-3104286ba322@arm.com>
 <20180928142148eucas1p17d6ecbd5c98b3fe1bf008dbcf0626c76~YlkfonoPN1120711207eucas1p1u@eucas1p1.samsung.com>
 <a9eb4b79-1fb8-eec7-0566-966f84022d7b@arm.com>
 <20180928161835eucas1p283072c72df1043b180ba55bba32bce65~YnKdLKRbM0111401114eucas1p2P@eucas1p2.samsung.com>
Message-ID: <CAAQKjZOvO_8Sd0dBDC07NJYVPdv5Z8xLv-Z96ropcbXMApY=2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 + dri-devel

This patch may also break other ARM DRM drivers. I cced dri-devel so
that they could manage this.

And below relevant link for ARM DRM maintainers,
https://www.spinics.net/lists/arm-kernel/msg676098.html

Thanks,
Inki Dae

2018? 9? 29? (?) ?? 1:19, Marek Szyprowski <m.szyprowski@samsung.com>?? ??:
>
> Hi Robin,
>
> On 2018-09-28 17:31, Robin Murphy wrote:
> > On 28/09/18 15:21, Marek Szyprowski wrote:
> >> On 2018-09-28 15:52, Robin Murphy wrote:
> >>> On 28/09/18 14:26, Marek Szyprowski wrote:
> >>>> On 2018-09-12 17:24, Robin Murphy wrote:
> >>>>> Most parts of iommu-dma already assume they are operating on a
> >>>>> default
> >>>>> domain set up by iommu_dma_init_domain(), and can be converted
> >>>>> straight
> >>>>> over to avoid the refcounting bottleneck. MSI page mappings may be in
> >>>>> an unmanaged domain with an explicit MSI-only cookie, so retain the
> >>>>> non-specific lookup, but that's OK since they're far from a contended
> >>>>> fast path either way.
> >>>>>
> >>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >>>>
> >>>> This breaks Exynos DRM driver with Exynos IOMMU on ARM64 (Exynos5433).
> >>>> Exynos DRM creates it's own domain, attach all devices which performs
> >>>> DMA access (typically CRTC devices) to it and uses standard
> >>>> DMA-mapping
> >>>> calls to allocate/map buffers. This way it can use the same one DMA
> >>>> address for each buffer regardless of the CRTC/display/processing
> >>>> device.
> >>>>
> >>>> This no longer works with this patch. The simplest solution to fix
> >>>> this
> >>>> is add API to change default_domain to the one allocated by the Exynos
> >>>> DRM driver.
> >>>
> >>> Ugh, I hadn't realised there were any drivers trying to fake up their
> >>> own default domains - that's always going to be fragile. In fact, one
> >>> of my proposals for un-breaking Tegra and other DRM drivers involves
> >>> preventing iommu-dma from trying to operate on non-IOMMU_DOMAIN_DMA
> >>> domains at all, which would stop that from working permanently.
> >>
> >> IMHO there should be a way to let drivers like DRM to use DMA-mapping
> >> infrastructure on their own iommu domain. Better provide such API to
> >> avoid hacking in the DRM drivers to get this done without help from
> >> IOMMU core.
> >
> > The tricky part is how to reconcile that with those other drivers
> > which want to do explicit IOMMU management with their own domain but
> > still use the DMA API for coherency of the underlying memory. I do
> > have a couple of half-formed ideas, but they're not quite there yet.
>
> The only idea I have here is to add some flags to struct driver to let
> device core and frameworks note that this driver wants to manage
> everything on their own. Then such drivers, once they settle their IOMMU
> domain, should call some simple API to bless it for DMA API.
>
> >
> >>> Can Exynos not put all the DRM components into a single group, or at
> >>> least just pick one of the real default domains to attach everyone to
> >>> instead of allocating a fake one?
> >>
> >> Exynos DRM components are not in the single group. Currently
> >> iommu-groups have no meaning on Exynos5433 and Exynos IOMMU simply
> >> allocate one group per each iommu-master device in the system.
> >
> > Yeah, a group spanning multiple IOMMU devices would have been a bit of
> > a hack for your topology, but still *technically* possible ;)
>
> The question if I want to put all DRM components into single IOMMU
> group, how to propagate such knowledge from Exynos DRM driver to Exynos
> IOMMU driver (groups are created by IOMMU driver)? Anyway, I don't see
> any benefits from using IOMMU groups as for now, especially when each
> Exynos DRM component has its own, separate IOMMU (or even more than one,
> but that a different story).
>
> >> Exynos DRM already selects one of its component devices as the 'main DMA
> >> device'. It is being used for managing buffers if no IOMMU is available,
> >> so it can also use its iommu domain instead of allocating a fake one.
> >> I've checked and it fixes Exynos DRM now. The question is how to merge
> >> this fix to keep bisectability.
> >>
> >> From: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Date: Fri, 28 Sep 2018 16:17:27 +0200
> >> Subject: [PATCH] drm/exynos: Use selected dma_dev default iommu domain
> >> instead
> >>    of a fake one
> >>
> >> Instead of allocating a fake IOMMU domain for all Exynos DRM components,
> >> simply reuse the default IOMMU domain of the already selected DMA
> >> device.
> >> This allows some design changes in IOMMU framework without breaking
> >> IOMMU
> >> support in Exynos DRM.
> >>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >>    drivers/gpu/drm/exynos/exynos_drm_iommu.h | 34
> >> ++++-------------------
> >>    1 file changed, 6 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.h
> >> b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
> >> index 87f6b5672e11..51d3b7dcd529 100644
> >> --- a/drivers/gpu/drm/exynos/exynos_drm_iommu.h
> >> +++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
> >> @@ -55,37 +55,12 @@ static inline void __exynos_iommu_detach(struct
> >> exynos_drm_private *priv,
> >>    static inline int __exynos_iommu_create_mapping(struct
> >> exynos_drm_private *priv,
> >>                        unsigned long start, unsigned long size)
> >>    {
> >> -    struct iommu_domain *domain;
> >> -    int ret;
> >> -
> >> -    domain = iommu_domain_alloc(priv->dma_dev->bus);
> >> -    if (!domain)
> >> -        return -ENOMEM;
> >> -
> >> -    ret = iommu_get_dma_cookie(domain);
> >> -    if (ret)
> >> -        goto free_domain;
> >> -
> >> -    ret = iommu_dma_init_domain(domain, start, size, NULL);
> >> -    if (ret)
> >> -        goto put_cookie;
> >> -
> >> -    priv->mapping = domain;
> >> +    priv->mapping = iommu_get_dma_domain(priv->dma_dev);
> >
> > iommu_get_domain_for_dev(), please - this isn't a performance-critical
> > path inside a DMA API implementation, plus without an actual
> > dependency on this series maybe there's a chance of sneaking it into
> > 4.19?
> >
> > (you could always still check domain->type == IOMMU_DOMAIN_DMA if you
> > want to be really really paranoid.)
> >
>
> I've sent a patch. I hope we will manage to get it as a fix into v4.19,
> so it won't block your changes in v4.20.
>
> >>        return 0;
> >> -
> >> -put_cookie:
> >> -    iommu_put_dma_cookie(domain);
> >> -free_domain:
> >> -    iommu_domain_free(domain);
> >> -    return ret;
> >>    }
> >>
> >>    static inline void __exynos_iommu_release_mapping(struct
> >> exynos_drm_private *priv)
> >>    {
> >> -    struct iommu_domain *domain = priv->mapping;
> >> -
> >> -    iommu_put_dma_cookie(domain);
> >> -    iommu_domain_free(domain);
> >>        priv->mapping = NULL;
> >>    }
> >>
> >> @@ -94,7 +69,9 @@ static inline int __exynos_iommu_attach(struct
> >> exynos_drm_private *priv,
> >>    {
> >>        struct iommu_domain *domain = priv->mapping;
> >>
> >> -    return iommu_attach_device(domain, dev);
> >> +    if (dev != priv->dma_dev)
> >> +        return iommu_attach_device(domain, dev);
> >> +    return 0;
> >>    }
> >>
> >>    static inline void __exynos_iommu_detach(struct exynos_drm_private
> >> *priv,
> >> @@ -102,7 +79,8 @@ static inline void __exynos_iommu_detach(struct
> >> exynos_drm_private *priv,
> >>    {
> >>        struct iommu_domain *domain = priv->mapping;
> >>
> >> -    iommu_detach_device(domain, dev);
> >> +    if (dev != priv->dma_dev)
> >> +        iommu_detach_device(domain, dev);
> >
> > Strictly you could skip that check, as detaching the master device
> > from its real default domain is just a no-op, but I guess maintaining
> > the symmetry is probably more intuitive.
>
> I would like to keep the symmetry.
>
> > ...
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
