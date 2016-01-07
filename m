From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jan 2016 14:55:34 +0100
Subject: [PATCH] gpio: moxart: fix build regression
Message-ID: <4110228.QqTjkKaKSX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A cleanup patch replaced bgpio_chip with gpio_chip but missed
two references to the bgpio_chip:

drivers/gpio/gpio-moxart.c:60:19: error: use of undeclared identifier 'bgc'; did you mean 'gc'?
        gc->bgpio_data = bgc->read_reg(bgc->reg_set);
drivers/gpio/gpio-moxart.c:35:20: note: 'gc' declared here
drivers/gpio/gpio-moxart.c:60:33: error: use of undeclared identifier 'bgc'; did you mean 'gc'?
        gc->bgpio_data = bgc->read_reg(bgc->reg_set);

This adds the missing change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0f4630f3720e ("gpio: generic: factor into gpio_chip struct")
---

diff --git a/drivers/gpio/gpio-moxart.c b/drivers/gpio/gpio-moxart.c
index 71c13c4e12b5..ca604538ebf7 100644
--- a/drivers/gpio/gpio-moxart.c
+++ b/drivers/gpio/gpio-moxart.c
@@ -57,7 +57,7 @@ static int moxart_gpio_probe(struct platform_device *pdev)
 	gc->label = "moxart-gpio";
 	gc->request = gpiochip_generic_request;
 	gc->free = gpiochip_generic_free;
-	gc->bgpio_data = bgc->read_reg(bgc->reg_set);
+	gc->bgpio_data = gc->read_reg(gc->reg_set);
 	gc->base = 0;
 	gc->ngpio = 32;
 	gc->parent = dev;
