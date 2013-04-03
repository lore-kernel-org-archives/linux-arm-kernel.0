From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:08:24 +0900
Subject: [PATCH 09/11] ARM: shmobile: mackerel: switch SDHI and MMCIF
 interfaces to slot-gpio
In-Reply-To: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954906-16014-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Both SDHI and MMCIF drivers can use the standard slot-gpio card-detection
functions. Switch mackerel to using them instead of platform callbacks.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |   39 ++++++++++---------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 734565d..a47a1116 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -963,15 +963,6 @@ static struct platform_device nand_flash_device = {
 	},
 };
 
-/*
- * The card detect pin of the top SD/MMC slot (CN7) is active low and is
- * connected to GPIO A22 of SH7372 (GPIO 41).
- */
-static int slot_cn7_get_cd(struct platform_device *pdev)
-{
-	return !gpio_get_value(41);
-}
-
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
@@ -1011,13 +1002,15 @@ static struct platform_device sdhi0_device = {
 
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SDHI1 */
+
+/* GPIO 41 can trigger IRQ8, but it is used by USBHS1, we have to poll */
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
-	.get_cd		= slot_cn7_get_cd,
+	.cd_gpio	= 41,
 };
 
 static struct resource sdhi1_resources[] = {
@@ -1052,23 +1045,19 @@ static struct platform_device sdhi1_device = {
 };
 #endif
 
+/* SDHI2 */
+
 /*
  * The card detect pin of the top SD/MMC slot (CN23) is active low and is
- * connected to GPIO SCIFB_SCK of SH7372 (162).
+ * connected to GPIO SCIFB_SCK of SH7372 (GPIO 162).
  */
-static int slot_cn23_get_cd(struct platform_device *pdev)
-{
-	return !gpio_get_value(162);
-}
-
-/* SDHI2 */
 static struct sh_mobile_sdhi_info sdhi2_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
-	.get_cd		= slot_cn23_get_cd,
+	.cd_gpio	= 162,
 };
 
 static struct resource sdhi2_resources[] = {
@@ -1127,7 +1116,9 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
-	.get_cd		= slot_cn7_get_cd,
+	.use_cd_gpio	= true,
+	/* card detect pin for SD/MMC slot (CN7) */
+	.cd_gpio	= 41,
 	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
 	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
@@ -1475,12 +1466,6 @@ static void __init mackerel_init(void)
 	/* SDHI0 PORT172 card-detect IRQ26 */
 	gpio_request(GPIO_FN_IRQ26_172, NULL);
 
-	/* card detect pin for MMC slot (CN7) */
-	gpio_request_one(41, GPIOF_IN, NULL);
-
-	/* card detect pin for microSD slot (CN23) */
-	gpio_request_one(162, GPIOF_IN, NULL);
-
 	/* FLCTL */
 	gpio_request(GPIO_FN_D0_NAF0, NULL);
 	gpio_request(GPIO_FN_D1_NAF1, NULL);
-- 
1.7.10.4
