From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 24 Nov 2016 16:04:53 +0100
Subject: [PATCH v2 2/3] ARM: davinci: da850-evm: use gpio descriptor for mmc
 pins
In-Reply-To: <20161124150454.23899-1-ahaslam@baylibre.com>
References: <20161124150454.23899-1-ahaslam@baylibre.com>
Message-ID: <20161124150454.23899-3-ahaslam@baylibre.com>
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
 arch/arm/mach-davinci/board-da850-evm.c | 35 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index ec5cb10..1a31ac3 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/i2c.h>
@@ -56,9 +57,6 @@
 #define DA850_LCD_PWR_PIN		GPIO_TO_PIN(2, 8)
 #define DA850_LCD_BL_PIN		GPIO_TO_PIN(2, 15)
 
-#define DA850_MMCSD_CD_PIN		GPIO_TO_PIN(4, 0)
-#define DA850_MMCSD_WP_PIN		GPIO_TO_PIN(4, 1)
-
 #define DA850_MII_MDIO_CLKEN_PIN	GPIO_TO_PIN(2, 6)
 
 static struct mtd_partition da850evm_spiflash_part[] = {
@@ -776,19 +774,16 @@ static const short da850_evm_mcasp_pins[] __initconst = {
 	-1
 };
 
-static int da850_evm_mmc_get_ro(int index)
-{
-	return gpio_get_value(DA850_MMCSD_WP_PIN);
-}
-
-static int da850_evm_mmc_get_cd(int index)
-{
-	return !gpio_get_value(DA850_MMCSD_CD_PIN);
-}
+static struct gpiod_lookup_table mmc_gpios_table = {
+	.dev_id = "da830-mmc.0",
+	.table = {
+		/* gpio chip 2 contains gpio range 64-95 */
+		GPIO_LOOKUP("davinci_gpio.2", 0, "cd", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.2", 1, "wp", GPIO_ACTIVE_LOW),
+	},
+};
 
 static struct davinci_mmc_config da850_mmc_config = {
-	.get_ro		= da850_evm_mmc_get_ro,
-	.get_cd		= da850_evm_mmc_get_cd,
 	.wires		= 4,
 	.max_freq	= 50000000,
 	.caps		= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
@@ -1383,17 +1378,7 @@ static __init void da850_evm_init(void)
 			pr_warn("%s: MMCSD0 mux setup failed: %d\n",
 				__func__, ret);
 
-		ret = gpio_request(DA850_MMCSD_CD_PIN, "MMC CD\n");
-		if (ret)
-			pr_warn("%s: can not open GPIO %d\n",
-				__func__, DA850_MMCSD_CD_PIN);
-		gpio_direction_input(DA850_MMCSD_CD_PIN);
-
-		ret = gpio_request(DA850_MMCSD_WP_PIN, "MMC WP\n");
-		if (ret)
-			pr_warn("%s: can not open GPIO %d\n",
-				__func__, DA850_MMCSD_WP_PIN);
-		gpio_direction_input(DA850_MMCSD_WP_PIN);
+		gpiod_add_lookup_table(&mmc_gpios_table);
 
 		ret = da8xx_register_mmcsd0(&da850_mmc_config);
 		if (ret)
-- 
2.9.3
