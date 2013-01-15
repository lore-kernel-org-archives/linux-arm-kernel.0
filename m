From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 15 Jan 2013 16:37:36 +0800
Subject: [PATCH 2/2] gpio: devm_gpio_* support should not depend on GPIOLIB
In-Reply-To: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
References: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1358239056-703-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some architectures (e.g. blackfin) provide gpio API without requiring
GPIOLIB support (ARCH_WANT_OPTIONAL_GPIOLIB).  devm_gpio_* functions
should also work for these architectures, since they do not really
depend on GPIOLIB.

Add a new option GPIO_DEVRES (enabled by default) to control the build
of devres.c, and move devm_gpio_* function declarations out from #ifdef
CONFIG_GPIOLIB in include/asm-generic/gpio.h, so that they can be
available to client drivers without unnecessary dependency on GPIOLIB.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpio/Kconfig       |    3 +++
 drivers/gpio/Makefile      |    3 ++-
 include/asm-generic/gpio.h |   17 ++++++++---------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 682de75..d972932 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -30,6 +30,9 @@ config ARCH_REQUIRE_GPIOLIB
 	  Selecting this from the architecture code will cause the gpiolib
 	  code to always get built in.
 
+config GPIO_DEVRES
+	def_bool y
+	depends on HAS_IOMEM
 
 
 menuconfig GPIOLIB
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c5aebd0..36ca605 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -2,7 +2,8 @@
 
 ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 
-obj-$(CONFIG_GPIOLIB)		+= gpiolib.o devres.o
+obj-$(CONFIG_GPIO_DEVRES)	+= devres.o
+obj-$(CONFIG_GPIOLIB)		+= gpiolib.o
 obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
 obj-$(CONFIG_GPIO_ACPI)		+= gpiolib-acpi.o
 
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 2341014..71fd984 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -7,6 +7,8 @@
 #include <linux/of.h>
 #include <linux/pinctrl/pinctrl.h>
 
+struct device;
+
 #ifdef CONFIG_GPIOLIB
 
 #include <linux/compiler.h>
@@ -42,7 +44,6 @@ static inline bool gpio_is_valid(int number)
 	return number >= 0 && number < ARCH_NR_GPIOS;
 }
 
-struct device;
 struct gpio;
 struct seq_file;
 struct module;
@@ -192,12 +193,6 @@ extern int gpio_request_one(unsigned gpio, unsigned long flags, const char *labe
 extern int gpio_request_array(const struct gpio *array, size_t num);
 extern void gpio_free_array(const struct gpio *array, size_t num);
 
-/* bindings for managed devices that want to request gpios */
-int devm_gpio_request(struct device *dev, unsigned gpio, const char *label);
-int devm_gpio_request_one(struct device *dev, unsigned gpio,
-			  unsigned long flags, const char *label);
-void devm_gpio_free(struct device *dev, unsigned int gpio);
-
 #ifdef CONFIG_GPIO_SYSFS
 
 /*
@@ -280,9 +275,13 @@ static inline void gpio_set_value_cansleep(unsigned gpio, int value)
 
 #endif /* !CONFIG_GPIOLIB */
 
-#ifndef CONFIG_GPIO_SYSFS
+/* bindings for managed devices that want to request gpios */
+int devm_gpio_request(struct device *dev, unsigned gpio, const char *label);
+int devm_gpio_request_one(struct device *dev, unsigned gpio,
+			  unsigned long flags, const char *label);
+void devm_gpio_free(struct device *dev, unsigned int gpio);
 
-struct device;
+#ifndef CONFIG_GPIO_SYSFS
 
 /* sysfs support is only available with gpiolib, where it's optional */
 
-- 
1.7.9.5
