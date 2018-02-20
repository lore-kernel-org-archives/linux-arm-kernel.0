From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 20 Feb 2018 14:19:33 +0200
Subject: [PATCH v5 3/5] gpio: raspberrypi-exp: Driver for RPi3 GPIO expander
 via mailbox service
In-Reply-To: <cover.1519128054.git.baruch@tkos.co.il>
References: <cover.1519128054.git.baruch@tkos.co.il>
Message-ID: <8c34f287ee72b340fa9d693aa0e304b25541c74c.1519128054.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

Pi3 and Compute Module 3 have a GPIO expander that the
VPU communicates with.
There is a mailbox service that now allows control of this
expander, so add a kernel driver that can make use of it.

Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v5:
  * Use the parent node to find the firmware

v4:
  * Don't set the .owner driver field
  * Add Stefan's review tag

v3:
  * Tweak Kconfig driver prompt
  * Make GPIO_RASPBERRYPI_EXP tristate
  * Make COMPILE_TEST independent of RASPBERRYPI_FIRMWARE
  * Remove redundant DMA header
  * Use less code lines for dev_err()
  * Check rpi_exp_gpio_get_polarity() return value
  * Remove redundant platform_set_drvdata() call

v2:
  * Rename driver to gpio-raspberrypi-exp
  * Populate the gpiochip parent device pointer
  * Use macro for the mailbox base GPIO number
  * Drop linux/gpio.h and GPIOF_DIR_*
  * Check and print firmware error value
  * Use devm_gpiochip_add_data(); drop .remove
  * A few more minor tweaks
---
 drivers/gpio/Kconfig                |   9 ++
 drivers/gpio/Makefile               |   1 +
 drivers/gpio/gpio-raspberrypi-exp.c | 252 ++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/gpio/gpio-raspberrypi-exp.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8dbb2280538d..fd0562a37f68 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -122,6 +122,15 @@ config GPIO_ATH79
 	  Select this option to enable GPIO driver for
 	  Atheros AR71XX/AR724X/AR913X SoC devices.
 
+config GPIO_RASPBERRYPI_EXP
+	tristate "Raspberry Pi 3 GPIO Expander"
+	default RASPBERRYPI_FIRMWARE
+	depends on OF_GPIO
+	depends on (ARCH_BCM2835 && RASPBERRYPI_FIRMWARE) || COMPILE_TEST
+	help
+	  Turn on GPIO support for the expander on Raspberry Pi 3 boards, using
+	  the firmware mailbox to communicate with VideoCore on BCM283x chips.
+
 config GPIO_BCM_KONA
 	bool "Broadcom Kona GPIO"
 	depends on OF_GPIO && (ARCH_BCM_MOBILE || COMPILE_TEST)
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index cccb0d40846c..76dc0a02bd56 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_GPIO_AMDPT)	+= gpio-amdpt.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
 obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
 obj-$(CONFIG_GPIO_ASPEED)	+= gpio-aspeed.o
+obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)	+= gpio-raspberrypi-exp.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BD9571MWV)	+= gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
diff --git a/drivers/gpio/gpio-raspberrypi-exp.c b/drivers/gpio/gpio-raspberrypi-exp.c
new file mode 100644
index 000000000000..d6d36d537e37
--- /dev/null
+++ b/drivers/gpio/gpio-raspberrypi-exp.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Raspberry Pi 3 expander GPIO driver
+ *
+ *  Uses the firmware mailbox service to communicate with the
+ *  GPIO expander on the VPU.
+ *
+ *  Copyright (C) 2017 Raspberry Pi Trading Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+#define MODULE_NAME "raspberrypi-exp-gpio"
+#define NUM_GPIO 8
+
+#define RPI_EXP_GPIO_BASE	128
+
+#define RPI_EXP_GPIO_DIR_IN	0
+#define RPI_EXP_GPIO_DIR_OUT	1
+
+struct rpi_exp_gpio {
+	struct gpio_chip gc;
+	struct rpi_firmware *fw;
+};
+
+/* VC4 firmware mailbox interface data structures */
+
+struct gpio_set_config {
+	u32 gpio;
+	u32 direction;
+	u32 polarity;
+	u32 term_en;
+	u32 term_pull_up;
+	u32 state;
+};
+
+struct gpio_get_config {
+	u32 gpio;
+	u32 direction;
+	u32 polarity;
+	u32 term_en;
+	u32 term_pull_up;
+};
+
+struct gpio_get_set_state {
+	u32 gpio;
+	u32 state;
+};
+
+static int rpi_exp_gpio_get_polarity(struct gpio_chip *gc, unsigned int off)
+{
+	struct rpi_exp_gpio *gpio;
+	struct gpio_get_config get;
+	int ret;
+
+	gpio = gpiochip_get_data(gc);
+
+	get.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
+
+	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_CONFIG,
+				    &get, sizeof(get));
+	if (ret || get.gpio != 0) {
+		dev_err(gc->parent, "Failed to get GPIO %u config (%d %x)\n",
+			off, ret, get.gpio);
+		return ret ? ret : -EIO;
+	}
+	return get.polarity;
+}
+
+static int rpi_exp_gpio_dir_in(struct gpio_chip *gc, unsigned int off)
+{
+	struct rpi_exp_gpio *gpio;
+	struct gpio_set_config set_in;
+	int ret;
+
+	gpio = gpiochip_get_data(gc);
+
+	set_in.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
+	set_in.direction = RPI_EXP_GPIO_DIR_IN;
+	set_in.term_en = 0;		/* termination disabled */
+	set_in.term_pull_up = 0;	/* n/a as termination disabled */
+	set_in.state = 0;		/* n/a as configured as an input */
+
+	ret = rpi_exp_gpio_get_polarity(gc, off);
+	if (ret < 0)
+		return ret;
+	set_in.polarity = ret;		/* Retain existing setting */
+
+	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_SET_GPIO_CONFIG,
+				    &set_in, sizeof(set_in));
+	if (ret || set_in.gpio != 0) {
+		dev_err(gc->parent, "Failed to set GPIO %u to input (%d %x)\n",
+			off, ret, set_in.gpio);
+		return ret ? ret : -EIO;
+	}
+	return 0;
+}
+
+static int rpi_exp_gpio_dir_out(struct gpio_chip *gc, unsigned int off, int val)
+{
+	struct rpi_exp_gpio *gpio;
+	struct gpio_set_config set_out;
+	int ret;
+
+	gpio = gpiochip_get_data(gc);
+
+	set_out.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
+	set_out.direction = RPI_EXP_GPIO_DIR_OUT;
+	set_out.term_en = 0;		/* n/a as an output */
+	set_out.term_pull_up = 0;	/* n/a as termination disabled */
+	set_out.state = val;		/* Output state */
+
+	ret = rpi_exp_gpio_get_polarity(gc, off);
+	if (ret < 0)
+		return ret;
+	set_out.polarity = ret;		/* Retain existing setting */
+
+	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_SET_GPIO_CONFIG,
+				    &set_out, sizeof(set_out));
+	if (ret || set_out.gpio != 0) {
+		dev_err(gc->parent, "Failed to set GPIO %u to output (%d %x)\n",
+			off, ret, set_out.gpio);
+		return ret ? ret : -EIO;
+	}
+	return 0;
+}
+
+static int rpi_exp_gpio_get_direction(struct gpio_chip *gc, unsigned int off)
+{
+	struct rpi_exp_gpio *gpio;
+	struct gpio_get_config get;
+	int ret;
+
+	gpio = gpiochip_get_data(gc);
+
+	get.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
+
+	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_CONFIG,
+				    &get, sizeof(get));
+	if (ret || get.gpio != 0) {
+		dev_err(gc->parent,
+			"Failed to get GPIO %u config (%d %x)\n", off, ret,
+			get.gpio);
+		return ret ? ret : -EIO;
+	}
+	return !get.direction;
+}
+
+static int rpi_exp_gpio_get(struct gpio_chip *gc, unsigned int off)
+{
+	struct rpi_exp_gpio *gpio;
+	struct gpio_get_set_state get;
+	int ret;
+
+	gpio = gpiochip_get_data(gc);
+
+	get.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
+	get.state = 0;		/* storage for returned value */
+
+	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_STATE,
+					 &get, sizeof(get));
+	if (ret || get.gpio != 0) {
+		dev_err(gc->parent,
+			"Failed to get GPIO %u state (%d %x)\n", off, ret,
+			get.gpio);
+		return ret ? ret : -EIO;
+	}
+	return !!get.state;
+}
+
+static void rpi_exp_gpio_set(struct gpio_chip *gc, unsigned int off, int val)
+{
+	struct rpi_exp_gpio *gpio;
+	struct gpio_get_set_state set;
+	int ret;
+
+	gpio = gpiochip_get_data(gc);
+
+	set.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
+	set.state = val;	/* Output state */
+
+	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_SET_GPIO_STATE,
+					 &set, sizeof(set));
+	if (ret || set.gpio != 0)
+		dev_err(gc->parent,
+			"Failed to set GPIO %u state (%d %x)\n", off, ret,
+			set.gpio);
+}
+
+static int rpi_exp_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *fw_node;
+	struct rpi_firmware *fw;
+	struct rpi_exp_gpio *rpi_gpio;
+
+	fw_node = of_get_parent(np);
+	if (!fw_node) {
+		dev_err(dev, "Missing firmware node\n");
+		return -ENOENT;
+	}
+
+	fw = rpi_firmware_get(fw_node);
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	rpi_gpio = devm_kzalloc(dev, sizeof(*rpi_gpio), GFP_KERNEL);
+	if (!rpi_gpio)
+		return -ENOMEM;
+
+	rpi_gpio->fw = fw;
+	rpi_gpio->gc.parent = dev;
+	rpi_gpio->gc.label = MODULE_NAME;
+	rpi_gpio->gc.owner = THIS_MODULE;
+	rpi_gpio->gc.of_node = np;
+	rpi_gpio->gc.base = -1;
+	rpi_gpio->gc.ngpio = NUM_GPIO;
+
+	rpi_gpio->gc.direction_input = rpi_exp_gpio_dir_in;
+	rpi_gpio->gc.direction_output = rpi_exp_gpio_dir_out;
+	rpi_gpio->gc.get_direction = rpi_exp_gpio_get_direction;
+	rpi_gpio->gc.get = rpi_exp_gpio_get;
+	rpi_gpio->gc.set = rpi_exp_gpio_set;
+	rpi_gpio->gc.can_sleep = true;
+
+	return devm_gpiochip_add_data(dev, &rpi_gpio->gc, rpi_gpio);
+}
+
+static const struct of_device_id rpi_exp_gpio_ids[] = {
+	{ .compatible = "raspberrypi,firmware-gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpi_exp_gpio_ids);
+
+static struct platform_driver rpi_exp_gpio_driver = {
+	.driver	= {
+		.name		= MODULE_NAME,
+		.of_match_table	= of_match_ptr(rpi_exp_gpio_ids),
+	},
+	.probe	= rpi_exp_gpio_probe,
+};
+module_platform_driver(rpi_exp_gpio_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dave Stevenson <dave.stevenson@raspberrypi.org>");
+MODULE_DESCRIPTION("Raspberry Pi 3 expander GPIO driver");
+MODULE_ALIAS("platform:rpi-exp-gpio");
-- 
2.16.1
