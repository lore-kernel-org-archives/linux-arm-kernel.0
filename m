From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Jun 2012 10:23:00 +0200
Subject: [PATCH 8/8] mmc: spi: Add DMA support into SPI driver
In-Reply-To: <1340958180-2291-1-git-send-email-marex@denx.de>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
Message-ID: <1340958180-2291-8-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <rob.herring@calxeda.com>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 drivers/spi/spi-mxs.c |  229 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 214 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index a7d2ebc..9f6d31a 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -36,6 +36,7 @@
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -55,8 +56,12 @@
 
 #define SSP_TIMEOUT		1000	/* 1000 ms */
 
+#define SG_NUM			4
+#define SG_MAXLEN		0xff00
+
 struct mxs_spi {
 	struct mxs_ssp		ssp;
+	struct completion	c;
 };
 
 static int mxs_spi_setup_transfer(struct spi_device *dev,
@@ -192,6 +197,115 @@ static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool set)
 	return 0;
 }
 
+static void mxs_ssp_dma_irq_callback(void *param)
+{
+	struct mxs_spi *spi = param;
+	complete(&spi->c);
+}
+
+static irqreturn_t mxs_ssp_irq_handler(int irq, void *dev_id)
+{
+	struct mxs_ssp *ssp = dev_id;
+	dev_err(ssp->dev, "%s[%i] CTRL1=%08x STATUS=%08x\n",
+		__func__, __LINE__,
+		readl(ssp->base + HW_SSP_CTRL1(ssp)),
+		readl(ssp->base + HW_SSP_STATUS(ssp)));
+	return IRQ_HANDLED;
+}
+
+static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
+			    unsigned char *buf, int len,
+			    int *first, int *last, int write)
+{
+	struct mxs_ssp *ssp = &spi->ssp;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist sg[SG_NUM];
+	int sg_count;
+	uint32_t pio = BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
+	int ret;
+
+	if (len > SG_NUM * SG_MAXLEN) {
+		dev_err(ssp->dev, "Data chunk too big for DMA\n");
+		return -EINVAL;
+	}
+
+	init_completion(&spi->c);
+
+	if (*first)
+		pio |= BM_SSP_CTRL0_LOCK_CS;
+	if (*last)
+		pio |= BM_SSP_CTRL0_IGNORE_CRC;
+	if (!write)
+		pio |= BM_SSP_CTRL0_READ;
+
+	if (ssp->devid == IMX23_SSP)
+		pio |= len;
+	else
+		writel(len, ssp->base + HW_SSP_XFER_SIZE);
+
+	/* Queue the PIO register write transfer. */
+	desc = dmaengine_prep_slave_sg(ssp->dmach,
+			(struct scatterlist *)&pio,
+			1, DMA_TRANS_NONE, 0);
+	if (!desc) {
+		dev_err(ssp->dev,
+			"Failed to get PIO reg. write descriptor.\n");
+		return -EINVAL;
+	}
+
+	/* Queue the DMA data transfer. */
+	sg_init_table(sg, (len / SG_MAXLEN) + 1);
+	sg_count = 0;
+	while (len) {
+		sg_set_buf(&sg[sg_count++], buf, min(len, SG_MAXLEN));
+		len -= min(len, SG_MAXLEN);
+		buf += min(len, SG_MAXLEN);
+	}
+	dma_map_sg(ssp->dev, sg, sg_count,
+		write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+	desc = dmaengine_prep_slave_sg(ssp->dmach, sg, sg_count,
+			write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+
+	if (!desc) {
+		dev_err(ssp->dev,
+			"Failed to get DMA data write descriptor.\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/*
+	 * The last descriptor must have this callback,
+	 * to finish the DMA transaction.
+	 */
+	desc->callback = mxs_ssp_dma_irq_callback;
+	desc->callback_param = spi;
+
+	/* Start the transfer. */
+	dmaengine_submit(desc);
+	dma_async_issue_pending(ssp->dmach);
+
+	ret = wait_for_completion_timeout(&spi->c,
+				msecs_to_jiffies(SSP_TIMEOUT));
+
+	if (!ret) {
+		dev_err(ssp->dev, "DMA transfer timeout\n");
+		ret = -ETIMEDOUT;
+		goto err;
+	}
+
+	ret = 0;
+
+err:
+	for (--sg_count; sg_count >= 0; sg_count--) {
+		dma_unmap_sg(ssp->dev, &sg[sg_count], 1,
+			write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	}
+
+	return ret;
+}
+
 static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 			    unsigned char *buf, int len,
 			    int *first, int *last, int write)
@@ -276,18 +390,48 @@ static int mxs_spi_transfer_one(struct spi_master *host, struct spi_message *m)
 			first = 1;
 		if (&t->transfer_list == m->transfers.prev)
 			last = 1;
-		if (t->rx_buf && t->tx_buf) {
+		if ((t->rx_buf && t->tx_buf) || (t->rx_dma && t->tx_dma)) {
 			dev_err(ssp->dev,
 				"Cannot send and receive simultaneously\n");
 			return -EINVAL;
 		}
 
-		if (t->tx_buf)
-			status = mxs_spi_txrx_pio(spi, cs, (void *)t->tx_buf,
-					     t->len, &first, &last, 1);
-		if (t->rx_buf)
-			status = mxs_spi_txrx_pio(spi, cs, t->rx_buf,
-					     t->len, &first, &last, 0);
+		/*
+		 * Small blocks can be transfered via PIO.
+		 * Measured by empiric means:
+		 *
+		 * dd if=/dev/mtdblock0 of=/dev/null bs=1024k count=1
+		 *
+		 * DMA only: 2.164808 seconds, 473.0KB/s
+		 * Combined: 1.676276 seconds, 610.9KB/s
+		 */
+		if (t->len <= 256) {
+			writel(BM_SSP_CTRL1_DMA_ENABLE,
+				ssp->base + HW_SSP_CTRL1(ssp) +
+				STMP_OFFSET_REG_CLR);
+
+			if (t->tx_buf)
+				status = mxs_spi_txrx_pio(spi, cs,
+						(void *)t->tx_buf,
+						t->len, &first, &last, 1);
+			if (t->rx_buf)
+				status = mxs_spi_txrx_pio(spi, cs,
+						t->rx_buf, t->len,
+						&first, &last, 0);
+		} else {
+			writel(BM_SSP_CTRL1_DMA_ENABLE,
+				ssp->base + HW_SSP_CTRL1(ssp) +
+				STMP_OFFSET_REG_SET);
+
+			if (t->tx_buf)
+				status = mxs_spi_txrx_dma(spi, cs,
+						(void *)t->tx_buf, t->len,
+						&first, &last, 1);
+			if (t->rx_buf)
+				status = mxs_spi_txrx_dma(spi, cs,
+						t->rx_buf, t->len,
+						&first, &last, 0);
+		}
 
 		m->actual_length += t->len;
 		if (status)
@@ -302,6 +446,21 @@ static int mxs_spi_transfer_one(struct spi_master *host, struct spi_message *m)
 	return status;
 }
 
+static bool mxs_ssp_dma_filter(struct dma_chan *chan, void *param)
+{
+	struct mxs_ssp *ssp = param;
+
+	if (!mxs_dma_is_apbh(chan))
+		return false;
+
+	if (chan->chan_id != ssp->dma_channel)
+		return false;
+
+	chan->private = &ssp->dma_data;
+
+	return true;
+}
+
 static const struct of_device_id mxs_spi_dt_ids[] = {
 	{ .compatible = "fsl,imx23-spi", .data = (void *) IMX23_SSP, },
 	{ .compatible = "fsl,imx28-spi", .data = (void *) IMX28_SSP, },
@@ -317,15 +476,19 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 	struct spi_master *host;
 	struct mxs_spi *spi;
 	struct mxs_ssp *ssp;
-	struct resource *iores;
+	struct resource *iores, *dmares;
 	struct pinctrl *pinctrl;
 	struct clk *clk;
 	void __iomem *base;
-	int devid;
-	int ret = 0;
+	int devid, dma_channel;
+	int ret = 0, irq_err, irq_dma;
+	dma_cap_mask_t mask;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iores)
+	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	irq_err = platform_get_irq(pdev, 0);
+	irq_dma = platform_get_irq(pdev, 1);
+	if (!iores || irq_err < 0 || irq_dma < 0)
 		return -EINVAL;
 
 	base = devm_request_and_ioremap(&pdev->dev, iores);
@@ -340,10 +503,23 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	if (np)
+	if (np) {
 		devid = (enum mxs_ssp_id) of_id->data;
-	else
+		/*
+		 * TODO: This is a temporary solution and should be changed
+		 * to use generic DMA binding later when the helpers get in.
+		 */
+		ret = of_property_read_u32(np, "fsl,ssp-dma-channel",
+					   &dma_channel);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to get DMA channel\n");
+			return -EINVAL;
+		}
+	} else {
 		devid = pdev->id_entry->driver_data;
+		dma_channel = dmares->start;
+	}
 
 	host = spi_alloc_master(&pdev->dev, sizeof(*spi));
 	if (!host)
@@ -363,8 +539,28 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 	ssp->clk = clk;
 	ssp->base = base;
 	ssp->devid = devid;
+	ssp->dma_channel = dma_channel;
+
+	ret = devm_request_irq(&pdev->dev, irq_err, mxs_ssp_irq_handler, 0,
+			       DRIVER_NAME, ssp);
+	if (ret)
+		goto out_host_free;
 
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	ssp->dma_data.chan_irq = irq_dma;
+	ssp->dmach = dma_request_channel(mask, mxs_ssp_dma_filter, ssp);
+	if (!ssp->dmach) {
+		dev_err(ssp->dev, "Failed to request DMA\n");
+		goto out_host_free;
+	}
+
+	/*
+	 * Crank up the clock to 120MHz, this will be further divided onto a
+	 * proper speed.
+	 */
 	clk_prepare_enable(ssp->clk);
+	clk_set_rate(ssp->clk, 120 * 1000 * 1000);
 	ssp->clk_rate = clk_get_rate(ssp->clk) / 1000;
 
 	stmp_reset_block(ssp->base);
@@ -374,15 +570,18 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 	ret = spi_register_master(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register SPI master, %d\n", ret);
-		goto out_host_free;
+		goto out_free_dma;
 	}
 
 	return 0;
 
-out_host_free:
+out_free_dma:
+	dma_release_channel(ssp->dmach);
 	clk_disable_unprepare(ssp->clk);
+out_host_free:
 	spi_master_put(host);
 	kfree(host);
+
 	return ret;
 }
 
-- 
1.7.10
