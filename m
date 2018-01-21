From: david@lechnology.com (David Lechner)
Date: Sun, 21 Jan 2018 17:09:40 -0600
Subject: [PATCH] gpio: davinci: add support for pinmux gpio ranges
Message-ID: <1516576180-1467-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the pinmux gpio ranges feature to the DaVinci gpio
driver. Only device tree is supported since the non-DT boards don't
use a generic pinmux controller.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/gpio/gpio-davinci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index e4b3d7d..744d6c2 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/irqchip/chained_irq.h>
@@ -225,6 +226,11 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	chips->chip.of_gpio_n_cells = 2;
 	chips->chip.parent = dev;
 	chips->chip.of_node = dev->of_node;
+
+	if (of_property_read_bool(dev->of_node, "gpio-ranges")) {
+		chips->chip.request = gpiochip_generic_request;
+		chips->chip.free = gpiochip_generic_free;
+	}
 #endif
 	spin_lock_init(&chips->lock);
 	bank_base += ngpio;
-- 
2.7.4
