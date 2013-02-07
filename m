From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 7 Feb 2013 16:35:52 +0200
Subject: [PATCH] omapdrm: fix the dependency to omapdss
In-Reply-To: <1360247752-25681-1-git-send-email-tomi.valkeinen@ti.com>
References: <1360247752-25681-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1360247752-25681-2-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omapdrm uses "select" in Kconfig to enable omapdss. This doesn't work
correctly, as "select" forces omapdss to be enabled in the config even
if it normally could not be enabled because of missing Kconfig
dependencies.

This causes a build break on ARM, when using allyesconfig:

drivers/video/omap2/dss/dss.c: In function 'dss_calc_clock_div':
drivers/video/omap2/dss/dss.c:572:20: error: 'CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK' undeclared (first use in this function)
drivers/video/omap2/dss/dss.c:572:20: note: each undeclared identifier is reported only once for each function it appears in

Instead of using select, this patch changes omapdrm to use "depend
on".

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/staging/omapdrm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/omapdrm/Kconfig b/drivers/staging/omapdrm/Kconfig
index b724a41..09f65dc 100644
--- a/drivers/staging/omapdrm/Kconfig
+++ b/drivers/staging/omapdrm/Kconfig
@@ -3,8 +3,8 @@ config DRM_OMAP
 	tristate "OMAP DRM"
 	depends on DRM && !CONFIG_FB_OMAP2
 	depends on ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM
+	depends on OMAP2_DSS
 	select DRM_KMS_HELPER
-	select OMAP2_DSS
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
-- 
1.7.10.4
