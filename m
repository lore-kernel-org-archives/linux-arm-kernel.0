From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Wed, 31 May 2017 02:19:56 -0700
Subject: [PATCH v2 linux-next 1/3] spi: imx: add selection for iMX53 and iMX6
 controller
In-Reply-To: <1496222398-3192-1-git-send-email-jiada_wang@mentor.com>
References: <1496222398-3192-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1496222398-3192-2-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

ECSPI contorller for iMX53 and iMX6 has few hardware issues
comparing to iMX51.
The change add possibility to detect which controller is used
to apply possible workaround and limitations.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
 drivers/spi/spi-imx.c                              | 46 ++++++++++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 31b5b21..5bf1396 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -9,6 +9,7 @@ Required properties:
   - "fsl,imx31-cspi" for SPI compatible with the one integrated on i.MX31
   - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
   - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
+  - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain CSPI/eCSPI interrupt
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b402530..765856c 100644
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
@@ -128,9 +129,32 @@ static inline int is_imx51_ecspi(struct spi_imx_data *d)
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
@@ -754,6 +778,15 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
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
@@ -774,6 +807,9 @@ static const struct platform_device_id spi_imx_devtype[] = {
 		.name = "imx51-ecspi",
 		.driver_data = (kernel_ulong_t) &imx51_ecspi_devtype_data,
 	}, {
+		.name = "imx53-ecspi",
+		.driver_data = (kernel_ulong_t) &imx53_ecspi_devtype_data,
+	}, {
 		/* sentinel */
 	}
 };
@@ -785,6 +821,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx31-cspi", .data = &imx31_cspi_devtype_data, },
 	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
 	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
+	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
@@ -1229,7 +1266,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx))
+	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
+	    is_imx53_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
 
 	spi_imx->spi_drctl = spi_drctl;
@@ -1282,7 +1320,7 @@ static int spi_imx_probe(struct platform_device *pdev)
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
