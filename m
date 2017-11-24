From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Nov 2017 10:30:41 +0100
Subject: [PATCH 1/5] Input: gpio-keys: Support getting descriptors from board
In-Reply-To: <20171124093045.5961-1-linus.walleij@linaro.org>
References: <20171124093045.5961-1-linus.walleij@linaro.org>
Message-ID: <20171124093045.5961-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are any number of board files in the kernel providing
keys/pushbuttons/switches using simple GPIO. In order to
transfer these smoothly to use GPIO descriptors with
descriptor tables in the board files and no static GPIO
numbers, we need to accept that the board files provide
named GPIOs associated with the GPIO chip device.

Luckily gpio_keys of both polled and interrupt-enabled
type will optionally pass a "desc" field which we can use
as the name of the GPIO to look up and request a GPIO
line for a certain key defined in a per-board descriptor
lookup table.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/keyboard/gpio_keys.c        | 14 +++++++++++++-
 drivers/input/keyboard/gpio_keys_polled.c | 10 ++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613dc33b8..420262a4fd54 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -520,7 +520,9 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	} else if (gpio_is_valid(button->gpio)) {
 		/*
 		 * Legacy GPIO number, so request the GPIO here and
-		 * convert it to descriptor.
+		 * convert it to descriptor. This code goes away once
+		 * we convert all old board files to provide descriptor
+		 * tables.
 		 */
 		unsigned flags = GPIOF_IN;
 
@@ -537,6 +539,16 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		bdata->gpiod = gpio_to_desc(button->gpio);
 		if (!bdata->gpiod)
 			return -EINVAL;
+	} else {
+		/*
+		 * Try to look up from the descriptor table, includes
+		 * letting gpiolib handle inversion semantics. This is
+		 * optional since we have interrupt-only keys as well.
+		 */
+		bdata->gpiod = devm_gpiod_get_optional(dev, desc,
+						       GPIOD_IN);
+		if (IS_ERR(bdata->gpiod))
+			return PTR_ERR(bdata->gpiod);
 	}
 
 	if (bdata->gpiod) {
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index edc7262103b9..1bc428a7edea 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -342,6 +342,16 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 					button->gpio);
 				return -EINVAL;
 			}
+		} else {
+			/*
+			 * Try to look up from the descriptor table, includes
+			 * letting gpiolib handle inversion semantics.
+			 */
+			bdata->gpiod = devm_gpiod_get_optional(dev,
+							       button->desc,
+							       GPIOD_IN);
+			if (IS_ERR(bdata->gpiod))
+				return PTR_ERR(bdata->gpiod);
 		}
 
 		bdata->last_state = -1;
-- 
2.14.3
