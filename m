From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Dec 2014 17:17:00 +0000
Subject: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback
 instead of initcall
In-Reply-To: <1826772.xgprzQcfXd@avalon>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1416395748-10731-19-git-send-email-m.szyprowski@samsung.com>
 <1826772.xgprzQcfXd@avalon>
Message-ID: <20141215171700.GP20738@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 14, 2014 at 12:45:36PM +0000, Laurent Pinchart wrote:
> On Wednesday 19 November 2014 12:15:47 Marek Szyprowski wrote:
> > This patch introduces IOMMU_OF_DECLARE-based initialization to the
> > driver, which replaces subsys_initcall-based procedure.
> > exynos_iommu_of_setup ensures that each sysmmu controller is probed
> > before its master device.
> > 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/iommu/exynos-iommu.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index cd28dc09db39..88f9afe641a0 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> 
> [snip]
> 
> > @@ -1125,4 +1134,21 @@ err_reg_driver:
> >  	kmem_cache_destroy(lv2table_kmem_cache);
> >  	return ret;
> >  }
> > -subsys_initcall(exynos_iommu_init);
> > +
> > +static int __init exynos_iommu_of_setup(struct device_node *np)
> > +{
> > +	struct platform_device *pdev;
> > +
> > +	if (!init_done)
> > +		exynos_iommu_init();
> > +
> > +	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> > +	if (IS_ERR(pdev))
> > +		return PTR_ERR(pdev);
> 
> If we end up having to create the IOMMU platform devices from within the 
> drivers, the introduction of IOMMU_OF_DECLARE starts to feel like a workaround 
> to me. I wonder whether it wouldn't then be better to let the driver core 
> instantiate the IOMMU platform device from DT as for all other devices, and 
> use device notifiers to defer probe of the bus masters until the required 
> IOMMU(s) are registered.
> 
> Will, what's your opinion on that ?

Creating the platform device manually for the IOMMU is indeed grotty, but I
don't really understand why it's needed. Interrupt controllers, for example,
seem to get by without one.

Will
