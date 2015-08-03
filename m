From: ranjit.waghmode@xilinx.com (Ranjit Waghmode)
Date: Mon, 3 Aug 2015 14:35:07 +0530
Subject: [LINUX RFC 2/2] spi: zynqmp: gqspi: add support for dual parallel
 mode configuration
In-Reply-To: <1438592707-30713-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1438592707-30713-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <1438592707-30713-3-git-send-email-ranjit.waghmode@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support of dual parallel mode configuration for
Zynq Ultrascale+ MPSoC GQSPI controller driver.

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index f23f36e..7a72781 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -153,6 +153,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @dma_rx_bytes:	Remaining bytes to receive by DMA mode
  * @dma_addr:		DMA address after mapping the kernel buffer
  * @genfifoentry:	Used for storing the genfifoentry instruction.
+ * @isinstr:		To determine whether the transfer is instruction
  * @mode:		Defines the mode in which QSPI is operating
  */
 struct zynqmp_qspi {
@@ -170,6 +171,7 @@ struct zynqmp_qspi {
 	u32 dma_rx_bytes;
 	dma_addr_t dma_addr;
 	u32 genfifoentry;
+	bool isinstr;
 	enum mode_type mode;
 };

@@ -405,9 +407,20 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 	genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
 	genfifoentry |= xqspi->genfifobus;

+	if (qspi->master->flags & SPI_MASTER_BOTH_CS) {
+		zynqmp_gqspi_selectslave(xqspi,
+				GQSPI_SELECT_FLASH_CS_BOTH,
+				GQSPI_SELECT_FLASH_BUS_BOTH);
+	} else {
+		zynqmp_gqspi_selectslave(xqspi,
+				GQSPI_SELECT_FLASH_CS_LOWER,
+				GQSPI_SELECT_FLASH_BUS_LOWER);
+	}
+
 	if (!is_high) {
 		genfifoentry |= xqspi->genfifocs;
 		genfifoentry |= GQSPI_GENFIFO_CS_SETUP;
+		xqspi->isinstr = true;
 	} else {
 		genfifoentry |= GQSPI_GENFIFO_CS_HOLD;
 	}
@@ -664,6 +677,7 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 	if ((xqspi->bytes_to_receive == 0) && (xqspi->bytes_to_transfer == 0)
 			&& ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
 		zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MASK);
+		xqspi->isinstr = false;
 		spi_finalize_current_transfer(master);
 		ret = IRQ_HANDLED;
 	}
@@ -827,6 +841,9 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
 	genfifoentry |= xqspi->genfifocs;
 	genfifoentry |= xqspi->genfifobus;

+	if ((!xqspi->isinstr) && (master->flags & SPI_MASTER_DATA_STRIPE))
+		genfifoentry |= GQSPI_GENFIFO_STRIPE;
+
 	zynqmp_qspi_txrxsetup(xqspi, transfer, &genfifoentry);

 	if (xqspi->mode == GQSPI_MODE_DMA)
@@ -983,6 +1000,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	struct zynqmp_qspi *xqspi;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
+	u32 num_cs;

 	master = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
 	if (!master)
@@ -1043,7 +1061,11 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}

-	master->num_chipselect = GQSPI_DEFAULT_NUM_CS;
+	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
+	if (ret < 0)
+		master->num_chipselect = GQSPI_DEFAULT_NUM_CS;
+	else
+		master->num_chipselect = num_cs;

 	master->setup = zynqmp_qspi_setup;
 	master->set_cs = zynqmp_qspi_chipselect;
--
2.1.2
