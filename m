From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 15 Jul 2012 15:40:34 +0200
Subject: [PATCH 1/4] ARM: at91: gpio: implement request
In-Reply-To: <20120715131618.GF4450@game.jcrosoft.org>
References: <20120715131618.GF4450@game.jcrosoft.org>
Message-ID: <1342359637-15325-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

confire the pin as pio when requested

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/gpio.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 325837a..994ed02 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -44,6 +44,7 @@ struct at91_gpio_chip {
 
 #define to_at91_gpio_chip(c) container_of(c, struct at91_gpio_chip, chip)
 
+static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset);
 static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip);
 static void at91_gpiolib_set(struct gpio_chip *chip, unsigned offset, int val);
 static int at91_gpiolib_get(struct gpio_chip *chip, unsigned offset);
@@ -57,6 +58,7 @@ static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 	{								\
 		.chip = {						\
 			.label		  = name,			\
+			.request	  = at91_gpiolib_request,	\
 			.direction_input  = at91_gpiolib_direction_input, \
 			.direction_output = at91_gpiolib_direction_output, \
 			.get		  = at91_gpiolib_get,		\
@@ -861,6 +863,18 @@ void __init at91_gpio_irq_setup(void)
 }
 
 /* gpiolib support */
+
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
1.7.10
