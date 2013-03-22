From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Mar 2013 10:23:52 +0900
Subject: [PATCH 6/6] Revert "ARM: shmobile: streamline mackerel SD and MMC
 devices"
In-Reply-To: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
References: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363915432-21720-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 626a645eb75415255aad3162f4da3f6988f0c8ec.

This appears to be incompatible with
"ARM: shmobile: sh7372: Remove SDHI and MMCIF function GPIOs"

Reverting this change resolves the following build failure:

arch/arm/mach-shmobile/board-mackerel.c: In function ?mackerel_init?:
arch/arm/mach-shmobile/board-mackerel.c:1468: error: ?GPIO_FN_SDHICMD1? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1468: error: (Each undeclared identifier is reported only once
arch/arm/mach-shmobile/board-mackerel.c:1468: error: for each function it appears in.)
arch/arm/mach-shmobile/board-mackerel.c:1469: error: ?GPIO_FN_SDHICLK1? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1470: error: ?GPIO_FN_SDHID1_3? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1471: error: ?GPIO_FN_SDHID1_2? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1472: error: ?GPIO_FN_SDHID1_1? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1473: error: ?GPIO_FN_SDHID1_0? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1489: error: ?GPIO_FN_SDHICMD2? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1490: error: ?GPIO_FN_SDHICLK2? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1491: error: ?GPIO_FN_SDHID2_3? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1492: error: ?GPIO_FN_SDHID2_2? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1493: error: ?GPIO_FN_SDHID2_1? undeclared (first use in this function)
arch/arm/mach-shmobile/board-mackerel.c:1494: error: ?GPIO_FN_SDHID2_0? undeclared (first use in this function)

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |  113 +++++++++++++++----------------
 1 file changed, 56 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index ef22ec4..1a9c753 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -963,6 +963,15 @@ static struct platform_device nand_flash_device = {
 	},
 };
 
+/*
+ * The card detect pin of the top SD/MMC slot (CN7) is active low and is
+ * connected to GPIO A22 of SH7372 (GPIO 41).
+ */
+static int slot_cn7_get_cd(struct platform_device *pdev)
+{
+	return !gpio_get_value(41);
+}
+
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
@@ -973,21 +982,21 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 };
 
 static struct resource sdhi0_resources[] = {
-	{
+	[0] = {
 		.name	= "SDHI0",
 		.start	= 0xe6850000,
 		.end	= 0xe68500ff,
 		.flags	= IORESOURCE_MEM,
-	}, {
-		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
+	},
+	[1] = {
 		.start	= evt2irq(0x0e00) /* SDHI0_SDHI0I0 */,
 		.flags	= IORESOURCE_IRQ,
-	}, {
-		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
+	},
+	[2] = {
 		.start	= evt2irq(0x0e20) /* SDHI0_SDHI0I1 */,
 		.flags	= IORESOURCE_IRQ,
-	}, {
-		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
+	},
+	[3] = {
 		.start	= evt2irq(0x0e40) /* SDHI0_SDHI0I2 */,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -1005,28 +1014,34 @@ static struct platform_device sdhi0_device = {
 
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SDHI1 */
-
-/* GPIO_PORT41 can trigger IRQ8, but it is used by USBHS1, we have to poll */
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
+	.tmio_ocr_mask	= MMC_VDD_165_195,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
-	.cd_gpio	= GPIO_PORT41,
+	.get_cd		= slot_cn7_get_cd,
 };
 
 static struct resource sdhi1_resources[] = {
-	{
+	[0] = {
 		.name	= "SDHI1",
 		.start	= 0xe6860000,
 		.end	= 0xe68600ff,
 		.flags	= IORESOURCE_MEM,
-	}, {
+	},
+	[1] = {
+		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
+		.start	= evt2irq(0x0e80), /* SDHI1_SDHI1I0 */
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
 		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x0ea0), /* SDHI1_SDHI1I1 */
 		.flags	= IORESOURCE_IRQ,
-	}, {
+	},
+	[3] = {
 		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x0ec0), /* SDHI1_SDHI1I2 */
 		.flags	= IORESOURCE_IRQ,
@@ -1044,32 +1059,43 @@ static struct platform_device sdhi1_device = {
 };
 #endif
 
-/* SDHI2 */
-
 /*
  * The card detect pin of the top SD/MMC slot (CN23) is active low and is
- * connected to GPIO SCIFB_SCK of SH7372 (GPIO_PORT162).
+ * connected to GPIO SCIFB_SCK of SH7372 (162).
  */
+static int slot_cn23_get_cd(struct platform_device *pdev)
+{
+	return !gpio_get_value(162);
+}
+
+/* SDHI2 */
 static struct sh_mobile_sdhi_info sdhi2_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
-	.cd_gpio	= GPIO_PORT162,
+	.get_cd		= slot_cn23_get_cd,
 };
 
 static struct resource sdhi2_resources[] = {
-	{
+	[0] = {
 		.name	= "SDHI2",
 		.start	= 0xe6870000,
 		.end	= 0xe68700ff,
 		.flags	= IORESOURCE_MEM,
-	}, {
+	},
+	[1] = {
+		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
+		.start	= evt2irq(0x1200), /* SDHI2_SDHI2I0 */
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
 		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x1220), /* SDHI2_SDHI2I1 */
 		.flags	= IORESOURCE_IRQ,
-	}, {
+	},
+	[3] = {
 		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x1240), /* SDHI2_SDHI2I2 */
 		.flags	= IORESOURCE_IRQ,
@@ -1108,12 +1134,11 @@ static struct resource sh_mmcif_resources[] = {
 
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
+	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
-	.use_cd_gpio	= true,
-	/* card detect pin for SD/MMC slot (CN7) */
-	.cd_gpio	= GPIO_PORT41,
+	.get_cd		= slot_cn7_get_cd,
 	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
 	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
@@ -1238,10 +1263,9 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&sdhi0_device,
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	&sdhi1_device,
-#else
-	&sh_mmcif_device,
 #endif
 	&sdhi2_device,
+	&sh_mmcif_device,
 	&ceu_device,
 	&mackerel_camera,
 	&hdmi_device,
@@ -1348,11 +1372,10 @@ static void __init mackerel_init(void)
 		{ "A3SP", &usbhs0_device, },
 		{ "A3SP", &usbhs1_device, },
 		{ "A3SP", &nand_flash_device, },
+		{ "A3SP", &sh_mmcif_device, },
 		{ "A3SP", &sdhi0_device, },
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 		{ "A3SP", &sdhi1_device, },
-#else
-		{ "A3SP", &sh_mmcif_device, },
 #endif
 		{ "A3SP", &sdhi2_device, },
 		{ "A4R", &ceu_device, },
@@ -1463,35 +1486,11 @@ static void __init mackerel_init(void)
 	/* SDHI0 PORT172 card-detect IRQ26 */
 	gpio_request(GPIO_FN_IRQ26_172, NULL);
 
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
-	/* enable SDHI1 */
-	gpio_request(GPIO_FN_SDHICMD1, NULL);
-	gpio_request(GPIO_FN_SDHICLK1, NULL);
-	gpio_request(GPIO_FN_SDHID1_3, NULL);
-	gpio_request(GPIO_FN_SDHID1_2, NULL);
-	gpio_request(GPIO_FN_SDHID1_1, NULL);
-	gpio_request(GPIO_FN_SDHID1_0, NULL);
-#else
-	/* MMCIF */
-	gpio_request(GPIO_FN_MMCD0_0, NULL);
-	gpio_request(GPIO_FN_MMCD0_1, NULL);
-	gpio_request(GPIO_FN_MMCD0_2, NULL);
-	gpio_request(GPIO_FN_MMCD0_3, NULL);
-	gpio_request(GPIO_FN_MMCD0_4, NULL);
-	gpio_request(GPIO_FN_MMCD0_5, NULL);
-	gpio_request(GPIO_FN_MMCD0_6, NULL);
-	gpio_request(GPIO_FN_MMCD0_7, NULL);
-	gpio_request(GPIO_FN_MMCCMD0, NULL);
-	gpio_request(GPIO_FN_MMCCLK0, NULL);
-#endif
+	/* card detect pin for MMC slot (CN7) */
+	gpio_request_one(41, GPIOF_IN, NULL);
 
-	/* enable SDHI2 */
-	gpio_request(GPIO_FN_SDHICMD2, NULL);
-	gpio_request(GPIO_FN_SDHICLK2, NULL);
-	gpio_request(GPIO_FN_SDHID2_3, NULL);
-	gpio_request(GPIO_FN_SDHID2_2, NULL);
-	gpio_request(GPIO_FN_SDHID2_1, NULL);
-	gpio_request(GPIO_FN_SDHID2_0, NULL);
+	/* card detect pin for microSD slot (CN23) */
+	gpio_request_one(162, GPIOF_IN, NULL);
 
 	/* FLCTL */
 	gpio_request(GPIO_FN_D0_NAF0, NULL);
-- 
1.7.10.4
