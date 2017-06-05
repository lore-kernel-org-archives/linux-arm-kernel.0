From: jiada_wang@mentor.com (Jiada Wang)
Date: Mon, 5 Jun 2017 12:38:06 +0900
Subject: [PATCH linux-next v3 1/4] spi: imx: introduce fifo_size and
 has_dmamode in spi_imx_devtype_data
In-Reply-To: <20170605033809.13726-1-jiada_wang@mentor.com>
References: <20170605033809.13726-1-jiada_wang@mentor.com>
Message-ID: <20170605033809.13726-2-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Different ECSPI controller has different fifosize and DMA capability,
instead of calling functions to identify these information by check
devtype. add fifo_size and has_dmamode to spi_imx_devtype_data.
so that these information can be directly accessed.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/spi/spi-imx.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b402530..e48989a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -78,6 +78,8 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	bool has_dmamode;
+	unsigned int fifo_size;
 	enum spi_imx_devtype devtype;
 };
 
@@ -128,11 +130,6 @@ static inline int is_imx51_ecspi(struct spi_imx_data *d)
 	return d->devtype_data->devtype == IMX51_ECSPI;
 }
 
-static inline unsigned spi_imx_get_fifosize(struct spi_imx_data *d)
-{
-	return is_imx51_ecspi(d) ? 64 : 8;
-}
-
 #define MXC_SPI_BUF_RX(type)						\
 static void spi_imx_buf_rx_##type(struct spi_imx_data *spi_imx)		\
 {									\
@@ -229,7 +226,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (bpw != 1 && bpw != 2 && bpw != 4)
 		return false;
 
-	for (i = spi_imx_get_fifosize(spi_imx) / 2; i > 0; i--) {
+	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
 		if (!(transfer->len % (i * bpw)))
 			break;
 	}
@@ -704,6 +701,8 @@ static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 	.trigger = mx1_trigger,
 	.rx_available = mx1_rx_available,
 	.reset = mx1_reset,
+	.fifo_size = 8,
+	.has_dmamode = false,
 	.devtype = IMX1_CSPI,
 };
 
@@ -713,6 +712,8 @@ static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
 	.reset = mx21_reset,
+	.fifo_size = 8,
+	.has_dmamode = false,
 	.devtype = IMX21_CSPI,
 };
 
@@ -723,6 +724,8 @@ static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
 	.reset = mx21_reset,
+	.fifo_size = 8,
+	.has_dmamode = false,
 	.devtype = IMX27_CSPI,
 };
 
@@ -732,6 +735,8 @@ static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
 	.reset = mx31_reset,
+	.fifo_size = 8,
+	.has_dmamode = false,
 	.devtype = IMX31_CSPI,
 };
 
@@ -742,6 +747,8 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
 	.reset = mx31_reset,
+	.fifo_size = 8,
+	.has_dmamode = true,
 	.devtype = IMX35_CSPI,
 };
 
@@ -751,6 +758,8 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
+	.fifo_size = 64,
+	.has_dmamode = true,
 	.devtype = IMX51_ECSPI,
 };
 
@@ -802,7 +811,7 @@ static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 
 static void spi_imx_push(struct spi_imx_data *spi_imx)
 {
-	while (spi_imx->txfifo < spi_imx_get_fifosize(spi_imx)) {
+	while (spi_imx->txfifo < spi_imx->devtype_data->fifo_size) {
 		if (!spi_imx->count)
 			break;
 		spi_imx->tx(spi_imx);
@@ -956,7 +965,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	if (of_machine_is_compatible("fsl,imx6dl"))
 		return 0;
 
-	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
+	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
 
 	/* Prepare for TX DMA: */
 	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
@@ -1282,7 +1291,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * Only validated on i.mx35 and i.mx6 now, can remove the constraint
 	 * if validated on other chips.
 	 */
-	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx)) {
+	if (spi_imx->devtype_data->has_dmamode) {
 		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
 		if (ret == -EPROBE_DEFER)
 			goto out_clk_put;
-- 
2.9.3
