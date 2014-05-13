From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 13 May 2014 20:20:42 +0200
Subject: [PATCH RESEND 2/5] ARM: at91: gpio: implement get_direction
In-Reply-To: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
References: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1400005245-11943-3-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for gpiod_get_direction().
Otherwise, it returns -EINVAL.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-at91/gpio.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index a5afcf7..afbe340 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -49,6 +49,7 @@ static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset);
 static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip);
 static void at91_gpiolib_set(struct gpio_chip *chip, unsigned offset, int val);
 static int at91_gpiolib_get(struct gpio_chip *chip, unsigned offset);
+static int at91_gpiolib_get_direction(struct gpio_chip *chip, unsigned offset);
 static int at91_gpiolib_direction_output(struct gpio_chip *chip,
 					 unsigned offset, int val);
 static int at91_gpiolib_direction_input(struct gpio_chip *chip,
@@ -60,6 +61,7 @@ static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 		.chip = {						\
 			.label		  = name,			\
 			.request	  = at91_gpiolib_request,	\
+			.get_direction    = at91_gpiolib_get_direction, \
 			.direction_input  = at91_gpiolib_direction_input, \
 			.direction_output = at91_gpiolib_direction_output, \
 			.get		  = at91_gpiolib_get,		\
@@ -799,6 +801,17 @@ static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
+static int at91_gpiolib_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
+	void __iomem *pio = at91_gpio->regbase;
+	unsigned mask = 1 << offset;
+	u32 osr;
+
+	osr = __raw_readl(pio + PIO_OSR);
+	return !(osr & mask);
+}
+
 static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 					unsigned offset)
 {
-- 
1.7.10.4
