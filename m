From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Apr 2012 11:09:28 +0000
Subject: [PATCH] ARM: Exynos4: integrate SYSMMU driver with DMA-mapping
 interface
In-Reply-To: <026301cd188d$32613860$9723a920$%szyprowski@samsung.com>
References: <1334155004-5700-1-git-send-email-m.szyprowski@samsung.com>
 <4F869AF4.3080402@gmail.com>
 <026301cd188d$32613860$9723a920$%szyprowski@samsung.com>
Message-ID: <201204121109.28753.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 April 2012, Marek Szyprowski wrote:
> +
> > > +/*
> > > + * s5p_sysmmu_late_init
> > > + * Create DMA-mapping IOMMU context for specified devices. This function must
> > > + * be called later, once SYSMMU driver gets registered and probed.
> > > + */
> > > +static int __init s5p_sysmmu_late_init(void)
> > > +{
> > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc0).dev,&s5p_device_fimc0.dev);
> > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc1).dev,&s5p_device_fimc1.dev);
> > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc2).dev,&s5p_device_fimc2.dev);
> > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc3).dev,&s5p_device_fimc3.dev);
> > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(mfc_l).dev,&s5p_device_mfc_l.dev);
> > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(mfc_r).dev,&s5p_device_mfc_r.dev);
> > > +
> > > +   s5p_create_iommu_mapping(&s5p_device_fimc0.dev, 0x20000000, SZ_128M, 4);
> > > +   s5p_create_iommu_mapping(&s5p_device_fimc1.dev, 0x20000000, SZ_128M, 4);
> > > +   s5p_create_iommu_mapping(&s5p_device_fimc2.dev, 0x20000000, SZ_128M, 4);
> > > +   s5p_create_iommu_mapping(&s5p_device_fimc3.dev, 0x20000000, SZ_128M, 4);
> > > +   s5p_create_iommu_mapping(&s5p_device_mfc_l.dev, 0x20000000, SZ_128M, 4);
> > > +   s5p_create_iommu_mapping(&s5p_device_mfc_r.dev, 0x40000000, SZ_128M, 4);
> > > +
> > > +   return 0;
> > > +}
> > > +device_initcall(s5p_sysmmu_late_init);
> > 
> > Shouldn't these things be specific to a SoC? With this RFC, it happens
> > that you will predefine the IOMMU attachment and mapping information for
> > devices in common location (dev-sysmmu.c)? This may lead to problems
> > because there are some IP's with SYSMMU support in exynos5, but not
> > available in exynos4 (eg: GSC, FIMC-LITE, FIMC-ISP) Previously we used
> > to do above declaration in individual machine file, which I think was
> > more meaningful.
> 
> Right, I simplified the code too much. Keeping these definitions inside machine 
> files was a better idea. I completely forgot that Exynos sub-platform now covers
> both Exynos4 and Exynos5 SoC families.

Ideally the information about iommu attachment should come from the
device tree. We have the "dma-ranges" properties that define how a dma
address space is mapped. I am not entirely sure how that works when you
have multiple IOMMUs and if that requires defining addititional properties,
but I think we should make it so that we don't have to hardcode specific
devices in the source.

	Arnd
