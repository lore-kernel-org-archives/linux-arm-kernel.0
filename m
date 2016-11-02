From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 2 Nov 2016 09:32:56 -0500
Subject: [PATCHv3 2/4] misc: Add Altera Arria10 System Resource Control
In-Reply-To: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
References: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1478097178-24341-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch adds the Altera Arria10 control & monitoring
functions to the Arria10 System Resource chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  Change compatible string and filename from -mon to -monitor
    Change CONFIG from module to builtin.
    Make wm_rst register writeable.
v3  Remove unused ret variable.
    Shorten driver name (remove altr_).
---
 MAINTAINERS                         |   1 +
 drivers/misc/Kconfig                |   7 ++
 drivers/misc/Makefile               |   1 +
 drivers/misc/altera-a10sr-monitor.c | 175 ++++++++++++++++++++++++++++++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 drivers/misc/altera-a10sr-monitor.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b180821..baf2404 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -635,6 +635,7 @@ M:	Thor Thayer <tthayer@opensource.altera.com>
 S:	Maintained
 F:	drivers/gpio/gpio-altera-a10sr.c
 F:	drivers/mfd/altera-a10sr.c
+F: 	drivers/misc/altera-a10sr-monitor.c
 F:	include/linux/mfd/altera-a10sr.h
 
 ALTERA TRIPLE SPEED ETHERNET DRIVER
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 64971ba..f42d459 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -766,6 +766,13 @@ config PANEL_BOOT_MESSAGE
 	  An empty message will only clear the display at driver init time. Any other
 	  printf()-formatted message is valid with newline and escape codes.
 
+config ALTERA_A10SR_MONITOR
+	bool "Altera Arria10 System Resource Monitor"
+	depends on MFD_ALTERA_A10SR
+	help
+	  This enables the System Resource monitor driver for the Altera
+	  Arria10 DevKit.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 3198336..9f6e77a 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -43,6 +43,7 @@ obj-y				+= ti-st/
 obj-y				+= lis3lv02d/
 obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
 obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
+obj-$(CONFIG_ALTERA_A10SR_MONITOR)	+= altera-a10sr-monitor.o
 obj-$(CONFIG_INTEL_MEI)		+= mei/
 obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
diff --git a/drivers/misc/altera-a10sr-monitor.c b/drivers/misc/altera-a10sr-monitor.c
new file mode 100644
index 0000000..66338e0
--- /dev/null
+++ b/drivers/misc/altera-a10sr-monitor.c
@@ -0,0 +1,175 @@
+/*
+ * Altera Arria10 DevKit System Resource Chip Monitor Driver
+ *
+ * Author: Thor Thayer <tthayer@opensource.altera.com>
+ *
+ * Copyright Intel Corporation (C) 2014-2016. All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Monitor driver for the Altera Arria10 MAX5 System Resource Chip
+ * Adapted from ics932s401.c
+ */
+
+#include <linux/err.h>
+#include <linux/mfd/altera-a10sr.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct altr_a10sr_regs {
+	struct regmap		*regmap;
+	struct attribute_group	attr_grp;
+};
+
+static ssize_t a10sr_show(struct device *dev,
+			  struct device_attribute *devattr, char *buf);
+static ssize_t a10sr_store(struct device *dev,
+			   struct device_attribute *devattr, const char *buf,
+			   size_t count);
+
+/* Define FS entries */
+static DEVICE_ATTR(max5_version, 0444, a10sr_show, NULL);
+static DEVICE_ATTR(max5_led, 0644, a10sr_show, a10sr_store);
+static DEVICE_ATTR(max5_button, 0444, a10sr_show, NULL);
+static DEVICE_ATTR(max5_button_irq, 0644, a10sr_show, a10sr_store);
+static DEVICE_ATTR(max5_pg1, 0444, a10sr_show, NULL);
+static DEVICE_ATTR(max5_pg2, 0444, a10sr_show, NULL);
+static DEVICE_ATTR(max5_pg3, 0444, a10sr_show, NULL);
+static DEVICE_ATTR(max5_fmcab, 0444, a10sr_show, NULL);
+static DEVICE_ATTR(max5_hps_resets, 0644, a10sr_show, a10sr_store);
+static DEVICE_ATTR(max5_per_resets, 0644, a10sr_show, a10sr_store);
+static DEVICE_ATTR(max5_sfpa, 0644, a10sr_show, a10sr_store);
+static DEVICE_ATTR(max5_sfpb, 0644, a10sr_show, a10sr_store);
+static DEVICE_ATTR(max5_i2c_master, 0644, a10sr_show, a10sr_store);
+static DEVICE_ATTR(max5_wm_rst, 0644, a10sr_show, a10sr_store);
+static DEVICE_ATTR(max5_wm_rst_key, 0644, a10sr_show, a10sr_store);
+static DEVICE_ATTR(max5_pmbus, 0644, a10sr_show, a10sr_store);
+
+static struct attribute *altr_a10sr_attr[] = {
+	&dev_attr_max5_version.attr,
+	&dev_attr_max5_led.attr,
+	&dev_attr_max5_button.attr,
+	&dev_attr_max5_button_irq.attr,
+	&dev_attr_max5_pg1.attr,
+	&dev_attr_max5_pg2.attr,
+	&dev_attr_max5_pg3.attr,
+	&dev_attr_max5_fmcab.attr,
+	&dev_attr_max5_hps_resets.attr,
+	&dev_attr_max5_per_resets.attr,
+	&dev_attr_max5_sfpa.attr,
+	&dev_attr_max5_sfpb.attr,
+	&dev_attr_max5_i2c_master.attr,
+	&dev_attr_max5_wm_rst.attr,
+	&dev_attr_max5_wm_rst_key.attr,
+	&dev_attr_max5_pmbus.attr,
+	NULL
+};
+
+static const struct attribute_group a10sr_attr_group = {
+	.attrs = altr_a10sr_attr,
+};
+
+static ssize_t a10sr_show(struct device *dev, struct device_attribute *devattr,
+			  char *buf)
+{
+	int i, ret;
+	unsigned int val;
+	struct altr_a10sr_regs *a10sr_regs = dev_get_drvdata(dev);
+
+	for (i = 0; i < ARRAY_SIZE(altr_a10sr_attr); i++) {
+		if (devattr == (struct device_attribute *)altr_a10sr_attr[i])
+			break;
+	}
+
+	if (i >= ARRAY_SIZE(altr_a10sr_attr))
+		return -EINVAL;
+
+	/* Shift because LS bit set by regmap for Read */
+	i <<= 1;
+	ret = regmap_read(a10sr_regs->regmap, i, &val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "0x%X\n", val);
+}
+
+static ssize_t a10sr_store(struct device *dev,
+			   struct device_attribute *devattr, const char *buf,
+			   size_t count)
+{
+	struct altr_a10sr_regs *a10sr_regs = dev_get_drvdata(dev);
+	unsigned long val;
+	int i, ret;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(altr_a10sr_attr); i++) {
+		if (devattr == (struct device_attribute *)altr_a10sr_attr[i])
+			break;
+	}
+	if (i >= ARRAY_SIZE(altr_a10sr_attr))
+		return -EINVAL;
+
+	/* Shift because LS bit cleared by regmap for Write */
+	i <<= 1;
+	ret = regmap_write(a10sr_regs->regmap, i, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static int altr_a10sr_regs_probe(struct platform_device *pdev)
+{
+	struct altr_a10sr_regs *a10regs;
+	struct altr_a10sr *a10sr = dev_get_drvdata(pdev->dev.parent);
+
+	a10regs = devm_kzalloc(&pdev->dev, sizeof(*a10regs), GFP_KERNEL);
+	if (!a10regs)
+		return -ENOMEM;
+
+	a10regs->regmap = a10sr->regmap;
+	a10regs->attr_grp = a10sr_attr_group;
+
+	platform_set_drvdata(pdev, a10regs);
+
+	return sysfs_create_group(&pdev->dev.kobj, &a10sr_attr_group);
+}
+
+static int altr_a10sr_regs_remove(struct platform_device *pdev)
+{
+	struct altr_a10sr_regs *a10regs = platform_get_drvdata(pdev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &a10regs->attr_grp);
+
+	return 0;
+}
+
+static const struct of_device_id altr_a10sr_regs_of_match[] = {
+	{ .compatible = "altr,a10sr-monitor" },
+	{ },
+};
+
+static struct platform_driver altr_a10sr_regs_driver = {
+	.probe = altr_a10sr_regs_probe,
+	.remove = altr_a10sr_regs_remove,
+	.driver = {
+		.name = "a10sr_monitor",
+		.of_match_table = altr_a10sr_regs_of_match,
+	},
+};
+
+builtin_platform_driver(altr_a10sr_regs_driver);
-- 
1.9.1
