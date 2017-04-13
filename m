From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Thu, 13 Apr 2017 05:14:02 -0700
Subject: [PATCH RFC 3/5] spi: imx: add selection for iMX53 and iMX6 controller
In-Reply-To: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1492085644-4195-4-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

ECSPI contorller for iMX53 and iMX6 has few hardware issues
comparing to iMX51.
The change add possibility to detect which controller is used
to apply possible workaround and limitations.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/spi/spi-imx.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 9a7c62f..b2323b9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -67,7 +67,8 @@ enum spi_imx_devtype {
 	IMX27_CSPI,
 	IMX31_CSPI,
 	IMX35_CSPI,	/* CSPI on all i.mx except above */
-	IMX51_ECSPI,	/* ECSPI on i.mx51 and later */
+	IMX51_ECSPI,	/* ECSPI on i.mx51 */
+	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
 };
 
 struct spi_imx_data;
@@ -127,9 +128,32 @@ static inline int is_imx51_ecspi(struct spi_imx_data *d)
 	return d->devtype_data->devtype == IMX51_ECSPI;
 }
 
+static inline int is_imx53_ecspi(struct spi_imx_data *d)
+{
+	return d->devtype_data->devtype == IMX53_ECSPI;
+}
+
 static inline unsigned spi_imx_get_fifosize(struct spi_imx_data *d)
 {
-	return is_imx51_ecspi(d) ? 64 : 8;
+	switch (d->devtype_data->devtype) {
+	case IMX51_ECSPI:
+	case IMX53_ECSPI:
+		return 64;
+	default:
+		return 8;
+	}
+}
+
+static inline bool spi_imx_has_dmamode(struct spi_imx_data *d)
+{
+	switch (d->devtype_data->devtype) {
+	case IMX35_CSPI:
+	case IMX51_ECSPI:
+	case IMX53_ECSPI:
+		return true;
+	default:
+		return false;
+	}
 }
 
 #define MXC_SPI_BUF_RX(type)						\
@@ -746,6 +770,15 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.devtype = IMX51_ECSPI,
 };
 
+static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
+	.intctrl = mx51_ecspi_intctrl,
+	.config = mx51_ecspi_config,
+	.trigger = mx51_ecspi_trigger,
+	.rx_available = mx51_ecspi_rx_available,
+	.reset = mx51_ecspi_reset,
+	.devtype = IMX53_ECSPI,
+};
+
 static const struct platform_device_id spi_imx_devtype[] = {
 	{
 		.name = "imx1-cspi",
@@ -766,6 +799,9 @@ static const struct platform_device_id spi_imx_devtype[] = {
 		.name = "imx51-ecspi",
 		.driver_data = (kernel_ulong_t) &imx51_ecspi_devtype_data,
 	}, {
+		.name = "imx53-ecspi",
+		.driver_data = (kernel_ulong_t) &imx53_ecspi_devtype_data,
+	}, {
 		/* sentinel */
 	}
 };
@@ -777,6 +813,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx31-cspi", .data = &imx31_cspi_devtype_data, },
 	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
 	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
+	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
@@ -1266,7 +1303,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * Only validated on i.mx35 and i.mx6 now, can remove the constraint
 	 * if validated on other chips.
 	 */
-	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx)) {
+	if (spi_imx_has_dmamode(spi_imx)) {
 		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
 		if (ret == -EPROBE_DEFER)
 			goto out_clk_put;
-- 
2.7.4
