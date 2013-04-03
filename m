From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:08:26 +0900
Subject: [PATCH 11/11] ARM: shmobile: mackerel: clean up MMCIF vs. SDHI1
 selection
In-Reply-To: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954906-16014-12-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

MMCIF and SDHI1 share the same slot on mackerel. One of them is selected
by a jumper, which cannot be queried from software. Currently in software
one of the two interfaces is selected, depending whether or not the MMCIF
driver is enabled. This is not optimal, since the kernel has to be rebuilt
to switch from one interface to another. Still, so far there isn't a
better option. At least make this selection consistent.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |   34 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b976ad6..5b452e1 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -999,7 +999,7 @@ static struct platform_device sdhi0_device = {
 	},
 };
 
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+#if !IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 /* SDHI1 */
 
 /* GPIO 41 can trigger IRQ8, but it is used by USBHS1, we have to poll */
@@ -1062,10 +1062,6 @@ static struct resource sdhi2_resources[] = {
 		.end	= 0xe68700ff,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
-		.start	= evt2irq(0x1200), /* SDHI2_SDHI2I0 */
-		.flags	= IORESOURCE_IRQ,
-	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x1220), /* SDHI2_SDHI2I1 */
 		.flags	= IORESOURCE_IRQ,
@@ -1087,6 +1083,7 @@ static struct platform_device sdhi2_device = {
 };
 
 /* SH_MMCIF */
+#if IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
 		.name	= "MMCIF",
@@ -1118,7 +1115,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
 
-static struct platform_device sh_mmcif_device __maybe_unused = {
+static struct platform_device sh_mmcif_device = {
 	.name		= "sh_mmcif",
 	.id		= 0,
 	.dev		= {
@@ -1129,7 +1126,7 @@ static struct platform_device sh_mmcif_device __maybe_unused = {
 	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
 	.resource	= sh_mmcif_resources,
 };
-
+#endif
 
 static int mackerel_camera_add(struct soc_camera_device *icd);
 static void mackerel_camera_del(struct soc_camera_device *icd);
@@ -1236,11 +1233,12 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&fsi_hdmi_device,
 	&nand_flash_device,
 	&sdhi0_device,
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+#if !IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 	&sdhi1_device,
+#else
+	&sh_mmcif_device,
 #endif
 	&sdhi2_device,
-	&sh_mmcif_device,
 	&ceu_device,
 	&mackerel_camera,
 	&hdmi_device,
@@ -1305,11 +1303,6 @@ static struct i2c_board_info i2c1_devices[] = {
 };
 
 static const struct pinctrl_map mackerel_pinctrl_map[] = {
-	/* MMCIF */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
-				  "mmc0_data8_0", "mmc0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
-				  "mmc0_ctrl_0", "mmc0"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1318,11 +1311,17 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_wp", "sdhi0"),
 	/* SDHI1 */
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+#if !IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh7372",
 				  "sdhi1_data4", "sdhi1"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh7372",
 				  "sdhi1_ctrl", "sdhi1"),
+#else
+	/* MMCIF */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
+				  "mmc0_data8_0", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
+				  "mmc0_ctrl_0", "mmc0"),
 #endif
 	/* SDHI2 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh7372",
@@ -1347,10 +1346,11 @@ static void __init mackerel_init(void)
 		{ "A3SP", &usbhs0_device, },
 		{ "A3SP", &usbhs1_device, },
 		{ "A3SP", &nand_flash_device, },
-		{ "A3SP", &sh_mmcif_device, },
 		{ "A3SP", &sdhi0_device, },
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+#if !IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 		{ "A3SP", &sdhi1_device, },
+#else
+		{ "A3SP", &sh_mmcif_device, },
 #endif
 		{ "A3SP", &sdhi2_device, },
 		{ "A4R", &ceu_device, },
-- 
1.7.10.4
