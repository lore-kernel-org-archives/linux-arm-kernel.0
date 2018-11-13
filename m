From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 13 Nov 2018 11:22:25 +0100
Subject: [PATCH v3 3/6] spi: pxa2xx: Add slave mode support
In-Reply-To: <20181113102228.820214-1-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
Message-ID: <20181113102228.820214-4-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on an OLPC XO-1.75 machine, where the Embedded Controller happens
to be a SPI master.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/spi/spi-pxa2xx.c       | 81 +++++++++++++++++++++++++++++++---
 include/linux/spi/pxa2xx_spi.h |  1 +
 2 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 612cc49db28f..54ae77f1227c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -626,6 +626,11 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 		return IRQ_HANDLED;
 	}
 
+	if (irq_status & SSSR_TUR) {
+		int_error_stop(drv_data, "interrupt_transfer: fifo underrun");
+		return IRQ_HANDLED;
+	}
+
 	if (irq_status & SSSR_TINT) {
 		pxa2xx_spi_write(drv_data, SSSR, SSSR_TINT);
 		if (drv_data->read(drv_data)) {
@@ -1073,6 +1078,11 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
 
+	if (spi_controller_is_slave(master)) {
+		while (drv_data->write(drv_data))
+			;
+	}
+
 	/*
 	 * Release the data by enabling service requests and interrupts,
 	 * without changing any mode bits
@@ -1082,6 +1092,27 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 	return 1;
 }
 
+static int pxa2xx_spi_slave_abort(struct spi_master *master)
+{
+	struct driver_data *drv_data = spi_controller_get_devdata(master);
+
+	/* Stop and reset SSP */
+	write_SSSR_CS(drv_data, drv_data->clear_sr);
+	reset_sccr1(drv_data);
+	if (!pxa25x_ssp_comp(drv_data))
+		pxa2xx_spi_write(drv_data, SSTO, 0);
+	pxa2xx_spi_flush(drv_data);
+	pxa2xx_spi_write(drv_data, SSCR0,
+			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+
+	dev_dbg(&drv_data->pdev->dev, "transfer aborted\n");
+
+	drv_data->master->cur_msg->status = -EINTR;
+	spi_finalize_current_transfer(drv_data->master);
+
+	return 0;
+}
+
 static void pxa2xx_spi_handle_err(struct spi_controller *master,
 				 struct spi_message *msg)
 {
@@ -1209,9 +1240,14 @@ static int setup(struct spi_device *spi)
 		rx_thres = config->rx_threshold;
 		break;
 	default:
-		tx_thres = TX_THRESH_DFLT;
 		tx_hi_thres = 0;
-		rx_thres = RX_THRESH_DFLT;
+		if (spi_controller_is_slave(drv_data->master)) {
+			tx_thres = 1;
+			rx_thres = 2;
+		} else {
+			tx_thres = TX_THRESH_DFLT;
+			rx_thres = RX_THRESH_DFLT;
+		}
 		break;
 	}
 
@@ -1255,6 +1291,12 @@ static int setup(struct spi_device *spi)
 		if (chip_info->enable_loopback)
 			chip->cr1 = SSCR1_LBM;
 	}
+	if (spi_controller_is_slave(drv_data->master)) {
+		chip->cr1 |= SSCR1_SCFR;
+		chip->cr1 |= SSCR1_SCLKDIR;
+		chip->cr1 |= SSCR1_SFRMDIR;
+		chip->cr1 |= SSCR1_SPH;
+	}
 
 	chip->lpss_rx_threshold = SSIRF_RxThresh(rx_thres);
 	chip->lpss_tx_threshold = SSITF_TxLoThresh(tx_thres)
@@ -1494,6 +1536,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	}
 #endif
 
+#if CONFIG_OF
+	if (of_id) {
+		pdata->is_slave = of_property_read_bool(pdev->dev.of_node,
+								"spi-slave");
+	}
+#endif
+
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	ssp->irq = platform_get_irq(pdev, 0);
 	ssp->type = type;
@@ -1559,7 +1608,11 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	master = spi_alloc_master(dev, sizeof(struct driver_data));
+	if (platform_info->is_slave)
+		master = spi_alloc_slave(dev, sizeof(struct driver_data));
+	else
+		master = spi_alloc_master(dev, sizeof(struct driver_data));
+
 	if (!master) {
 		dev_err(&pdev->dev, "cannot alloc spi_master\n");
 		pxa_ssp_free(ssp);
@@ -1581,6 +1634,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->setup = setup;
 	master->set_cs = pxa2xx_spi_set_cs;
 	master->transfer_one = pxa2xx_spi_transfer_one;
+	master->slave_abort = pxa2xx_spi_slave_abort;
 	master->handle_err = pxa2xx_spi_handle_err;
 	master->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
 	master->fw_translate_cs = pxa2xx_spi_fw_translate_cs;
@@ -1610,7 +1664,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE;
 		drv_data->dma_cr1 = DEFAULT_DMA_CR1;
 		drv_data->clear_sr = SSSR_ROR | SSSR_TINT;
-		drv_data->mask_sr = SSSR_TINT | SSSR_RFS | SSSR_TFS | SSSR_ROR;
+		drv_data->mask_sr = SSSR_TINT | SSSR_RFS | SSSR_TFS
+						| SSSR_ROR | SSSR_TUR;
 	}
 
 	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
@@ -1658,10 +1713,22 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
 	default:
-		tmp = SSCR1_RxTresh(RX_THRESH_DFLT) |
-		      SSCR1_TxTresh(TX_THRESH_DFLT);
+
+		if (spi_controller_is_slave(master)) {
+			tmp = SSCR1_SCFR |
+			      SSCR1_SCLKDIR |
+			      SSCR1_SFRMDIR |
+			      SSCR1_RxTresh(2) |
+			      SSCR1_TxTresh(1) |
+			      SSCR1_SPH;
+		} else {
+			tmp = SSCR1_RxTresh(RX_THRESH_DFLT) |
+			      SSCR1_TxTresh(TX_THRESH_DFLT);
+		}
 		pxa2xx_spi_write(drv_data, SSCR1, tmp);
-		tmp = SSCR0_SCR(2) | SSCR0_Motorola | SSCR0_DataSize(8);
+		tmp = SSCR0_Motorola | SSCR0_DataSize(8);
+		if (!spi_controller_is_slave(master))
+			tmp |= SSCR0_SCR(2);
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
 	}
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 9ec4c147abbc..b0674e330ef6 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -25,6 +25,7 @@ struct dma_chan;
 struct pxa2xx_spi_master {
 	u16 num_chipselect;
 	u8 enable_dma;
+	bool is_slave;
 
 	/* DMA engine specific config */
 	bool (*dma_filter)(struct dma_chan *chan, void *param);
-- 
2.19.1
