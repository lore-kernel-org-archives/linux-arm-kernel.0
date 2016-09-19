From: eric@anholt.net (Eric Anholt)
Date: Mon, 19 Sep 2016 17:13:13 +0100
Subject: [PATCH 2/3] gpio: Add a driver for the Raspberry Pi's firmware GPIO
 calls.
In-Reply-To: <20160919161314.25858-1-eric@anholt.net>
References: <20160919161314.25858-1-eric@anholt.net>
Message-ID: <20160919161314.25858-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver will be used for accessing the FXL6408 GPIO exander on the
Pi3.  We can't drive it directly from Linux because the firmware is
continuously polling one of the expander's lines to do its
undervoltage detection.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpio/Kconfig                       |   8 ++
 drivers/gpio/Makefile                      |   1 +
 drivers/gpio/gpio-raspberrypi.c            | 159 +++++++++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |   2 +
 4 files changed, 170 insertions(+)
 create mode 100644 drivers/gpio/gpio-raspberrypi.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index fcbd8e318474..60cf38bb3a44 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -136,6 +136,14 @@ config GPIO_BCM_KONA
 	help
 	  Turn on GPIO support for Broadcom "Kona" chips.
 
+config GPIO_RASPBERRYPI
+	tristate "Raspberry Pi firmware-based GPIO access"
+	depends on OF_GPIO && RASPBERRYPI_FIRMWARE && (ARCH_BCM2835 || COMPILE_TEST)
+	help
+	  Turns on support for using the Raspberry Pi firmware to
+	  control GPIO pins.  Used for access to the FXL6408 GPIO
+	  expander on the Pi 3.
+
 config GPIO_BRCMSTB
 	tristate "BRCMSTB GPIO support"
 	default y if (ARCH_BRCMSTB || BMIPS_GENERIC)
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index b3e039c3ae8d..fa10cf4030ad 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
 obj-$(CONFIG_GPIO_ASPEED)	+= gpio-aspeed.o
 obj-$(CONFIG_GPIO_AXP209)	+= gpio-axp209.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
+obj-$(CONFIG_GPIO_RASPBERRYPI)	+= gpio-raspberrypi.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
 obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
diff --git a/drivers/gpio/gpio-raspberrypi.c b/drivers/gpio/gpio-raspberrypi.c
new file mode 100644
index 000000000000..233c211f45ba
--- /dev/null
+++ b/drivers/gpio/gpio-raspberrypi.c
@@ -0,0 +1,159 @@
+/*
+ * Copyright ? 2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+/* This driver supports using the Raspberry Pi's firmware interface to
+ * access its GPIO lines.  This lets us interact with the GPIO lines
+ * on the Raspberry Pi 3's FXL6408 expander, which we otherwise have
+ * no way to access (since the firmware is polling the chip
+ * continuously).
+ */
+
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+struct rpi_gpio {
+	struct device *dev;
+	struct gpio_chip gc;
+	struct rpi_firmware *firmware;
+
+	/* Offset of our pins in the GET_GPIO_STATE/SET_GPIO_STATE calls. */
+	unsigned offset;
+};
+
+static int rpi_gpio_dir_in(struct gpio_chip *gc, unsigned off)
+{
+	/* We don't have direction control. */
+	return -EINVAL;
+}
+
+static int rpi_gpio_dir_out(struct gpio_chip *gc, unsigned off, int val)
+{
+	/* We don't have direction control. */
+	return -EINVAL;
+}
+
+static void rpi_gpio_set(struct gpio_chip *gc, unsigned off, int val)
+{
+	struct rpi_gpio *rpi = container_of(gc, struct rpi_gpio, gc);
+	u32 packet[2] = { rpi->offset + off, val };
+	int ret;
+
+	ret = rpi_firmware_property(rpi->firmware,
+				    RPI_FIRMWARE_SET_GPIO_STATE,
+				    &packet, sizeof(packet));
+	if (ret)
+		dev_err(rpi->dev, "Error setting GPIO %d state: %d\n", off, ret);
+}
+
+static int rpi_gpio_get(struct gpio_chip *gc, unsigned off)
+{
+	struct rpi_gpio *rpi = container_of(gc, struct rpi_gpio, gc);
+	u32 packet[2] = { rpi->offset + off, 0 };
+	int ret;
+
+	ret = rpi_firmware_property(rpi->firmware,
+				    RPI_FIRMWARE_GET_GPIO_STATE,
+				    &packet, sizeof(packet));
+	if (ret) {
+		dev_err(rpi->dev, "Error getting GPIO state: %d\n", ret);
+		return ret;
+	} else if (packet[0]) {
+		dev_err(rpi->dev, "Firmware error getting GPIO state: %d\n",
+			packet[0]);
+		return -EINVAL;
+	} else {
+		return packet[1];
+	}
+}
+
+static int rpi_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *fw_node;
+	struct rpi_gpio *rpi;
+	u32 ngpio;
+	int ret;
+
+	rpi = devm_kzalloc(dev, sizeof *rpi, GFP_KERNEL);
+	if (!rpi)
+		return -ENOMEM;
+	rpi->dev = dev;
+
+	fw_node = of_parse_phandle(np, "firmware", 0);
+	if (!fw_node) {
+		dev_err(dev, "Missing firmware node\n");
+		return -ENOENT;
+	}
+
+	rpi->firmware = rpi_firmware_get(fw_node);
+	if (!rpi->firmware)
+		return -EPROBE_DEFER;
+
+	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpio)) {
+		dev_err(dev, "Missing ngpios");
+		return -ENOENT;
+	}
+	if (of_property_read_u32(pdev->dev.of_node,
+				 "raspberrypi,firmware-gpio-offset",
+				 &rpi->offset)) {
+		dev_err(dev, "Missing raspberrypi,firmware-gpio-offset");
+		return -ENOENT;
+	}
+
+	rpi->gc.label = np->full_name;
+	rpi->gc.owner = THIS_MODULE;
+	rpi->gc.of_node = np;
+	rpi->gc.ngpio = ngpio;
+	rpi->gc.direction_input = rpi_gpio_dir_in;
+	rpi->gc.direction_output = rpi_gpio_dir_out;
+	rpi->gc.get = rpi_gpio_get;
+	rpi->gc.set = rpi_gpio_set;
+	rpi->gc.can_sleep = true;
+
+	ret = gpiochip_add(&rpi->gc);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, rpi);
+
+	return 0;
+}
+
+static int rpi_gpio_remove(struct platform_device *pdev)
+{
+	struct rpi_gpio *rpi = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&rpi->gc);
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused rpi_gpio_ids[] = {
+	{ .compatible = "raspberrypi,firmware-gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpi_gpio_ids);
+
+static struct platform_driver rpi_gpio_driver = {
+	.driver	= {
+		.name = "gpio-raspberrypi-firmware",
+		.of_match_table	= of_match_ptr(rpi_gpio_ids),
+	},
+	.probe	= rpi_gpio_probe,
+	.remove	= rpi_gpio_remove,
+};
+module_platform_driver(rpi_gpio_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
+MODULE_DESCRIPTION("Raspberry Pi firmware GPIO driver");
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 3fb357193f09..671ccd00aea2 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -73,11 +73,13 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_GET_DISPMANX_RESOURCE_MEM_HANDLE =       0x00030014,
 	RPI_FIRMWARE_GET_EDID_BLOCK =                         0x00030020,
 	RPI_FIRMWARE_GET_DOMAIN_STATE =                       0x00030030,
+	RPI_FIRMWARE_GET_GPIO_STATE =                         0x00030041,
 	RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
 	RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
 	RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,
 	RPI_FIRMWARE_SET_TURBO =                              0x00038009,
 	RPI_FIRMWARE_SET_DOMAIN_STATE =                       0x00038030,
+	RPI_FIRMWARE_SET_GPIO_STATE =                         0x00038041,
 
 	/* Dispmanx TAGS */
 	RPI_FIRMWARE_FRAMEBUFFER_ALLOCATE =                   0x00040001,
-- 
2.9.3
