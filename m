From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 23 Jan 2013 16:25:54 +0800
Subject: [PATCH 10/10] gpio: pxa: bind to pinctrl by request
In-Reply-To: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358929554-32265-11-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While gpio pins is requested, request the pin of pinctrl driver first.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pxa.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 528f742..d64ec8c 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
@@ -159,6 +160,17 @@ int pxa_irq_to_gpio(struct irq_data *d)
 	return gpio;
 }
 
+static int pxa_gpio_request(struct gpio_chip *gc, unsigned offset)
+{
+	/*
+	 * Map back to global GPIO space and request muxing, the direction
+	 * parameter does not matter for this controller.
+	 */
+	int gpio = gc->base + offset;
+
+	return pinctrl_request_gpio(gpio);
+}
+
 static int pxa_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
 {
 	struct pxa_gpio_chip *chip = NULL;
@@ -469,6 +481,7 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 		gc->base  = gpio;
 		gc->label = chips[i].label;
 
+		gc->request = pxa_gpio_request;
 		gc->direction_input  = pxa_gpio_direction_input;
 		gc->direction_output = pxa_gpio_direction_output;
 		gc->get = pxa_gpio_get;
-- 
1.7.10.4
