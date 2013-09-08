From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Sun,  8 Sep 2013 10:50:39 +0200
Subject: [PATCH 4/4] RX-51: Add platform function and data for bq24150a charger
In-Reply-To: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1378630239-10006-5-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will register bq24150a charger in RX-51 board data.
Patch also adding platform function between isp1704 and bq2415x
drivers for detecting charger type.

So finally charging battery on Nokia N900 (RX-51) working
automatically without any proprietary Nokia bits in userspace.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   56 +++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 9c2dd10..a993ffe 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -25,6 +25,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
 #include <linux/power/isp1704_charger.h>
+#include <linux/power/bq2415x_charger.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 
@@ -270,6 +271,44 @@ static struct platform_device rx51_battery_device = {
 	.id	= -1,
 };
 
+static enum bq2415x_mode rx51_charger_mode = BQ2415X_MODE_OFF;
+static void *rx51_charger_hook_data;
+static void (*rx51_charger_hook)(enum bq2415x_mode mode, void *data);
+
+static int rx51_charger_set_hook(
+		void (*hook)(enum bq2415x_mode mode, void *data), void *data)
+{
+	rx51_charger_hook = hook;
+	rx51_charger_hook_data = data;
+	if (rx51_charger_hook)
+		rx51_charger_hook(rx51_charger_mode, rx51_charger_hook_data);
+	return 1;
+}
+
+static void rx51_charger_set_current(int mA)
+{
+	enum bq2415x_mode mode;
+
+	pr_info("RX-51: Charger current limit is %d mA\n", mA);
+
+	if (mA == 0)
+		mode = BQ2415X_MODE_OFF;
+	else if (mA < 500)
+		mode = BQ2415X_MODE_NONE;
+	else if (mA < 1800)
+		mode = BQ2415X_MODE_HOST_CHARGER;
+	else
+		mode = BQ2415X_MODE_DEDICATED_CHARGER;
+
+	if (rx51_charger_mode == mode)
+		return;
+
+	rx51_charger_mode = mode;
+
+	if (rx51_charger_hook)
+		rx51_charger_hook(rx51_charger_mode, rx51_charger_hook_data);
+}
+
 static void rx51_charger_set_power(bool on)
 {
 	gpio_set_value(RX51_USB_TRANSCEIVER_RST_GPIO, on);
@@ -277,6 +316,7 @@ static void rx51_charger_set_power(bool on)
 
 static struct isp1704_charger_data rx51_charger_data = {
 	.set_power	= rx51_charger_set_power,
+	.set_current	= rx51_charger_set_current,
 };
 
 static struct platform_device rx51_charger_device = {
@@ -1017,6 +1057,16 @@ static struct aic3x_pdata rx51_aic3x_data2 = {
 	.gpio_reset = 60,
 };
 
+static struct bq2415x_platform_data rx51_bq24150a_platform_data = {
+	.current_limit = 100,			/* mA */
+	.weak_battery_voltage = 3400,		/* mV */
+	.battery_regulation_voltage = 4200,	/* mV */
+	.charge_current = 650,			/* mA */
+	.termination_current = 100,		/* mA */
+	.resistor_sense = 68,			/* m ohm */
+	.set_mode_hook = &rx51_charger_set_hook,
+};
+
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
@@ -1044,7 +1094,11 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 	{
 		I2C_BOARD_INFO("tpa6130a2", 0x60),
 		.platform_data = &rx51_tpa6130a2_data,
-	}
+	},
+	{
+		I2C_BOARD_INFO("bq24150a", 0x6b),
+		.platform_data = &rx51_bq24150a_platform_data,
+	},
 };
 
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_3[] = {
-- 
1.7.10.4
