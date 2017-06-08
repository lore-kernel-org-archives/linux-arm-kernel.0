From: jiada_wang@mentor.com (Jiada Wang)
Date: Thu, 8 Jun 2017 14:16:01 +0900
Subject: [PATCH linux-next v4 2/4] spi: imx: add selection for iMX53 and iMX6
 controller
In-Reply-To: <20170608051603.16070-1-jiada_wang@mentor.com>
References: <20170608051603.16070-1-jiada_wang@mentor.com>
Message-ID: <20170608051603.16070-3-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ECSPI contorller for iMX53 and iMX6 has few hardware issues
comparing to iMX51.
The change add possibility to detect which controller is used
to apply possible workaround and limitations.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
 drivers/spi/spi-imx.c                              | 26 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

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
index 4469121..8e6f339 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -63,7 +63,8 @@ enum spi_imx_devtype {
 	IMX27_CSPI,
 	IMX31_CSPI,
 	IMX35_CSPI,	/* CSPI on all i.mx except above */
-	IMX51_ECSPI,	/* ECSPI on i.mx51 and later */
+	IMX51_ECSPI,	/* ECSPI on i.mx51 */
+	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
 };
 
 struct spi_imx_data;
@@ -127,6 +128,11 @@ static inline int is_imx51_ecspi(struct spi_imx_data *d)
 	return d->devtype_data->devtype == IMX51_ECSPI;
 }
 
+static inline int is_imx53_ecspi(struct spi_imx_data *d)
+{
+	return d->devtype_data->devtype == IMX53_ECSPI;
+}
+
 #define MXC_SPI_BUF_RX(type)						\
 static void spi_imx_buf_rx_##type(struct spi_imx_data *spi_imx)		\
 {									\
@@ -752,6 +758,17 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.devtype = IMX51_ECSPI,
 };
 
+static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
+	.intctrl = mx51_ecspi_intctrl,
+	.config = mx51_ecspi_config,
+	.trigger = mx51_ecspi_trigger,
+	.rx_available = mx51_ecspi_rx_available,
+	.reset = mx51_ecspi_reset,
+	.fifo_size = 64,
+	.has_dmamode = true,
+	.devtype = IMX53_ECSPI,
+};
+
 static const struct platform_device_id spi_imx_devtype[] = {
 	{
 		.name = "imx1-cspi",
@@ -772,6 +789,9 @@ static const struct platform_device_id spi_imx_devtype[] = {
 		.name = "imx51-ecspi",
 		.driver_data = (kernel_ulong_t) &imx51_ecspi_devtype_data,
 	}, {
+		.name = "imx53-ecspi",
+		.driver_data = (kernel_ulong_t) &imx53_ecspi_devtype_data,
+	}, {
 		/* sentinel */
 	}
 };
@@ -783,6 +803,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx31-cspi", .data = &imx31_cspi_devtype_data, },
 	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
 	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
+	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
@@ -1218,7 +1239,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx))
+	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
+	    is_imx53_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
 
 	spi_imx->spi_drctl = spi_drctl;
-- 
2.9.3
