From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:45:05 +0200
Subject: [PATCH v3 17/30] iio: adc: sun4i-gpadc-iio: rework: support clocks
 and reset
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-18-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For adding newer sensor some basic rework of the code is necessary.

The SoCs after H3 has newer thermal sensor ADCs, which have two clock
inputs (bus clock and sampling clock) and a reset. The registers are
also re-arranged.

This commit reworks the code, adds the process of the clocks and resets.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 72 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index c278e165e161..c12de48c4e86 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -22,6 +22,7 @@
  * shutdown for not being used.
  */
 
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -31,6 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/thermal.h>
 #include <linux/delay.h>
 
@@ -63,6 +65,9 @@ struct gpadc_data {
 	int		(*ths_suspend)(struct sun4i_gpadc_iio *info);
 	int		(*ths_resume)(struct sun4i_gpadc_iio *info);
 	bool		support_irq;
+	bool		has_bus_clk;
+	bool		has_bus_rst;
+	bool		has_mod_clk;
 	u32		temp_data_base;
 };
 
@@ -127,6 +132,9 @@ struct sun4i_gpadc_iio {
 	struct mutex			mutex;
 	struct thermal_zone_device	*tzd;
 	struct device			*sensor_device;
+	struct clk			*bus_clk;
+	struct clk			*mod_clk;
+	struct reset_control		*reset;
 };
 
 static const struct iio_chan_spec sun4i_gpadc_channels[] = {
@@ -472,8 +480,13 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					     &sun4i_gpadc_regmap_config);
+	if (info->data->has_bus_clk)
+		info->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus",
+				base, &sun4i_gpadc_regmap_config);
+	else
+		info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+				&sun4i_gpadc_regmap_config);
+
 	if (IS_ERR(info->regmap)) {
 		ret = PTR_ERR(info->regmap);
 		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
@@ -498,9 +511,58 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 		}
 	}
 
+	if (info->data->has_bus_rst) {
+		info->reset = devm_reset_control_get(&pdev->dev, NULL);
+		if (IS_ERR(info->reset)) {
+			ret = PTR_ERR(info->reset);
+			return ret;
+		}
+
+		ret = reset_control_deassert(info->reset);
+		if (ret)
+			return ret;
+	}
+
+	if (info->data->has_bus_clk) {
+		info->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		if (IS_ERR(info->bus_clk)) {
+			ret = PTR_ERR(info->bus_clk);
+			goto assert_reset;
+		}
+
+		ret = clk_prepare_enable(info->bus_clk);
+		if (ret)
+			goto assert_reset;
+	}
+
+	if (info->data->has_mod_clk) {
+		info->mod_clk = devm_clk_get(&pdev->dev, "mod");
+		if (IS_ERR(info->mod_clk)) {
+			ret = PTR_ERR(info->mod_clk);
+			goto disable_bus_clk;
+		}
+
+		/* Running at 4MHz */
+		ret = clk_set_rate(info->mod_clk, 4000000);
+		if (ret)
+			goto disable_bus_clk;
+
+		ret = clk_prepare_enable(info->mod_clk);
+		if (ret)
+			goto disable_bus_clk;
+	}
+
 	info->sensor_device = &pdev->dev;
 
 	return 0;
+
+disable_bus_clk:
+	clk_disable_unprepare(info->bus_clk);
+
+assert_reset:
+	reset_control_assert(info->reset);
+
+	return ret;
 }
 
 static int sun4i_gpadc_probe(struct platform_device *pdev)
@@ -586,6 +648,12 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	if (!info->data->support_irq)
 		iio_map_array_unregister(indio_dev);
 
+	clk_disable_unprepare(info->mod_clk);
+
+	clk_disable_unprepare(info->bus_clk);
+
+	reset_control_assert(info->reset);
+
 	return 0;
 }
 
-- 
2.11.0
