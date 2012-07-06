From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri,  6 Jul 2012 13:26:11 +0200
Subject: [PATCH 2/2] ARM: at91: gpio: implement gpio_free
In-Reply-To: <1341573971-30145-1-git-send-email-plagnioj@jcrosoft.com>
References: <1341573971-30145-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1341573971-30145-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

configure a gpio as input when freeing it to reduce power consumption

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/gpio.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 994ed02..3833f82 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -45,6 +45,7 @@ struct at91_gpio_chip {
 #define to_at91_gpio_chip(c) container_of(c, struct at91_gpio_chip, chip)
 
 static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset);
+static void at91_gpiolib_free(struct gpio_chip *chip, unsigned offset);
 static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip);
 static void at91_gpiolib_set(struct gpio_chip *chip, unsigned offset, int val);
 static int at91_gpiolib_get(struct gpio_chip *chip, unsigned offset);
@@ -59,6 +60,7 @@ static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 		.chip = {						\
 			.label		  = name,			\
 			.request	  = at91_gpiolib_request,	\
+			.free		  = at91_gpiolib_free,		\
 			.direction_input  = at91_gpiolib_direction_input, \
 			.direction_output = at91_gpiolib_direction_output, \
 			.get		  = at91_gpiolib_get,		\
@@ -863,7 +865,10 @@ void __init at91_gpio_irq_setup(void)
 }
 
 /* gpiolib support */
-
+static void at91_gpiolib_free(struct gpio_chip *chip, unsigned offset)
+{
+	at91_gpiolib_direction_input(chip, offset);
+}
 
 static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset)
 {
-- 
1.7.10
