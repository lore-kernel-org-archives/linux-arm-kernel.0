From: lakshmi.sai.krishna.potthuri@xilinx.com (P L Sai Krishna)
Date: Mon, 21 Mar 2016 17:50:09 +0530
Subject: [LINUX PATCH 2/2] spi:zynqmp:gqspi: Added separate dummy entry.
In-Reply-To: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
Message-ID: <1458562809-36114-2-git-send-email-lakshmis@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sends dummy as a separate entry.
Break the Address+Cmd+dummy transfer into multiple transfers.
Address+Cmd as one transfer.
Dummy cycles as another transfer.
As per the controller spec, immediate data field of dummy entry
in the GenFifo represent dummy cycles.
Bus width for dummy cycles transfer should be same as
Rx bus width.

Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 57 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index aab9b49..9393b1e 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -134,6 +134,9 @@
 #define GQSPI_SELECT_MODE_QUADSPI	0x4
 #define GQSPI_DMA_UNALIGN		0x3
 #define GQSPI_DEFAULT_NUM_CS	1	/* Default number of chip selects */
+#define GQSPI_RX_BUS_WIDTH_QUAD		0x4
+#define GQSPI_RX_BUS_WIDTH_DUAL		0x2
+#define GQSPI_RX_BUS_WIDTH_SINGLE	0x1
 
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
@@ -169,6 +172,7 @@ struct zynqmp_qspi {
 	u32 genfifobus;
 	u32 dma_rx_bytes;
 	dma_addr_t dma_addr;
+	u32 rx_bus_width;
 	u32 genfifoentry;
 	enum mode_type mode;
 };
@@ -541,6 +545,35 @@ static void zynqmp_qspi_filltxfifo(struct zynqmp_qspi *xqspi, int size)
 }
 
 /**
+ * zynqmp_qspi_preparedummy:	Prepares the dummy entry
+ *
+ * @xqspi:	Pointer to the zynqmp_qspi structure
+ * @transfer:	It is a pointer to the structure containing transfer data.
+ * @genfifoentry:	genfifoentry is pointer to the variable in which
+ *			GENFIFO	mask is returned to calling function
+ */
+static void zynqmp_qspi_preparedummy(struct zynqmp_qspi *xqspi,
+					struct spi_transfer *transfer,
+					u32 *genfifoentry)
+{
+	/* For dummy Tx and Rx are NULL */
+	*genfifoentry &= ~(GQSPI_GENFIFO_TX | GQSPI_GENFIFO_RX);
+
+	/* SPI mode */
+	*genfifoentry &= ~GQSPI_GENFIFO_MODE_QUADSPI;
+	if (xqspi->rx_bus_width == GQSPI_RX_BUS_WIDTH_QUAD)
+		*genfifoentry |= GQSPI_GENFIFO_MODE_QUADSPI;
+	else if (xqspi->rx_bus_width == GQSPI_RX_BUS_WIDTH_DUAL)
+		*genfifoentry |= GQSPI_GENFIFO_MODE_DUALSPI;
+	else
+		*genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
+
+	/* Immediate data */
+	*genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
+	*genfifoentry |= transfer->dummy;
+}
+
+/**
  * zynqmp_qspi_readrxfifo:	Fills the RX FIFO as long as there is room in
  *				the FIFO.
  * @xqspi:	Pointer to the zynqmp_qspi structure
@@ -771,7 +804,7 @@ static void zynqmp_qspi_txrxsetup(struct zynqmp_qspi *xqspi,
 		*genfifoentry |= GQSPI_GENFIFO_TX;
 		*genfifoentry |=
 			zynqmp_qspi_selectspimode(xqspi, transfer->tx_nbits);
-		xqspi->bytes_to_transfer = transfer->len;
+		xqspi->bytes_to_transfer = transfer->len - (transfer->dummy/8);
 		if (xqspi->mode == GQSPI_MODE_DMA) {
 			config_reg = zynqmp_gqspi_read(xqspi,
 							GQSPI_CONFIG_OFST);
@@ -832,13 +865,19 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
 	if (xqspi->mode == GQSPI_MODE_DMA)
 		transfer_len = xqspi->dma_rx_bytes;
 	else
-		transfer_len = transfer->len;
+		transfer_len = transfer->len - (transfer->dummy/8);
 
 	xqspi->genfifoentry = genfifoentry;
 	if ((transfer_len) < GQSPI_GENFIFO_IMM_DATA_MASK) {
 		genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
 		genfifoentry |= transfer_len;
 		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
+		if (transfer->dummy) {
+			zynqmp_qspi_preparedummy(xqspi, transfer,
+					&genfifoentry);
+			zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST,
+					genfifoentry);
+		}
 	} else {
 		int tempcount = transfer_len;
 		u32 exponent = 8;	/* 2^8 = 256 */
@@ -979,6 +1018,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	struct zynqmp_qspi *xqspi;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
+	struct device_node *nc;
+	u32 rx_bus_width;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
 	if (!master)
@@ -1039,6 +1080,18 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	xqspi->rx_bus_width = GQSPI_RX_BUS_WIDTH_SINGLE;
+	for_each_available_child_of_node(pdev->dev.of_node, nc) {
+		ret = of_property_read_u32(nc, "spi-rx-bus-width",
+					&rx_bus_width);
+		if (!ret) {
+			xqspi->rx_bus_width = rx_bus_width;
+			break;
+		}
+	}
+	if (ret)
+		dev_err(dev, "rx bus width not found\n");
+
 	master->num_chipselect = GQSPI_DEFAULT_NUM_CS;
 
 	master->setup = zynqmp_qspi_setup;
-- 
2.1.2
