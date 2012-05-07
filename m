From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2012 15:51:17 +0000
Subject: ARM: ux500: !CONFIG_OF build error drivers/gpio/gpio-nomadik.c
Message-ID: <201205071551.17327.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

a60b57e "ddrivers/gpio: gpio-nomadik: Add support for irqdomains" broke
building with CONFIG_OF_GPIO disabled. 

Without this patch, building nhk8815_defconfig results in:

/home/arnd/linux-arm/drivers/gpio/gpio-nomadik.c: In function 'nmk_gpio_probe':
/home/arnd/linux-arm/drivers/gpio/gpio-nomadik.c:1238:6: error: 'struct gpio_chip' has no member named 'of_node'
make[3]: *** [drivers/gpio/gpio-nomadik.o] Error 1
make[2]: *** [drivers/gpio] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If I hear no complaints, I'd like to apply this patch on the ux500/gpio branch.

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 9b126b6..1352f33 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -1235,7 +1235,9 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	nmk_chip->lowemi = readl_relaxed(nmk_chip->addr + NMK_GPIO_LOWEMI);
 	clk_disable(nmk_chip->clk);
 
+#ifdef CONFIG_OF_GPIO
 	chip->of_node = np;
+#endif
 
 	ret = gpiochip_add(&nmk_chip->chip);
 	if (ret)
