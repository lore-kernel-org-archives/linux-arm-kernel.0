From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun,  3 Feb 2013 01:25:47 +0800
Subject: [PATCH v8 06/12] gpio: pl061: bind pinctrl by gpio request
In-Reply-To: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1359825953-15663-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the pl061_gpio_request() to request pinctrl. Create the logic
between pl061 gpio driver and pinctrl (pinctrl-single) driver.

While a gpio pin is requested, it will request pinctrl driver to
set that pin with gpio function mode. So pinctrl driver should
append .gpio_request_enable() in pinmux_ops.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pl061.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index fd26f63..292620c 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -23,6 +23,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
 #include <linux/slab.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm.h>
 #include <asm/mach/irq.h>
 
@@ -61,6 +62,17 @@ struct pl061_gpio {
 #endif
 };
 
+static int pl061_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	/*
+	 * Map back to global GPIO space and request muxing, the direction
+	 * parameter does not matter for this controller.
+	 */
+	int gpio = chip->base + offset;
+
+	return pinctrl_request_gpio(gpio);
+}
+
 static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
 {
 	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
@@ -251,6 +263,7 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 
 	spin_lock_init(&chip->lock);
 
+	chip->gc.request = pl061_gpio_request;
 	chip->gc.direction_input = pl061_direction_input;
 	chip->gc.direction_output = pl061_direction_output;
 	chip->gc.get = pl061_get_value;
-- 
1.7.10.4
