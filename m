From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 5 Feb 2018 09:47:55 +0100
Subject: [RESEND][PATCH] video: fbdev: atmel_lcdfb: convert to use GPIO
 descriptors
Message-ID: <20180205084755.6011-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GPIO descriptors instead of relying on the old method.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 3dee267d7c75..ef3d4198014f 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/backlight.h>
 #include <linux/gfp.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -61,8 +62,7 @@ struct atmel_lcdfb_info {
 };
 
 struct atmel_lcdfb_power_ctrl_gpio {
-	int gpio;
-	int active_low;
+	struct gpio_desc *gpiod;
 
 	struct list_head list;
 };
@@ -1018,7 +1018,7 @@ static void atmel_lcdfb_power_control_gpio(struct atmel_lcdfb_pdata *pdata, int
 	struct atmel_lcdfb_power_ctrl_gpio *og;
 
 	list_for_each_entry(og, &pdata->pwr_gpios, list)
-		gpio_set_value(og->gpio, on);
+		gpiod_set_value(og->gpiod, on);
 }
 
 static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
@@ -1031,11 +1031,11 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	struct device_node *display_np;
 	struct device_node *timings_np;
 	struct display_timings *timings;
-	enum of_gpio_flags flags;
 	struct atmel_lcdfb_power_ctrl_gpio *og;
 	bool is_gpio_power = false;
 	int ret = -ENOENT;
-	int i, gpio;
+	int i;
+	struct gpio_desc *gpiod;
 
 	sinfo->config = (struct atmel_lcdfb_config*)
 		of_match_device(atmel_lcdfb_dt_ids, dev)->data;
@@ -1072,28 +1072,22 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 
 	INIT_LIST_HEAD(&pdata->pwr_gpios);
 	ret = -ENOMEM;
-	for (i = 0; i < of_gpio_named_count(display_np, "atmel,power-control-gpio"); i++) {
-		gpio = of_get_named_gpio_flags(display_np, "atmel,power-control-gpio",
-					       i, &flags);
-		if (gpio < 0)
+	for (i = 0; i < gpiod_count(dev, "atmel,power-control"); i++) {
+		gpiod = devm_gpiod_get_index_optional(dev,
+				"atmel,power-control", i, GPIOD_ASIS);
+		if (!gpiod)
 			continue;
 
 		og = devm_kzalloc(dev, sizeof(*og), GFP_KERNEL);
 		if (!og)
 			goto put_display_node;
 
-		og->gpio = gpio;
-		og->active_low = flags & OF_GPIO_ACTIVE_LOW;
+		og->gpiod = gpiod;
 		is_gpio_power = true;
-		ret = devm_gpio_request(dev, gpio, "lcd-power-control-gpio");
-		if (ret) {
-			dev_err(dev, "request gpio %d failed\n", gpio);
-			goto put_display_node;
-		}
 
-		ret = gpio_direction_output(gpio, og->active_low);
+		ret = gpiod_direction_output(gpiod, gpiod_is_active_low(gpiod));
 		if (ret) {
-			dev_err(dev, "set direction output gpio %d failed\n", gpio);
+			dev_err(dev, "set direction output gpio atmel,power-control[%d] failed\n", i);
 			goto put_display_node;
 		}
 		list_add(&og->list, &pdata->pwr_gpios);
-- 
2.12.2
