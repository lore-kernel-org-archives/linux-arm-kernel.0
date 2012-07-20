From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Fri, 20 Jul 2012 20:11:31 +0530
Subject: [PATCH] ARM: dm644x: fix clock setting and add vpss clock in VPSS
 driver
Message-ID: <1342795291-17847-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lad, Prabhakar <prabhakar.lad@ti.com>

fix clock setting for 480p and 576p. adjust appropriately
without this patch we get out of range signal for this
format. Add master and slave clock for VPSS driver
which allows capture and display to independently work.

Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
---
 arch/arm/mach-davinci/dm644x.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 20b7f15..952f6ac 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -801,8 +801,7 @@ static int dm644x_venc_setup_clock(enum vpbe_enc_timings_type type,
 		switch (mode) {
 		case V4L2_DV_480P59_94:
 		case V4L2_DV_576P50:
-			v |= DM644X_VPSS_MUXSEL_PLL2_MODE |
-			     DM644X_VPSS_DACCLKEN;
+			v |= DM644X_VPSS_DACCLKEN;
 			writel(v, DAVINCI_SYSMOD_VIRT(SYSMOD_VPSS_CLKCTL));
 			break;
 		case V4L2_DV_720P60:
@@ -1005,8 +1004,15 @@ void __init dm644x_init(void)
 int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 				struct vpbe_config *vpbe_cfg)
 {
-	if (vpfe_cfg || vpbe_cfg)
+	if (vpfe_cfg || vpbe_cfg) {
+		/* Add vpss clock aliases */
+		clk_add_alias("master", dm644x_vpss_device.name,
+			      "vpss_master", NULL);
+		clk_add_alias("slave", dm644x_vpss_device.name,
+			      "vpss_slave", NULL);
+
 		platform_device_register(&dm644x_vpss_device);
+	}
 
 	if (vpfe_cfg) {
 		dm644x_vpfe_dev.dev.platform_data = vpfe_cfg;
-- 
1.7.0.4
