From: hramrach@gmail.com (Michal Suchanek)
Date: 26 May 2016 19:25:25 -0000
Subject: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <cover.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
Message-ID: <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

This patch adds support for 64 byte or bigger transfers on the
sun4i SPI controller. Said transfers will be performed via DMA.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Michal Suchanek <hramrach@gmail.com>

---
v2:
 - fallback to previous behaviour when DMA initialization fails

   + this has the problem that when the driver happens to load before the dma
     driver it will not use dma - can be addressed with a module parameter
 + the issue with dma_async_tx_descriptor *desc_tx = NULL, *desc_rx = NULL; ...
   dma_wait_for_async_tx(desc_rx); remains unaddressed

---
 drivers/spi/spi-sun4i.c | 171 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 158 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index e1a75dd6..ed2269c 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -14,6 +14,8 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -34,6 +36,7 @@
 #define SUN4I_CTL_CPHA				BIT(2)
 #define SUN4I_CTL_CPOL				BIT(3)
 #define SUN4I_CTL_CS_ACTIVE_LOW			BIT(4)
+#define SUN4I_CTL_DMAMC_DEDICATED		BIT(5)
 #define SUN4I_CTL_LMTF				BIT(6)
 #define SUN4I_CTL_TF_RST			BIT(8)
 #define SUN4I_CTL_RF_RST			BIT(9)
@@ -51,6 +54,8 @@
 #define SUN4I_INT_STA_REG		0x10
 
 #define SUN4I_DMA_CTL_REG		0x14
+#define SUN4I_DMA_CTL_RF_READY			BIT(0)
+#define SUN4I_DMA_CTL_TF_NOT_FULL		BIT(10)
 
 #define SUN4I_WAIT_REG			0x18
 
@@ -130,6 +135,13 @@ static inline void sun4i_spi_fill_fifo(struct sun4i_spi *sspi, int len)
 	}
 }
 
+static bool sun4i_spi_can_dma(struct spi_master *master,
+			      struct spi_device *spi,
+			      struct spi_transfer *tfr)
+{
+	return tfr->len >= SUN4I_FIFO_DEPTH;
+}
+
 static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct sun4i_spi *sspi = spi_master_get_devdata(spi->master);
@@ -177,17 +189,20 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 				  struct spi_transfer *tfr)
 {
 	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	struct dma_async_tx_descriptor *desc_tx = NULL, *desc_rx = NULL;
 	unsigned int mclk_rate, div, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
+	u32 reg, trigger = 0;
 	int ret = 0;
-	u32 reg;
 
-	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUN4I_FIFO_DEPTH)
-		return -EMSGSIZE;
-	if (tfr->tx_buf && tfr->len >= SUN4I_FIFO_DEPTH)
-		return -EMSGSIZE;
+	if (!master->can_dma) {
+		/* We don't support transfer larger than the FIFO */
+		if (tfr->len > SUN4I_FIFO_DEPTH)
+			return -EMSGSIZE;
+		if (tfr->tx_buf && tfr->len >= SUN4I_FIFO_DEPTH)
+			return -EMSGSIZE;
+	}
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
@@ -277,14 +292,67 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	sun4i_spi_write(sspi, SUN4I_BURST_CNT_REG, SUN4I_BURST_CNT(tfr->len));
 	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
 
-	/* Fill the TX FIFO */
-	/* Filling the FIFO fully causes timeout for some reason
-	 * at least on spi2 on A10s */
-	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
-
 	/* Enable the interrupts */
 	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
 
+	if (sun4i_spi_can_dma(master, spi, tfr)) {
+		dev_dbg(&sspi->master->dev, "Using DMA mode for transfer\n");
+
+		if (sspi->tx_buf) {
+			desc_tx = dmaengine_prep_slave_sg(master->dma_tx,
+					tfr->tx_sg.sgl, tfr->tx_sg.nents,
+					DMA_TO_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+			if (!desc_tx) {
+				dev_err(&sspi->master->dev,
+					"Couldn't prepare dma slave\n");
+				return -EIO;
+			}
+
+			trigger |= SUN4I_DMA_CTL_TF_NOT_FULL;
+
+			dmaengine_submit(desc_tx);
+			dma_async_issue_pending(master->dma_tx);
+
+		}
+
+		if (sspi->rx_buf) {
+			desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
+					tfr->rx_sg.sgl, tfr->rx_sg.nents,
+					DMA_FROM_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+			if (!desc_rx) {
+				dev_err(&sspi->master->dev,
+					"Couldn't prepare dma slave\n");
+				return -EIO;
+			}
+
+			trigger |= SUN4I_DMA_CTL_RF_READY;
+
+			dmaengine_submit(desc_rx);
+			dma_async_issue_pending(master->dma_rx);
+		}
+
+		/* Enable Dedicated DMA requests */
+		reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
+		reg |= SUN4I_CTL_DMAMC_DEDICATED;
+		sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
+		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, trigger);
+	} else {
+		dev_dbg(&sspi->master->dev, "Using PIO mode for transfer\n");
+
+		/* Disable DMA requests */
+		reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
+		sun4i_spi_write(sspi, SUN4I_CTL_REG,
+				reg & ~SUN4I_CTL_DMAMC_DEDICATED);
+		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, 0);
+
+		/* Fill the TX FIFO */
+		/* Filling the FIFO fully causes timeout for some reason
+		 * at least on spi2 on A10s */
+		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
+	}
+
 	/* Start the transfer */
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
@@ -304,7 +372,16 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 		goto out;
 	}
 
-	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
+	if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
+		/* The receive transfer should be the last one to finish */
+			/* This seems to work OK.
+			 * TODO: look for some drivers which do something
+			 * more sensible here. */
+		dma_wait_for_async_tx(desc_rx);
+	} else {
+		/* This should be noop with tx only dma */
+		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
+	}
 
 out:
 	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
@@ -369,6 +446,7 @@ static int sun4i_spi_runtime_suspend(struct device *dev)
 
 static int sun4i_spi_probe(struct platform_device *pdev)
 {
+	struct dma_slave_config dma_sconfig;
 	struct spi_master *master;
 	struct sun4i_spi *sspi;
 	struct resource	*res;
@@ -404,6 +482,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
+	init_completion(&sspi->done);
 	sspi->master = master;
 	master->max_speed_hz = 100*1000*1000;
 	master->min_speed_hz =        3*1000;
@@ -430,8 +509,55 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
-	init_completion(&sspi->done);
+	master->dma_tx = dma_request_slave_channel_reason(&pdev->dev, "tx");
+	if (IS_ERR(master->dma_tx)) {
+		dev_err(&pdev->dev, "Unable to acquire DMA channel TX\n");
+		ret = PTR_ERR(master->dma_tx);
+		master->dma_tx = NULL;
+		goto wakeup;
+	}
+
+	dma_sconfig.direction = DMA_MEM_TO_DEV;
+	dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.dst_addr = res->start + SUN4I_TXDATA_REG;
+	dma_sconfig.src_maxburst = 1;
+	dma_sconfig.dst_maxburst = 1;
 
+	ret = dmaengine_slave_config(master->dma_tx, &dma_sconfig);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to configure TX DMA slave\n");
+		goto err_tx_dma_release;
+	}
+
+	master->dma_rx = dma_request_slave_channel_reason(&pdev->dev, "rx");
+	if (IS_ERR(master->dma_rx)) {
+		dev_err(&pdev->dev, "Unable to acquire DMA channel RX\n");
+		ret = PTR_ERR(master->dma_rx);
+		goto err_tx_dma_release;
+	}
+
+	dma_sconfig.direction = DMA_DEV_TO_MEM;
+	dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.src_addr = res->start + SUN4I_RXDATA_REG;
+	dma_sconfig.src_maxburst = 1;
+	dma_sconfig.dst_maxburst = 1;
+
+	ret = dmaengine_slave_config(master->dma_rx, &dma_sconfig);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to configure RX DMA slave\n");
+		goto err_rx_dma_release;
+	}
+
+	/* This is a bit dodgy. If you set can_dma then map_msg in spi.c
+	 * apparently dereferences your dma channels if non-NULL even if your
+	 * can_dma never returns true (and crashes if the channel is an error
+	 * pointer). So just don't set can_dma unless both channels are valid.
+	 */
+	master->can_dma = sun4i_spi_can_dma;
+	master->max_transfer_size = NULL; /* no known limit */
+wakeup:
 	/*
 	 * This wake-up/shutdown pattern is to be able to have the
 	 * device woken up, even if runtime_pm is disabled
@@ -454,18 +580,37 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_rx_dma_release:
+	dma_release_channel(master->dma_rx);
+err_tx_dma_release:
+	dma_release_channel(master->dma_tx);
+	master->dma_tx = NULL;
+	master->dma_rx = NULL;
+	goto wakeup;
+
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	sun4i_spi_runtime_suspend(&pdev->dev);
 err_free_master:
+	if (master->can_dma) {
+		dma_release_channel(master->dma_rx);
+		dma_release_channel(master->dma_tx);
+	}
 	spi_master_put(master);
 	return ret;
 }
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_master *master = platform_get_drvdata(pdev);
+
 	pm_runtime_disable(&pdev->dev);
 
+	if (master->can_dma) {
+		dma_release_channel(master->dma_rx);
+		dma_release_channel(master->dma_tx);
+	}
+
 	return 0;
 }
 
-- 
2.8.1
