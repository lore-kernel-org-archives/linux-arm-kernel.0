From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:29 +0100
Subject: [PATCH 09/11] misc: Versatile Express system registers driver
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-10-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a platform driver for Versatile Express' "system
register" block. It's a random collection of registers providing
the following functionality:

- low level platform functions like board ID access; in order to
  use those, the driver must be initialized early, either statically
  or based on the DT

- config bus bridge via "system control" interface; as the response
  from the controller does not generate interrupt (yet), the status
  register is periodically polled using a timer

- pseudo GPIO lines providing MMC card status and Flash WP#
  signal control

- LED interface for a set of 8 LEDs on the motherboard, with
  "heartbeat" and "mmc0" as default triggers for 2 of them

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/misc/vexpress/Makefile |    1 +
 drivers/misc/vexpress/sysreg.c |  423 ++++++++++++++++++++++++++++++++++++++++
 include/linux/vexpress.h       |   13 ++
 3 files changed, 437 insertions(+)
 create mode 100644 drivers/misc/vexpress/sysreg.c

diff --git a/drivers/misc/vexpress/Makefile b/drivers/misc/vexpress/Makefile
index d83d6b6..45af621 100644
--- a/drivers/misc/vexpress/Makefile
+++ b/drivers/misc/vexpress/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += config_bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += display.o
 obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += reset.o
+obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += sysreg.o
diff --git a/drivers/misc/vexpress/sysreg.c b/drivers/misc/vexpress/sysreg.c
new file mode 100644
index 0000000..e43abc8
--- /dev/null
+++ b/drivers/misc/vexpress/sysreg.c
@@ -0,0 +1,423 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/leds.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/stat.h>
+#include <linux/timer.h>
+#include <linux/vexpress.h>
+
+#define SYS_ID			0x000
+#define SYS_SW			0x004
+#define SYS_LED			0x008
+#define SYS_100HZ		0x024
+#define SYS_FLAGS		0x030
+#define SYS_FLAGSSET		0x030
+#define SYS_FLAGSCLR		0x034
+#define SYS_NVFLAGS		0x038
+#define SYS_NVFLAGSSET		0x038
+#define SYS_NVFLAGSCLR		0x03c
+#define SYS_MCI			0x048
+#define SYS_FLASH		0x04c
+#define SYS_CFGSW		0x058
+#define SYS_24MHZ		0x05c
+#define SYS_MISC		0x060
+#define SYS_DMA			0x064
+#define SYS_PROCID0		0x084
+#define SYS_PROCID1		0x088
+#define SYS_CFGDATA		0x0a0
+#define SYS_CFGCTRL		0x0a4
+#define SYS_CFGSTAT		0x0a8
+
+#define SYS_HBI_MASK		0xfff
+#define SYS_ID_HBI_SHIFT	16
+#define SYS_PROCIDx_HBI_SHIFT	0
+
+#define SYS_MCI_CARDIN		(1 << 0)
+#define SYS_MCI_WPROT		(1 << 1)
+
+#define SYS_FLASH_WPn		(1 << 0)
+
+#define SYS_MISC_MASTERSITE	(1 << 14)
+
+#define SYS_CFGCTRL_START	(1 << 31)
+#define SYS_CFGCTRL_WRITE	(1 << 30)
+#define SYS_CFGCTRL_DCC(n)	(((n) & 0xf) << 26)
+#define SYS_CFGCTRL_FUNC(n)	(((n) & 0x3f) << 20)
+#define SYS_CFGCTRL_SITE(n)	(((n) & 0x3) << 16)
+#define SYS_CFGCTRL_POSITION(n)	(((n) & 0xf) << 12)
+#define SYS_CFGCTRL_DEVICE(n)	(((n) & 0xfff) << 0)
+
+#define SYS_CFGSTAT_ERR		(1 << 1)
+#define SYS_CFGSTAT_COMPLETE	(1 << 0)
+
+
+static void __iomem *vexpress_sysreg_base;
+static struct device *vexpress_sysreg_dev;
+static int vexpress_master_site;
+
+
+void __init vexpress_flags_set(u32 data)
+{
+	writel(~0, vexpress_sysreg_base + SYS_FLAGSCLR);
+	writel(data, vexpress_sysreg_base + SYS_FLAGSSET);
+}
+
+u32 vexpress_get_procid(int site)
+{
+	if (site == VEXPRESS_SITE_MASTER)
+		site = vexpress_master_site;
+
+	return readl(vexpress_sysreg_base + (site == VEXPRESS_SITE_DB1 ?
+			SYS_PROCID0 : SYS_PROCID1));
+}
+
+u32 vexpress_get_hbi(int site)
+{
+	u32 id;
+
+	switch (site) {
+	case VEXPRESS_SITE_MB:
+		id = readl(vexpress_sysreg_base + SYS_ID);
+		return (id >> SYS_ID_HBI_SHIFT) & SYS_HBI_MASK;
+	case VEXPRESS_SITE_MASTER:
+	case VEXPRESS_SITE_DB1:
+	case VEXPRESS_SITE_DB2:
+		id = vexpress_get_procid(site);
+		return (id >> SYS_PROCIDx_HBI_SHIFT) & SYS_HBI_MASK;
+	}
+
+	return ~0;
+}
+
+void __iomem *vexpress_get_24mhz_clock_base(void)
+{
+	return vexpress_sysreg_base + SYS_24MHZ;
+}
+
+
+static struct vexpress_config_bridge *vexpress_sysreg_config_bridge;
+static struct timer_list vexpress_sysreg_config_timer;
+static u32 *vexpress_sysreg_config_data;
+static int vexpress_sysreg_config_tries;
+
+static int vexpress_sysreg_config_command(bool async, bool write,
+		unsigned func, struct vexpress_config_address *addr, u32 *data)
+{
+	int res = 0;
+	u32 command;
+
+	if (WARN_ON(!vexpress_sysreg_base))
+		return -ENOENT;
+
+	command = readl(vexpress_sysreg_base + SYS_CFGCTRL);
+	if (WARN_ON(command & SYS_CFGCTRL_START))
+		return -EBUSY;
+
+	command = SYS_CFGCTRL_START;
+	command |= write ? SYS_CFGCTRL_WRITE : 0;
+	command |= SYS_CFGCTRL_DCC(addr->dcc);
+	command |= SYS_CFGCTRL_FUNC(func);
+	command |= SYS_CFGCTRL_SITE(addr->site);
+	command |= SYS_CFGCTRL_POSITION(addr->position);
+	command |= SYS_CFGCTRL_DEVICE(addr->device);
+
+	if (write)
+		writel(*data, vexpress_sysreg_base + SYS_CFGDATA);
+	else
+		vexpress_sysreg_config_data = data;
+	writel(0, vexpress_sysreg_base + SYS_CFGSTAT);
+	writel(command, vexpress_sysreg_base + SYS_CFGCTRL);
+	mb();
+
+	if (async) {
+		vexpress_sysreg_config_tries = 100;
+		mod_timer(&vexpress_sysreg_config_timer,
+				jiffies + usecs_to_jiffies(100));
+	} else {
+		u32 val;
+
+		do {
+			cpu_relax();
+			val = readl(vexpress_sysreg_base + SYS_CFGSTAT);
+		} while (!val);
+
+		if (!write && (val & SYS_CFGSTAT_COMPLETE))
+			*data = readl(vexpress_sysreg_base + SYS_CFGDATA);
+
+		if (val & SYS_CFGSTAT_ERR)
+			res = -EINVAL;
+	}
+
+	return res;
+}
+
+struct vexpress_config_bridge_info vexpress_sysreg_config_bridge_info = {
+	.name = "vexpress-sysreg",
+	.command = vexpress_sysreg_config_command,
+};
+
+static void vexpress_sysreg_config_complete(unsigned long data)
+{
+	int err = 0;
+	u32 val = readl(vexpress_sysreg_base + SYS_CFGSTAT);
+
+	if (val & SYS_CFGSTAT_ERR)
+		err = -EINVAL;
+	if (!vexpress_sysreg_config_tries--)
+		err = -ETIMEDOUT;
+
+	if (!err && !(val & SYS_CFGSTAT_COMPLETE)) {
+		mod_timer(&vexpress_sysreg_config_timer,
+				jiffies + usecs_to_jiffies(50));
+		return;
+	}
+
+	if (vexpress_sysreg_config_data) {
+		*vexpress_sysreg_config_data = readl(vexpress_sysreg_base +
+				SYS_CFGDATA);
+		vexpress_sysreg_config_data = NULL;
+	}
+
+	vexpress_config_complete(vexpress_sysreg_config_bridge, err);
+}
+
+
+static struct vexpress_sysreg_gpio {
+	unsigned long reg;
+	u32 value;
+} vexpress_sysreg_gpios[] = {
+	[VEXPRESS_GPIO_MMC_CARDIN] = {
+		.reg = SYS_MCI,
+		.value = SYS_MCI_CARDIN,
+	},
+	[VEXPRESS_GPIO_MMC_WPROT] = {
+		.reg = SYS_MCI,
+		.value = SYS_MCI_WPROT,
+	},
+	[VEXPRESS_GPIO_FLASH_WPn] = {
+		.reg = SYS_FLASH,
+		.value = SYS_FLASH_WPn,
+	},
+};
+
+static int vexpress_sysreg_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned offset)
+{
+	return 0;
+}
+
+static int vexpress_sysreg_gpio_direction_output(struct gpio_chip *chip,
+						unsigned offset, int value)
+{
+	return 0;
+}
+
+static int vexpress_sysreg_gpio_get(struct gpio_chip *chip,
+				       unsigned offset)
+{
+	struct vexpress_sysreg_gpio *gpio = &vexpress_sysreg_gpios[offset];
+	u32 reg_value = readl(vexpress_sysreg_base + gpio->reg);
+
+	return !!(reg_value & gpio->value);
+}
+
+static void vexpress_sysreg_gpio_set(struct gpio_chip *chip,
+				       unsigned offset, int value)
+{
+	struct vexpress_sysreg_gpio *gpio = &vexpress_sysreg_gpios[offset];
+	u32 reg_value = readl(vexpress_sysreg_base + gpio->reg);
+
+	if (value)
+		reg_value |= gpio->value;
+	else
+		reg_value &= ~gpio->value;
+
+	writel(reg_value, vexpress_sysreg_base + gpio->reg);
+}
+
+static struct gpio_chip vexpress_sysreg_gpio_chip = {
+	.label = "vexpress-sysreg",
+	.direction_input = vexpress_sysreg_gpio_direction_input,
+	.direction_output = vexpress_sysreg_gpio_direction_output,
+	.get = vexpress_sysreg_gpio_get,
+	.set = vexpress_sysreg_gpio_set,
+	.ngpio = ARRAY_SIZE(vexpress_sysreg_gpios),
+	.base = 0,
+};
+
+
+void __init vexpress_sysreg_early_init(void __iomem *base)
+{
+	if (WARN_ON(!base))
+		return;
+
+	vexpress_sysreg_base = base;
+
+	if (readl(vexpress_sysreg_base + SYS_MISC) & SYS_MISC_MASTERSITE)
+		vexpress_master_site = VEXPRESS_SITE_DB2;
+	else
+		vexpress_master_site = VEXPRESS_SITE_DB1;
+
+	vexpress_config_set_master_site(vexpress_master_site);
+
+	vexpress_sysreg_config_bridge = vexpress_config_bridge_register(
+			&vexpress_sysreg_config_bridge_info);
+}
+
+void __init vexpress_sysreg_of_early_init(void)
+{
+	struct device_node *node = of_find_compatible_node(NULL, NULL,
+			"arm,vexpress-sysreg");
+
+	vexpress_sysreg_early_init(of_iomap(node, 0));
+}
+
+
+static ssize_t vexpress_sysreg_sys_id_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", readl(vexpress_sysreg_base + SYS_ID));
+}
+
+DEVICE_ATTR(sys_id, S_IRUGO, vexpress_sysreg_sys_id_show, NULL);
+
+static int __devinit vexpress_sysreg_probe(struct platform_device *pdev)
+{
+	int err;
+	struct resource *res = platform_get_resource(pdev,
+			IORESOURCE_MEM, 0);
+
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+			resource_size(res), pdev->name)) {
+		dev_err(&pdev->dev, "Failed to request memory region!\n");
+		return -EBUSY;
+	}
+
+	if (!vexpress_sysreg_base)
+		vexpress_sysreg_base = devm_ioremap(&pdev->dev, res->start,
+				resource_size(res));
+
+	if (!vexpress_sysreg_base) {
+		dev_err(&pdev->dev, "Failed to obtain base address!\n");
+		return -EFAULT;
+	}
+
+	setup_timer(&vexpress_sysreg_config_timer,
+			vexpress_sysreg_config_complete, 0);
+
+	vexpress_sysreg_gpio_chip.dev = &pdev->dev;
+	err = gpiochip_add(&vexpress_sysreg_gpio_chip);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register GPIO chip! (%d)\n",
+				err);
+		return err;
+	}
+
+	vexpress_sysreg_dev = &pdev->dev;
+
+	device_create_file(vexpress_sysreg_dev, &dev_attr_sys_id);
+
+	return 0;
+}
+
+static const struct of_device_id vexpress_sysreg_match[] = {
+	{ .compatible = "arm,vexpress-sysreg", },
+	{},
+};
+
+static struct platform_driver vexpress_sysreg_driver = {
+	.driver = {
+		.name = "vexpress-sysreg",
+		.of_match_table = vexpress_sysreg_match,
+	},
+	.probe = vexpress_sysreg_probe,
+};
+
+static int __init vexpress_sysreg_init(void)
+{
+	return platform_driver_register(&vexpress_sysreg_driver);
+}
+subsys_initcall(vexpress_sysreg_init);
+
+
+struct vexpress_sysreg_led {
+	u32 mask;
+	struct led_classdev cdev;
+} vexpress_sysreg_leds[] = {
+	{ .mask = 1 << 0, .cdev.name = "v2m:green:user1",
+			.cdev.default_trigger = "heartbeat", },
+	{ .mask = 1 << 1, .cdev.name = "v2m:green:user2",
+			.cdev.default_trigger = "mmc0", },
+	{ .mask = 1 << 2, .cdev.name = "v2m:green:user3", },
+	{ .mask = 1 << 3, .cdev.name = "v2m:green:user4", },
+	{ .mask = 1 << 4, .cdev.name = "v2m:green:user5", },
+	{ .mask = 1 << 5, .cdev.name = "v2m:green:user6", },
+	{ .mask = 1 << 6, .cdev.name = "v2m:green:user7", },
+	{ .mask = 1 << 7, .cdev.name = "v2m:green:user8", },
+};
+
+static DEFINE_SPINLOCK(vexpress_sysreg_leds_lock);
+
+static void vexpress_sysreg_led_brightness_set(struct led_classdev *cdev,
+		enum led_brightness brightness)
+{
+	struct vexpress_sysreg_led *led = container_of(cdev,
+			struct vexpress_sysreg_led, cdev);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&vexpress_sysreg_leds_lock, flags);
+
+	val = readl(vexpress_sysreg_base + SYS_LED);
+	if (brightness == LED_OFF)
+		val &= ~led->mask;
+	else
+		val |= led->mask;
+	writel(val, vexpress_sysreg_base + SYS_LED);
+
+	spin_unlock_irqrestore(&vexpress_sysreg_leds_lock, flags);
+}
+
+static int __init vexpress_sysreg_init_leds(void)
+{
+	struct vexpress_sysreg_led *led;
+	int i;
+
+	/* Clear all user LEDs */
+	writel(0, vexpress_sysreg_base + SYS_LED);
+
+	for (i = 0, led = vexpress_sysreg_leds;
+			i < ARRAY_SIZE(vexpress_sysreg_leds); i++, led++) {
+		int err;
+
+		led->cdev.brightness_set = vexpress_sysreg_led_brightness_set;
+		err = led_classdev_register(vexpress_sysreg_dev, &led->cdev);
+		if (err) {
+			dev_err(vexpress_sysreg_dev,
+					"Failed to register LED %d! (%d)\n",
+					i, err);
+			while (led--, i--)
+				led_classdev_unregister(&led->cdev);
+			return err;
+		}
+	}
+
+	return 0;
+}
+device_initcall(vexpress_sysreg_init_leds);
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index 18f03d1..c44d2dc 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -134,4 +134,17 @@ int vexpress_osc_driver_register(void);
 void vexpress_clk_init(void __iomem *sp810_base);
 void vexpress_clk_of_init(void);
 
+/* System facilities */
+void vexpress_sysreg_early_init(void __iomem *base);
+void vexpress_sysreg_of_early_init(void);
+u32 vexpress_get_procid(int site);
+u32 vexpress_get_hbi(int site);
+void *vexpress_get_24mhz_clock_base(void);
+void __init vexpress_flags_set(u32 data);
+
+/* System pseudo-GPIOs */
+#define VEXPRESS_GPIO_MMC_CARDIN	0
+#define VEXPRESS_GPIO_MMC_WPROT		1
+#define VEXPRESS_GPIO_FLASH_WPn		2
+
 #endif
-- 
1.7.9.5
