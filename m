From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon,  7 Jun 2010 05:59:03 +0200
Subject: [PATCH v2] pxa/z2: Add regulator support
Message-ID: <1275883143-3512-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register TPS65023 regulator as found in Z2. The Z2 actually contains a TPS65021,
but this chip is apparently compatible.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/z2.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 967e8cb..cceffeb 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -27,6 +27,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/delay.h>
+#include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -610,6 +611,75 @@ static inline void z2_spi_init(void) {}
 #endif
 
 /******************************************************************************
+ * Core power regulator
+ ******************************************************************************/
+#if defined(CONFIG_REGULATOR_TPS65023) || \
+	defined(CONFIG_REGULATOR_TPS65023_MODULE)
+static struct regulator_consumer_supply z2_tps65021_consumers[] = {
+	{
+		.supply	= "vcc_core",
+	}
+};
+
+static struct regulator_init_data z2_tps65021_info[] = {
+	{
+		.constraints = {
+			.name		= "vcc_core range",
+			.min_uV		= 800000,
+			.max_uV		= 1600000,
+			.always_on	= 1,
+			.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+		},
+		.consumer_supplies	= z2_tps65021_consumers,
+		.num_consumer_supplies	= ARRAY_SIZE(z2_tps65021_consumers),
+	}, {
+		.constraints = {
+			.name		= "DCDC2",
+			.min_uV		= 3300000,
+			.max_uV		= 3300000,
+			.always_on	= 1,
+		},
+	}, {
+		.constraints = {
+			.name		= "DCDC3",
+			.min_uV		= 1800000,
+			.max_uV		= 1800000,
+			.always_on	= 1,
+		},
+	}, {
+		.constraints = {
+			.name		= "LDO1",
+			.min_uV		= 1000000,
+			.max_uV		= 3150000,
+			.always_on	= 1,
+		},
+	}, {
+		.constraints = {
+			.name		= "LDO2",
+			.min_uV		= 1050000,
+			.max_uV		= 3300000,
+			.always_on	= 1,
+		},
+	}
+};
+
+static struct i2c_board_info __initdata z2_pi2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("tps65023", 0x48),
+		.platform_data	= &z2_tps65021_info,
+	},
+};
+
+static void __init z2_pmic_init(void)
+{
+	pxa27x_set_i2c_power_info(NULL);
+	i2c_register_board_info(1, ARRAY_AND_SIZE(z2_pi2c_board_info));
+}
+#else
+static inline void z2_pmic_init(void) {}
+#endif
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void __init z2_init(void)
@@ -629,6 +699,7 @@ static void __init z2_init(void)
 	z2_pwm_init();
 	z2_leds_init();
 	z2_keys_init();
+	z2_pmic_init();
 }
 
 MACHINE_START(ZIPIT2, "Zipit Z2")
-- 
1.7.1
