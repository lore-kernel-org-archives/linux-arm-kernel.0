From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Sat, 26 Nov 2011 07:08:59 +0800
Subject: [PATCH 2/7] gpio: make pxa gpio depend on pinmux
In-Reply-To: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1322262544-7854-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <hzhuang1@hexinfolabs.org>

While gpio_request() is called, pinmux_request_gpio() would be called
too. Then alternate function of pin can be changed to gpio directly.

Signed-off-by: Haojian Zhuang <hzhuang1@hexinfolabs.org>
---
 drivers/gpio/gpio-pxa.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index b2d3ee1..8808004 100644
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
@@ -612,4 +625,4 @@ static int __init pxa_gpio_sysinit(void)
 	register_syscore_ops(&pxa_gpio_syscore_ops);
 	return 0;
 }
-postcore_initcall(pxa_gpio_sysinit);
+postcore_initcall_sync(pxa_gpio_sysinit);
-- 
1.7.0.4
