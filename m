From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 25 Feb 2013 11:49:40 +0800
Subject: [PATCH v5 11/12] gpio: pxa: bind to pinctrl by request
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361764181-26647-12-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While gpio pins is requested, request the pin of pinctrl driver first.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Tested-by: Igor Grinberg <grinberg@compulab.co.il>
---
 drivers/gpio/gpio-pxa.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 91f4881..f2f7737 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
@@ -154,6 +155,23 @@ int pxa_irq_to_gpio(int irq)
 	return irq - irq_base;
 }
 
+static int pxa_gpio_request(struct gpio_chip *gc, unsigned offset)
+{
+	/*
+	 * Map back to global GPIO space and request muxing, the direction
+	 * parameter does not matter for this controller.
+	 */
+	int gpio = gc->base + offset;
+
+	/*
+	 * Platforms in ARCH_PXA doesn't move to device tree yet,
+	 * and PINCTRL_SINGLE is depend on device tree.
+	 */ 
+	if (IS_ENABLED(CONFIG_PINCTRL_SINGLE))
+		return pinctrl_request_gpio(gpio);
+	return 0;
+}
+
 static int pxa_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
 {
 	void __iomem *base = gpio_chip_base(gc);
@@ -258,6 +276,7 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end)
 		gc->base  = gpio;
 		gc->label = chips[i].label;
 
+		gc->request = pxa_gpio_request;
 		gc->direction_input  = pxa_gpio_direction_input;
 		gc->direction_output = pxa_gpio_direction_output;
 		gc->get = pxa_gpio_get;
-- 
1.7.10.4
