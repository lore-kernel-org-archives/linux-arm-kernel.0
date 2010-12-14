From: mark.brown314@gmail.com (Mark F. Brown)
Date: Mon, 13 Dec 2010 22:56:59 -0500
Subject: [PATCH] ARM: mmp: refactored 5V regulator support using
	fixed-regulator
Message-ID: <1292299019-2915-1-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
---
 arch/arm/mach-mmp/brownstone.c |   48 +++++++++++++++++++++++++++------------
 1 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 9d37b35..9ebeb21 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -17,6 +17,7 @@
 #include <linux/gpio.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/max8649.h>
+#include <linux/regulator/fixed.h>
 #include <linux/mfd/max8925.h>
 
 #include <asm/mach-types.h>
@@ -128,6 +129,35 @@ static struct max8649_platform_data brownstone_max8649_info = {
 	.regulator	= &max8649_init_data,
 };
 
+static struct regulator_consumer_supply brownstone_v_5vp_supplies[] = {
+	REGULATOR_SUPPLY("v_5vp", NULL),
+};
+
+static struct regulator_init_data brownstone_v_5vp_data = {
+	.constraints	= {
+		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(brownstone_v_5vp_supplies),
+	.consumer_supplies	= brownstone_v_5vp_supplies,
+};
+
+static struct fixed_voltage_config brownstone_v_5vp = {
+	.supply_name		= "v_5vp",
+	.microvolts		= 5000000,
+	.gpio			= GPIO_5V_ENABLE,
+	.enable_high		= 1,
+	.enabled_at_boot	= 1,
+	.init_data		= &brownstone_v_5vp_data,
+};
+
+static struct platform_device brownstone_v_5vp_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev = {
+		.platform_data = &brownstone_v_5vp,
+	},
+};
+
 static struct max8925_platform_data brownstone_max8925_info = {
 	.irq_base		= IRQ_BOARD_START,
 };
@@ -150,30 +180,18 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
 	.max_speed	= 25000000,
 };
 
-/* enable for MAX8815A regulator (5V_ENABLE) */
-static void brownstone_enable_5v_regulator(void)
-{
-	int ret;
-	ret = gpio_request(GPIO_5V_ENABLE, "5V_ENABLE");
-	if (ret < 0)
-		pr_warning("Unable to request GPIO_5V_ENABLE\n");
-	else
-		gpio_direction_output(GPIO_5V_ENABLE, 1);
-	gpio_free(GPIO_5V_ENABLE);
-}
-
 static void __init brownstone_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
 
-	/* enable 5v regulator */
-	brownstone_enable_5v_regulator();
-
 	/* on-chip devices */
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+
+	/* enable 5v regulator */
+	platform_device_register(&brownstone_v_5vp_device);
 }
 
 MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
-- 
1.7.0.4
