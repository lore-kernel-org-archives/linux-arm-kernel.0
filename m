From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sat, 18 Mar 2017 01:01:32 +0100
Subject: [PATCH 2/2] thermal: broadcom: add Raspberry Pi thermal driver
In-Reply-To: <20170318000132.9212-1-zajec5@gmail.com>
References: <20170318000132.9212-1-zajec5@gmail.com>
Message-ID: <20170318000132.9212-2-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Raspberry Pi devices use BCM283[567] SoCs with a thermal device inside.
Querying it is possible using Raspberry specific firmware interface.
This simple driver allows reading SoC temperature.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 drivers/thermal/Kconfig                        |  5 ++
 drivers/thermal/Makefile                       |  1 +
 drivers/thermal/broadcom/Kconfig               |  7 +++
 drivers/thermal/broadcom/Makefile              |  1 +
 drivers/thermal/broadcom/raspberrypi-thermal.c | 85 ++++++++++++++++++++++++++
 5 files changed, 99 insertions(+)
 create mode 100644 drivers/thermal/broadcom/Kconfig
 create mode 100644 drivers/thermal/broadcom/Makefile
 create mode 100644 drivers/thermal/broadcom/raspberrypi-thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 776b34396144..008e173ec825 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -392,6 +392,11 @@ config MTK_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Mediatek SoCs
 
+menu "Broadcom thermal drivers"
+depends on ARCH_BCM || COMPILE_TEST
+source "drivers/thermal/broadcom/Kconfig"
+endmenu
+
 menu "Texas Instruments thermal drivers"
 depends on ARCH_HAS_BANDGAP || COMPILE_TEST
 depends on HAS_IOMEM
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 7adae2029355..549d81b6363c 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -27,6 +27,7 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
 # platform thermal drivers
+obj-y				+= broadcom/
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
new file mode 100644
index 000000000000..03d52d1d1403
--- /dev/null
+++ b/drivers/thermal/broadcom/Kconfig
@@ -0,0 +1,7 @@
+config RASPBERRYPI_THERMAL
+	tristate "Raspberry Pi thermal driver"
+	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on RASPBERRYPI_FIRMWARE=y
+	help
+	  This enables support for the RPi power domains which can be enabled
+	  or disabled via the RPi firmware.
diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
new file mode 100644
index 000000000000..5ea7f8819b7d
--- /dev/null
+++ b/drivers/thermal/broadcom/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_RASPBERRYPI_THERMAL)	+= raspberrypi-thermal.o
diff --git a/drivers/thermal/broadcom/raspberrypi-thermal.c b/drivers/thermal/broadcom/raspberrypi-thermal.c
new file mode 100644
index 000000000000..d9c1db06f806
--- /dev/null
+++ b/drivers/thermal/broadcom/raspberrypi-thermal.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2017 Rafa? Mi?ecki <rafal@milecki.pl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+struct rpi_thermal {
+	struct rpi_firmware *fw;
+};
+
+static int rpi_thermal_get_temp(void *data, int *temp)
+{
+	struct rpi_thermal *rpi_thermal = data;
+	struct {
+		u32 id;
+		u32 temp;
+	} tag_data = {};
+	int err;
+
+	err = rpi_firmware_property(rpi_thermal->fw,
+				    RPI_FIRMWARE_GET_TEMPERATURE,
+				    &tag_data, sizeof(tag_data));
+	if (!err)
+		*temp = tag_data.temp;
+
+	return err;
+}
+
+const struct thermal_zone_of_device_ops rpi_thermal_ops = {
+	.get_temp = rpi_thermal_get_temp,
+};
+
+static int rpi_thermal_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rpi_thermal *rpi_thermal;
+	struct device_node *fw_np;
+	struct thermal_zone_device *tzd;
+
+	rpi_thermal = devm_kzalloc(dev, sizeof(*rpi_thermal), GFP_KERNEL);
+	if (!rpi_thermal)
+		return -ENOMEM;
+
+	fw_np = of_parse_phandle(dev->of_node, "firmware", 0);
+	if (!fw_np) {
+		dev_err(dev, "Failed to get firmware phandle\n");
+		return -ENOENT;
+	}
+
+	rpi_thermal->fw = rpi_firmware_get(fw_np);
+	of_node_put(fw_np);
+	if (!rpi_thermal->fw)
+		return -ENODEV;
+
+	tzd = devm_thermal_zone_of_sensor_register(dev, 0, rpi_thermal,
+						   &rpi_thermal_ops);
+
+	return PTR_ERR_OR_ZERO(tzd);
+}
+
+static const struct of_device_id rpi_thermal_of_match[] = {
+	{ .compatible = "raspberrypi,bcm2835-thermal", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rpi_thermal_of_match);
+
+static struct platform_driver rpi_thermal_driver = {
+	.probe		= rpi_thermal_probe,
+	.driver = {
+		.name = "raspberrypi-thermal",
+		.of_match_table = rpi_thermal_of_match,
+	},
+};
+module_platform_driver(rpi_thermal_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
