From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:19 +0800
Subject: [PATCH 11/16] gpio: introduce gpio_request_one() and friends
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-12-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_request() without initial configuration of the GPIO is normally
useless, introduce gpio_request_one() together with GPIOF_ flags for
input/output direction and initial output level.

gpio_{request,free}_array() for multiple GPIOs.

Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 drivers/gpio/gpiolib.c     |   42 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/gpio.h |   20 ++++++++++++++++++++
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a25ad28..e80a1f8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1239,6 +1239,48 @@ void gpio_free(unsigned gpio)
 }
 EXPORT_SYMBOL_GPL(gpio_free);
 
+int gpio_request_one(unsigned gpio, unsigned long flags, const char *label)
+{
+	int err;
+
+	err = gpio_request(gpio, label);
+	if (err)
+		return err;
+
+	if (flags & GPIOF_DIR_IN)
+		err = gpio_direction_input(gpio);
+	else
+		err = gpio_direction_output(gpio,
+				(flags & GPIOF_INIT_HIGH) ? 1 : 0);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(gpio_request_one);
+
+int gpio_request_array(struct gpio *array, size_t num)
+{
+	int i, err;
+
+	for (i = 0; i < num; i++, array++) {
+		err = gpio_request_one(array->gpio, array->flags, array->label);
+		if (err)
+			goto err_free;
+	}
+	return 0;
+
+err_free:
+	while (i--)
+		gpio_free((--array)->gpio);
+	return err;
+}
+EXPORT_SYMBOL_GPL(gpio_request_array);
+
+void gpio_free_array(struct gpio *array, size_t num)
+{
+	while (num--)
+		gpio_free((array++)->gpio);
+}
+EXPORT_SYMBOL_GPL(gpio_free_array);
 
 /**
  * gpiochip_is_requested - return string iff signal was requested
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 485eeb6..5aaa56e 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -136,6 +136,26 @@ extern int __gpio_cansleep(unsigned gpio);
 
 extern int __gpio_to_irq(unsigned gpio);
 
+#define GPIOF_DIR_OUT	(0 << 0)
+#define GPIOF_DIR_IN	(1 << 0)
+
+#define GPIOF_INIT_LOW	(0 << 1)
+#define GPIOF_INIT_HIGH	(1 << 1)
+
+#define GPIOF_IN		(GPIOF_DIR_IN)
+#define GPIOF_OUT_INIT_LOW	(GPIOF_DIR_OUT | GPIOF_INIT_LOW)
+#define GPIOF_OUT_INIT_HIGH	(GPIOF_DIR_OUT | GPIOF_INIT_HIGH)
+
+struct gpio {
+	unsigned	gpio;
+	unsigned long	flags;
+	const char	*label;
+};
+
+extern int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
+extern int gpio_request_array(struct gpio *array, size_t num);
+extern void gpio_free_array(struct gpio *array, size_t num);
+
 #ifdef CONFIG_GPIO_SYSFS
 
 /*
-- 
1.6.3.3
