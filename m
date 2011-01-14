From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Fri, 14 Jan 2011 10:53:59 +0100
Subject: [PATCH v2] ux500: platform data for SFH7741 proximity sensor driver
	(standard Keyboard GPIO driver)
Message-ID: <1294998839-14089-1-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Proximity sensor is managed as an input event (SW_PROXIMITY).

Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    4 ++
 arch/arm/mach-ux500/board-mop500.c            |   52 +++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 7584a16..42c920a 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -18,6 +18,10 @@ static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
 		.dev = NULL,
 		.supply = "v-display",
 	},
+	{
+		.dev_name = "gpio-keys",
+		.supply = "v-proximity",
+	},
 #ifdef CONFIG_SENSORS_BH1780
 	{
 		.dev_name = "bh1780",
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 2635bb7..c0ee1d7 100644
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
@@ -171,8 +173,58 @@ static void __init mop500_i2c_init(void)
 	db8500_add_i2c3(&u8500_i2c3_data);
 }
 
+static struct gpio_keys_button mop500_gpio_keys[] = {
+	{
+		.desc			= "SFH7741 Proximity Sensor",
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
+static struct platform_device mop500_gpio_keys_device = {
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
+
 /* add any platform devices here - TODO */
 static struct platform_device *platform_devs[] __initdata = {
+	&mop500_gpio_keys_device,
 };
 
 #ifdef CONFIG_STE_DMA40
-- 
1.7.3.1
