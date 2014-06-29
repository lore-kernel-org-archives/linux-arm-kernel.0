From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 29 Jun 2014 17:55:54 +0100
Subject: [PATCH] regulator: convert to use gpio_desc internally
Message-ID: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the regulator GPIO handling to use a gpio descriptor rather than
numbers.  This allows us to revise the interfaces to permit all GPIOs
to be used with the regulator core.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
This is an initial step towards allowing the first GPIO (specified in
DT on Cubox-i/HB as <&gpio1 0 0> to work with the regulator code.

 drivers/regulator/core.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4c1f999041dd..03ce33387a5d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -24,6 +24,7 @@
 #include <linux/suspend.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
@@ -77,7 +78,7 @@ struct regulator_map {
  */
 struct regulator_enable_gpio {
 	struct list_head list;
-	int gpio;
+	struct gpio_desc *gpiod;
 	u32 enable_count;	/* a number of enabled shared GPIO */
 	u32 request_count;	/* a number of requested shared GPIO */
 	unsigned int ena_gpio_invert:1;
@@ -1660,10 +1661,13 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 				const struct regulator_config *config)
 {
 	struct regulator_enable_gpio *pin;
+	struct gpio_desc *gpiod;
 	int ret;
 
+	gpiod = gpio_to_desc(config->ena_gpio);
+
 	list_for_each_entry(pin, &regulator_ena_gpio_list, list) {
-		if (pin->gpio == config->ena_gpio) {
+		if (pin->gpiod == gpiod) {
 			rdev_dbg(rdev, "GPIO %d is already used\n",
 				config->ena_gpio);
 			goto update_ena_gpio_to_rdev;
@@ -1682,7 +1686,7 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 		return -ENOMEM;
 	}
 
-	pin->gpio = config->ena_gpio;
+	pin->gpiod = gpiod;
 	pin->ena_gpio_invert = config->ena_gpio_invert;
 	list_add(&pin->list, &regulator_ena_gpio_list);
 
@@ -1701,10 +1705,10 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 
 	/* Free the GPIO only in case of no use */
 	list_for_each_entry_safe(pin, n, &regulator_ena_gpio_list, list) {
-		if (pin->gpio == rdev->ena_pin->gpio) {
+		if (pin->gpiod == rdev->ena_pin->gpiod) {
 			if (pin->request_count <= 1) {
 				pin->request_count = 0;
-				gpio_free(pin->gpio);
+				gpiod_put(pin->gpiod);
 				list_del(&pin->list);
 				kfree(pin);
 			} else {
@@ -1732,8 +1736,8 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 	if (enable) {
 		/* Enable GPIO at initial use */
 		if (pin->enable_count == 0)
-			gpio_set_value_cansleep(pin->gpio,
-						!pin->ena_gpio_invert);
+			gpiod_set_value_cansleep(pin->gpiod,
+						 !pin->ena_gpio_invert);
 
 		pin->enable_count++;
 	} else {
@@ -1744,8 +1748,8 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 
 		/* Disable GPIO if not used */
 		if (pin->enable_count <= 1) {
-			gpio_set_value_cansleep(pin->gpio,
-						pin->ena_gpio_invert);
+			gpiod_set_value_cansleep(pin->gpiod,
+						 pin->ena_gpio_invert);
 			pin->enable_count = 0;
 		}
 	}
-- 
1.8.3.1
