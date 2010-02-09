From: sguinot@lacie.com (Simon Guinot)
Date: Tue,  9 Feb 2010 21:20:56 +0100
Subject: [PATCH 2/2] [ARM] Kirkwood: define SATA LED for netspace_v2
In-Reply-To: <1265746856-21930-1-git-send-email-sguinot@lacie.com>
References: <1265746856-21930-1-git-send-email-sguinot@lacie.com>
Message-ID: <1265746856-21930-2-git-send-email-sguinot@lacie.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add a GPIO LED named "ns_v2:blue:sata" which can be used to
enable or disable SATA activity LED blinking.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-kirkwood/netspace_v2-setup.c |   45 ++++++++++++---------------
 1 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index df1a99d..270fe57 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -182,8 +182,14 @@ static struct platform_device netspace_v2_gpio_buttons = {
 
 static struct gpio_led netspace_v2_gpio_led_pins[] = {
 	{
-		.name	= "ns_v2:red:fail",
-		.gpio	= NETSPACE_V2_GPIO_RED_LED,
+		.name			= "ns_v2:blue:sata",
+		.default_trigger	= "default-on",
+		.gpio			= NETSPACE_V2_GPIO_BLUE_LED_CMD,
+		.active_low		= 1,
+	},
+	{
+		.name			= "ns_v2:red:fail",
+		.gpio			= NETSPACE_V2_GPIO_RED_LED,
 	},
 };
 
@@ -202,30 +208,19 @@ static struct platform_device netspace_v2_gpio_leds = {
 
 static void __init netspace_v2_gpio_leds_init(void)
 {
-	platform_device_register(&netspace_v2_gpio_leds);
+	int err;
 
-	/*
-	 * Configure the front blue LED to blink in relation with the SATA
-	 * activity.
-	 */
-	if (gpio_request(NETSPACE_V2_GPIO_BLUE_LED_SLOW,
-			 "SATA blue LED slow") != 0)
-		return;
-	if (gpio_direction_output(NETSPACE_V2_GPIO_BLUE_LED_SLOW, 0) != 0)
-		goto err_free_1;
-	if (gpio_request(NETSPACE_V2_GPIO_BLUE_LED_CMD,
-			 "SATA blue LED command") != 0)
-		goto err_free_1;
-	if (gpio_direction_output(NETSPACE_V2_GPIO_BLUE_LED_CMD, 0) != 0)
-		goto err_free_2;
-
-	return;
-
-err_free_2:
-	gpio_free(NETSPACE_V2_GPIO_BLUE_LED_CMD);
-err_free_1:
-	gpio_free(NETSPACE_V2_GPIO_BLUE_LED_SLOW);
-	pr_err("netspace_v2: failed to configure SATA blue LED\n");
+	/* Configure register slow_led to allow SATA activity LED blinking */
+	err = gpio_request(NETSPACE_V2_GPIO_BLUE_LED_SLOW, "blue LED slow");
+	if (err == 0) {
+		err = gpio_direction_output(NETSPACE_V2_GPIO_BLUE_LED_SLOW, 0);
+		if (err)
+			gpio_free(NETSPACE_V2_GPIO_BLUE_LED_SLOW);
+	}
+	if (err)
+		pr_err("netspace_v2: failed to configure blue LED slow GPIO\n");
+
+	platform_device_register(&netspace_v2_gpio_leds);
 }
 
 /*****************************************************************************
-- 
1.6.3.1
