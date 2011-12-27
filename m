From: yanok@emcraft.com (Ilya Yanok)
Date: Wed, 28 Dec 2011 00:31:33 +0100
Subject: [PATCH V2] OMAP3: hwmod_data: register dss hwmods after dss_core
In-Reply-To: <1324562563-27119-1-git-send-email-yanok@emcraft.com>
References: <1324562563-27119-1-git-send-email-yanok@emcraft.com>
Message-ID: <1325028693-14728-1-git-send-email-yanok@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dss_core has to be initialized before any other DSS hwmod. Currently
this is broken as dss_core is listed in chip/revision specific hwmod
lists while other DSS hwmods are listed in common list which is
registered first.

This patch moves DSS hwmods (except for dss_core) to the separate list
which is registered last to ensure that dss_core is already registered.

This solves the problem with BUG() in L3 interrupt handler on boards
with DSS enabled in bootloader.

CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
CC: Archit Taneja <archit@ti.com>
CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---

Changes from V1:
 - Added extended comment

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5324e8d..f263d3c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3523,12 +3523,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_uart2_hwmod,
 	&omap3xxx_uart3_hwmod,
 
-	/* dss class */
-	&omap3xxx_dss_dispc_hwmod,
-	&omap3xxx_dss_dsi1_hwmod,
-	&omap3xxx_dss_rfbi_hwmod,
-	&omap3xxx_dss_venc_hwmod,
-
 	/* i2c class */
 	&omap3xxx_i2c1_hwmod,
 	&omap3xxx_i2c2_hwmod,
@@ -3635,6 +3629,15 @@ static __initdata struct omap_hwmod *am35xx_hwmods[] = {
 	NULL
 };
 
+static __initdata struct omap_hwmod *omap3xxx_dss_hwmods[] = {
+	/* dss class */
+	&omap3xxx_dss_dispc_hwmod,
+	&omap3xxx_dss_dsi1_hwmod,
+	&omap3xxx_dss_rfbi_hwmod,
+	&omap3xxx_dss_venc_hwmod,
+	NULL
+};
+
 int __init omap3xxx_hwmod_init(void)
 {
 	int r;
@@ -3708,6 +3711,19 @@ int __init omap3xxx_hwmod_init(void)
 
 	if (h)
 		r = omap_hwmod_register(h);
+	if (r < 0)
+		return r;
+
+	/*
+	 * DSS code presumes that dss_core hwmod is handled first,
+	 * _before_ any other DSS related hwmods so register common
+	 * DSS hwmods last to ensure that dss_core is already registered.
+	 * Otherwise some change things may happen, for ex. if dispc
+	 * is handled before dss_core and DSS is enabled in bootloader
+	 * DIPSC will be reset with outputs enabled which sometimes leads
+	 * to unrecoverable L3 error.
+	 */
+	r = omap_hwmod_register(omap3xxx_dss_hwmods);
 
 	return r;
 }
-- 
1.7.6.4
