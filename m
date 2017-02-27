From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 28 Feb 2017 03:40:53 +0800
Subject: [PATCH 2/3] thermal: add support for the thermal sensor on Allwinner
 new SoCs
In-Reply-To: <20170227194054.51951-1-icenowy@aosc.xyz>
References: <20170227194054.51951-1-icenowy@aosc.xyz>
Message-ID: <20170227194054.51951-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

Allwinner SoCs from H3 (including H5, A64, etc) have a new version of
thermal sensor, and needs a new driver for it.

Add such a driver.

Currently only H3 is supported, but other SoCs are easily to be
supported by adding new formula and set the sensor number.

Signed-off-by: Ond?ej Jirman <megous@megous.com>
[Icenowy: extend to support further multiple-sensor SoCs, change commit
 message]
Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/thermal/Kconfig     |  11 ++
 drivers/thermal/Makefile    |   1 +
 drivers/thermal/sun8i_ths.c | 332 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+)
 create mode 100644 drivers/thermal/sun8i_ths.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 776b34396144..c9a04575acdc 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -392,6 +392,17 @@ config MTK_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Mediatek SoCs
 
+config SUN8I_THS
+	tristate "Thermal sensor driver for new Allwinner SoCs"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on NVMEM_SUNXI_SID
+	depends on OF
+	depends on RESET_CONTROLLER
+	help
+	  Enable this option if you want to have support for thermal reporting
+	  on some newer Allwinner SoCs.
+
 menu "Texas Instruments thermal drivers"
 depends on ARCH_HAS_BANDGAP || COMPILE_TEST
 depends on HAS_IOMEM
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 7adae2029355..2da2a010795f 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -56,5 +56,6 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom/
 obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
+obj-$(CONFIG_SUN8I_THS)		+= sun8i_ths.o
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
diff --git a/drivers/thermal/sun8i_ths.c b/drivers/thermal/sun8i_ths.c
new file mode 100644
index 000000000000..1d3763ccece4
--- /dev/null
+++ b/drivers/thermal/sun8i_ths.c
@@ -0,0 +1,332 @@
+/*
+ * Thermal sensor driver for Allwinner new SoCs
+ *
+ * Copyright (C) 2016 Ond?ej Jirman
+ * Based on the work of Josef Gajdusek <atx@atx.name>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/printk.h>
+
+#define THS_H3_MAX_SENSOR_NUM	4
+
+#define THS_H3_CTRL0		0x00
+#define THS_H3_CTRL2		0x40
+#define THS_H3_INT_CTRL		0x44
+#define THS_H3_STAT		0x48
+#define THS_H3_FILTER		0x70
+#define THS_H3_CDATA0		0x74
+#define THS_H3_CDATA1		0x74
+#define THS_H3_DATA(n)		(0x80 + 4 * (n))
+
+#define THS_H3_CTRL0_SENSOR_ACQ0(x)	(x)
+#define THS_H3_CTRL2_SENSE_EN(n)	BIT(0 + (n))
+#define THS_H3_CTRL2_SENSOR_ACQ1(x)	((x) << 16)
+#define THS_H3_INT_CTRL_DATA_IRQ_EN(n)	BIT(8 + (n))
+#define THS_H3_INT_CTRL_THERMAL_PER(x)	((x) << 12)
+#define THS_H3_STAT_DATA_IRQ_STS(n)	BIT(8 + (n))
+#define THS_H3_FILTER_TYPE(x)		((x) << 0)
+#define THS_H3_FILTER_EN		BIT(2)
+
+#define THS_H3_CLK_IN		40000000 /* Hz */
+#define THS_H3_DATA_PERIOD	330 /* ms */
+
+#define THS_H3_FILTER_TYPE_VALUE	2 /* average over 2^(n+1) samples */
+#define THS_H3_FILTER_DIV		(1 << (THS_H3_FILTER_TYPE_VALUE + 1))
+#define THS_H3_INT_CTRL_THERMAL_PER_VALUE \
+	(THS_H3_DATA_PERIOD * (THS_H3_CLK_IN / 1000) / THS_H3_FILTER_DIV / 4096 - 1)
+#define THS_H3_CTRL0_SENSOR_ACQ0_VALUE	0x3f /* 16us */
+#define THS_H3_CTRL2_SENSOR_ACQ1_VALUE	0x3f
+
+struct sun8i_ths_data;
+
+struct sun8i_ths_sensor {
+	struct sun8i_ths_data *data;
+	int id;
+	struct thermal_zone_device *tzd;
+	u32 val;
+};
+
+struct sun8i_ths_cfg {
+	int sensor_num;
+	int (*calc_temp)(u32 val);
+};
+
+struct sun8i_ths_data {
+	struct reset_control *reset;
+	struct clk *clk;
+	struct clk *busclk;
+	void __iomem *regs;
+	struct nvmem_cell *calcell;
+	const struct sun8i_ths_cfg *cfg;
+	struct sun8i_ths_sensor sensors[THS_H3_MAX_SENSOR_NUM];
+};
+
+static int sun8i_ths_calc_temp_h3(u32 val)
+{
+	return (217000 - (int)((val * 1000000) / 8253));
+}
+
+static int sun8i_ths_get_temp(void *_data, int *out)
+{
+	struct sun8i_ths_sensor *sensor = _data;
+
+	if (sensor->val == 0)
+		return -EBUSY;
+
+	/* Formula and parameters from the Allwinner 3.4 kernel */
+	*out = sensor->data->cfg->calc_temp(sensor->val);
+	return 0;
+}
+
+static irqreturn_t sun8i_ths_irq_thread(int irq, void *_data)
+{
+	struct sun8i_ths_data *data = _data;
+	int i;
+
+	for (i = 0; i < data->cfg->sensor_num; i++) {
+		if (!(readl(data->regs + THS_H3_STAT) &
+		      THS_H3_STAT_DATA_IRQ_STS(i)))
+			continue;
+
+		writel(THS_H3_STAT_DATA_IRQ_STS(i), data->regs + THS_H3_STAT);
+
+		data->sensors[i].val = readl(data->regs + THS_H3_DATA(i));
+		if (data->sensors[i].val)
+			thermal_zone_device_update(data->sensors[i].tzd,
+						   THERMAL_EVENT_TEMP_SAMPLE);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void sun8i_ths_init(struct sun8i_ths_data *data)
+{
+	u32 val;
+	int i;
+
+	writel(THS_H3_CTRL0_SENSOR_ACQ0(THS_H3_CTRL0_SENSOR_ACQ0_VALUE),
+		data->regs + THS_H3_CTRL0);
+	writel(THS_H3_FILTER_EN | THS_H3_FILTER_TYPE(THS_H3_FILTER_TYPE_VALUE),
+		data->regs + THS_H3_FILTER);
+
+	val = THS_H3_CTRL2_SENSOR_ACQ1(THS_H3_CTRL2_SENSOR_ACQ1_VALUE);
+	for (i = 0; i < data->cfg->sensor_num; i++)
+		val |= THS_H3_CTRL2_SENSE_EN(i);
+	writel(val, data->regs + THS_H3_CTRL2);
+
+	val = THS_H3_INT_CTRL_THERMAL_PER(THS_H3_INT_CTRL_THERMAL_PER_VALUE);
+	for (i = 0; i < data->cfg->sensor_num; i++)
+		val |= THS_H3_INT_CTRL_DATA_IRQ_EN(i);
+	writel(val, data->regs + THS_H3_INT_CTRL);
+}
+
+static int sun8i_ths_calibrate(struct sun8i_ths_data *data)
+{
+	u32 *caldata;
+	size_t callen;
+
+	caldata = nvmem_cell_read(data->calcell, &callen);
+	if (IS_ERR(caldata))
+		return PTR_ERR(caldata);
+
+	writel(be32_to_cpu(caldata[0]), data->regs + THS_H3_CDATA0);
+	if (callen > 4)
+		writel(be32_to_cpu(caldata[1]), data->regs + THS_H3_CDATA1);
+
+	kfree(caldata);
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops sun8i_ths_thermal_ops = {
+	.get_temp = sun8i_ths_get_temp,
+};
+
+static int sun8i_ths_probe(struct platform_device *pdev)
+{
+	struct sun8i_ths_data *data;
+	struct resource *res;
+	int ret, irq, i;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->cfg = of_device_get_match_data(&pdev->dev);
+	if (!data->cfg)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no memory resources defined\n");
+		return -EINVAL;
+	}
+
+	data->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->regs)) {
+		ret = PTR_ERR(data->regs);
+		dev_err(&pdev->dev, "failed to ioremap THS registers: %d\n", ret);
+		return ret;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
+		return irq;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					sun8i_ths_irq_thread, IRQF_ONESHOT,
+					dev_name(&pdev->dev), data);
+	if (ret)
+		return ret;
+
+	data->busclk = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(data->busclk)) {
+		ret = PTR_ERR(data->busclk);
+		dev_err(&pdev->dev, "failed to get ahb clk: %d\n", ret);
+		return ret;
+	}
+
+	data->clk = devm_clk_get(&pdev->dev, "ths");
+	if (IS_ERR(data->clk)) {
+		ret = PTR_ERR(data->clk);
+		dev_err(&pdev->dev, "failed to get ths clk: %d\n", ret);
+		return ret;
+	}
+
+	data->reset = devm_reset_control_get(&pdev->dev, "ahb");
+	if (IS_ERR(data->reset)) {
+		ret = PTR_ERR(data->reset);
+		dev_err(&pdev->dev, "failed to get reset: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_deassert(data->reset);
+	if (ret) {
+		dev_err(&pdev->dev, "reset deassert failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(data->busclk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable bus clk: %d\n", ret);
+		goto err_assert_reset;
+	}
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable ths clk: %d\n", ret);
+		goto err_disable_bus;
+	}
+
+	ret = clk_set_rate(data->clk, THS_H3_CLK_IN);
+	if (ret)
+		goto err_disable_ths;
+
+	data->calcell = devm_nvmem_cell_get(&pdev->dev, "cal");
+	if (IS_ERR(data->calcell)) {
+		if (PTR_ERR(data->calcell) == -EPROBE_DEFER) {
+			ret = PTR_ERR(data->calcell);
+			goto err_disable_ths;
+		}
+		/*
+		 * Even if the external calibration data stored in eFUSE is
+		 * not accessible, the THS hardware can still work, although
+		 * the data won't be so accurate.
+		 * The default value of calibration register is 0x800 for
+		 * every sensor, and the calibration value is usually 0x7xx
+		 * or 0x8xx, so they won't be away from the default value
+		 * for a lot.
+		 * So here we do not return if the calibartion data is not
+		 * available, except the probe needs deferring.
+		 */
+	} else {
+		ret = sun8i_ths_calibrate(data);
+		if (ret)
+			goto err_disable_ths;
+	}
+
+	for (i = 0; i < data->cfg->sensor_num; i++) {
+		data->sensors[i].data = data;
+		data->sensors[i].id = i;
+		data->sensors[i].tzd =
+			devm_thermal_zone_of_sensor_register(&pdev->dev,
+				i, &data->sensors[i], &sun8i_ths_thermal_ops);
+		if (IS_ERR(data->sensors[i].tzd)) {
+			ret = PTR_ERR(data->sensors[i].tzd);
+			dev_err(&pdev->dev,
+				"failed to register thermal zone %d: %d\n",
+				i, ret);
+			goto err_disable_ths;
+		}
+	}
+
+	sun8i_ths_init(data);
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+
+err_disable_ths:
+	clk_disable_unprepare(data->clk);
+err_disable_bus:
+	clk_disable_unprepare(data->busclk);
+err_assert_reset:
+	reset_control_assert(data->reset);
+	return ret;
+}
+
+static int sun8i_ths_remove(struct platform_device *pdev)
+{
+	struct sun8i_ths_data *data = platform_get_drvdata(pdev);
+
+	reset_control_assert(data->reset);
+	clk_disable_unprepare(data->clk);
+	clk_disable_unprepare(data->busclk);
+	return 0;
+}
+
+static const struct sun8i_ths_cfg sun8i_h3_ths_cfg = {
+	.sensor_num = 1,
+	.calc_temp = sun8i_ths_calc_temp_h3,
+};
+
+static const struct of_device_id sun8i_ths_id_table[] = {
+	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths_cfg },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, sun8i_ths_id_table);
+
+static struct platform_driver sun8i_ths_driver = {
+	.probe = sun8i_ths_probe,
+	.remove = sun8i_ths_remove,
+	.driver = {
+		.name = "sun8i_ths",
+		.of_match_table = sun8i_ths_id_table,
+	},
+};
+
+module_platform_driver(sun8i_ths_driver);
+
+MODULE_AUTHOR("Ond?ej Jirman <megous@megous.com>");
+MODULE_DESCRIPTION("Thermal sensor driver for new Allwinner SoCs");
+MODULE_LICENSE("GPL v2");
-- 
2.11.1
