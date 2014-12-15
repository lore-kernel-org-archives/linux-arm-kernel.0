From: treding@nvidia.com (Thierry Reding)
Date: Mon, 15 Dec 2014 10:47:16 +0100
Subject: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback
 instead of initcall
In-Reply-To: <1826772.xgprzQcfXd@avalon>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1416395748-10731-19-git-send-email-m.szyprowski@samsung.com>
 <1826772.xgprzQcfXd@avalon>
Message-ID: <20141215094714.GA517@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 14, 2014 at 02:45:36PM +0200, Laurent Pinchart wrote:
> Hi Marek,
> 
> Thank you for the patch.
> 
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

Notifiers don't work very well for this. Notifier blocks are supposed to
return a very limited number of values, so sneaking in a -EPROBE_DEFER
isn't likely to work out very well.

This was in fact one of Hiroshi's proposals over a year ago and got
refused because of those reasons. The next solution was to introduce a
function, not very much unlike the of_iommu_configure() that would be
called in the core prior to calling into the driver's ->probe() callback
so that it could handle this at probe time (as opposed to device
creation time). That way the core can easily defer probe if the IOMMU is
not there yet. At the same time it can simply use the driver model
without requiring per-architecture hacks or workarounds.

Note that there is really no need for any of this configuration or
initialization to happen at device creation time. Drivers won't be able
to use the IOMMU or DMA APIs until their .probe(), so handling this any
earlier is completely unnecessary.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141215/dfb39a50/attachment.sig>
