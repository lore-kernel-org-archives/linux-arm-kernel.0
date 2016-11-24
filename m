From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 24 Nov 2016 16:04:52 +0100
Subject: [PATCH v2 1/3] ARM: davinci: hawk: use gpio descriptor for mmc pins
In-Reply-To: <20161124150454.23899-1-ahaslam@baylibre.com>
References: <20161124150454.23899-1-ahaslam@baylibre.com>
Message-ID: <20161124150454.23899-2-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the mmc driver is polling the gpio to know if the
card was removed.

By using a gpio descriptor instead of the platform callbacks,
the driver will be able to register the gpio using the mmc core
API's designed for this purpose.

This has the advantage that an irq will be registered, and
polling is no longer needed. Also, a dependency on platform
callbacks is removed for this board.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 42 ++++++++---------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index a4e8726..a2966d3 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -15,6 +15,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/regulator/machine.h>
+#include <linux/gpio/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -25,8 +26,6 @@
 #include <mach/mux.h>
 
 #define HAWKBOARD_PHY_ID		"davinci_mdio-0:07"
-#define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
-#define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
 
 #define DA850_USB1_VBUS_PIN		GPIO_TO_PIN(2, 4)
 #define DA850_USB1_OC_PIN		GPIO_TO_PIN(6, 13)
@@ -123,19 +122,16 @@ static const short hawk_mmcsd0_pins[] = {
 	-1
 };
 
-static int da850_hawk_mmc_get_ro(int index)
-{
-	return gpio_get_value(DA850_HAWK_MMCSD_WP_PIN);
-}
-
-static int da850_hawk_mmc_get_cd(int index)
-{
-	return !gpio_get_value(DA850_HAWK_MMCSD_CD_PIN);
-}
+static struct gpiod_lookup_table mmc_gpios_table = {
+	.dev_id = "da830-mmc.0",
+	.table = {
+		/* CD: gpio3_12: gpio60: chip 1 contains gpio range 32-63*/
+		GPIO_LOOKUP("davinci_gpio.1", 28, "cd", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.1", 29, "wp", GPIO_ACTIVE_LOW),
+	},
+};
 
 static struct davinci_mmc_config da850_mmc_config = {
-	.get_ro		= da850_hawk_mmc_get_ro,
-	.get_cd		= da850_hawk_mmc_get_cd,
 	.wires		= 4,
 	.max_freq	= 50000000,
 	.caps		= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
@@ -151,21 +147,7 @@ static __init void omapl138_hawk_mmc_init(void)
 		return;
 	}
 
-	ret = gpio_request_one(DA850_HAWK_MMCSD_CD_PIN,
-			GPIOF_DIR_IN, "MMC CD");
-	if (ret < 0) {
-		pr_warn("%s: can not open GPIO %d\n",
-			__func__, DA850_HAWK_MMCSD_CD_PIN);
-		return;
-	}
-
-	ret = gpio_request_one(DA850_HAWK_MMCSD_WP_PIN,
-			GPIOF_DIR_IN, "MMC WP");
-	if (ret < 0) {
-		pr_warn("%s: can not open GPIO %d\n",
-			__func__, DA850_HAWK_MMCSD_WP_PIN);
-		goto mmc_setup_wp_fail;
-	}
+	gpiod_add_lookup_table(&mmc_gpios_table);
 
 	ret = da8xx_register_mmcsd0(&da850_mmc_config);
 	if (ret) {
@@ -176,9 +158,7 @@ static __init void omapl138_hawk_mmc_init(void)
 	return;
 
 mmc_setup_mmcsd_fail:
-	gpio_free(DA850_HAWK_MMCSD_WP_PIN);
-mmc_setup_wp_fail:
-	gpio_free(DA850_HAWK_MMCSD_CD_PIN);
+	gpiod_remove_lookup_table(&mmc_gpios_table);
 }
 
 static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
-- 
2.9.3
