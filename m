From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Aug 2012 15:01:58 +0200
Subject: [PATCH 01/14] ARM: at91: gpio: implement request and free
In-Reply-To: <20120810124820.GA20557@game.jcrosoft.org>
References: <20120810124820.GA20557@game.jcrosoft.org>
Message-ID: <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure a gpio as input when freeing it to reduce power consumption/
Confire the pin as pio when requested.

This is need by DT as we do not mux them any more.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/gpio.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index be42cf0..3770d72 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -46,6 +46,8 @@ struct at91_gpio_chip {
 
 #define to_at91_gpio_chip(c) container_of(c, struct at91_gpio_chip, chip)
 
+static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset);
+static void at91_gpiolib_free(struct gpio_chip *chip, unsigned offset);
 static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip);
 static void at91_gpiolib_set(struct gpio_chip *chip, unsigned offset, int val);
 static int at91_gpiolib_get(struct gpio_chip *chip, unsigned offset);
@@ -59,6 +61,8 @@ static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 	{								\
 		.chip = {						\
 			.label		  = name,			\
+			.request	  = at91_gpiolib_request,	\
+			.free		  = at91_gpiolib_free,		\
 			.direction_input  = at91_gpiolib_direction_input, \
 			.direction_output = at91_gpiolib_direction_output, \
 			.get		  = at91_gpiolib_get,		\
@@ -862,6 +866,21 @@ void __init at91_gpio_irq_setup(void)
 }
 
 /* gpiolib support */
+static void at91_gpiolib_free(struct gpio_chip *chip, unsigned offset)
+{
+	at91_gpiolib_direction_input(chip, offset);
+}
+
+static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
+	void __iomem *pio = at91_gpio->regbase;
+	unsigned mask = 1 << offset;
+
+	__raw_writel(mask, pio + PIO_PER);
+	return 0;
+}
+
 static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 					unsigned offset)
 {
-- 
1.7.10.4
