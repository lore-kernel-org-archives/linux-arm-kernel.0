From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 07 Mar 2014 18:45:15 +0100
Subject: [PATCH 1/2] imx-drm: imx-ldb: Add drm_panel support
In-Reply-To: <20140307172243.GQ21483@n2100.arm.linux.org.uk>
References: <1394114080-27223-1-git-send-email-p.zabel@pengutronix.de>
 <20140307172243.GQ21483@n2100.arm.linux.org.uk>
Message-ID: <1394214315.16309.47.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Freitag, den 07.03.2014, 17:22 +0000 schrieb Russell King - ARM
Linux:
> On Thu, Mar 06, 2014 at 02:54:39PM +0100, Philipp Zabel wrote:
> > This patch allows to optionally attach the lvds-channel to a panel
> > supported by a drm_panel driver instead of supplying the modes via
> > device tree.
> 
> Hmm, I think something may be missing in this patch... you're introducing
> calls into the drm panel code, but there's nothign which ensures that
> code gets built alongside imx-ldb.c.  With imx-ldb built as a module,
> I get:
> 
> ERROR: "drm_panel_attach" [drivers/staging/imx-drm/imx-ldb.ko] undefined!
> ERROR: "of_drm_find_panel" [drivers/staging/imx-drm/imx-ldb.ko] undefined!

Thanks for testing. Yes, this Kconfig change is missing from patch 1:

diff --git a/drivers/staging/imx-drm/Kconfig
b/drivers/staging/imx-drm/Kconfig
index 82fb758..8e5b7e9 100644
--- a/drivers/staging/imx-drm/Kconfig
+++ b/drivers/staging/imx-drm/Kconfig
@@ -35,6 +35,7 @@ config DRM_IMX_TVE
 config DRM_IMX_LDB
 	tristate "Support for LVDS displays"
 	depends on DRM_IMX && MFD_SYSCON
+	select DRM_PANEL
 	help
 	  Choose this to enable the internal LVDS Display Bridge (LDB)
 	  found on i.MX53 and i.MX6 processors.

I haven't noticed because I've enabled the parallel display driver,
which does correctly select DRM_PANEL.

regards
Philipp
