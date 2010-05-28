From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 28 May 2010 19:10:42 +0400
Subject: [PATCH 1/2] at91sam9g20ek: add fixed-value regulator for wm8731
Message-ID: <1275059443-10100-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_REGULATOR is enabled, wm8731 fails on AT91SAM9G20EK board,
since codec driver requires several voltage supplies and none are
provided currently. As requires voltages are hardwired to 3V3, use fixed
voltage regulator for this chip.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-at91/board-sam9g20ek.c |   45 ++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index a2f00f4..9398ebc 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -28,6 +28,9 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/clk.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/consumer.h>
 
 #include <mach/hardware.h>
 #include <asm/setup.h>
@@ -283,6 +286,46 @@ static void __init ek_add_device_buttons(void)
 static void __init ek_add_device_buttons(void) {}
 #endif
 
+#if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
+static struct regulator_consumer_supply ek_audio_consumer_supplies[] = {
+	REGULATOR_SUPPLY("AVDD", "0-001b"),
+	REGULATOR_SUPPLY("HPVDD", "0-001b"),
+	REGULATOR_SUPPLY("DBVDD", "0-001b"),
+	REGULATOR_SUPPLY("DCVDD", "0-001b"),
+};
+
+static struct regulator_init_data ek_avdd_reg_init_data = {
+	.constraints	= {
+		.name	= "3V3",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.consumer_supplies = ek_audio_consumer_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(ek_audio_consumer_supplies),
+};
+
+static struct fixed_voltage_config ek_vdd_pdata = {
+	.supply_name	= "board-3V3",
+	.microvolts	= 3300000,
+	.gpio		= -EINVAL,
+	.enabled_at_boot = 0,
+	.init_data	= &ek_avdd_reg_init_data,
+};
+static struct platform_device ek_voltage_regulator = {
+	.name		= "reg-fixed-voltage",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &ek_vdd_pdata,
+	},
+};
+static void __init ek_add_regulators(void)
+{
+	platform_device_register(&ek_voltage_regulator);
+}
+#else
+static void __init ek_add_regulators(void) {}
+#endif
+
 
 static struct i2c_board_info __initdata ek_i2c_devices[] = {
         {
@@ -308,6 +351,8 @@ static void __init ek_board_init(void)
 	ek_add_device_nand();
 	/* Ethernet */
 	at91_add_device_eth(&ek_macb_data);
+	/* Regulators */
+	ek_add_regulators();
 	/* MMC */
 	at91_add_device_mmc(0, &ek_mmc_data);
 	/* I2C */
-- 
1.7.1
