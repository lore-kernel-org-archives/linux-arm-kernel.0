From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:44 -0700
Subject: [PATCH 40/46] davinci: DA850/OMAP-L138 EVM expander setup and UI card
	detection
In-Reply-To: <1255720190-7452-41-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-41-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-42-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chaithrika U S <chaithrika@ti.com>

DA850/OMAP-L138 EVM can be connected to an UI card which has various
peripherals on it.The UI card has TCA6416 expander which can be probed
to check whether the UI card is connected or not. If the UI card is
connected, setup NOR and NAND devices. This is done via the expander
setup callback.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |  127 ++++++++++++++++++++++++-------
 1 files changed, 99 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a34df64..05b2d87 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -17,6 +17,7 @@
 #include <linux/console.h>
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
+#include <linux/i2c/pca953x.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
@@ -145,10 +146,85 @@ static struct platform_device da850_evm_nandflash_device = {
 	.resource	= da850_evm_nandflash_resource,
 };
 
+static u32 ui_card_detected;
+static void da850_evm_setup_nor_nand(void);
+
+static int da850_evm_ui_expander_setup(struct i2c_client *client, unsigned gpio,
+						unsigned ngpio, void *c)
+{
+	int sel_a, sel_b, sel_c, ret;
+
+	sel_a = gpio + 7;
+	sel_b = gpio + 6;
+	sel_c = gpio + 5;
+
+	ret = gpio_request(sel_a, "sel_a");
+	if (ret) {
+		pr_warning("Cannot open UI expander pin %d\n", sel_a);
+		goto exp_setup_sela_fail;
+	}
+
+	ret = gpio_request(sel_b, "sel_b");
+	if (ret) {
+		pr_warning("Cannot open UI expander pin %d\n", sel_b);
+		goto exp_setup_selb_fail;
+	}
+
+	ret = gpio_request(sel_c, "sel_c");
+	if (ret) {
+		pr_warning("Cannot open UI expander pin %d\n", sel_c);
+		goto exp_setup_selc_fail;
+	}
+
+	/* deselect all functionalities */
+	gpio_direction_output(sel_a, 1);
+	gpio_direction_output(sel_b, 1);
+	gpio_direction_output(sel_c, 1);
+
+	ui_card_detected = 1;
+	pr_info("DA850/OMAP-L138 EVM UI card detected\n");
+
+	da850_evm_setup_nor_nand();
+
+	return 0;
+
+exp_setup_selc_fail:
+	gpio_free(sel_b);
+exp_setup_selb_fail:
+	gpio_free(sel_a);
+exp_setup_sela_fail:
+	return ret;
+}
+
+static int da850_evm_ui_expander_teardown(struct i2c_client *client,
+					unsigned gpio, unsigned ngpio, void *c)
+{
+	/* deselect all functionalities */
+	gpio_set_value(gpio + 5, 1);
+	gpio_set_value(gpio + 6, 1);
+	gpio_set_value(gpio + 7, 1);
+
+	gpio_free(gpio + 5);
+	gpio_free(gpio + 6);
+	gpio_free(gpio + 7);
+
+	return 0;
+}
+
+static struct pca953x_platform_data da850_evm_ui_expander_info = {
+	.gpio_base	= DAVINCI_N_GPIO,
+	.setup		= da850_evm_ui_expander_setup,
+	.teardown	= da850_evm_ui_expander_teardown,
+};
+
 static struct i2c_board_info __initdata da850_evm_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-	}
+	},
+	{
+		I2C_BOARD_INFO("tca6416", 0x20),
+		.platform_data = &da850_evm_ui_expander_info,
+	},
 };
 
 static struct davinci_i2c_platform_data da850_evm_i2c_0_pdata = {
@@ -399,13 +475,6 @@ static int __init pmic_tps65070_init(void)
 					ARRAY_SIZE(da850evm_tps65070_info));
 }
 
-#if defined(CONFIG_MTD_PHYSMAP) || \
-    defined(CONFIG_MTD_PHYSMAP_MODULE)
-#define HAS_NOR 1
-#else
-#define HAS_NOR 0
-#endif
-
 #if defined(CONFIG_MMC_DAVINCI) || \
     defined(CONFIG_MMC_DAVINCI_MODULE)
 #define HAS_MMC 1
@@ -413,6 +482,28 @@ static int __init pmic_tps65070_init(void)
 #define HAS_MMC 0
 #endif
 
+static void da850_evm_setup_nor_nand(void)
+{
+	int ret = 0;
+
+	if (ui_card_detected & !HAS_MMC) {
+		ret = da8xx_pinmux_setup(da850_nand_pins);
+		if (ret)
+			pr_warning("da850_evm_init: nand mux setup failed: "
+					"%d\n",	ret);
+
+		ret = da8xx_pinmux_setup(da850_nor_pins);
+		if (ret)
+			pr_warning("da850_evm_init: nor mux setup failed: %d\n",
+				ret);
+
+		da850_evm_init_nor();
+
+		platform_add_devices(da850_evm_devices,
+					ARRAY_SIZE(da850_evm_devices));
+	}
+}
+
 static const short da850_evm_lcdc_pins[] = {
 	DA850_GPIO2_8, DA850_GPIO2_15,
 	-1
@@ -428,21 +519,6 @@ static __init void da850_evm_init(void)
 		pr_warning("da850_evm_init: TPS65070 PMIC init failed: %d\n",
 				ret);
 
-	ret = da8xx_pinmux_setup(da850_nand_pins);
-	if (ret)
-		pr_warning("da850_evm_init: nand mux setup failed: %d\n",
-				ret);
-
-	ret = da8xx_pinmux_setup(da850_nor_pins);
-	if (ret)
-		pr_warning("da850_evm_init: nor mux setup failed: %d\n",
-				ret);
-
-	da850_evm_init_nor();
-
-	platform_add_devices(da850_evm_devices,
-				ARRAY_SIZE(da850_evm_devices));
-
 	ret = da8xx_register_edma();
 	if (ret)
 		pr_warning("da850_evm_init: edma registration failed: %d\n",
@@ -478,11 +554,6 @@ static __init void da850_evm_init(void)
 				ret);
 
 	if (HAS_MMC) {
-		if (HAS_NOR)
-			pr_warning("WARNING: both NOR Flash and MMC/SD are "
-				"enabled, but they share AEMIF pins.\n"
-				"\tDisable one of them.\n");
-
 		ret = da8xx_pinmux_setup(da850_mmcsd0_pins);
 		if (ret)
 			pr_warning("da850_evm_init: mmcsd0 mux setup failed:"
-- 
1.6.4.3
