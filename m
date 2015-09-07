From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon,  7 Sep 2015 14:23:30 +0200
Subject: [PATCH v4 05/22] gpio: Probe GPIO drivers on demand
In-Reply-To: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1441628627-5143-6-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a gpiochip through its firmware node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpio/gpiolib-of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index fa6e3c8823d6..9a439dab7a87 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -19,6 +19,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/slab.h>
@@ -95,6 +96,8 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 		return ERR_PTR(ret);
 	}
 
+	of_device_probe(gg_data.gpiospec.np);
+
 	gpiochip_find(&gg_data, of_gpiochip_find_and_xlate);
 
 	of_node_put(gg_data.gpiospec.np);
-- 
2.4.3
