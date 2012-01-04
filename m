From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  4 Jan 2012 10:26:35 +0800
Subject: [PATCH v4 3/3] gpio: pxa: request pinmux function for gpio
In-Reply-To: <1325643995-20745-1-git-send-email-haojian.zhuang@marvell.com>
References: <1325643995-20745-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1325643995-20745-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While gpio is requested for pxa, gpio driver will request function ready
on pin.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/gpio/gpio-pxa.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index b2d3ee1..5e12c19 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/pinmux.h>
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
 
@@ -267,6 +268,16 @@ static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 				(value ? GPSR_OFFSET : GPCR_OFFSET));
 }
 
+static int pxa_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	return pinmux_request_gpio(chip->base + offset);
+}
+
+static void pxa_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	pinmux_free_gpio(chip->base + offset);
+}
+
 static int __devinit pxa_init_gpio_chip(int gpio_end)
 {
 	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
@@ -292,6 +303,8 @@ static int __devinit pxa_init_gpio_chip(int gpio_end)
 		c->get = pxa_gpio_get;
 		c->set = pxa_gpio_set;
 		c->to_irq = pxa_gpio_to_irq;
+		c->request = pxa_gpio_request;
+		c->free = pxa_gpio_free;
 
 		/* number of GPIOs on last bank may be less than 32 */
 		c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
-- 
1.7.0.4
