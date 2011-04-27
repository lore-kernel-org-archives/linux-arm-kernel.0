From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 27 Apr 2011 20:50:19 +0200
Subject: [PATCH v2] pxa/hx4700: use gpio arrays for global gpio initialization
In-Reply-To: <20110421150226.GA10052@rainbow>
References: <1303329317.21545.5.camel@flow> <20110421150226.GA10052@rainbow>
Message-ID: <1303930220.14964.8.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_request_array() is a functional replacement for hx4700_gpio_request(),
which is now obsolete.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/mach-pxa/hx4700.c |   70 ++++++++++++--------------------------------
 1 files changed, 19 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 9cdcca5..46b8045 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -135,42 +135,6 @@ static unsigned long hx4700_pin_config[] __initdata = {
 	GPIO66_GPIO,	/* nSDIO_IRQ */
 };
 
-#define HX4700_GPIO_IN(num, _desc) \
-	{ .gpio = (num), .dir = 0, .desc = (_desc) }
-#define HX4700_GPIO_OUT(num, _init, _desc) \
-	{ .gpio = (num), .dir = 1, .init = (_init), .desc = (_desc) }
-struct gpio_ress {
-	unsigned gpio : 8;
-	unsigned dir : 1;
-	unsigned init : 1;
-	char *desc;
-};
-
-static int hx4700_gpio_request(struct gpio_ress *gpios, int size)
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
-			pr_err("Error requesting GPIO %d(%s) : %d\n",
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
 /*
  * IRDA
  */
@@ -829,26 +793,30 @@ static struct platform_device *devices[] __initdata = {
 	&pcmcia,
 };
 
-static struct gpio_ress global_gpios[] = {
-	HX4700_GPIO_IN(GPIO12_HX4700_ASIC3_IRQ, "ASIC3_IRQ"),
-	HX4700_GPIO_IN(GPIO13_HX4700_W3220_IRQ, "W3220_IRQ"),
-	HX4700_GPIO_IN(GPIO14_HX4700_nWLAN_IRQ, "WLAN_IRQ"),
-	HX4700_GPIO_OUT(GPIO59_HX4700_LCD_PC1,          1, "LCD_PC1"),
-	HX4700_GPIO_OUT(GPIO62_HX4700_LCD_nRESET,       1, "LCD_RESET"),
-	HX4700_GPIO_OUT(GPIO70_HX4700_LCD_SLIN1,        1, "LCD_SLIN1"),
-	HX4700_GPIO_OUT(GPIO84_HX4700_LCD_SQN,          1, "LCD_SQN"),
-	HX4700_GPIO_OUT(GPIO110_HX4700_LCD_LVDD_3V3_ON, 1, "LCD_LVDD"),
-	HX4700_GPIO_OUT(GPIO111_HX4700_LCD_AVDD_3V3_ON, 1, "LCD_AVDD"),
-	HX4700_GPIO_OUT(GPIO32_HX4700_RS232_ON,         1, "RS232_ON"),
-	HX4700_GPIO_OUT(GPIO71_HX4700_ASIC3_nRESET,     1, "ASIC3_nRESET"),
-	HX4700_GPIO_OUT(GPIO82_HX4700_EUART_RESET,      1, "EUART_RESET"),
-	HX4700_GPIO_OUT(GPIO105_HX4700_nIR_ON,          1, "nIR_EN"),
+static struct gpio global_gpios[] = {
+	{ GPIO12_HX4700_ASIC3_IRQ, GPIOF_IN, "ASIC3_IRQ" },
+	{ GPIO13_HX4700_W3220_IRQ, GPIOF_IN, "W3220_IRQ" },
+	{ GPIO14_HX4700_nWLAN_IRQ, GPIOF_IN, "WLAN_IRQ" },
+	{ GPIO59_HX4700_LCD_PC1,          GPIOF_OUT_INIT_HIGH, "LCD_PC1" },
+	{ GPIO62_HX4700_LCD_nRESET,       GPIOF_OUT_INIT_HIGH, "LCD_RESET" },
+	{ GPIO70_HX4700_LCD_SLIN1,        GPIOF_OUT_INIT_HIGH, "LCD_SLIN1" },
+	{ GPIO84_HX4700_LCD_SQN,          GPIOF_OUT_INIT_HIGH, "LCD_SQN" },
+	{ GPIO110_HX4700_LCD_LVDD_3V3_ON, GPIOF_OUT_INIT_HIGH, "LCD_LVDD" },
+	{ GPIO111_HX4700_LCD_AVDD_3V3_ON, GPIOF_OUT_INIT_HIGH, "LCD_AVDD" },
+	{ GPIO32_HX4700_RS232_ON,         GPIOF_OUT_INIT_HIGH, "RS232_ON" },
+	{ GPIO71_HX4700_ASIC3_nRESET,     GPIOF_OUT_INIT_HIGH, "ASIC3_nRESET" },
+	{ GPIO82_HX4700_EUART_RESET,      GPIOF_OUT_INIT_HIGH, "EUART_RESET" },
+	{ GPIO105_HX4700_nIR_ON,          GPIOF_OUT_INIT_HIGH, "nIR_EN" },
 };
 
 static void __init hx4700_init(void)
 {
+	int ret;
+
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(hx4700_pin_config));
-	hx4700_gpio_request(ARRAY_AND_SIZE(global_gpios));
+	ret = gpio_request_array(ARRAY_AND_SIZE(global_gpios));
+	if (ret)
+		pr_err ("hx4700: Failed to request GPIOs.\n");
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
-- 
1.7.4.4
