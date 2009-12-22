From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 22 Dec 2009 15:11:30 -0500
Subject: [PATCH] [ARM] pxa: remove reduntant gpio setting on mmc slot
Message-ID: <mailman.107.1261484991.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA mmc host driver supports card detect, read only and power gpio pin
setting already. Zylonite platform driver needn't implement this any more.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/include/mach/zylonite.h |    7 --
 arch/arm/mach-pxa/zylonite.c              |   87 +++++------------------------
 arch/arm/mach-pxa/zylonite_pxa300.c       |   12 +---
 arch/arm/mach-pxa/zylonite_pxa320.c       |    4 -
 4 files changed, 16 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/zylonite.h
b/arch/arm/mach-pxa/include/mach/zylonite.h
index bf6785a..9edf645 100644
--- a/arch/arm/mach-pxa/include/mach/zylonite.h
+++ b/arch/arm/mach-pxa/include/mach/zylonite.h
@@ -8,13 +8,6 @@
 /* the following variables are processor specific and initialized
  * by the corresponding zylonite_pxa3xx_init()
  */
-struct platform_mmc_slot {
-	int gpio_cd;
-	int gpio_wp;
-};
-
-extern struct platform_mmc_slot zylonite_mmc_slot[];
-
 extern int gpio_eth_irq;
 extern int gpio_debug_led1;
 extern int gpio_debug_led2;
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index b66e9e2..2b4043c 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -36,9 +36,6 @@
 #include "devices.h"
 #include "generic.h"

-#define MAX_SLOTS	3
-struct platform_mmc_slot zylonite_mmc_slot[MAX_SLOTS];
-
 int gpio_eth_irq;
 int gpio_debug_led1;
 int gpio_debug_led2;
@@ -220,84 +217,28 @@ static inline void zylonite_init_lcd(void) {}
 #endif

 #if defined(CONFIG_MMC)
-static int zylonite_mci_ro(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	return gpio_get_value(zylonite_mmc_slot[pdev->id].gpio_wp);
-}
-
-static int zylonite_mci_init(struct device *dev,
-			     irq_handler_t zylonite_detect_int,
-			     void *data)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	int err, cd_irq, gpio_cd, gpio_wp;
-
-	cd_irq = gpio_to_irq(zylonite_mmc_slot[pdev->id].gpio_cd);
-	gpio_cd = zylonite_mmc_slot[pdev->id].gpio_cd;
-	gpio_wp = zylonite_mmc_slot[pdev->id].gpio_wp;
-
-	/*
-	 * setup GPIO for Zylonite MMC controller
-	 */
-	err = gpio_request(gpio_cd, "mmc card detect");
-	if (err)
-		goto err_request_cd;
-	gpio_direction_input(gpio_cd);
-
-	err = gpio_request(gpio_wp, "mmc write protect");
-	if (err)
-		goto err_request_wp;
-	gpio_direction_input(gpio_wp);
-
-	err = request_irq(cd_irq, zylonite_detect_int,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			  "MMC card detect", data);
-	if (err) {
-		printk(KERN_ERR "%s: MMC/SD/SDIO: "
-				"can't request card detect IRQ\n", __func__);
-		goto err_request_irq;
-	}
-
-	return 0;
-
-err_request_irq:
-	gpio_free(gpio_wp);
-err_request_wp:
-	gpio_free(gpio_cd);
-err_request_cd:
-	return err;
-}
-
-static void zylonite_mci_exit(struct device *dev, void *data)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	int cd_irq, gpio_cd, gpio_wp;
-
-	cd_irq = gpio_to_irq(zylonite_mmc_slot[pdev->id].gpio_cd);
-	gpio_cd = zylonite_mmc_slot[pdev->id].gpio_cd;
-	gpio_wp = zylonite_mmc_slot[pdev->id].gpio_wp;
-
-	free_irq(cd_irq, data);
-	gpio_free(gpio_cd);
-	gpio_free(gpio_wp);
-}
-
 static struct pxamci_platform_data zylonite_mci_platform_data = {
 	.detect_delay	= 20,
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.init 		= zylonite_mci_init,
-	.exit		= zylonite_mci_exit,
-	.get_ro		= zylonite_mci_ro,
-	.gpio_card_detect = -1,
-	.gpio_card_ro	= -1,
+	.gpio_card_detect = EXT_GPIO(0),
+	.gpio_card_ro	= EXT_GPIO(2),
 	.gpio_power	= -1,
 };

 static struct pxamci_platform_data zylonite_mci2_platform_data = {
 	.detect_delay	= 20,
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
+	.gpio_card_detect = EXT_GPIO(1),
+	.gpio_card_ro	= EXT_GPIO(3),
+	.gpio_power	= -1,
+};
+
+static struct pxamci_platform_data zylonite_mci3_platform_data = {
+	.detect_delay	= 20,
+	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
+	.gpio_card_detect = EXT_GPIO(30),
+	.gpio_card_ro	= EXT_GPIO(31),
+	.gpio_power	= -1,
 };

 static void __init zylonite_init_mmc(void)
@@ -305,7 +246,7 @@ static void __init zylonite_init_mmc(void)
 	pxa_set_mci_info(&zylonite_mci_platform_data);
 	pxa3xx_set_mci2_info(&zylonite_mci2_platform_data);
 	if (cpu_is_pxa310())
-		pxa3xx_set_mci3_info(&zylonite_mci_platform_data);
+		pxa3xx_set_mci3_info(&zylonite_mci3_platform_data);
 }
 #else
 static inline void zylonite_init_mmc(void) {}
diff --git a/arch/arm/mach-pxa/zylonite_pxa300.c
b/arch/arm/mach-pxa/zylonite_pxa300.c
index 8409544..3aa73b3 100644
--- a/arch/arm/mach-pxa/zylonite_pxa300.c
+++ b/arch/arm/mach-pxa/zylonite_pxa300.c
@@ -129,8 +129,8 @@ static mfp_cfg_t common_mfp_cfg[] __initdata = {
 	GPIO22_I2C_SDA,

 	/* GPIO */
-	GPIO18_GPIO,	/* GPIO Expander #0 INT_N */
-	GPIO19_GPIO,	/* GPIO Expander #1 INT_N */
+	GPIO18_GPIO | MFP_PULL_HIGH,	/* GPIO Expander #0 INT_N */
+	GPIO19_GPIO | MFP_PULL_HIGH,	/* GPIO Expander #1 INT_N */
 };

 static mfp_cfg_t pxa300_mfp_cfg[] __initdata = {
@@ -258,10 +258,6 @@ void __init zylonite_pxa300_init(void)
 		/* detect LCD panel */
 		zylonite_detect_lcd_panel();

-		/* MMC card detect & write protect for controller 0 */
-		zylonite_mmc_slot[0].gpio_cd  = EXT_GPIO(0);
-		zylonite_mmc_slot[0].gpio_wp  = EXT_GPIO(2);
-
 		/* WM9713 IRQ */
 		wm9713_irq = mfp_to_gpio(MFP_PIN_GPIO26);

@@ -276,10 +272,6 @@ void __init zylonite_pxa300_init(void)
 	if (cpu_is_pxa310()) {
 		pxa3xx_mfp_config(ARRAY_AND_SIZE(pxa310_mfp_cfg));
 		gpio_eth_irq = mfp_to_gpio(MFP_PIN_GPIO102);
-
-		/* MMC card detect & write protect for controller 2 */
-		zylonite_mmc_slot[2].gpio_cd = EXT_GPIO(30);
-		zylonite_mmc_slot[2].gpio_wp = EXT_GPIO(31);
 	}

 	/* GPIOs for Debug LEDs */
diff --git a/arch/arm/mach-pxa/zylonite_pxa320.c
b/arch/arm/mach-pxa/zylonite_pxa320.c
index 60d08f2..9942bac 100644
--- a/arch/arm/mach-pxa/zylonite_pxa320.c
+++ b/arch/arm/mach-pxa/zylonite_pxa320.c
@@ -209,10 +209,6 @@ void __init zylonite_pxa320_init(void)
 		gpio_debug_led1	= mfp_to_gpio(MFP_PIN_GPIO1_2);
 		gpio_debug_led2	= mfp_to_gpio(MFP_PIN_GPIO4_2);

-		/* MMC card detect & write protect for controller 0 */
-		zylonite_mmc_slot[0].gpio_cd  = mfp_to_gpio(MFP_PIN_GPIO1);
-		zylonite_mmc_slot[0].gpio_wp  = mfp_to_gpio(MFP_PIN_GPIO5);
-
 		/* WM9713 IRQ */
 		wm9713_irq = mfp_to_gpio(MFP_PIN_GPIO15);
 	}
-- 
1.5.6.5
