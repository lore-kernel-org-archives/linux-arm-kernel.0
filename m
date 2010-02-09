From: sguinot@lacie.com (Simon Guinot)
Date: Tue,  9 Feb 2010 21:21:50 +0100
Subject: [PATCH 2/2] [ARM] Orion5x: enable SATA LED blinking for d2net
In-Reply-To: <1265746910-21982-1-git-send-email-sguinot@lacie.com>
References: <1265746910-21982-1-git-send-email-sguinot@lacie.com>
Message-ID: <1265746910-21982-2-git-send-email-sguinot@lacie.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-orion5x/d2net-setup.c |   41 ++++++++++++++--------------------
 1 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
index 0420e45..7130904 100644
--- a/arch/arm/mach-orion5x/d2net-setup.c
+++ b/arch/arm/mach-orion5x/d2net-setup.c
@@ -149,10 +149,7 @@ static void __init d2net_sata_power_init(void)
 
 /*
  * The blue front LED is wired to the CPLD and can blink in relation with the
- * SATA activity. This feature is disabled to make this LED compatible with
- * the leds-gpio driver: MPP14 and MPP15 are configured to act like output
- * GPIO's and have to stay in an active state. This is needed to set the blue
- * LED in a "fix on" state regardless of the SATA activity.
+ * SATA activity.
  *
  * The following array detail the different LED registers and the combination
  * of their possible values:
@@ -171,12 +168,11 @@ static void __init d2net_sata_power_init(void)
 #define D2NET_GPIO_RED_LED		6
 #define D2NET_GPIO_BLUE_LED_BLINK_CTRL	16
 #define D2NET_GPIO_BLUE_LED_OFF		23
-#define D2NET_GPIO_SATA0_ACT		14
-#define D2NET_GPIO_SATA1_ACT		15
 
 static struct gpio_led d2net_leds[] = {
 	{
-		.name = "d2net:blue:power",
+		.name = "d2net:blue:sata",
+		.default_trigger = "default-on",
 		.gpio = D2NET_GPIO_BLUE_LED_OFF,
 		.active_low = 1,
 	},
@@ -201,25 +197,22 @@ static struct platform_device d2net_gpio_leds = {
 
 static void __init d2net_gpio_leds_init(void)
 {
+	int err;
+
 	/* Configure GPIO over MPP max number. */
 	orion_gpio_set_valid(D2NET_GPIO_BLUE_LED_OFF, 1);
 
-	if (gpio_request(D2NET_GPIO_SATA0_ACT, "LED SATA0 activity") != 0)
-		return;
-	if (gpio_direction_output(D2NET_GPIO_SATA0_ACT, 1) != 0)
-		goto err_free_1;
-	if (gpio_request(D2NET_GPIO_SATA1_ACT, "LED SATA1 activity") != 0)
-		goto err_free_1;
-	if (gpio_direction_output(D2NET_GPIO_SATA1_ACT, 1) != 0)
-		goto err_free_2;
-	platform_device_register(&d2net_gpio_leds);
-	return;
+	/* Configure register blink_ctrl to allow SATA activity LED blinking. */
+	err = gpio_request(D2NET_GPIO_BLUE_LED_BLINK_CTRL, "blue LED blink");
+	if (err == 0) {
+		err = gpio_direction_output(D2NET_GPIO_BLUE_LED_BLINK_CTRL, 1);
+		if (err)
+			gpio_free(D2NET_GPIO_BLUE_LED_BLINK_CTRL);
+	}
+	if (err)
+		pr_err("d2net: failed to configure blue LED blink GPIO\n");
 
-err_free_2:
-	gpio_free(D2NET_GPIO_SATA1_ACT);
-err_free_1:
-	gpio_free(D2NET_GPIO_SATA0_ACT);
-	return;
+	platform_device_register(&d2net_gpio_leds);
 }
 
 /****************************************************************************
@@ -289,8 +282,8 @@ static struct orion5x_mpp_mode d2net_mpp_modes[] __initdata = {
 	{ 11, MPP_UNUSED },
 	{ 12, MPP_GPIO },	/* SATA 1 power */
 	{ 13, MPP_UNUSED },
-	{ 14, MPP_GPIO },	/* SATA 0 active */
-	{ 15, MPP_GPIO },	/* SATA 1 active */
+	{ 14, MPP_SATA_LED },	/* SATA 0 active */
+	{ 15, MPP_SATA_LED },	/* SATA 1 active */
 	{ 16, MPP_GPIO },	/* Blue front LED blink control */
 	{ 17, MPP_UNUSED },
 	{ 18, MPP_GPIO },	/* Front button (0 = Released, 1 = Pushed ) */
-- 
1.6.3.1
