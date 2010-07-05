From: simon@sequanux.org (Simon Guinot)
Date: Mon,  5 Jul 2010 12:31:06 +0200
Subject: [PATCH 3/3] [ARM] Kirkwood: update LED support for Network Space v2
In-Reply-To: <1278325866-3890-2-git-send-email-simon@sequanux.org>
References: <1278325866-3890-1-git-send-email-simon@sequanux.org>
	<1278325866-3890-2-git-send-email-simon@sequanux.org>
Message-ID: <1278325866-3890-3-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-kirkwood/netspace_v2-setup.c |   71 ++++++++++++----------------
 1 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index 9f20c8d..63361fb 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -35,6 +35,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
+#include <linux/leds-ns2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -172,36 +173,12 @@ static struct platform_device netspace_v2_gpio_buttons = {
  * GPIO LEDs
  ****************************************************************************/
 
-/*
- * The blue front LED is wired to a CPLD and can blink in relation with the
- * SATA activity.
- *
- * The following array detail the different LED registers and the combination
- * of their possible values:
- *
- *  cmd_led   |  slow_led  | /SATA active | LED state
- *            |            |              |
- *     1      |     0      |      x       |  off
- *     -      |     1      |      x       |  on
- *     0      |     0      |      1       |  on
- *     0      |     0      |      0       |  blink (rate 300ms)
- */
-
 #define NETSPACE_V2_GPIO_RED_LED	12
-#define NETSPACE_V2_GPIO_BLUE_LED_SLOW	29
-#define NETSPACE_V2_GPIO_BLUE_LED_CMD	30
-
 
 static struct gpio_led netspace_v2_gpio_led_pins[] = {
 	{
-		.name			= "ns_v2:blue:sata",
-		.default_trigger	= "default-on",
-		.gpio			= NETSPACE_V2_GPIO_BLUE_LED_CMD,
-		.active_low		= 1,
-	},
-	{
-		.name			= "ns_v2:red:fail",
-		.gpio			= NETSPACE_V2_GPIO_RED_LED,
+		.name	= "ns_v2:red:fail",
+		.gpio	= NETSPACE_V2_GPIO_RED_LED,
 	},
 };
 
@@ -218,22 +195,33 @@ static struct platform_device netspace_v2_gpio_leds = {
 	},
 };
 
-static void __init netspace_v2_gpio_leds_init(void)
-{
-	int err;
+/*****************************************************************************
+ * Dual-GPIO CPLD LEDs
+ ****************************************************************************/
 
-	/* Configure register slow_led to allow SATA activity LED blinking */
-	err = gpio_request(NETSPACE_V2_GPIO_BLUE_LED_SLOW, "blue LED slow");
-	if (err == 0) {
-		err = gpio_direction_output(NETSPACE_V2_GPIO_BLUE_LED_SLOW, 0);
-		if (err)
-			gpio_free(NETSPACE_V2_GPIO_BLUE_LED_SLOW);
-	}
-	if (err)
-		pr_err("netspace_v2: failed to configure blue LED slow GPIO\n");
+#define NETSPACE_V2_GPIO_BLUE_LED_SLOW	29
+#define NETSPACE_V2_GPIO_BLUE_LED_CMD	30
 
-	platform_device_register(&netspace_v2_gpio_leds);
-}
+static struct ns2_led netspace_v2_led_pins[] = {
+	{
+		.name	= "ns_v2:blue:sata",
+		.cmd	= NETSPACE_V2_GPIO_BLUE_LED_CMD,
+		.slow	= NETSPACE_V2_GPIO_BLUE_LED_SLOW,
+	},
+};
+
+static struct ns2_led_platform_data netspace_v2_leds_data = {
+	.num_leds	= ARRAY_SIZE(netspace_v2_led_pins),
+	.leds		= netspace_v2_led_pins,
+};
+
+static struct platform_device netspace_v2_leds = {
+	.name		= "leds-ns2",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &netspace_v2_leds_data,
+	},
+};
 
 /*****************************************************************************
  * Timer
@@ -316,7 +304,8 @@ static void __init netspace_v2_init(void)
 	i2c_register_board_info(0, netspace_v2_i2c_info,
 				ARRAY_SIZE(netspace_v2_i2c_info));
 
-	netspace_v2_gpio_leds_init();
+	platform_device_register(&netspace_v2_leds);
+	platform_device_register(&netspace_v2_gpio_leds);
 	platform_device_register(&netspace_v2_gpio_buttons);
 
 	if (gpio_request(NETSPACE_V2_GPIO_POWER_OFF, "power-off") == 0 &&
-- 
1.6.3.1
