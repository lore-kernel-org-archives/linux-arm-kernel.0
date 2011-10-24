From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 24 Oct 2011 21:13:20 +0800
Subject: [RFC] ARM: at91: gpio add mux check
Message-ID: <1319462000-32642-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will check if the pio is not configured as mux first

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: swarren at nvidia.com
---
Hi,

	one of the the issue is what happened it the bootloader miss
	configured a pin a periph A or B?

	do we need to keep the tracking of it in the pinmux?

Best Regards,
J.
 arch/arm/mach-at91/gpio.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 743f668..89761d0 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -38,6 +38,7 @@ struct at91_gpio_chip {
 #define to_at91_gpio_chip(c) container_of(c, struct at91_gpio_chip, chip)
 
 static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip);
+static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset);
 static void at91_gpiolib_set(struct gpio_chip *chip, unsigned offset, int val);
 static int at91_gpiolib_get(struct gpio_chip *chip, unsigned offset);
 static int at91_gpiolib_direction_output(struct gpio_chip *chip,
@@ -49,6 +50,7 @@ static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 	{								\
 		.chip = {						\
 			.label		  = name,			\
+			.request	  = at91_gpiolib_request,	\
 			.direction_input  = at91_gpiolib_direction_input, \
 			.direction_output = at91_gpiolib_direction_output, \
 			.get		  = at91_gpiolib_get,		\
@@ -532,6 +534,19 @@ void __init at91_gpio_irq_setup(void)
 }
 
 /* gpiolib support */
+
+static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
+	void __iomem *pio = at91_gpio->regbase;
+	unsigned mask = 1 << offset;
+
+	if (__raw_readl(pio + PIO_PSR) & mask)
+		return 0;
+
+	return -EBUSY;
+}
+
 static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 					unsigned offset)
 {
-- 
1.7.7
