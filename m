From: simon@sequanux.org (Simon Guinot)
Date: Tue,  6 Jul 2010 16:08:46 +0200
Subject: [PATCH v2 2/3] leds: add LED driver for Network Space v2 LEDs
In-Reply-To: <1278425327-16762-1-git-send-email-simon@sequanux.org>
References: <alpine.LFD.2.00.1007051444030.6020@xanadu.home>
	<1278425327-16762-1-git-send-email-simon@sequanux.org>
Message-ID: <1278425327-16762-2-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

This patch add a LED class driver for the dual-GPIO LEDs found on the
Network Space v2 board (and parents). This include Internet Space v2,
Network Space (Max) v2 and d2 Network v2 boards.

This dual-GPIO LED is wired to a CPLD and can blink in relation with the
SATA activity. The driver expose this capability through a "sata" sysfs
attribute.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-kirkwood/include/mach/leds-ns2.h |   26 ++
 drivers/leds/Kconfig                           |    9 +
 drivers/leds/Makefile                          |    1 +
 drivers/leds/leds-ns2.c                        |  338 ++++++++++++++++++++++++
 4 files changed, 374 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/include/mach/leds-ns2.h
 create mode 100644 drivers/leds/leds-ns2.c

diff --git a/arch/arm/mach-kirkwood/include/mach/leds-ns2.h b/arch/arm/mach-kirkwood/include/mach/leds-ns2.h
new file mode 100644
index 0000000..e21272e
--- /dev/null
+++ b/arch/arm/mach-kirkwood/include/mach/leds-ns2.h
@@ -0,0 +1,26 @@
+/*
+ * arch/arm/mach-kirkwood/include/mach/leds-ns2.h
+ *
+ * Platform data structure for Network Space v2 LED driver
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_LEDS_NS2_H
+#define __MACH_LEDS_NS2_H
+
+struct ns2_led {
+	const char	*name;
+	const char	*default_trigger;
+	unsigned	cmd;
+	unsigned	slow;
+};
+
+struct ns2_led_platform_data {
+	int		num_leds;
+	struct ns2_led	*leds;
+};
+
+#endif /* __MACH_LEDS_NS2_H */
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 81bf25e..e411262 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -302,6 +302,15 @@ config LEDS_MC13783
 	  This option enable support for on-chip LED drivers found
 	  on Freescale Semiconductor MC13783 PMIC.
 
+config LEDS_NS2
+	tristate "LED support for Network Space v2 GPIO LEDs"
+	depends on MACH_NETSPACE_V2 || MACH_INETSPACE_V2 || MACH_NETSPACE_MAX_V2
+	default y
+	help
+	  This option enable support for the dual-GPIO LED found on the
+	  Network Space v2 board (and parents). This include Internet Space v2,
+	  Network Space (Max) v2 and d2 Network v2 boards.
+
 config LEDS_TRIGGERS
 	bool "LED Trigger support"
 	help
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 2493de4..7d6b958 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
 obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
 obj-$(CONFIG_LEDS_DELL_NETBOOKS)	+= dell-led.o
 obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
+obj-$(CONFIG_LEDS_NS2)			+= leds-ns2.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
new file mode 100644
index 0000000..74dce4b
--- /dev/null
+++ b/drivers/leds/leds-ns2.c
@@ -0,0 +1,338 @@
+/*
+ * leds-ns2.c - Driver for the Network Space v2 (and parents) dual-GPIO LED
+ *
+ * Copyright (C) 2010 LaCie
+ *
+ * Author: Simon Guinot <sguinot@lacie.com>
+ *
+ * Based on leds-gpio.c by Raphael Assenat <raph@8d.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <mach/leds-ns2.h>
+
+/*
+ * The Network Space v2 dual-GPIO LED is wired to a CPLD and can blink in
+ * relation with the SATA activity. This capability is exposed through the
+ * "sata" sysfs attribute.
+ *
+ * The following array detail the different LED registers and the combination
+ * of their possible values:
+ *
+ *  cmd_led   |  slow_led  | /SATA active | LED state
+ *            |            |              |
+ *     1      |     0      |      x       |  off
+ *     -      |     1      |      x       |  on
+ *     0      |     0      |      1       |  on
+ *     0      |     0      |      0       |  blink (rate 300ms)
+ */
+
+enum ns2_led_modes {
+	NS_V2_LED_OFF,
+	NS_V2_LED_ON,
+	NS_V2_LED_SATA,
+};
+
+struct ns2_led_mode_value {
+	enum ns2_led_modes	mode;
+	int			cmd_level;
+	int			slow_level;
+};
+
+static struct ns2_led_mode_value ns2_led_modval[] = {
+	{ NS_V2_LED_OFF	, 1, 0 },
+	{ NS_V2_LED_ON	, 0, 1 },
+	{ NS_V2_LED_ON	, 1, 1 },
+	{ NS_V2_LED_SATA, 0, 0 },
+};
+
+struct ns2_led_data {
+	struct led_classdev	cdev;
+	unsigned		cmd;
+	unsigned		slow;
+	unsigned char		sata; /* True when SATA mode active. */
+	rwlock_t		rw_lock; /* Lock GPIOs. */
+};
+
+static int ns2_led_get_mode(struct ns2_led_data *led_dat,
+			    enum ns2_led_modes *mode)
+{
+	int i;
+	int ret = -EINVAL;
+	int cmd_level;
+	int slow_level;
+
+	read_lock(&led_dat->rw_lock);
+
+	cmd_level = gpio_get_value(led_dat->cmd);
+	slow_level = gpio_get_value(led_dat->slow);
+
+	for (i = 0; i < ARRAY_SIZE(ns2_led_modval); i++) {
+		if (cmd_level == ns2_led_modval[i].cmd_level &&
+		    slow_level == ns2_led_modval[i].slow_level) {
+			*mode = ns2_led_modval[i].mode;
+			ret = 0;
+			break;
+		}
+	}
+
+	read_unlock(&led_dat->rw_lock);
+
+	return ret;
+}
+
+static void ns2_led_set_mode(struct ns2_led_data *led_dat,
+			     enum ns2_led_modes mode)
+{
+	int i;
+
+	write_lock(&led_dat->rw_lock);
+
+	for (i = 0; i < ARRAY_SIZE(ns2_led_modval); i++) {
+		if (mode == ns2_led_modval[i].mode) {
+			gpio_set_value(led_dat->cmd,
+				       ns2_led_modval[i].cmd_level);
+			gpio_set_value(led_dat->slow,
+				       ns2_led_modval[i].slow_level);
+		}
+	}
+
+	write_unlock(&led_dat->rw_lock);
+}
+
+static void ns2_led_set(struct led_classdev *led_cdev,
+			enum led_brightness value)
+{
+	struct ns2_led_data *led_dat =
+		container_of(led_cdev, struct ns2_led_data, cdev);
+	enum ns2_led_modes mode;
+
+	if (value == LED_OFF)
+		mode = NS_V2_LED_OFF;
+	else if (led_dat->sata)
+		mode = NS_V2_LED_SATA;
+	else
+		mode = NS_V2_LED_ON;
+
+	ns2_led_set_mode(led_dat, mode);
+}
+
+static ssize_t ns2_led_sata_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buff, size_t count)
+{
+	int ret;
+	unsigned long enable;
+	enum ns2_led_modes mode;
+	struct ns2_led_data *led_dat = dev_get_drvdata(dev);
+
+	ret = strict_strtoul(buff, 10, &enable);
+	if (ret < 0)
+		return ret;
+
+	enable = !!enable;
+
+	if (led_dat->sata == enable)
+		return count;
+
+	ret = ns2_led_get_mode(led_dat, &mode);
+	if (ret < 0)
+		return ret;
+
+	if (enable && mode == NS_V2_LED_ON)
+		ns2_led_set_mode(led_dat, NS_V2_LED_SATA);
+	if (!enable && mode == NS_V2_LED_SATA)
+		ns2_led_set_mode(led_dat, NS_V2_LED_ON);
+
+	led_dat->sata = enable;
+
+	return count;
+}
+
+static ssize_t ns2_led_sata_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct ns2_led_data *led_dat = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", led_dat->sata);
+}
+
+static DEVICE_ATTR(sata, 0644, ns2_led_sata_show, ns2_led_sata_store);
+
+static int __devinit
+create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
+	       const struct ns2_led *template)
+{
+	int ret;
+	enum ns2_led_modes mode;
+
+	ret = gpio_request(template->cmd, template->name);
+	if (ret == 0) {
+		ret = gpio_direction_output(template->cmd,
+					    gpio_get_value(template->cmd));
+		if (ret)
+			gpio_free(template->cmd);
+	}
+	if (ret) {
+		dev_err(&pdev->dev, "%s: failed to setup command GPIO\n",
+			template->name);
+	}
+
+	ret = gpio_request(template->slow, template->name);
+	if (ret == 0) {
+		ret = gpio_direction_output(template->slow,
+					    gpio_get_value(template->slow));
+		if (ret)
+			gpio_free(template->slow);
+	}
+	if (ret) {
+		dev_err(&pdev->dev, "%s: failed to setup slow GPIO\n",
+			template->name);
+		goto err_free_cmd;
+	}
+
+	rwlock_init(&led_dat->rw_lock);
+
+	led_dat->cdev.name = template->name;
+	led_dat->cdev.default_trigger = template->default_trigger;
+	led_dat->cdev.blink_set = NULL;
+	led_dat->cdev.brightness_set = ns2_led_set;
+	led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
+	led_dat->cmd = template->cmd;
+	led_dat->slow = template->slow;
+
+	ret = ns2_led_get_mode(led_dat, &mode);
+	if (ret < 0)
+		goto err_free_slow;
+
+	/* Set LED initial state. */
+	led_dat->sata = (mode == NS_V2_LED_SATA) ? 1 : 0;
+	led_dat->cdev.brightness =
+		(mode == NS_V2_LED_OFF) ? LED_OFF : LED_FULL;
+
+	ret = led_classdev_register(&pdev->dev, &led_dat->cdev);
+	if (ret < 0)
+		goto err_free_slow;
+
+	dev_set_drvdata(led_dat->cdev.dev, led_dat);
+	ret = device_create_file(led_dat->cdev.dev, &dev_attr_sata);
+	if (ret < 0)
+		goto err_free_cdev;
+
+	return 0;
+
+err_free_cdev:
+	led_classdev_unregister(&led_dat->cdev);
+err_free_slow:
+	gpio_free(led_dat->slow);
+err_free_cmd:
+	gpio_free(led_dat->cmd);
+
+	return ret;
+}
+
+static void __devexit delete_ns2_led(struct ns2_led_data *led_dat)
+{
+	device_remove_file(led_dat->cdev.dev, &dev_attr_sata);
+	led_classdev_unregister(&led_dat->cdev);
+	gpio_free(led_dat->cmd);
+	gpio_free(led_dat->slow);
+}
+
+static int __devinit ns2_led_probe(struct platform_device *pdev)
+{
+	struct ns2_led_platform_data *pdata = pdev->dev.platform_data;
+	struct ns2_led_data *leds_data;
+	int i;
+	int ret;
+
+	if (!pdata)
+		return -EINVAL;
+
+	leds_data = kzalloc(sizeof(struct ns2_led_data) *
+			    pdata->num_leds, GFP_KERNEL);
+	if (!leds_data)
+		return -ENOMEM;
+
+	for (i = 0; i < pdata->num_leds; i++) {
+		ret = create_ns2_led(pdev, &leds_data[i], &pdata->leds[i]);
+		if (ret < 0)
+			goto err;
+
+	}
+
+	platform_set_drvdata(pdev, leds_data);
+
+	return 0;
+
+err:
+	for (i = i - 1; i >= 0; i--)
+		delete_ns2_led(&leds_data[i]);
+
+	kfree(leds_data);
+
+	return ret;
+}
+
+static int __devexit ns2_led_remove(struct platform_device *pdev)
+{
+	int i;
+	struct ns2_led_platform_data *pdata = pdev->dev.platform_data;
+	struct ns2_led_data *leds_data;
+
+	leds_data = platform_get_drvdata(pdev);
+
+	for (i = 0; i < pdata->num_leds; i++)
+		delete_ns2_led(&leds_data[i]);
+
+	kfree(leds_data);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver ns2_led_driver = {
+	.probe		= ns2_led_probe,
+	.remove		= __devexit_p(ns2_led_remove),
+	.driver		= {
+		.name	= "leds-ns2",
+		.owner	= THIS_MODULE,
+	},
+};
+MODULE_ALIAS("platform:leds-ns2");
+
+static int __init ns2_led_init(void)
+{
+	return platform_driver_register(&ns2_led_driver);
+}
+
+static void __exit ns2_led_exit(void)
+{
+	platform_driver_unregister(&ns2_led_driver);
+}
+
+module_init(ns2_led_init);
+module_exit(ns2_led_exit);
+
+MODULE_AUTHOR("Simon Guinot <sguinot@lacie.com>");
+MODULE_DESCRIPTION("Network Space v2 LED driver");
+MODULE_LICENSE("GPL");
-- 
1.6.3.1
