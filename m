From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon, 21 Nov 2016 17:15:40 +0100
Subject: [PATCH 2/3] ARM: davinci: hawk: remove mmc ro pin
In-Reply-To: <20161121161541.27048-1-ahaslam@baylibre.com>
References: <20161121161541.27048-1-ahaslam@baylibre.com>
Message-ID: <20161121161541.27048-3-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hawk board does not have a write protect pin to read the card
write protect status.

So remove un-needed platform data declaration for this gpio.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index c0c24ba9..ddc312d 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -26,7 +26,6 @@
 
 #define HAWKBOARD_PHY_ID		"davinci_mdio-0:07"
 #define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(4, 0)
-#define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
 
 #define DA850_USB1_VBUS_PIN		GPIO_TO_PIN(2, 4)
 #define DA850_USB1_OC_PIN		GPIO_TO_PIN(6, 13)
@@ -119,22 +118,16 @@ static struct edma_rsv_info *da850_edma_rsv[2] = {
 static const short hawk_mmcsd0_pins[] = {
 	DA850_MMCSD0_DAT_0, DA850_MMCSD0_DAT_1, DA850_MMCSD0_DAT_2,
 	DA850_MMCSD0_DAT_3, DA850_MMCSD0_CLK, DA850_MMCSD0_CMD,
-	DA850_GPIO4_0, DA850_GPIO3_13,
+	DA850_GPIO4_0,
 	-1
 };
 
-static int da850_hawk_mmc_get_ro(int index)
-{
-	return gpio_get_value(DA850_HAWK_MMCSD_WP_PIN);
-}
-
 static int da850_hawk_mmc_get_cd(int index)
 {
 	return !gpio_get_value(DA850_HAWK_MMCSD_CD_PIN);
 }
 
 static struct davinci_mmc_config da850_mmc_config = {
-	.get_ro		= da850_hawk_mmc_get_ro,
 	.get_cd		= da850_hawk_mmc_get_cd,
 	.wires		= 4,
 	.max_freq	= 50000000,
@@ -159,14 +152,6 @@ static __init void omapl138_hawk_mmc_init(void)
 		return;
 	}
 
-	ret = gpio_request_one(DA850_HAWK_MMCSD_WP_PIN,
-			GPIOF_DIR_IN, "MMC WP");
-	if (ret < 0) {
-		pr_warn("%s: can not open GPIO %d\n",
-			__func__, DA850_HAWK_MMCSD_WP_PIN);
-		goto mmc_setup_wp_fail;
-	}
-
 	ret = da8xx_register_mmcsd0(&da850_mmc_config);
 	if (ret) {
 		pr_warn("%s: MMC/SD0 registration failed: %d\n", __func__, ret);
@@ -176,8 +161,6 @@ static __init void omapl138_hawk_mmc_init(void)
 	return;
 
 mmc_setup_mmcsd_fail:
-	gpio_free(DA850_HAWK_MMCSD_WP_PIN);
-mmc_setup_wp_fail:
 	gpio_free(DA850_HAWK_MMCSD_CD_PIN);
 }
 
-- 
2.9.3
