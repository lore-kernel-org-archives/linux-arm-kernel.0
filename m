From: stigge@antcom.de (Roland Stigge)
Date: Thu, 20 Sep 2012 10:48:03 +0200
Subject: [PATCH] gpio-lpc32xx: Fix value handling of gpio_direction_output()
Message-ID: <1348130883-11329-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For GPIOs of gpio-lpc32xx, gpio_direction_output() ignores the value argument
(initial value of output). This patch fixes this by setting the level
accordingly.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
Applies to v3.6-rc6

 drivers/gpio/gpio-lpc32xx.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.orig/drivers/gpio/gpio-lpc32xx.c
+++ linux-2.6/drivers/gpio/gpio-lpc32xx.c
@@ -308,6 +308,7 @@ static int lpc32xx_gpio_dir_output_p012(
 {
 	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
 
+	__set_gpio_level_p012(group, pin, value);
 	__set_gpio_dir_p012(group, pin, 0);
 
 	return 0;
@@ -318,6 +319,7 @@ static int lpc32xx_gpio_dir_output_p3(st
 {
 	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
 
+	__set_gpio_level_p3(group, pin, value);
 	__set_gpio_dir_p3(group, pin, 0);
 
 	return 0;
@@ -326,6 +328,9 @@ static int lpc32xx_gpio_dir_output_p3(st
 static int lpc32xx_gpio_dir_out_always(struct gpio_chip *chip, unsigned pin,
 	int value)
 {
+	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
+
+	__set_gpo_level_p3(group, pin, value);
 	return 0;
 }
 
