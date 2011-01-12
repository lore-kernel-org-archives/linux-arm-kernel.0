From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Wed, 12 Jan 2011 11:21:09 +0100
Subject: [PATCH] ux500: platform data for SFH7741 proximity sensor driver
	(standard Keyboard GPIO driver)
Message-ID: <1294827669-29884-1-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Proximity sensor is managed as an input event (SW_PROXIMITY).

Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |   11 ++++
 arch/arm/mach-ux500/board-mop500.c            |   63 +++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 7584a16..6625f4a 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -9,15 +9,26 @@
  * MOP500 board specific initialization for regulators
  */
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/ab8500.h>
 #include "board-mop500-regulators.h"
 
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+extern struct platform_device mop500_gpio_keys_device;
+#endif
+
 static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
 	{
 		.dev = NULL,
 		.supply = "v-display",
 	},
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+	{
+		.dev = &mop500_gpio_keys_device.dev,
+		.supply = "v-proximity",
+	},
+#endif
 #ifdef CONFIG_SENSORS_BH1780
 	{
 		.dev_name = "bh1780",
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 2635bb7..472f9a2 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -21,6 +21,8 @@
 #include <linux/spi/spi.h>
 #include <linux/mfd/ab8500.h>
 #include <linux/mfd/tc3589x.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -171,10 +173,68 @@ static void __init mop500_i2c_init(void)
 	db8500_add_i2c3(&u8500_i2c3_data);
 }
 
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+static struct gpio_keys_button mop500_gpio_keys[] = {
+	{
+		.desc			= "Proximity Sensor",
+		.type			= EV_SW,
+		.code			= SW_FRONT_PROXIMITY,
+		.gpio			= MOP500_EGPIO(7),
+		.active_low		= 0,
+		.can_disable		= 1,
+	}
+};
+
+static struct regulator *prox_regulator;
+static int mop500_prox_activate(struct device *dev);
+static void mop500_prox_deactivate(struct device *dev);
+
+static struct gpio_keys_platform_data mop500_gpio_keys_data = {
+	.buttons	= mop500_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(mop500_gpio_keys),
+	.enable		= mop500_prox_activate,
+	.disable	= mop500_prox_deactivate,
+};
+
+struct platform_device mop500_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &mop500_gpio_keys_data,
+	},
+};
+
+static int mop500_prox_activate(struct device *dev)
+{
+	prox_regulator = regulator_get(&mop500_gpio_keys_device.dev,
+						"v-proximity");
+	if (IS_ERR(prox_regulator)) {
+		dev_err(&mop500_gpio_keys_device.dev,
+			"regulator_get(\"v-proximity\") failed\n");
+		return PTR_ERR(prox_regulator);
+	}
+	regulator_enable(prox_regulator);
+	return 0;
+}
+
+static void mop500_prox_deactivate(struct device *dev)
+{
+	regulator_disable(prox_regulator);
+	regulator_put(prox_regulator);
+}
+#endif
+
 /* add any platform devices here - TODO */
 static struct platform_device *platform_devs[] __initdata = {
 };
 
+static struct platform_device *u8500_platform_devices[] __initdata = {
+	/*TODO - add platform devices here */
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+	&mop500_gpio_keys_device,
+#endif
+};
+
 #ifdef CONFIG_STE_DMA40
 static struct stedma40_chan_cfg ssp0_dma_cfg_rx = {
 	.mode = STEDMA40_MODE_LOGICAL,
@@ -322,6 +382,9 @@ static void __init u8500_init_machine(void)
 
 	i2c_register_board_info(0, mop500_i2c0_devices,
 				ARRAY_SIZE(mop500_i2c0_devices));
+
+	platform_add_devices(u8500_platform_devices,
+			     ARRAY_SIZE(u8500_platform_devices));
 }
 
 MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
-- 
1.7.3.1
