From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:45:07 +0200
Subject: [PATCH v3 19/30] iio: adc: sun4i-gpadc-iio: rework: support nvmem
 calibration data
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-20-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reworks the driver to support nvmem calibration cells.
The driver checks if the nvmem calibration is supported and reads out
the nvmem.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 18ab72e52d78..2fd73d143815 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -70,6 +71,7 @@ struct gpadc_data {
 	bool		has_mod_clk;
 	u32		temp_data_base;
 	int		sensor_count;
+	bool		supports_nvmem;
 };
 
 static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
@@ -146,6 +148,7 @@ struct sun4i_gpadc_iio {
 	struct clk			*bus_clk;
 	struct clk			*mod_clk;
 	struct reset_control		*reset;
+	u32				calibration_data[2];
 };
 
 static const struct iio_chan_spec sun4i_gpadc_channels[] = {
@@ -484,6 +487,9 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	struct resource *mem;
 	void __iomem *base;
 	int ret;
+	struct nvmem_cell *cell;
+	ssize_t cell_size;
+	u32 *cell_data;
 
 	info->data = of_device_get_match_data(&pdev->dev);
 	if (!info->data)
@@ -494,6 +500,24 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	if (info->data->supports_nvmem) {
+
+		cell = nvmem_cell_get(&pdev->dev, "calibration");
+		if (IS_ERR(cell)) {
+			if (PTR_ERR(cell) == -EPROBE_DEFER)
+				return PTR_ERR(cell);
+		} else {
+			cell_data = (u32 *)nvmem_cell_read(cell, &cell_size);
+			if (cell_size != 8)
+				dev_err(&pdev->dev,
+					"Calibration data has wrong size\n");
+			else {
+				info->calibration_data[0] = cell_data[0];
+				info->calibration_data[1] = cell_data[1];
+			}
+		}
+	}
+
 	if (info->data->has_bus_clk)
 		info->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus",
 				base, &sun4i_gpadc_regmap_config);
-- 
2.11.0
