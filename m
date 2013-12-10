From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 11 Dec 2013 02:50:30 +0400
Subject: [PATCH] arm: sa1100: collie: add gpio-keys configuration
Message-ID: <1386715830-18352-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

collie has several GPIO lines that act like keys - Sync/Wakeup button on
dock station is connected to GPIO line. Another one is connected to
on/off button. Add corresponding gpio-keys configuration.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/collie.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 7fb96eb..831a158 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -27,6 +27,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/timer.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/pda_power.h>
 
@@ -242,10 +244,43 @@ struct platform_device collie_locomo_device = {
 	.resource	= locomo_resources,
 };
 
+static struct gpio_keys_button collie_gpio_keys[] = {
+	{
+		.type	= EV_PWR,
+		.code	= KEY_RESERVED,
+		.gpio	= COLLIE_GPIO_ON_KEY,
+		.desc	= "On key",
+		.wakeup	= 1,
+		.active_low = 1,
+	},
+	{
+		.type	= EV_PWR,
+		.code	= KEY_WAKEUP,
+		.gpio	= COLLIE_GPIO_WAKEUP,
+		.desc	= "Sync",
+		.wakeup = 1,
+		.active_low = 1,
+	},
+};
+
+static struct gpio_keys_platform_data collie_gpio_keys_data = {
+	.buttons	= collie_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(collie_gpio_keys),
+};
+
+static struct platform_device collie_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &collie_gpio_keys_data,
+	},
+};
+
 static struct platform_device *devices[] __initdata = {
 	&collie_locomo_device,
 	&colliescoop_device,
 	&collie_power_device,
+	&collie_gpio_keys_device,
 };
 
 static struct mtd_partition collie_partitions[] = {
-- 
1.8.4.3
