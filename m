From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 24 Oct 2014 21:14:22 +0400
Subject: [PATCH] ARM: pxa: tosa: switch to gpio-charger
Message-ID: <1414170862-17995-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to simpler gpio-charger module. PDA power requires additional
setup in platform file and is more suited for boards with separate AC
and USB charging inputs. Tosa has a unified input, so it's better suited
for gpio-charger.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/tosa.c | 41 +++++++----------------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index c158a6e..7780d1fa 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -30,7 +30,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
-#include <linux/pda_power.h>
+#include <linux/power/gpio-charger.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/input/matrix_keypad.h>
@@ -361,44 +361,17 @@ static struct pxaficp_platform_data tosa_ficp_platform_data = {
 /*
  * Tosa AC IN
  */
-static int tosa_power_init(struct device *dev)
-{
-	int ret = gpio_request(TOSA_GPIO_AC_IN, "ac in");
-	if (ret)
-		goto err_gpio_req;
-
-	ret = gpio_direction_input(TOSA_GPIO_AC_IN);
-	if (ret)
-		goto err_gpio_in;
-
-	return 0;
-
-err_gpio_in:
-	gpio_free(TOSA_GPIO_AC_IN);
-err_gpio_req:
-	return ret;
-}
-
-static void tosa_power_exit(struct device *dev)
-{
-	gpio_free(TOSA_GPIO_AC_IN);
-}
-
-static int tosa_power_ac_online(void)
-{
-	return gpio_get_value(TOSA_GPIO_AC_IN) == 0;
-}
-
 static char *tosa_ac_supplied_to[] = {
 	"main-battery",
 	"backup-battery",
 	"jacket-battery",
 };
 
-static struct pda_power_pdata tosa_power_data = {
-	.init			= tosa_power_init,
-	.is_ac_online		= tosa_power_ac_online,
-	.exit			= tosa_power_exit,
+static struct gpio_charger_platform_data tosa_power_data = {
+	.name			= "charger",
+	.type			= POWER_SUPPLY_TYPE_MAINS,
+	.gpio			= TOSA_GPIO_AC_IN,
+	.gpio_active_low	= 1,
 	.supplied_to		= tosa_ac_supplied_to,
 	.num_supplicants	= ARRAY_SIZE(tosa_ac_supplied_to),
 };
@@ -415,7 +388,7 @@ static struct resource tosa_power_resource[] = {
 };
 
 static struct platform_device tosa_power_device = {
-	.name			= "pda-power",
+	.name			= "gpio-charger",
 	.id			= -1,
 	.dev.platform_data	= &tosa_power_data,
 	.resource		= tosa_power_resource,
-- 
2.1.1
