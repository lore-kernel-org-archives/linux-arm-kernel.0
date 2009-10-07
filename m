From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  7 Oct 2009 14:36:34 +0100
Subject: [PATCH] SMDK6410: Hook up regulator supplies for WM8580
Message-ID: <1254922594-20907-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DVDD is supplied by supplies derived from the PMIC, AVDD and PVDD are
supplied from the main wall supply on the base board which runs at
5V. No option is currently supported for running without a PMIC card,
the assumption is that the regulator API will be built out when no
soft PMIC card is in use.

To ease merge issues since this uses the newly added dev_name supply
configuration from the regulator API (currently in -next only) the
fixed voltage regulator is ifdefed out when the regulator API is not
enabled.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |   52 +++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index ea51dbe..72776ff 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/smsc911x.h>
+#include <linux/regulator/fixed.h>
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 #include <linux/mfd/wm8350/core.h>
@@ -184,6 +185,43 @@ static struct platform_device smdk6410_smsc911x = {
 	},
 };
 
+#ifdef CONFIG_REGULATOR
+static struct regulator_consumer_supply smdk6410_b_pwr_5v_consumers[] = {
+	{
+		/* WM8580 */
+		.supply = "PVDD",
+		.dev_name = "0-001b",
+	},
+	{
+		/* WM8580 */
+		.supply = "AVDD",
+		.dev_name = "0-001b",
+	},
+};
+
+static struct regulator_init_data smdk6410_b_pwr_5v_data = {
+	.constraints = {
+		.always_on = 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(smdk6410_b_pwr_5v_consumers),
+	.consumer_supplies = smdk6410_b_pwr_5v_consumers,
+};
+
+static struct fixed_voltage_config smdk6410_b_pwr_5v_pdata = {
+	.supply_name = "B_PWR_5V",
+	.microvolts = 5000000,
+	.init_data = &smdk6410_b_pwr_5v_data,
+};
+
+static struct platform_device smdk6410_b_pwr_5v = {
+	.name          = "reg-fixed-voltage",
+	.id            = -1,
+	.dev = {
+		.platform_data = &smdk6410_b_pwr_5v_pdata,
+	},
+};
+#endif
+
 static struct map_desc smdk6410_iodesc[] = {};
 
 static struct platform_device *smdk6410_devices[] __initdata = {
@@ -198,6 +236,10 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_usb,
 	&s3c_device_usb_hsotg,
+
+#ifdef CONFIG_REGULATOR
+	&smdk6410_b_pwr_5v,
+#endif
 	&smdk6410_lcd_powerdev,
 
 	&smdk6410_smsc911x,
@@ -232,6 +274,14 @@ static struct regulator_init_data wm8350_dcdc3_data = {
 };
 
 /* USB, EXT, PCM, ADC/DAC, USB, MMC */
+static struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
+	{
+		/* WM8580 */
+		.supply = "DVDD",
+		.dev_name = "0-001b",
+	},
+};
+
 static struct regulator_init_data wm8350_dcdc4_data = {
 	.constraints = {
 		.name = "PVDD_HI/PVDD_EXT/PVDD_SYS/PVCCM2MTV",
@@ -239,6 +289,8 @@ static struct regulator_init_data wm8350_dcdc4_data = {
 		.max_uV = 3000000,
 		.always_on = 1,
 	},
+	.num_consumer_supplies = ARRAY_SIZE(wm8350_dcdc4_consumers),
+	.consumer_supplies = wm8350_dcdc4_consumers,
 };
 
 /* ARM core */
-- 
1.6.4.3
