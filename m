From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 20 Sep 2017 15:39:20 +0200
Subject: [PATCH 1/8] pinctrl: meson: remove offset from pinctrl
In-Reply-To: <20170920133927.17390-1-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
Message-ID: <20170920133927.17390-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Offset on meson pinctrl and gpios is something that was carried from the
vendor driver, where there is a weird link between the 2
controllers. Since these 2 controllers are independent, this offset adds
an unnecessary complexity.

This patch remove this manually set offset and rely on pinctrl to figure
out the gpio base offset

Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 18 +++---------------
 drivers/pinctrl/meson/pinctrl-meson.h |  8 +++-----
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 66ed70c12733..247208150b19 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -410,18 +410,6 @@ static const struct pinconf_ops meson_pinconf_ops = {
 	.is_generic		= true,
 };
 
-static int meson_gpio_request(struct gpio_chip *chip, unsigned gpio)
-{
-	return pinctrl_request_gpio(chip->base + gpio);
-}
-
-static void meson_gpio_free(struct gpio_chip *chip, unsigned gpio)
-{
-	struct meson_pinctrl *pc = gpiochip_get_data(chip);
-
-	pinctrl_free_gpio(pc->data->pin_base + gpio);
-}
-
 static int meson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
 	struct meson_pinctrl *pc = gpiochip_get_data(chip);
@@ -539,13 +527,13 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
 
 	pc->chip.label = pc->data->name;
 	pc->chip.parent = pc->dev;
-	pc->chip.request = meson_gpio_request;
-	pc->chip.free = meson_gpio_free;
+	pc->chip.request = gpiochip_generic_request;
+	pc->chip.free = gpiochip_generic_free;
 	pc->chip.direction_input = meson_gpio_direction_input;
 	pc->chip.direction_output = meson_gpio_direction_output;
 	pc->chip.get = meson_gpio_get;
 	pc->chip.set = meson_gpio_set;
-	pc->chip.base = pc->data->pin_base;
+	pc->chip.base = -1;
 	pc->chip.ngpio = pc->data->num_pins;
 	pc->chip.can_sleep = false;
 	pc->chip.of_node = pc->of_node;
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 890f296f5840..227b72a60c22 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -124,8 +124,6 @@ struct meson_pinctrl {
 	struct device_node *of_node;
 };
 
-#define PIN(x, b)	(b + x)
-
 #define GROUP(grp, r, b)						\
 	{								\
 		.name = #grp,						\
@@ -135,10 +133,10 @@ struct meson_pinctrl {
 		.bit = b,						\
 	 }
 
-#define GPIO_GROUP(gpio, b)						\
+#define GPIO_GROUP(gpio)						\
 	{								\
 		.name = #gpio,						\
-		.pins = (const unsigned int[]){ PIN(gpio, b) },		\
+		.pins = (const unsigned int[]){ gpio },			\
 		.num_pins = 1,						\
 		.is_gpio = true,					\
 	 }
@@ -166,7 +164,7 @@ struct meson_pinctrl {
 		},							\
 	 }
 
-#define MESON_PIN(x, b) PINCTRL_PIN(PIN(x, b), #x)
+#define MESON_PIN(x) PINCTRL_PIN(x, #x)
 
 extern struct meson_pinctrl_data meson8_cbus_pinctrl_data;
 extern struct meson_pinctrl_data meson8_aobus_pinctrl_data;
-- 
2.13.5
