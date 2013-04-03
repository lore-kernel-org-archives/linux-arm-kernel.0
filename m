From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:04:45 +0900
Subject: [PATCH 07/28] gpio-rcar: Add pinctrl support
In-Reply-To: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954706-14727-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Register the GPIO pin range, and request and free GPIO pins using the
pinctrl API.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/gpio/gpio-rcar.c                |   23 +++++++++++++++++++++++
 include/linux/platform_data/gpio-rcar.h |    1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 581ba56..b4ca450 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -190,6 +191,21 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	spin_unlock_irqrestore(&p->lock, flags);
 }
 
+static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
+{
+	return pinctrl_request_gpio(chip->base + offset);
+}
+
+static void gpio_rcar_free(struct gpio_chip *chip, unsigned offset)
+{
+	pinctrl_free_gpio(chip->base + offset);
+
+	/* Set the GPIO as an input to ensure that the next GPIO request won't
+	 * drive the GPIO pin as an output.
+	 */
+	gpio_rcar_config_general_input_output_mode(chip, offset, false);
+}
+
 static int gpio_rcar_direction_input(struct gpio_chip *chip, unsigned offset)
 {
 	gpio_rcar_config_general_input_output_mode(chip, offset, false);
@@ -285,6 +301,8 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	}
 
 	gpio_chip = &p->gpio_chip;
+	gpio_chip->request = gpio_rcar_request;
+	gpio_chip->free = gpio_rcar_free;
 	gpio_chip->direction_input = gpio_rcar_direction_input;
 	gpio_chip->get = gpio_rcar_get;
 	gpio_chip->direction_output = gpio_rcar_direction_output;
@@ -337,6 +355,11 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 				 p->config.irq_base, ret);
 	}
 
+	ret = gpiochip_add_pin_range(gpio_chip, p->config.pctl_name, 0,
+				     gpio_chip->base, gpio_chip->ngpio);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "failed to add pin range\n");
+
 	return 0;
 
 err1:
diff --git a/include/linux/platform_data/gpio-rcar.h b/include/linux/platform_data/gpio-rcar.h
index bebfcd8..b253f77 100644
--- a/include/linux/platform_data/gpio-rcar.h
+++ b/include/linux/platform_data/gpio-rcar.h
@@ -20,6 +20,7 @@ struct gpio_rcar_config {
 	unsigned int gpio_base;
 	unsigned int irq_base;
 	unsigned int number_of_pins;
+	const char *pctl_name;
 };
 
 #endif /* __GPIO_RCAR_H__ */
-- 
1.7.10.4
