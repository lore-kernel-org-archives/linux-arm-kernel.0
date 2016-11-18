From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Nov 2016 12:13:40 +0000
Subject: [RFC 1/6] drm/etnaviv: add binding for the gc320 found in ti socs
In-Reply-To: <0bf288ee-33bc-c3b5-389f-08d9bb89ccb5@ti.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <0bf288ee-33bc-c3b5-389f-08d9bb89ccb5@ti.com>
Message-ID: <20161118121340.GC23750@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 08:53:38PM -0600, Nishanth Menon wrote:
> >diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> >index a6799b0..ce51270 100644
> >--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> >+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> >@@ -653,6 +653,7 @@ static int etnaviv_pdev_remove(struct platform_device *pdev)
> > static const struct of_device_id dt_match[] = {
> > 	{ .compatible = "fsl,imx-gpu-subsystem" },
> > 	{ .compatible = "marvell,dove-gpu-subsystem" },
> >+	{ .compatible = "ti,gc320-gpu-subsystem" },

We need to get away from this ever-increasing set of compatible
strings here, as this is not long-term maintainable.

What we should have is a common compatible which describes that
the node is compatible with this driver, and then use SoC specific
compatible strings later if we need to (eg, because of some GPU
subsystem SoC specifics.)

So, I'd suggest that we update the documentation and add:

	"vivante,gc-gpu-subsystem"

as a common compatible now, and if necessary move on to more specific
compatibles if we need to later.

Also, I'd strongly suggest that no compatibles should contain the ID
number of the GPU core for exactly the same reason - Vivante GPU cores
vary according to features, and we don't want to end up with a long
list of specific compatibles (eg)
	"ti,gc2000-and-gc320-and-gc355-gpu-subsystem" because TI
decides to integrate a 3d, 2d and VG core.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
