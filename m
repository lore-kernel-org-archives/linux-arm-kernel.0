From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 28 Nov 2018 05:58:22 +0000
Subject: [PATCH V2 2/4] thermal: imx_sc: add i.MX system controller thermal
 support
In-Reply-To: <1543384349-2851-1-git-send-email-Anson.Huang@nxp.com>
References: <1543384349-2851-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1543384349-2851-3-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and thermal sensors etc..

This patch adds i.MX system controller thermal driver support,
Linux kernel has to communicate with system controller via MU
(message unit) IPC to get each thermal sensor's temperature,
it supports multiple sensors which are passed from device tree,
please see the binding doc for details.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	remove boiler plate license text;
	remove unnecessary kfree during probe;
	remove build warning of comparing unsigned int with < 0;
 drivers/thermal/Kconfig          |  11 +++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/imx_sc_thermal.c | 201 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/thermal/imx_sc_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0e69edc..84e850c 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -222,6 +222,17 @@ config IMX_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the
 	  passive trip is crossed.
 
+config IMX_SC_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on OF
+	help
+	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
+	  system controller inside, Linux kernel has to communicate with system
+	  controller via MU (message unit) IPC to get temperature from thermal
+	  sensor. It supports one critical trip point and one
+	  passive trip point for each thermal sensor.
+
 config MAX77620_THERMAL
 	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
 	depends on MFD_MAX77620
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 610344e..1b13f6a 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
+obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
new file mode 100644
index 0000000..890537f
--- /dev/null
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/err.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+#define IMX_SC_MISC_FUNC_GET_TEMP	13
+#define IMX_SC_C_TEMP			0
+
+struct imx_sc_ipc *thermal_ipc_handle;
+
+struct imx_sc_sensor {
+	struct thermal_zone_device *tzd;
+	u32 resource_id;
+};
+
+struct imx_sc_thermal_data {
+	struct imx_sc_sensor *sensor;
+};
+
+struct imx_sc_msg_req_misc_get_temp {
+	struct imx_sc_rpc_msg hdr;
+	u16 resource_id;
+	u8 type;
+} __packed;
+
+struct imx_sc_msg_resp_misc_get_temp {
+	struct imx_sc_rpc_msg hdr;
+	u16 celsius;
+	u8 tenths;
+} __packed;
+
+static int imx_sc_thermal_get_temp(void *data, int *temp)
+{
+	struct imx_sc_msg_resp_misc_get_temp *resp;
+	struct imx_sc_msg_req_misc_get_temp msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	struct imx_sc_sensor *sensor = data;
+	int ret;
+
+	msg.resource_id = sensor->resource_id;
+	msg.type = IMX_SC_C_TEMP;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_MISC;
+	hdr->func = IMX_SC_MISC_FUNC_GET_TEMP;
+	hdr->size = 2;
+
+	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("read temp sensor %d failed, ret %d\n",
+			sensor->resource_id, ret);
+		return ret;
+	}
+
+	resp = (struct imx_sc_msg_resp_misc_get_temp *)&msg;
+	*temp = resp->celsius * 1000 + resp->tenths * 100;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops imx_sc_thermal_ops = {
+	.get_temp = imx_sc_thermal_get_temp,
+};
+
+static int imx_sc_thermal_register_sensor(struct platform_device *pdev,
+					  struct imx_sc_sensor *sensor)
+{
+	struct thermal_zone_device *tzd;
+
+	tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
+						   sensor->resource_id,
+						   sensor,
+						   &imx_sc_thermal_ops);
+	if (IS_ERR(tzd)) {
+		dev_err(&pdev->dev, "failed to register sensor: %d\n",
+			sensor->resource_id);
+		return -EINVAL;
+	}
+
+	sensor->tzd = tzd;
+
+	return 0;
+}
+
+static int imx_sc_thermal_get_sensor_id(struct device_node *sensor_np, u32 *id)
+{
+	struct of_phandle_args sensor_specs;
+	int ret;
+
+	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
+			"#thermal-sensor-cells",
+			0, &sensor_specs);
+	if (ret)
+		return ret;
+
+	if (sensor_specs.args_count >= 1) {
+		*id = sensor_specs.args[0];
+		WARN(sensor_specs.args_count > 1,
+				"%pOFn: too many cells in sensor specifier %d\n",
+				sensor_specs.np, sensor_specs.args_count);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_sc_thermal_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *sensor_np = NULL;
+	struct imx_sc_thermal_data *data;
+	struct imx_sc_sensor *sensors;
+	u32 sensor_num;
+	int ret, i;
+
+	ret = imx_scu_get_handle(&thermal_ipc_handle);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		dev_err(&pdev->dev, "failed to get ipc handle: %d!\n", ret);
+		return ret;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(np, "tsens-num", &sensor_num);
+	if (ret || !sensor_num) {
+		dev_err(&pdev->dev, "failed to get valid temp sensor number!\n");
+		return -EINVAL;
+	}
+
+	sensors = devm_kzalloc(&pdev->dev, sizeof(*data->sensor) * sensor_num,
+			       GFP_KERNEL);
+	if (!sensors)
+		return -ENOMEM;
+
+	data->sensor = sensors;
+
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np)
+		return -ENODEV;
+
+	for (i = 0; i < sensor_num; i++) {
+		struct imx_sc_sensor *sensor = &data->sensor[i];
+
+		sensor_np = of_get_next_child(np, sensor_np);
+		ret = imx_sc_thermal_get_sensor_id(sensor_np, &sensor->resource_id);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"failed to get valid sensor resource id: %d\n",
+				ret);
+			break;
+		}
+
+		ret = imx_sc_thermal_register_sensor(pdev, sensor);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to register thermal sensor: %d\n",
+				ret);
+			break;
+		}
+	}
+
+	of_node_put(np);
+	of_node_put(sensor_np);
+
+	return ret;
+}
+
+static const struct of_device_id imx_sc_thermal_table[] = {
+	{ .compatible = "nxp,imx8qxp-sc-thermal", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
+
+static struct platform_driver imx_sc_thermal_driver = {
+		.probe = imx_sc_thermal_probe,
+		.driver = {
+			.name = "imx-sc-thermal",
+			.of_match_table = imx_sc_thermal_table,
+		},
+};
+module_platform_driver(imx_sc_thermal_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("Thermal driver for NXP i.MX SoCs with system controller");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
