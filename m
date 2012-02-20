From: stigge@antcom.de (Roland Stigge)
Date: Mon, 20 Feb 2012 22:39:08 +0100
Subject: [PATCH 2/2] GPIO: LPC32xx: Add output reading to GPO P3
In-Reply-To: <1329773948-4655-1-git-send-email-stigge@antcom.de>
References: <1329773948-4655-1-git-send-email-stigge@antcom.de>
Message-ID: <1329773948-4655-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chip offers the function to detect the current state of output of the GPO
P3 pins. Useful for reading GPIO output state in Linux' GPIO API, e.g. via
sysfs

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 drivers/gpio/gpio-lpc32xx.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- linux-2.6.orig/drivers/gpio/gpio-lpc32xx.c
+++ linux-2.6/drivers/gpio/gpio-lpc32xx.c
@@ -62,9 +62,11 @@
 #define GPIO3_PIN_IN_SEL(x, y)		(((x) >> GPIO3_PIN_IN_SHIFT(y)) & 1)
 #define GPIO3_PIN5_IN_SEL(x)		(((x) >> 24) & 1)
 #define GPI3_PIN_IN_SEL(x, y)		(((x) >> (y)) & 1)
+#define GPO3_PIN_IN_SEL(x, y)		(((x) >> (y)) & 1)
 
 struct gpio_regs {
 	void __iomem *inp_state;
+	void __iomem *outp_state;
 	void __iomem *outp_set;
 	void __iomem *outp_clr;
 	void __iomem *dir_set;
@@ -145,6 +147,7 @@ static struct gpio_regs gpio_grp_regs_p2
 
 static struct gpio_regs gpio_grp_regs_p3 = {
 	.inp_state	= LPC32XX_GPIO_P3_INP_STATE,
+	.outp_state	= LPC32XX_GPIO_P3_OUTP_STATE,
 	.outp_set	= LPC32XX_GPIO_P3_OUTP_SET,
 	.outp_clr	= LPC32XX_GPIO_P3_OUTP_CLR,
 	.dir_set	= LPC32XX_GPIO_P2_DIR_SET,
@@ -240,6 +243,12 @@ static int __get_gpi_state_p3(struct lpc
 	return GPI3_PIN_IN_SEL(__raw_readl(group->gpio_grp->inp_state), pin);
 }
 
+static int __get_gpo_state_p3(struct lpc32xx_gpio_chip *group,
+	unsigned pin)
+{
+	return GPO3_PIN_IN_SEL(__raw_readl(group->gpio_grp->outp_state), pin);
+}
+
 /*
  * GENERIC_GPIO primitives.
  */
@@ -340,6 +349,13 @@ static void lpc32xx_gpo_set_value(struct
 	__set_gpo_level_p3(group, pin, value);
 }
 
+static int lpc32xx_gpo_get_value(struct gpio_chip *chip, unsigned pin)
+{
+	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
+
+	return __get_gpo_state_p3(group, pin);
+}
+
 static int lpc32xx_gpio_request(struct gpio_chip *chip, unsigned pin)
 {
 	if (pin < chip->ngpio)
@@ -427,6 +443,7 @@ static struct lpc32xx_gpio_chip lpc32xx_
 			.label			= "gpo_p3",
 			.direction_output	= lpc32xx_gpio_dir_out_always,
 			.set			= lpc32xx_gpo_set_value,
+			.get			= lpc32xx_gpo_get_value,
 			.request		= lpc32xx_gpio_request,
 			.base			= LPC32XX_GPO_P3_GRP,
 			.ngpio			= LPC32XX_GPO_P3_MAX,
