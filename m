From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 12:26:36 +0100
Subject: [PATCH 7/8] ARM: sa1100/h3xxx: switch h3xxx IrDA to use gpiod APIs
In-Reply-To: <20160829112540.GF1041@n2100.armlinux.org.uk>
References: <20160829112540.GF1041@n2100.armlinux.org.uk>
Message-ID: <E1beKi4-0001HN-Oo@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the IrDA code to use the gpiod APIs rather than platform data
with function callbacks.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/h3100.c | 44 ++++++++++++--------------------------------
 arch/arm/mach-sa1100/h3600.c | 44 ++++++++++++--------------------------------
 2 files changed, 24 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index c6b412054a3c..9930e8a6cd43 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 
 #include <video/sa1100fb.h>
 
@@ -86,44 +87,23 @@ static void __init h3100_map_io(void)
 	GAFR &= ~0x000001fb;
 }
 
-/*
- * This turns the IRDA power on or off on the Compaq H3100
- */
-static struct gpio h3100_irda_gpio[] = {
-	{ H3100_GPIO_IR_ON,	GPIOF_OUT_INIT_LOW, "IrDA power" },
-	{ H3100_GPIO_IR_FSEL,	GPIOF_OUT_INIT_LOW, "IrDA fsel" },
+static struct irda_platform_data h3100_irda_data = {
 };
 
-static int h3100_irda_set_power(struct device *dev, unsigned int state)
-{
-	gpio_set_value(H3100_GPIO_IR_ON, state);
-	return 0;
-}
-
-static void h3100_irda_set_speed(struct device *dev, unsigned int speed)
-{
-	gpio_set_value(H3100_GPIO_IR_FSEL, !(speed < 4000000));
-}
-
-static int h3100_irda_startup(struct device *dev)
-{
-	return gpio_request_array(h3100_irda_gpio, sizeof(h3100_irda_gpio));
-}
-
-static void h3100_irda_shutdown(struct device *dev)
-{
-	return gpio_free_array(h3100_irda_gpio, sizeof(h3100_irda_gpio));
-}
-
-static struct irda_platform_data h3100_irda_data = {
-	.set_power	= h3100_irda_set_power,
-	.set_speed	= h3100_irda_set_speed,
-	.startup	= h3100_irda_startup,
-	.shutdown	= h3100_irda_shutdown,
+/* IrDA GPIO mappings */
+static struct gpiod_lookup_table h3100_irda_gpio_table = {
+	.dev_id = "sa11x0-ir",
+	.table = {
+		GPIO_LOOKUP("gpio", 8, "ir-power", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", 9, "ir-fsel", GPIO_ACTIVE_HIGH),
+		{ },
+	},
 };
 
 static void __init h3100_mach_init(void)
 {
+	gpiod_add_lookup_table(&h3100_irda_gpio_table);
+
 	h3xxx_mach_init();
 
 	sa11x0_register_lcd(&h3100_lcd_info);
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 118338efd790..1a925ab9aa51 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 
 #include <video/sa1100fb.h>
 
@@ -94,44 +95,23 @@ static void __init h3600_map_io(void)
 	h3xxx_map_io();
 }
 
-/*
- * This turns the IRDA power on or off on the Compaq H3600
- */
-static struct gpio h3600_irda_gpio[] = {
-	{ H3600_EGPIO_IR_ON,	GPIOF_OUT_INIT_LOW, "IrDA power" },
-	{ H3600_EGPIO_IR_FSEL,	GPIOF_OUT_INIT_LOW, "IrDA fsel" },
+static struct irda_platform_data h3600_irda_data = {
 };
 
-static int h3600_irda_set_power(struct device *dev, unsigned int state)
-{
-	gpio_set_value(H3600_EGPIO_IR_ON, state);
-	return 0;
-}
-
-static void h3600_irda_set_speed(struct device *dev, unsigned int speed)
-{
-	gpio_set_value(H3600_EGPIO_IR_FSEL, !(speed < 4000000));
-}
-
-static int h3600_irda_startup(struct device *dev)
-{
-	return gpio_request_array(h3600_irda_gpio, sizeof(h3600_irda_gpio));
-}
-
-static void h3600_irda_shutdown(struct device *dev)
-{
-	return gpio_free_array(h3600_irda_gpio, sizeof(h3600_irda_gpio));
-}
-
-static struct irda_platform_data h3600_irda_data = {
-	.set_power	= h3600_irda_set_power,
-	.set_speed	= h3600_irda_set_speed,
-	.startup	= h3600_irda_startup,
-	.shutdown	= h3600_irda_shutdown,
+/* IrDA GPIO mappings */
+static struct gpiod_lookup_table h3600_irda_gpio_table = {
+	.dev_id = "sa11x0-ir",
+	.table = {
+		GPIO_LOOKUP("htc-egpio", 9, "ir-power", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("htc-egpio", 13, "ir-fsel", GPIO_ACTIVE_HIGH),
+		{ },
+	},
 };
 
 static void __init h3600_mach_init(void)
 {
+	gpiod_add_lookup_table(&h3600_irda_gpio_table);
+
 	h3xxx_mach_init();
 
 	sa11x0_register_lcd(&h3600_lcd_info);
-- 
2.1.0
