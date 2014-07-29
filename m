From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Jul 2014 09:24:46 +0200
Subject: [PATCH 4/4] gpio: pca953x: Add DT binding for reset gpio
In-Reply-To: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1406618686-22385-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pca953x has a negated reset input. This patch adds a DT binding for
the reset gpio and resets the chip when it is probed. This will reset
the device and leave the gpio in the correct state so reset is not
triggered.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/gpio/gpio-pca953x.txt          |  5 +++++
 drivers/gpio/gpio-pca953x.c                            | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
index eb65157d47f6..57e31414f74d 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
@@ -27,6 +27,10 @@ Required properties:
 	ti,tca6424
 	exar,xra1202
 
+Optional properties:
+ - reset-gpios: phandle with arguments identifying the reset gpio. See
+   Documentation/devicetree/bindings/gpio/gpio.txt for more information
+
 Example:
 
 
@@ -37,4 +41,5 @@ Example:
 		pinctrl-0 = <&pinctrl_pca9505>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
 	};
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index df5eb6e6be1e..053d8b4702e6 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -11,6 +11,7 @@
  *  the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
@@ -660,8 +661,25 @@ static int pca953x_probe(struct i2c_client *client,
 		invert = pdata->invert;
 		chip->names = pdata->names;
 	} else {
+		struct gpio_desc *reset;
+
 		chip->gpio_start = -1;
 		irq_base = 0;
+
+		reset = devm_gpiod_get(&client->dev, "reset");
+		if (IS_ERR(reset)) {
+			if (PTR_ERR(reset) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			else
+				dev_info(&client->dev, "Did not find/get a gpio for reset (%ld)\n",
+						PTR_ERR(reset));
+		} else {
+			/* Reset the chip if the reset is wired */
+			gpiod_direction_output(reset, 0);
+			udelay(100);
+			gpiod_set_value(reset, 1);
+			udelay(100);
+		}
 	}
 
 	chip->client = client;
-- 
2.0.1
