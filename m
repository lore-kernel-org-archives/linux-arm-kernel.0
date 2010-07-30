From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 30 Jul 2010 08:34:28 +0200
Subject: [PATCH 6/6] [ARM] pxa/balloon3: Add MAX1586 PMIC support
In-Reply-To: <1280471668-30955-1-git-send-email-marek.vasut@gmail.com>
References: <1280471668-30955-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1280471668-30955-6-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c |   55 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index e2eb0b7..9041340 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -29,6 +29,7 @@
 #include <linux/i2c/pcf857x.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/physmap.h>
+#include <linux/regulator/max1586.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -680,6 +681,59 @@ static inline void balloon3_nand_init(void) {}
 #endif
 
 /******************************************************************************
+ * Core power regulator
+ ******************************************************************************/
+#if defined(CONFIG_REGULATOR_MAX1586) || \
+    defined(CONFIG_REGULATOR_MAX1586_MODULE)
+static struct regulator_consumer_supply balloon3_max1587a_consumers[] = {
+	{
+		.supply	= "vcc_core",
+	}
+};
+
+static struct regulator_init_data balloon3_max1587a_v3_info = {
+	.constraints = {
+		.name		= "vcc_core range",
+		.min_uV		= 900000,
+		.max_uV		= 1705000,
+		.always_on	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.consumer_supplies	= balloon3_max1587a_consumers,
+	.num_consumer_supplies	= ARRAY_SIZE(balloon3_max1587a_consumers),
+};
+
+static struct max1586_subdev_data balloon3_max1587a_subdevs[] = {
+	{
+		.name		= "vcc_core",
+		.id		= MAX1586_V3,
+		.platform_data	= &balloon3_max1587a_v3_info,
+	}
+};
+
+static struct max1586_platform_data balloon3_max1587a_info = {
+	.subdevs     = balloon3_max1587a_subdevs,
+	.num_subdevs = ARRAY_SIZE(balloon3_max1587a_subdevs),
+	.v3_gain     = MAX1586_GAIN_R24_3k32, /* 730..1550 mV */
+};
+
+static struct i2c_board_info __initdata balloon3_pi2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("max1586", 0x14),
+		.platform_data	= &balloon3_max1587a_info,
+	},
+};
+
+static void __init balloon3_pmic_init(void)
+{
+	pxa27x_set_i2c_power_info(NULL);
+	i2c_register_board_info(1, ARRAY_AND_SIZE(balloon3_pi2c_board_info));
+}
+#else
+static inline void balloon3_pmic_init(void) {}
+#endif
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void __init balloon3_init(void)
@@ -699,6 +753,7 @@ static void __init balloon3_init(void)
 	balloon3_mmc_init();
 	balloon3_nand_init();
 	balloon3_nor_init();
+	balloon3_pmic_init();
 	balloon3_ts_init();
 	balloon3_udc_init();
 	balloon3_uhc_init();
-- 
1.7.1
