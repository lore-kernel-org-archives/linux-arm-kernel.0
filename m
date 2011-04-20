From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 20 Apr 2011 21:55:28 +0200
Subject: [PATCH] pxa/mioa701: use gpio arrays for global and gsm gpio
	initialization
Message-ID: <1303329331.21545.7.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_request_arrays() / gpio_free_arrays() are functional replacements for
mio_gpio_request() / mio_gpio_free(), which are now obsolete.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/mach-pxa/mioa701.c |   66 +++++++-----------------------------------
 1 files changed, 11 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 23925db..1ce6e5c 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -177,50 +177,6 @@ static unsigned long mioa701_pin_config[] = {
 	MFP_CFG_OUT(GPIO116, AF0, DRIVE_HIGH),
 };
 
-#define MIO_GPIO_IN(num, _desc) \
-	{ .gpio = (num), .dir = 0, .desc = (_desc) }
-#define MIO_GPIO_OUT(num, _init, _desc) \
-	{ .gpio = (num), .dir = 1, .init = (_init), .desc = (_desc) }
-struct gpio_ress {
-	unsigned gpio : 8;
-	unsigned dir : 1;
-	unsigned init : 1;
-	char *desc;
-};
-
-static int mio_gpio_request(struct gpio_ress *gpios, int size)
-{
-	int i, rc = 0;
-	int gpio;
-	int dir;
-
-	for (i = 0; (!rc) && (i < size); i++) {
-		gpio = gpios[i].gpio;
-		dir = gpios[i].dir;
-		rc = gpio_request(gpio, gpios[i].desc);
-		if (rc) {
-			printk(KERN_ERR "Error requesting GPIO %d(%s) : %d\n",
-			       gpio, gpios[i].desc, rc);
-			continue;
-		}
-		if (dir)
-			gpio_direction_output(gpio, gpios[i].init);
-		else
-			gpio_direction_input(gpio);
-	}
-	while ((rc) && (--i >= 0))
-		gpio_free(gpios[i].gpio);
-	return rc;
-}
-
-static void mio_gpio_free(struct gpio_ress *gpios, int size)
-{
-	int i;
-
-	for (i = 0; i < size; i++)
-		gpio_free(gpios[i].gpio);
-}
-
 /* LCD Screen and Backlight */
 static struct platform_pwm_backlight_data mioa701_backlight_data = {
 	.pwm_id		= 0,
@@ -346,16 +302,16 @@ irqreturn_t gsm_on_irq(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-struct gpio_ress gsm_gpios[] = {
-	MIO_GPIO_IN(GPIO25_GSM_MOD_ON_STATE, "GSM state"),
-	MIO_GPIO_IN(GPIO113_GSM_EVENT, "GSM event"),
+static struct gpio gsm_gpios[] = {
+	{ GPIO25_GSM_MOD_ON_STATE, GPIOF_IN, "GSM state" },
+	{ GPIO113_GSM_EVENT, GPIOF_IN, "GSM event" },
 };
 
 static int __init gsm_init(void)
 {
 	int rc;
 
-	rc = mio_gpio_request(ARRAY_AND_SIZE(gsm_gpios));
+	rc = gpio_request_array(ARRAY_AND_SIZE(gsm_gpios));
 	if (rc)
 		goto err_gpio;
 	rc = request_irq(gpio_to_irq(GPIO25_GSM_MOD_ON_STATE), gsm_on_irq,
@@ -369,7 +325,7 @@ static int __init gsm_init(void)
 
 err_irq:
 	printk(KERN_ERR "Mioa701: Can't request GSM_ON irq\n");
-	mio_gpio_free(ARRAY_AND_SIZE(gsm_gpios));
+	gpio_free_array(ARRAY_AND_SIZE(gsm_gpios));
 err_gpio:
 	printk(KERN_ERR "Mioa701: gsm not available\n");
 	return rc;
@@ -378,7 +334,7 @@ err_gpio:
 static void gsm_exit(void)
 {
 	free_irq(gpio_to_irq(GPIO25_GSM_MOD_ON_STATE), NULL);
-	mio_gpio_free(ARRAY_AND_SIZE(gsm_gpios));
+	gpio_free_array(ARRAY_AND_SIZE(gsm_gpios));
 }
 
 /*
@@ -776,10 +732,10 @@ static void mioa701_restart(char c, const char *cmd)
 	arm_machine_restart('s', cmd);
 }
 
-static struct gpio_ress global_gpios[] = {
-	MIO_GPIO_OUT(GPIO9_CHARGE_EN, 1, "Charger enable"),
-	MIO_GPIO_OUT(GPIO18_POWEROFF, 0, "Power Off"),
-	MIO_GPIO_OUT(GPIO87_LCD_POWER, 0, "LCD Power"),
+static struct gpio global_gpios[] = {
+	{ GPIO9_CHARGE_EN, GPIOF_OUT_INIT_HIGH, "Charger enable" },
+	{ GPIO18_POWEROFF, GPIOF_OUT_INIT_LOW, "Power Off" },
+	{ GPIO87_LCD_POWER, GPIOF_OUT_INIT_LOW, "LCD Power" },
 };
 
 static void __init mioa701_machine_init(void)
@@ -793,7 +749,7 @@ static void __init mioa701_machine_init(void)
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
-	mio_gpio_request(ARRAY_AND_SIZE(global_gpios));
+	gpio_request_array(ARRAY_AND_SIZE(global_gpios));
 	bootstrap_init();
 	pxa_set_fb_info(NULL, &mioa701_pxafb_info);
 	pxa_set_mci_info(&mioa701_mci_info);
-- 
1.7.4.4
