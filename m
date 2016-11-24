From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 24 Nov 2016 16:04:54 +0100
Subject: [PATCH v2 3/3] ARM: davinci: da830-evm: use gpio descriptor for mmc
 pins
In-Reply-To: <20161124150454.23899-1-ahaslam@baylibre.com>
References: <20161124150454.23899-1-ahaslam@baylibre.com>
Message-ID: <20161124150454.23899-4-ahaslam@baylibre.com>
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
 arch/arm/mach-davinci/board-da830-evm.c | 41 +++++++++------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 5db0901..5807562 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -14,6 +14,7 @@
 #include <linux/console.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pcf857x.h>
@@ -204,22 +205,16 @@ static const short da830_evm_mmc_sd_pins[] = {
 	-1
 };
 
-#define DA830_MMCSD_WP_PIN		GPIO_TO_PIN(2, 1)
-#define DA830_MMCSD_CD_PIN		GPIO_TO_PIN(2, 2)
-
-static int da830_evm_mmc_get_ro(int index)
-{
-	return gpio_get_value(DA830_MMCSD_WP_PIN);
-}
-
-static int da830_evm_mmc_get_cd(int index)
-{
-	return !gpio_get_value(DA830_MMCSD_CD_PIN);
-}
+static struct gpiod_lookup_table mmc_gpios_table = {
+	.dev_id = "da830-mmc.0",
+	.table = {
+		/* gpio chip 1 contains gpio range 32-63 */
+		GPIO_LOOKUP("davinci_gpio.1", 2, "cd", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.1", 1, "wp", GPIO_ACTIVE_LOW),
+	},
+};
 
 static struct davinci_mmc_config da830_evm_mmc_config = {
-	.get_ro			= da830_evm_mmc_get_ro,
-	.get_cd			= da830_evm_mmc_get_cd,
 	.wires			= 8,
 	.max_freq		= 50000000,
 	.caps			= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
@@ -235,26 +230,12 @@ static inline void da830_evm_init_mmc(void)
 		return;
 	}
 
-	ret = gpio_request(DA830_MMCSD_WP_PIN, "MMC WP");
-	if (ret) {
-		pr_warn("%s: can not open GPIO %d\n",
-			__func__, DA830_MMCSD_WP_PIN);
-		return;
-	}
-	gpio_direction_input(DA830_MMCSD_WP_PIN);
-
-	ret = gpio_request(DA830_MMCSD_CD_PIN, "MMC CD\n");
-	if (ret) {
-		pr_warn("%s: can not open GPIO %d\n",
-			__func__, DA830_MMCSD_CD_PIN);
-		return;
-	}
-	gpio_direction_input(DA830_MMCSD_CD_PIN);
+	gpiod_add_lookup_table(&mmc_gpios_table);
 
 	ret = da8xx_register_mmcsd0(&da830_evm_mmc_config);
 	if (ret) {
 		pr_warn("%s: mmc/sd registration failed: %d\n", __func__, ret);
-		gpio_free(DA830_MMCSD_WP_PIN);
+		gpiod_remove_lookup_table(&mmc_gpios_table);
 	}
 }
 
-- 
2.9.3
