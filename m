From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 27 Sep 2009 21:08:21 +0200
Subject: [PATCH] Fix U300 generic GPIO, remove ifdefs from MMCI
Message-ID: <1254078501-11745-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #ifdefs in the MMCI driver were erroneous and just masking
a bug in the U300 generic GPIO implementation. This removes the
ifdefs and fixes the U300 generic GPIO instead.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/gpio.c              |    8 ++++++++
 arch/arm/mach-u300/include/mach/gpio.h |    1 +
 drivers/mmc/host/mmci.c                |    2 --
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-u300/gpio.c b/arch/arm/mach-u300/gpio.c
index 63c8f27..ce268ef 100644
--- a/arch/arm/mach-u300/gpio.c
+++ b/arch/arm/mach-u300/gpio.c
@@ -281,6 +281,14 @@ int gpio_unregister_callback(unsigned gpio)
 }
 EXPORT_SYMBOL(gpio_unregister_callback);
 
+int gpio_is_valid(int number)
+{
+	if (number < (U300_GPIO_NUM_PORTS * U300_GPIO_PINS_PER_PORT))
+		return 0;
+	return -EINVAL;
+}
+EXPORT_SYMBOL(gpio_is_valid);
+
 int gpio_request(unsigned gpio, const char *label)
 {
 	if (gpio_pin[gpio].users)
diff --git a/arch/arm/mach-u300/include/mach/gpio.h b/arch/arm/mach-u300/include/mach/gpio.h
index c817412..7b1fc98 100644
--- a/arch/arm/mach-u300/include/mach/gpio.h
+++ b/arch/arm/mach-u300/include/mach/gpio.h
@@ -258,6 +258,7 @@
 #define PIN_TO_PORT(val) (val >> 3)
 
 /* These can be found in arch/arm/mach-u300/gpio.c */
+extern int gpio_is_valid(int number);
 extern int gpio_request(unsigned gpio, const char *label);
 extern void gpio_free(unsigned gpio);
 extern int gpio_direction_input(unsigned gpio);
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3d1e532..705a589 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -678,7 +678,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	writel(0, host->base + MMCIMASK1);
 	writel(0xfff, host->base + MMCICLEAR);
 
-#ifdef CONFIG_GPIOLIB
 	if (gpio_is_valid(plat->gpio_cd)) {
 		ret = gpio_request(plat->gpio_cd, DRIVER_NAME " (cd)");
 		if (ret == 0)
@@ -697,7 +696,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		else if (ret != -ENOSYS)
 			goto err_gpio_wp;
 	}
-#endif
 
 	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
 	if (ret)
-- 
1.6.2.5
