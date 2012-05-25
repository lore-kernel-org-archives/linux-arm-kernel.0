From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 25 May 2012 21:36:16 +0800
Subject: [PATCH v4 2/6] gpio: re-add of_node_to_gpiochip function
In-Reply-To: <1337952980-14621-1-git-send-email-b29396@freescale.com>
References: <1337952980-14621-1-git-send-email-b29396@freescale.com>
Message-ID: <1337952980-14621-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/gpio/gpiolib-of.c |   11 +++++++++++
 include/linux/of_gpio.h   |    5 +++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 8389d4a..b8010a9 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -234,3 +234,14 @@ void of_gpiochip_remove(struct gpio_chip *chip)
 	if (chip->of_node)
 		of_node_put(chip->of_node);
 }
+
+/* Private function for resolving node pointer to gpio_chip */
+static int of_gpiochip_is_match(struct gpio_chip *chip, void *data)
+{
+	return chip->of_node == data;
+}
+
+struct gpio_chip *of_node_to_gpiochip(struct device_node *np)
+{
+	return gpiochip_find(np, of_gpiochip_is_match);
+}
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index c454f57..880783b 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -61,6 +61,7 @@ extern void of_gpiochip_remove(struct gpio_chip *gc);
 extern int of_gpio_simple_xlate(struct gpio_chip *gc,
 				const struct of_phandle_args *gpiospec,
 				u32 *flags);
+extern struct gpio_chip *of_node_to_gpiochip(struct device_node *np);
 
 #else /* CONFIG_OF_GPIO */
 
@@ -84,6 +85,10 @@ static inline int of_gpio_simple_xlate(struct gpio_chip *gc,
 	return -ENOSYS;
 }
 
+static struct gpio_chip *of_node_to_gpiochip(struct device_node *np)
+{
+	return NULL;
+}
 static inline void of_gpiochip_add(struct gpio_chip *gc) { }
 static inline void of_gpiochip_remove(struct gpio_chip *gc) { }
 
-- 
1.7.0.4
