From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 25 Oct 2014 00:17:47 +0400
Subject: [PATCH] ARM: sa1100 collie: use gpio-charger instead of pda-power
Message-ID: <1414181867-14240-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio-charger driver instead of pda-power: it automatically cares
about used gpio and since collie does not differentiate between usb and
ac chargers, pda-power is an overkill for it.

As a bonus this allows us to remove gpio_to_irq calls from machine init
call - it is fragile. These gpio_to_irq calls will fail if gpios are
registered later, via device driver mechanisms.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/collie.c | 55 ++++++-------------------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 108939f..b90c7d8 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -30,7 +30,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
-#include <linux/pda_power.h>
+#include <linux/power/gpio-charger.h>
 
 #include <video/sa1100fb.h>
 
@@ -131,62 +131,24 @@ static struct irda_platform_data collie_ir_data = {
 /*
  * Collie AC IN
  */
-static int collie_power_init(struct device *dev)
-{
-	int ret = gpio_request(COLLIE_GPIO_AC_IN, "ac in");
-	if (ret)
-		goto err_gpio_req;
-
-	ret = gpio_direction_input(COLLIE_GPIO_AC_IN);
-	if (ret)
-		goto err_gpio_in;
-
-	return 0;
-
-err_gpio_in:
-	gpio_free(COLLIE_GPIO_AC_IN);
-err_gpio_req:
-	return ret;
-}
-
-static void collie_power_exit(struct device *dev)
-{
-	gpio_free(COLLIE_GPIO_AC_IN);
-}
-
-static int collie_power_ac_online(void)
-{
-	return gpio_get_value(COLLIE_GPIO_AC_IN) == 2;
-}
-
 static char *collie_ac_supplied_to[] = {
 	"main-battery",
 	"backup-battery",
 };
 
-static struct pda_power_pdata collie_power_data = {
-	.init			= collie_power_init,
-	.is_ac_online		= collie_power_ac_online,
-	.exit			= collie_power_exit,
+
+static struct gpio_charger_platform_data collie_power_data = {
+	.name			= "charger",
+	.type			= POWER_SUPPLY_TYPE_MAINS,
+	.gpio			= COLLIE_GPIO_AC_IN,
 	.supplied_to		= collie_ac_supplied_to,
 	.num_supplicants	= ARRAY_SIZE(collie_ac_supplied_to),
 };
 
-static struct resource collie_power_resource[] = {
-	{
-		.name		= "ac",
-		.flags		= IORESOURCE_IRQ |
-				  IORESOURCE_IRQ_HIGHEDGE |
-				  IORESOURCE_IRQ_LOWEDGE,
-	},
-};
-
 static struct platform_device collie_power_device = {
-	.name			= "pda-power",
+	.name			= "gpio-charger",
 	.id			= -1,
 	.dev.platform_data	= &collie_power_data,
-	.resource		= collie_power_resource,
-	.num_resources		= ARRAY_SIZE(collie_power_resource),
 };
 
 #ifdef CONFIG_SHARP_LOCOMO
@@ -420,9 +382,6 @@ static void __init collie_init(void)
 
 	GPSR |= _COLLIE_GPIO_UCB1x00_RESET;
 
-	collie_power_resource[0].start = gpio_to_irq(COLLIE_GPIO_AC_IN);
-	collie_power_resource[0].end = gpio_to_irq(COLLIE_GPIO_AC_IN);
-
 	sa11x0_ppc_configure_mcp();
 
 
-- 
2.1.1
