From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 14 May 2015 11:27:09 +0000
Subject: [PATCH v2] spi: sirf: add support for USP-based SPI
Message-ID: <1431602829-12428-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

USP is a general purpose serial port in SiRFSoC, which can work as SPI.
the most data flow of USP and pure SPI is same with main differences
in registers layout.
this patch moves registers layout to private data, and use flags to
differentiate other minor differences between prima2-spi, prima2-usp
and atlas7-usp for hardware configuration.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2: refine the MARCOs for FIFO status check;
 use uart_type instead of bool;
 cleanup some HW configuration codes;

 drivers/spi/spi-sirf.c | 677 ++++++++++++++++++++++++++-----------------------
 1 file changed, 353 insertions(+), 324 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index d3c739a..dd87ba6f 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -129,37 +129,23 @@
 #define SIRFSOC_USP_RX_FRAME_MASK	0xFF
 #define SIRFSOC_USP_RX_SHIFTER_MASK	0x1F
 #define SIRFSOC_USP_CS_HIGH_VALUE	BIT(1)
+
+#define SIRFSOC_SPI_FIFO_SC_OFFSET	0
+#define SIRFSOC_SPI_FIFO_LC_OFFSET	10
+#define SIRFSOC_SPI_FIFO_HC_OFFSET	20
+
+#define SIRFSOC_SPI_FIFO_FULL_MASK(s)	(1 << ((s)->fifo_full_offset))
+#define SIRFSOC_SPI_FIFO_EMPTY_MASK(s)	(1 << ((s)->fifo_full_offset + 1))
+#define SIRFSOC_SPI_FIFO_THD_MASK(s)	((s)->fifo_size - 1)
+#define SIRFSOC_SPI_FIFO_THD_OFFSET	2
+#define SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(s, val)	\
+	((val) & (s)->fifo_level_chk_mask)
+
 enum sirf_spi_type {
 	SIRF_REAL_SPI,
-	SIRF_USP_SPI,
+	SIRF_USP_SPI_P2,
+	SIRF_USP_SPI_A7,
 };
-#define SIRFSOC_SPI_FIFO_LEVEL_MASK(s)	((s->spi_type == SIRF_REAL_SPI) ? \
-					0xFF : ((s->is_atlas7_usp == 1) ? \
-					0x1FF : 0x7F))
-#define SIRFSOC_SPI_FIFO_FULL(s)	((s->spi_type == SIRF_REAL_SPI) ? \
-					BIT(8) : ((s->is_atlas7_usp == 1) ? \
-					BIT(9) : BIT(7)))
-#define SIRFSOC_SPI_FIFO_EMPTY(s)	((s->spi_type == SIRF_REAL_SPI) ? \
-					BIT(9) : ((s->is_atlas7_usp == 1) ? \
-					BIT(10) : BIT(8)))
-
-#define SIRFSOC_SPI_FIFO_SIZE(s)	((s->spi_type == SIRF_REAL_SPI) ? \
-					256 : ((s->is_atlas7_usp == 1) ? \
-					512 : 128))
-#define SIRFSOC_SPI_DAT_FRM_LEN_MAX(s)	((s->spi_type == SIRF_REAL_SPI) ? \
-					(64 * 1024) : (1024 * 1024))
-#define SIRFSOC_SPI_FIFO_SC(s, x)	((s->spi_type == SIRF_REAL_SPI) ? \
-			((x) & 0x3F) : ((s->is_atlas7_usp == 1) ?\
-			((x) & 0x3F) : ((x) & 0x1F)))
-#define SIRFSOC_SPI_FIFO_LC(s, x)	((s->spi_type == SIRF_REAL_SPI) ? \
-			(((x) & 0x3F) << 10) : ((s->is_atlas7_usp == 1) ?\
-			(((x) & 0x3F) << 10) : (((x) & 0x1F) << 10)))
-#define SIRFSOC_SPI_FIFO_HC(s, x)	((s->spi_type == SIRF_REAL_SPI) ? \
-			(((x) & 0x3F) << 20) : ((s->is_atlas7_usp == 1) ?\
-			(((x) & 0x1F) << 20) : (((x) & 0x1F) << 20)))
-#define SIRFSOC_SPI_FIFO_THD(s, x)	((s->spi_type == SIRF_REAL_SPI) ? \
-			(((x) & 0xFF) << 2) : ((s->is_atlas7_usp == 1) ?\
-			(((x) & 0x1FF) << 2) : (((x) & 0x7F) << 2)))
 
 /*
  * only if the rx/tx buffer and transfer size are 4-bytes aligned, we use dma
@@ -209,7 +195,7 @@ struct sirf_spi_register {
 	u32 usp_int_en_clr;
 };
 
-struct sirf_spi_register sirf_real_spi = {
+static const struct sirf_spi_register real_spi_register = {
 	.tx_rx_en		= 0x8,
 	.int_en		= 0xc,
 	.int_st		= 0x10,
@@ -231,7 +217,8 @@ struct sirf_spi_register sirf_real_spi = {
 	.spi_cmd		= 0x4,
 	.spi_dummy_delay_ctrl	= 0x144,
 };
-struct sirf_spi_register sirf_usp_spi = {
+
+static const struct sirf_spi_register usp_spi_register = {
 	.tx_rx_en		= 0x10,
 	.int_en		= 0x14,
 	.int_st		= 0x18,
@@ -260,6 +247,35 @@ struct sirf_spi_register sirf_usp_spi = {
 	.usp_sm_cfg		= 0x2c,
 	.usp_int_en_clr		= 0x140,
 };
+
+struct sirf_spi_comp_data {
+	const struct sirf_spi_register *regs;
+	enum sirf_spi_type type;
+	unsigned int dat_max_frm_len;
+	unsigned int fifo_size;
+};
+
+static const struct sirf_spi_comp_data sirf_real_spi = {
+	.regs = &real_spi_register,
+	.type = SIRF_REAL_SPI,
+	.dat_max_frm_len = 64 * 1024,
+	.fifo_size = 256,
+};
+
+static const struct sirf_spi_comp_data sirf_usp_spi_p2 = {
+	.regs = &usp_spi_register,
+	.type = SIRF_USP_SPI_P2,
+	.dat_max_frm_len = 1024 * 1024,
+	.fifo_size = 128,
+};
+
+static const struct sirf_spi_comp_data sirf_usp_spi_a7 = {
+	.regs = &usp_spi_register,
+	.type = SIRF_USP_SPI_A7,
+	.dat_max_frm_len = 1024 * 1024,
+	.fifo_size = 512,
+};
+
 struct sirfsoc_spi {
 	struct spi_bitbang bitbang;
 	struct completion rx_done;
@@ -296,24 +312,22 @@ struct sirfsoc_spi {
 	 */
 	bool	tx_by_cmd;
 	bool	hw_cs;
-	enum sirf_spi_type spi_type;
-	struct sirf_spi_register *spi_register;
-	bool	is_atlas7_usp;
+	enum sirf_spi_type type;
+	const struct sirf_spi_register *regs;
+	unsigned int fifo_size;
+	/* fifo empty offset is (fifo full offset + 1)*/
+	unsigned int fifo_full_offset;
+	/* fifo_level_chk_mask is (fifo_size/4 - 1) */
+	unsigned int fifo_level_chk_mask;
+	unsigned int dat_max_frm_len;
 };
 
-static struct sirf_spi_register *get_sirf_spi_register(struct sirfsoc_spi *sspi)
-{
-	return sspi->spi_register;
-}
-
 static void spi_sirfsoc_rx_word_u8(struct sirfsoc_spi *sspi)
 {
 	u32 data;
 	u8 *rx = sspi->rx;
-	struct sirf_spi_register *spi_reg;
 
-	spi_reg = get_sirf_spi_register(sspi);
-	data = readl(sspi->base + spi_reg->rxfifo_data);
+	data = readl(sspi->base + sspi->regs->rxfifo_data);
 
 	if (rx) {
 		*rx++ = (u8) data;
@@ -327,14 +341,12 @@ static void spi_sirfsoc_tx_word_u8(struct sirfsoc_spi *sspi)
 {
 	u32 data = 0;
 	const u8 *tx = sspi->tx;
-	struct sirf_spi_register *spi_reg;
 
-	spi_reg = get_sirf_spi_register(sspi);
 	if (tx) {
 		data = *tx++;
 		sspi->tx = tx;
 	}
-	writel(data, sspi->base + spi_reg->txfifo_data);
+	writel(data, sspi->base + sspi->regs->txfifo_data);
 	sspi->left_tx_word--;
 }
 
@@ -342,10 +354,8 @@ static void spi_sirfsoc_rx_word_u16(struct sirfsoc_spi *sspi)
 {
 	u32 data;
 	u16 *rx = sspi->rx;
-	struct sirf_spi_register *spi_reg;
 
-	spi_reg = get_sirf_spi_register(sspi);
-	data = readl(sspi->base + spi_reg->rxfifo_data);
+	data = readl(sspi->base + sspi->regs->rxfifo_data);
 
 	if (rx) {
 		*rx++ = (u16) data;
@@ -359,15 +369,13 @@ static void spi_sirfsoc_tx_word_u16(struct sirfsoc_spi *sspi)
 {
 	u32 data = 0;
 	const u16 *tx = sspi->tx;
-	struct sirf_spi_register *spi_reg;
 
-	spi_reg = get_sirf_spi_register(sspi);
 	if (tx) {
 		data = *tx++;
 		sspi->tx = tx;
 	}
 
-	writel(data, sspi->base + spi_reg->txfifo_data);
+	writel(data, sspi->base + sspi->regs->txfifo_data);
 	sspi->left_tx_word--;
 }
 
@@ -375,10 +383,8 @@ static void spi_sirfsoc_rx_word_u32(struct sirfsoc_spi *sspi)
 {
 	u32 data;
 	u32 *rx = sspi->rx;
-	struct sirf_spi_register *spi_reg;
 
-	spi_reg = get_sirf_spi_register(sspi);
-	data = readl(sspi->base + spi_reg->rxfifo_data);
+	data = readl(sspi->base + sspi->regs->rxfifo_data);
 
 	if (rx) {
 		*rx++ = (u32) data;
@@ -393,35 +399,28 @@ static void spi_sirfsoc_tx_word_u32(struct sirfsoc_spi *sspi)
 {
 	u32 data = 0;
 	const u32 *tx = sspi->tx;
-	struct sirf_spi_register *spi_reg;
 
-	spi_reg = get_sirf_spi_register(sspi);
 	if (tx) {
 		data = *tx++;
 		sspi->tx = tx;
 	}
 
-	writel(data, sspi->base + spi_reg->txfifo_data);
+	writel(data, sspi->base + sspi->regs->txfifo_data);
 	sspi->left_tx_word--;
 }
 
 static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
 {
 	struct sirfsoc_spi *sspi = dev_id;
-	struct sirf_spi_register *spi_reg;
 	u32 spi_stat;
 
-	spi_reg = get_sirf_spi_register(sspi);
-	spi_stat = readl(sspi->base + spi_reg->int_st);
-	if (sspi->tx_by_cmd && sspi->spi_type == SIRF_REAL_SPI
+	spi_stat = readl(sspi->base + sspi->regs->int_st);
+	if (sspi->tx_by_cmd && sspi->type == SIRF_REAL_SPI
 		&& (spi_stat & SIRFSOC_SPI_FRM_END)) {
 		complete(&sspi->tx_done);
-		if (sspi->is_atlas7_usp)
-			writel(~0UL, sspi->base + spi_reg->usp_int_en_clr);
-		else
-			writel(0x0, sspi->base + spi_reg->int_en);
-		writel(readl(sspi->base + spi_reg->int_st),
-				sspi->base + spi_reg->int_st);
+		writel(0x0, sspi->base + sspi->regs->int_en);
+		writel(readl(sspi->base + sspi->regs->int_st),
+				sspi->base + sspi->regs->int_st);
 		return IRQ_HANDLED;
 	}
 	/* Error Conditions */
@@ -429,26 +428,36 @@ static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
 			spi_stat & SIRFSOC_SPI_TX_UFLOW) {
 		complete(&sspi->tx_done);
 		complete(&sspi->rx_done);
-		if (sspi->is_atlas7_usp)
-			writel(~0UL, sspi->base + spi_reg->usp_int_en_clr);
-		else
-			writel(0x0, sspi->base + spi_reg->int_en);
-		writel(readl(sspi->base + spi_reg->int_st),
-				sspi->base + spi_reg->int_st);
+		switch (sspi->type) {
+		case SIRF_REAL_SPI:
+		case SIRF_USP_SPI_P2:
+			writel(0x0, sspi->base + sspi->regs->int_en);
+			break;
+		case SIRF_USP_SPI_A7:
+			writel(~0UL, sspi->base + sspi->regs->usp_int_en_clr);
+			break;
+		}
+		writel(readl(sspi->base + sspi->regs->int_st),
+				sspi->base + sspi->regs->int_st);
 		return IRQ_HANDLED;
 	}
 	if (spi_stat & SIRFSOC_SPI_TXFIFO_EMPTY)
 		complete(&sspi->tx_done);
-	while (!(readl(sspi->base + spi_reg->int_st) &
+	while (!(readl(sspi->base + sspi->regs->int_st) &
 		SIRFSOC_SPI_RX_IO_DMA))
 		cpu_relax();
 	complete(&sspi->rx_done);
-	if (sspi->is_atlas7_usp)
-		writel(~0UL, sspi->base + spi_reg->usp_int_en_clr);
-	else
-		writel(0x0, sspi->base + spi_reg->int_en);
-	writel(readl(sspi->base + spi_reg->int_st),
-			sspi->base + spi_reg->int_st);
+	switch (sspi->type) {
+	case SIRF_REAL_SPI:
+	case SIRF_USP_SPI_P2:
+		writel(0x0, sspi->base + sspi->regs->int_en);
+		break;
+	case SIRF_USP_SPI_A7:
+		writel(~0UL, sspi->base + sspi->regs->usp_int_en_clr);
+		break;
+	}
+	writel(readl(sspi->base + sspi->regs->int_st),
+			sspi->base + sspi->regs->int_st);
 
 	return IRQ_HANDLED;
 }
@@ -466,12 +475,10 @@ static void spi_sirfsoc_cmd_transfer(struct spi_device *spi,
 	struct sirfsoc_spi *sspi;
 	int timeout = t->len * 10;
 	u32 cmd;
-	struct sirf_spi_register *spi_reg;
 
 	sspi = spi_master_get_devdata(spi->master);
-	spi_reg = get_sirf_spi_register(sspi);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + spi_reg->txfifo_op);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + spi_reg->txfifo_op);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + sspi->regs->txfifo_op);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + sspi->regs->txfifo_op);
 	memcpy(&cmd, sspi->tx, t->len);
 	if (sspi->word_width == 1 && !(spi->mode & SPI_LSB_FIRST))
 		cmd = cpu_to_be32(cmd) >>
@@ -479,11 +486,11 @@ static void spi_sirfsoc_cmd_transfer(struct spi_device *spi,
 	if (sspi->word_width == 2 && t->len == 4 &&
 			(!(spi->mode & SPI_LSB_FIRST)))
 		cmd = ((cmd & 0xffff) << 16) | (cmd >> 16);
-	writel(cmd, sspi->base + spi_reg->spi_cmd);
+	writel(cmd, sspi->base + sspi->regs->spi_cmd);
 	writel(SIRFSOC_SPI_FRM_END_INT_EN,
-		sspi->base + spi_reg->int_en);
+		sspi->base + sspi->regs->int_en);
 	writel(SIRFSOC_SPI_CMD_TX_EN,
-		sspi->base + spi_reg->tx_rx_en);
+		sspi->base + sspi->regs->tx_rx_en);
 	if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
 		dev_err(&spi->dev, "cmd transfer timeout\n");
 		return;
@@ -497,52 +504,58 @@ static void spi_sirfsoc_dma_transfer(struct spi_device *spi,
 	struct sirfsoc_spi *sspi;
 	struct dma_async_tx_descriptor *rx_desc, *tx_desc;
 	int timeout = t->len * 10;
-	struct sirf_spi_register *spi_reg;
 
 	sspi = spi_master_get_devdata(spi->master);
-	spi_reg = get_sirf_spi_register(sspi);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + spi_reg->rxfifo_op);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + spi_reg->txfifo_op);
-	if (sspi->spi_type == SIRF_USP_SPI) {
-		writel(0x0, sspi->base + spi_reg->rxfifo_op);
-		writel(0x0, sspi->base + spi_reg->txfifo_op);
-	}
-	if (sspi->spi_type == SIRF_REAL_SPI) {
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + sspi->regs->rxfifo_op);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + sspi->regs->txfifo_op);
+	switch (sspi->type) {
+	case SIRF_REAL_SPI:
 		writel(SIRFSOC_SPI_FIFO_START,
-			sspi->base + spi_reg->rxfifo_op);
+			sspi->base + sspi->regs->rxfifo_op);
 		writel(SIRFSOC_SPI_FIFO_START,
-			sspi->base + spi_reg->txfifo_op);
+			sspi->base + sspi->regs->txfifo_op);
+		writel(0, sspi->base + sspi->regs->int_en);
+		break;
+	case SIRF_USP_SPI_P2:
+		writel(0x0, sspi->base + sspi->regs->rxfifo_op);
+		writel(0x0, sspi->base + sspi->regs->txfifo_op);
+		writel(0, sspi->base + sspi->regs->int_en);
+		break;
+	case SIRF_USP_SPI_A7:
+		writel(0x0, sspi->base + sspi->regs->rxfifo_op);
+		writel(0x0, sspi->base + sspi->regs->txfifo_op);
+		writel(~0UL, sspi->base + sspi->regs->usp_int_en_clr);
+		break;
 	}
-	if (sspi->is_atlas7_usp)
-		writel(~0UL, sspi->base + spi_reg->usp_int_en_clr);
-	else
-		writel(0, sspi->base + spi_reg->int_en);
-	writel(readl(sspi->base + spi_reg->int_st),
-		sspi->base + spi_reg->int_st);
-	if (sspi->left_tx_word < SIRFSOC_SPI_DAT_FRM_LEN_MAX(sspi)) {
-		if (sspi->spi_type == SIRF_REAL_SPI) {
-			writel(readl(sspi->base + spi_reg->spi_ctrl) |
+	writel(readl(sspi->base + sspi->regs->int_st),
+		sspi->base + sspi->regs->int_st);
+	if (sspi->left_tx_word < sspi->dat_max_frm_len) {
+		switch (sspi->type) {
+		case SIRF_REAL_SPI:
+			writel(readl(sspi->base + sspi->regs->spi_ctrl) |
 				SIRFSOC_SPI_ENA_AUTO_CLR |
 				SIRFSOC_SPI_MUL_DAT_MODE,
-				sspi->base + spi_reg->spi_ctrl);
+				sspi->base + sspi->regs->spi_ctrl);
 			writel(sspi->left_tx_word - 1,
-				sspi->base + spi_reg->tx_dma_io_len);
+				sspi->base + sspi->regs->tx_dma_io_len);
 			writel(sspi->left_tx_word - 1,
-				sspi->base + spi_reg->rx_dma_io_len);
-		}
-		if (sspi->spi_type == SIRF_USP_SPI) {
+				sspi->base + sspi->regs->rx_dma_io_len);
+			break;
+		case SIRF_USP_SPI_P2:
+		case SIRF_USP_SPI_A7:
 			/*USP simulate SPI, tx/rx_dma_io_len indicates bytes*/
 			writel(sspi->left_tx_word * sspi->word_width,
-				sspi->base + spi_reg->tx_dma_io_len);
+				sspi->base + sspi->regs->tx_dma_io_len);
 			writel(sspi->left_tx_word * sspi->word_width,
-				sspi->base + spi_reg->rx_dma_io_len);
+				sspi->base + sspi->regs->rx_dma_io_len);
+			break;
 		}
 	} else {
-		if (sspi->spi_type == SIRF_REAL_SPI)
-			writel(readl(sspi->base + spi_reg->spi_ctrl),
-				sspi->base + spi_reg->spi_ctrl);
-		writel(0, sspi->base + spi_reg->tx_dma_io_len);
-		writel(0, sspi->base + spi_reg->rx_dma_io_len);
+		if (sspi->type == SIRF_REAL_SPI)
+			writel(readl(sspi->base + sspi->regs->spi_ctrl),
+				sspi->base + sspi->regs->spi_ctrl);
+		writel(0, sspi->base + sspi->regs->tx_dma_io_len);
+		writel(0, sspi->base + sspi->regs->rx_dma_io_len);
 	}
 	sspi->dst_start = dma_map_single(&spi->dev, sspi->rx, t->len,
 					(t->tx_buf != t->rx_buf) ?
@@ -567,12 +580,13 @@ static void spi_sirfsoc_dma_transfer(struct spi_device *spi,
 	dma_async_issue_pending(sspi->tx_chan);
 	dma_async_issue_pending(sspi->rx_chan);
 	writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
-			sspi->base + spi_reg->tx_rx_en);
-	if (sspi->spi_type == SIRF_USP_SPI) {
+			sspi->base + sspi->regs->tx_rx_en);
+	if (sspi->type == SIRF_USP_SPI_P2 ||
+		sspi->type == SIRF_USP_SPI_A7) {
 		writel(SIRFSOC_SPI_FIFO_START,
-			sspi->base + spi_reg->rxfifo_op);
+			sspi->base + sspi->regs->rxfifo_op);
 		writel(SIRFSOC_SPI_FIFO_START,
-			sspi->base + spi_reg->txfifo_op);
+			sspi->base + sspi->regs->txfifo_op);
 	}
 	if (wait_for_completion_timeout(&sspi->rx_done, timeout) == 0) {
 		dev_err(&spi->dev, "transfer timeout\n");
@@ -586,19 +600,21 @@ static void spi_sirfsoc_dma_transfer(struct spi_device *spi,
 	 */
 	if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
 		dev_err(&spi->dev, "transfer timeout\n");
-		if (sspi->spi_type == SIRF_USP_SPI)
-			writel(0, sspi->base + spi_reg->tx_rx_en);
+		if (sspi->type == SIRF_USP_SPI_P2 ||
+			sspi->type == SIRF_USP_SPI_A7)
+			writel(0, sspi->base + sspi->regs->tx_rx_en);
 		dmaengine_terminate_all(sspi->tx_chan);
 	}
 	dma_unmap_single(&spi->dev, sspi->src_start, t->len, DMA_TO_DEVICE);
 	dma_unmap_single(&spi->dev, sspi->dst_start, t->len, DMA_FROM_DEVICE);
 	/* TX, RX FIFO stop */
-	writel(0, sspi->base + spi_reg->rxfifo_op);
-	writel(0, sspi->base + spi_reg->txfifo_op);
-	if (sspi->left_tx_word >= SIRFSOC_SPI_DAT_FRM_LEN_MAX(sspi))
-		writel(0, sspi->base + spi_reg->tx_rx_en);
-	if (sspi->spi_type == SIRF_USP_SPI)
-		writel(0, sspi->base + spi_reg->tx_rx_en);
+	writel(0, sspi->base + sspi->regs->rxfifo_op);
+	writel(0, sspi->base + sspi->regs->txfifo_op);
+	if (sspi->left_tx_word >= sspi->dat_max_frm_len)
+		writel(0, sspi->base + sspi->regs->tx_rx_en);
+	if (sspi->type == SIRF_USP_SPI_P2 ||
+		sspi->type == SIRF_USP_SPI_A7)
+		writel(0, sspi->base + sspi->regs->tx_rx_en);
 }
 
 static void spi_sirfsoc_pio_transfer(struct spi_device *spi,
@@ -606,84 +622,95 @@ static void spi_sirfsoc_pio_transfer(struct spi_device *spi,
 {
 	struct sirfsoc_spi *sspi;
 	int timeout = t->len * 10;
-	struct sirf_spi_register *spi_reg;
 	unsigned int data_units;
 
 	sspi = spi_master_get_devdata(spi->master);
-	spi_reg = get_sirf_spi_register(sspi);
 	do {
 		writel(SIRFSOC_SPI_FIFO_RESET,
-			sspi->base + spi_reg->rxfifo_op);
+			sspi->base + sspi->regs->rxfifo_op);
 		writel(SIRFSOC_SPI_FIFO_RESET,
-			sspi->base + spi_reg->txfifo_op);
-		if (sspi->spi_type == SIRF_USP_SPI) {
-			writel(0x0, sspi->base + spi_reg->rxfifo_op);
-			writel(0x0, sspi->base + spi_reg->txfifo_op);
-		}
-		if (sspi->spi_type == SIRF_REAL_SPI) {
+			sspi->base + sspi->regs->txfifo_op);
+		switch (sspi->type) {
+		case SIRF_USP_SPI_P2:
+			writel(0x0, sspi->base + sspi->regs->rxfifo_op);
+			writel(0x0, sspi->base + sspi->regs->txfifo_op);
+			writel(0, sspi->base + sspi->regs->int_en);
+			writel(readl(sspi->base + sspi->regs->int_st),
+				sspi->base + sspi->regs->int_st);
+			writel(min((sspi->left_tx_word * sspi->word_width),
+				sspi->fifo_size),
+				sspi->base + sspi->regs->tx_dma_io_len);
+			writel(min((sspi->left_rx_word * sspi->word_width),
+				sspi->fifo_size),
+				sspi->base + sspi->regs->rx_dma_io_len);
+			break;
+		case SIRF_USP_SPI_A7:
+			writel(0x0, sspi->base + sspi->regs->rxfifo_op);
+			writel(0x0, sspi->base + sspi->regs->txfifo_op);
+			writel(~0UL, sspi->base + sspi->regs->usp_int_en_clr);
+			writel(readl(sspi->base + sspi->regs->int_st),
+				sspi->base + sspi->regs->int_st);
+			writel(min((sspi->left_tx_word * sspi->word_width),
+				sspi->fifo_size),
+				sspi->base + sspi->regs->tx_dma_io_len);
+			writel(min((sspi->left_rx_word * sspi->word_width),
+				sspi->fifo_size),
+				sspi->base + sspi->regs->rx_dma_io_len);
+			break;
+		case SIRF_REAL_SPI:
 			writel(SIRFSOC_SPI_FIFO_START,
-				sspi->base + spi_reg->rxfifo_op);
+				sspi->base + sspi->regs->rxfifo_op);
 			writel(SIRFSOC_SPI_FIFO_START,
-				sspi->base + spi_reg->txfifo_op);
-		}
-		if (sspi->is_atlas7_usp)
-			writel(~0UL, sspi->base + spi_reg->usp_int_en_clr);
-		else
-			writel(0, sspi->base + spi_reg->int_en);
-		writel(readl(sspi->base + spi_reg->int_st),
-			sspi->base + spi_reg->int_st);
-		if (sspi->spi_type == SIRF_REAL_SPI) {
-
-			writel(readl(sspi->base + spi_reg->spi_ctrl) |
+				sspi->base + sspi->regs->txfifo_op);
+			writel(0, sspi->base + sspi->regs->int_en);
+			writel(readl(sspi->base + sspi->regs->int_st),
+				sspi->base + sspi->regs->int_st);
+			writel(readl(sspi->base + sspi->regs->spi_ctrl) |
 				SIRFSOC_SPI_MUL_DAT_MODE |
 				SIRFSOC_SPI_ENA_AUTO_CLR,
-				sspi->base + spi_reg->spi_ctrl);
-			data_units = 256 / sspi->word_width;
+				sspi->base + sspi->regs->spi_ctrl);
+			data_units = sspi->fifo_size / sspi->word_width;
 			writel(min(sspi->left_tx_word, data_units) - 1,
-				sspi->base + spi_reg->tx_dma_io_len);
+				sspi->base + sspi->regs->tx_dma_io_len);
 			writel(min(sspi->left_rx_word, data_units) - 1,
-				sspi->base + spi_reg->rx_dma_io_len);
-		}
-		if (sspi->spi_type == SIRF_USP_SPI) {
-			/*USP simulate SPI, tx/rx_dma_io_len indicates bytes*/
-			data_units = (sspi->is_atlas7_usp == 1) ? 512 : 128;
-			writel(min((unsigned int)(sspi->left_tx_word *
-				sspi->word_width), data_units),
-				sspi->base + spi_reg->tx_dma_io_len);
-			writel(min((unsigned int)(sspi->left_rx_word *
-				sspi->word_width), data_units),
-				sspi->base + spi_reg->rx_dma_io_len);
+				sspi->base + sspi->regs->rx_dma_io_len);
+			break;
 		}
-		while (!((readl(sspi->base + spi_reg->txfifo_st)
-			& SIRFSOC_SPI_FIFO_FULL(sspi))) && sspi->left_tx_word)
+		while (!((readl(sspi->base + sspi->regs->txfifo_st)
+			& SIRFSOC_SPI_FIFO_FULL_MASK(sspi))) &&
+			sspi->left_tx_word)
 			sspi->tx_word(sspi);
 		writel(SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN |
 			SIRFSOC_SPI_TX_UFLOW_INT_EN |
 			SIRFSOC_SPI_RX_OFLOW_INT_EN |
 			SIRFSOC_SPI_RX_IO_DMA_INT_EN,
-			sspi->base + spi_reg->int_en);
+			sspi->base + sspi->regs->int_en);
 		writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
-			sspi->base + spi_reg->tx_rx_en);
-		if (sspi->spi_type == SIRF_USP_SPI) {
+			sspi->base + sspi->regs->tx_rx_en);
+		if (sspi->type == SIRF_USP_SPI_P2 ||
+			sspi->type == SIRF_USP_SPI_A7) {
 			writel(SIRFSOC_SPI_FIFO_START,
-				sspi->base + spi_reg->rxfifo_op);
+				sspi->base + sspi->regs->rxfifo_op);
 			writel(SIRFSOC_SPI_FIFO_START,
-				sspi->base + spi_reg->txfifo_op);
+				sspi->base + sspi->regs->txfifo_op);
 		}
 		if (!wait_for_completion_timeout(&sspi->tx_done, timeout) ||
 			!wait_for_completion_timeout(&sspi->rx_done, timeout)) {
 			dev_err(&spi->dev, "transfer timeout\n");
-			if (sspi->spi_type == SIRF_USP_SPI)
-				writel(0, sspi->base + spi_reg->tx_rx_en);
+			if (sspi->type == SIRF_USP_SPI_P2 ||
+				sspi->type == SIRF_USP_SPI_A7)
+				writel(0, sspi->base + sspi->regs->tx_rx_en);
 			break;
 		}
-		while (!((readl(sspi->base + spi_reg->rxfifo_st)
-			& SIRFSOC_SPI_FIFO_EMPTY(sspi))) && sspi->left_rx_word)
+		while (!((readl(sspi->base + sspi->regs->rxfifo_st)
+			& SIRFSOC_SPI_FIFO_EMPTY_MASK(sspi))) &&
+			sspi->left_rx_word)
 			sspi->rx_word(sspi);
-		if (sspi->spi_type == SIRF_USP_SPI)
-			writel(0, sspi->base + spi_reg->tx_rx_en);
-		writel(0, sspi->base + spi_reg->rxfifo_op);
-		writel(0, sspi->base + spi_reg->txfifo_op);
+		if (sspi->type == SIRF_USP_SPI_P2 ||
+			sspi->type == SIRF_USP_SPI_A7)
+			writel(0, sspi->base + sspi->regs->tx_rx_en);
+		writel(0, sspi->base + sspi->regs->rxfifo_op);
+		writel(0, sspi->base + sspi->regs->txfifo_op);
 	} while (sspi->left_tx_word != 0 || sspi->left_rx_word != 0);
 }
 
@@ -702,7 +729,7 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 	 * null, just fill command data into command register and wait for its
 	 * completion.
 	 */
-	if (sspi->spi_type == SIRF_REAL_SPI && sspi->tx_by_cmd)
+	if (sspi->type == SIRF_REAL_SPI && sspi->tx_by_cmd)
 		spi_sirfsoc_cmd_transfer(spi, t);
 	else if (IS_DMA_VALID(t))
 		spi_sirfsoc_dma_transfer(spi, t);
@@ -715,13 +742,13 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
 {
 	struct sirfsoc_spi *sspi = spi_master_get_devdata(spi->master);
-	struct sirf_spi_register *spi_reg;
 
-	spi_reg = get_sirf_spi_register(sspi);
 	if (sspi->hw_cs) {
-		if (sspi->spi_type == SIRF_REAL_SPI) {
-			u32 regval = readl(sspi->base + spi_reg->spi_ctrl);
+		u32 regval;
 
+		switch (sspi->type) {
+		case SIRF_REAL_SPI:
+			regval = readl(sspi->base + sspi->regs->spi_ctrl);
 			switch (value) {
 			case BITBANG_CS_ACTIVE:
 				if (spi->mode & SPI_CS_HIGH)
@@ -736,10 +763,12 @@ static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
 					regval |= SIRFSOC_SPI_CS_IO_OUT;
 				break;
 			}
-			writel(regval, sspi->base + spi_reg->spi_ctrl);
-		} else {
-			u32 regval = readl(sspi->base +
-					spi_reg->usp_pin_io_data);
+			writel(regval, sspi->base + sspi->regs->spi_ctrl);
+			break;
+		case SIRF_USP_SPI_P2:
+		case SIRF_USP_SPI_A7:
+			regval = readl(sspi->base +
+					sspi->regs->usp_pin_io_data);
 			switch (value) {
 			case BITBANG_CS_ACTIVE:
 				if (spi->mode & SPI_CS_HIGH)
@@ -754,7 +783,9 @@ static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
 					regval |= SIRFSOC_USP_CS_HIGH_VALUE;
 				break;
 			}
-			writel(regval, sspi->base + spi_reg->usp_pin_io_data);
+			writel(regval,
+				sspi->base + sspi->regs->usp_pin_io_data);
+			break;
 		}
 	} else {
 		switch (value) {
@@ -770,20 +801,94 @@ static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
 	}
 }
 
+static int spi_sirfsoc_config_mode(struct spi_device *spi)
+{
+	struct sirfsoc_spi *sspi;
+	u32 regval, usp_mode1;
+
+	sspi = spi_master_get_devdata(spi->master);
+	regval = readl(sspi->base + sspi->regs->spi_ctrl);
+	usp_mode1 = readl(sspi->base + sspi->regs->usp_mode1);
+	if (!(spi->mode & SPI_CS_HIGH)) {
+		regval |= SIRFSOC_SPI_CS_IDLE_STAT;
+		usp_mode1 &= ~SIRFSOC_USP_CS_HIGH_VALID;
+	} else {
+		regval &= ~SIRFSOC_SPI_CS_IDLE_STAT;
+		usp_mode1 |= SIRFSOC_USP_CS_HIGH_VALID;
+	}
+	if (!(spi->mode & SPI_LSB_FIRST)) {
+		regval |= SIRFSOC_SPI_TRAN_MSB;
+		usp_mode1 &= ~SIRFSOC_USP_LSB;
+	} else {
+		regval &= ~SIRFSOC_SPI_TRAN_MSB;
+		usp_mode1 |= SIRFSOC_USP_LSB;
+	}
+	if (spi->mode & SPI_CPOL) {
+		regval |= SIRFSOC_SPI_CLK_IDLE_STAT;
+		usp_mode1 |= SIRFSOC_USP_SCLK_IDLE_STAT;
+	} else {
+		regval &= ~SIRFSOC_SPI_CLK_IDLE_STAT;
+		usp_mode1 &= ~SIRFSOC_USP_SCLK_IDLE_STAT;
+	}
+	/*
+	 * Data should be driven at least 1/2 cycle before the fetch edge
+	 * to make sure that data gets stable at the fetch edge.
+	 */
+	if (((spi->mode & SPI_CPOL) && (spi->mode & SPI_CPHA)) ||
+	    (!(spi->mode & SPI_CPOL) && !(spi->mode & SPI_CPHA))) {
+		regval &= ~SIRFSOC_SPI_DRV_POS_EDGE;
+		usp_mode1 |= (SIRFSOC_USP_TXD_FALLING_EDGE |
+				SIRFSOC_USP_RXD_FALLING_EDGE);
+	} else {
+		regval |= SIRFSOC_SPI_DRV_POS_EDGE;
+		usp_mode1 &= ~(SIRFSOC_USP_RXD_FALLING_EDGE |
+				SIRFSOC_USP_TXD_FALLING_EDGE);
+	}
+	writel((SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, sspi->fifo_size - 2) <<
+		SIRFSOC_SPI_FIFO_SC_OFFSET) |
+		(SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, sspi->fifo_size / 2) <<
+		SIRFSOC_SPI_FIFO_LC_OFFSET) |
+		(SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, 2) <<
+		SIRFSOC_SPI_FIFO_HC_OFFSET),
+		sspi->base + sspi->regs->txfifo_level_chk);
+	writel((SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, 2) <<
+		SIRFSOC_SPI_FIFO_SC_OFFSET) |
+		(SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, sspi->fifo_size / 2) <<
+		SIRFSOC_SPI_FIFO_LC_OFFSET) |
+		(SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, sspi->fifo_size - 2) <<
+		SIRFSOC_SPI_FIFO_HC_OFFSET),
+		sspi->base + sspi->regs->rxfifo_level_chk);
+	/*
+	 * it should never set to hardware cs mode because in hardware cs mode,
+	 * cs signal can't controlled by driver.
+	 */
+	switch (sspi->type) {
+	case SIRF_REAL_SPI:
+		regval |= SIRFSOC_SPI_CS_IO_MODE;
+		writel(regval, sspi->base + sspi->regs->spi_ctrl);
+		break;
+	case SIRF_USP_SPI_P2:
+	case SIRF_USP_SPI_A7:
+		usp_mode1 |= SIRFSOC_USP_SYNC_MODE;
+		usp_mode1 |= SIRFSOC_USP_TFS_IO_MODE;
+		usp_mode1 &= ~SIRFSOC_USP_TFS_IO_INPUT;
+		writel(usp_mode1, sspi->base + sspi->regs->usp_mode1);
+		break;
+	}
+
+	return 0;
+}
+
 static int
 spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct sirfsoc_spi *sspi;
 	u8 bits_per_word = 0;
 	int hz = 0;
-	u32 regval;
-	u32 txfifo_ctrl, rxfifo_ctrl;
-	u32 fifo_size;
-	u32 usp_mode1, usp_mode2, tx_frm_ctl, rx_frm_ctl;
-	struct sirf_spi_register *spi_reg;
+	u32 regval, txfifo_ctrl, rxfifo_ctrl, tx_frm_ctl, rx_frm_ctl, usp_mode2;
 
 	sspi = spi_master_get_devdata(spi->master);
-	spi_reg = get_sirf_spi_register(sspi);
+
 	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
 	hz = t && t->speed_hz ? t->speed_hz : spi->max_speed_hz;
 
@@ -816,13 +921,18 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		return -EINVAL;
 	}
 	sspi->word_width = DIV_ROUND_UP(bits_per_word, 8);
-	txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(sspi,
-			SIRFSOC_SPI_FIFO_SIZE(sspi) / 2) |
+	txfifo_ctrl = (((sspi->fifo_size / 2) &
+			SIRFSOC_SPI_FIFO_THD_MASK(sspi))
+			<< SIRFSOC_SPI_FIFO_THD_OFFSET) |
 			(sspi->word_width >> 1);
-	rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(sspi,
-			SIRFSOC_SPI_FIFO_SIZE(sspi) / 2) |
+	rxfifo_ctrl = (((sspi->fifo_size / 2) &
+			SIRFSOC_SPI_FIFO_THD_MASK(sspi))
+			<< SIRFSOC_SPI_FIFO_THD_OFFSET) |
 			(sspi->word_width >> 1);
-	if (sspi->spi_type == SIRF_USP_SPI) {
+	writel(txfifo_ctrl, sspi->base + sspi->regs->txfifo_ctrl);
+	writel(rxfifo_ctrl, sspi->base + sspi->regs->rxfifo_ctrl);
+	if (sspi->type == SIRF_USP_SPI_P2 ||
+		sspi->type == SIRF_USP_SPI_A7) {
 		tx_frm_ctl = 0;
 		tx_frm_ctl |= ((bits_per_word - 1) & SIRFSOC_USP_TX_DATA_MASK)
 				<< SIRFSOC_USP_TX_DATA_OFFSET;
@@ -847,104 +957,49 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		writel(tx_frm_ctl | (((usp_mode2 >> 10) &
 			SIRFSOC_USP_CLK_10_11_MASK) <<
 			SIRFSOC_USP_CLK_10_11_OFFSET),
-			sspi->base + spi_reg->usp_tx_frame_ctrl);
+			sspi->base + sspi->regs->usp_tx_frame_ctrl);
 		writel(rx_frm_ctl | (((usp_mode2 >> 12) &
 			SIRFSOC_USP_CLK_12_15_MASK) <<
 			SIRFSOC_USP_CLK_12_15_OFFSET),
-			sspi->base + spi_reg->usp_rx_frame_ctrl);
-	}
-	usp_mode1 = readl(sspi->base + spi_reg->usp_mode1);
-	if (!(spi->mode & SPI_CS_HIGH)) {
-		regval |= SIRFSOC_SPI_CS_IDLE_STAT;
-		usp_mode1 &= ~SIRFSOC_USP_CS_HIGH_VALID;
-	} else {
-		regval &= ~SIRFSOC_SPI_CS_IDLE_STAT;
-		usp_mode1 |= SIRFSOC_USP_CS_HIGH_VALID;
-	}
-	if (!(spi->mode & SPI_LSB_FIRST)) {
-		regval |= SIRFSOC_SPI_TRAN_MSB;
-		usp_mode1 &= ~SIRFSOC_USP_LSB;
-	} else {
-		regval &= ~SIRFSOC_SPI_TRAN_MSB;
-		usp_mode1 |= SIRFSOC_USP_LSB;
-	}
-	if (spi->mode & SPI_CPOL) {
-		regval |= SIRFSOC_SPI_CLK_IDLE_STAT;
-		usp_mode1 |= SIRFSOC_USP_SCLK_IDLE_STAT;
-	} else {
-		regval &= ~SIRFSOC_SPI_CLK_IDLE_STAT;
-		usp_mode1 &= ~SIRFSOC_USP_SCLK_IDLE_STAT;
-	}
-	/*
-	 * Data should be driven at least 1/2 cycle before the fetch edge
-	 * to make sure that data gets stable at the fetch edge.
-	 */
-	if (((spi->mode & SPI_CPOL) && (spi->mode & SPI_CPHA)) ||
-	    (!(spi->mode & SPI_CPOL) && !(spi->mode & SPI_CPHA))) {
-		regval &= ~SIRFSOC_SPI_DRV_POS_EDGE;
-		usp_mode1 |= (SIRFSOC_USP_TXD_FALLING_EDGE |
-				SIRFSOC_USP_RXD_FALLING_EDGE);
-	} else {
-		regval |= SIRFSOC_SPI_DRV_POS_EDGE;
-		usp_mode1 &= ~(SIRFSOC_USP_RXD_FALLING_EDGE |
-				SIRFSOC_USP_RXD_FALLING_EDGE);
-	}
-	fifo_size = SIRFSOC_SPI_FIFO_SIZE(sspi);
-	writel(SIRFSOC_SPI_FIFO_SC(sspi, fifo_size - 2) |
-			SIRFSOC_SPI_FIFO_LC(sspi, fifo_size / 2) |
-			SIRFSOC_SPI_FIFO_HC(sspi, 2),
-		sspi->base + spi_reg->txfifo_level_chk);
-	writel(SIRFSOC_SPI_FIFO_SC(sspi, 2) |
-			SIRFSOC_SPI_FIFO_LC(sspi, fifo_size / 2) |
-			SIRFSOC_SPI_FIFO_HC(sspi, fifo_size - 2),
-		sspi->base + spi_reg->rxfifo_level_chk);
-	writel(txfifo_ctrl, sspi->base + spi_reg->txfifo_ctrl);
-	writel(rxfifo_ctrl, sspi->base + spi_reg->rxfifo_ctrl);
-
-	if (sspi->spi_type != SIRF_USP_SPI && t && t->tx_buf &&
-		!t->rx_buf && (t->len <= SIRFSOC_MAX_CMD_BYTES)) {
-		regval |= (SIRFSOC_SPI_CMD_BYTE_NUM((t->len - 1)) |
-				SIRFSOC_SPI_CMD_MODE);
-		sspi->tx_by_cmd = true;
-	} else {
-		if (sspi->spi_type != SIRF_USP_SPI)
-			regval &= ~SIRFSOC_SPI_CMD_MODE;
-		sspi->tx_by_cmd = false;
-	}
-	/*
-	 * it should never set to hardware cs mode because in hardware cs mode,
-	 * cs signal can't controlled by driver.
-	 */
-	if (sspi->spi_type == SIRF_REAL_SPI) {
-		regval |= SIRFSOC_SPI_CS_IO_MODE;
-		writel(regval, sspi->base + spi_reg->spi_ctrl);
-	}
-	if (sspi->spi_type == SIRF_USP_SPI) {
-		writel(readl(sspi->base + spi_reg->usp_mode2) |
+			sspi->base + sspi->regs->usp_rx_frame_ctrl);
+		writel(readl(sspi->base + sspi->regs->usp_mode2) |
 			((usp_mode2 & SIRFSOC_USP_CLK_DIVISOR_MASK) <<
 			SIRFSOC_USP_CLK_DIVISOR_OFFSET) |
 			(SIRFSOC_USP_RXD_DELAY_LEN <<
 			 SIRFSOC_USP_RXD_DELAY_OFFSET) |
 			(SIRFSOC_USP_TXD_DELAY_LEN <<
 			 SIRFSOC_USP_TXD_DELAY_OFFSET),
-			sspi->base + spi_reg->usp_mode2);
-
-		usp_mode1 |= SIRFSOC_USP_SYNC_MODE;
-		usp_mode1 |= SIRFSOC_USP_TFS_IO_MODE;
-		usp_mode1 &= ~SIRFSOC_USP_TFS_IO_INPUT;
-		writel(usp_mode1, sspi->base + spi_reg->usp_mode1);
+			sspi->base + sspi->regs->usp_mode2);
+	}
+	if (sspi->type == SIRF_REAL_SPI)
+		writel(regval, sspi->base + sspi->regs->spi_ctrl);
+	spi_sirfsoc_config_mode(spi);
+	if (sspi->type == SIRF_REAL_SPI) {
+		if (t && t->tx_buf && !t->rx_buf &&
+			(t->len <= SIRFSOC_MAX_CMD_BYTES)) {
+			sspi->tx_by_cmd = true;
+			writel(readl(sspi->base + sspi->regs->spi_ctrl) |
+				(SIRFSOC_SPI_CMD_BYTE_NUM((t->len - 1)) |
+				SIRFSOC_SPI_CMD_MODE),
+				sspi->base + sspi->regs->spi_ctrl);
+		} else {
+			sspi->tx_by_cmd = false;
+			writel(readl(sspi->base + sspi->regs->spi_ctrl) &
+				~SIRFSOC_SPI_CMD_MODE,
+				sspi->base + sspi->regs->spi_ctrl);
+		}
 	}
 	if (IS_DMA_VALID(t)) {
 		/* Enable DMA mode for RX, TX */
-		writel(0, sspi->base + spi_reg->tx_dma_io_ctrl);
+		writel(0, sspi->base + sspi->regs->tx_dma_io_ctrl);
 		writel(SIRFSOC_SPI_RX_DMA_FLUSH,
-			sspi->base + spi_reg->rx_dma_io_ctrl);
+			sspi->base + sspi->regs->rx_dma_io_ctrl);
 	} else {
 		/* Enable IO mode for RX, TX */
 		writel(SIRFSOC_SPI_IO_MODE_SEL,
-			sspi->base + spi_reg->tx_dma_io_ctrl);
+			sspi->base + sspi->regs->tx_dma_io_ctrl);
 		writel(SIRFSOC_SPI_IO_MODE_SEL,
-			sspi->base + spi_reg->rx_dma_io_ctrl);
+			sspi->base + sspi->regs->rx_dma_io_ctrl);
 	}
 	return 0;
 }
@@ -952,12 +1007,9 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 static int spi_sirfsoc_setup(struct spi_device *spi)
 {
 	struct sirfsoc_spi *sspi;
-	struct sirf_spi_register *spi_reg;
 	int ret = 0;
-	u32 usp_mode1;
 
 	sspi = spi_master_get_devdata(spi->master);
-	spi_reg = get_sirf_spi_register(sspi);
 	if (spi->cs_gpio == -ENOENT)
 		sspi->hw_cs = true;
 	else {
@@ -982,26 +1034,7 @@ static int spi_sirfsoc_setup(struct spi_device *spi)
 			spi_set_ctldata(spi, cs);
 		}
 	}
-	if (sspi->spi_type == SIRF_REAL_SPI) {
-		writel(0, sspi->base + spi_reg->spi_dummy_delay_ctrl);
-		writel(readl(sspi->base + spi_reg->spi_ctrl) |
-			SIRFSOC_SPI_CS_IO_MODE, sspi->base + spi_reg->spi_ctrl);
-	}
-	if (sspi->spi_type == SIRF_USP_SPI) {
-		writel(readl(sspi->base + spi_reg->usp_mode1) & ~SIRFSOC_USP_EN,
-				sspi->base + spi_reg->usp_mode1);
-		writel(readl(sspi->base + spi_reg->usp_mode1) | SIRFSOC_USP_EN,
-					sspi->base + spi_reg->usp_mode1);
-		usp_mode1 = readl(sspi->base + spi_reg->usp_mode1);
-		if (!(spi->mode & SPI_CS_HIGH))
-			usp_mode1 &= ~SIRFSOC_USP_CS_HIGH_VALID;
-		else
-			usp_mode1 |= SIRFSOC_USP_CS_HIGH_VALID;
-		usp_mode1 |= SIRFSOC_USP_SYNC_MODE;
-		usp_mode1 |= SIRFSOC_USP_TFS_IO_MODE;
-		usp_mode1 &= ~SIRFSOC_USP_TFS_IO_INPUT;
-		writel(usp_mode1, sspi->base + spi_reg->usp_mode1);
-	}
+	spi_sirfsoc_config_mode(spi);
 	spi_sirfsoc_chipselect(spi, BITBANG_CS_INACTIVE);
 exit:
 	return ret;
@@ -1017,8 +1050,8 @@ static void spi_sirfsoc_cleanup(struct spi_device *spi)
 
 static const struct of_device_id spi_sirfsoc_of_match[] = {
 	{ .compatible = "sirf,prima2-spi", .data = &sirf_real_spi},
-	{ .compatible = "sirf,prima2-usp-spi", .data = &sirf_usp_spi},
-	{ .compatible = "sirf,atlas7-usp-spi", .data = &sirf_usp_spi},
+	{ .compatible = "sirf,prima2-usp-spi", .data = &sirf_usp_spi_p2},
+	{ .compatible = "sirf,atlas7-usp-spi", .data = &sirf_usp_spi_a7},
 	{}
 };
 MODULE_DEVICE_TABLE(of, spi_sirfsoc_of_match);
@@ -1028,6 +1061,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	struct sirfsoc_spi *sspi;
 	struct spi_master *master;
 	struct resource *mem_res;
+	struct sirf_spi_comp_data *spi_comp_data;
 	int irq;
 	int ret;
 	const struct of_device_id *match;
@@ -1046,16 +1080,13 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	match = of_match_node(spi_sirfsoc_of_match, pdev->dev.of_node);
 	platform_set_drvdata(pdev, master);
 	sspi = spi_master_get_devdata(master);
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-spi"))
-		sspi->spi_type = SIRF_USP_SPI;
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,atlas7-usp-spi")) {
-		sspi->spi_type = SIRF_USP_SPI;
-		sspi->is_atlas7_usp = true;
-	}
-
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-spi"))
-		sspi->spi_type = SIRF_REAL_SPI;
-	sspi->spi_register = (struct sirf_spi_register *)match->data;
+	sspi->fifo_full_offset = ilog2(sspi->fifo_size);
+	spi_comp_data = (struct sirf_spi_comp_data *)match->data;
+	sspi->regs = spi_comp_data->regs;
+	sspi->type = spi_comp_data->type;
+	sspi->fifo_level_chk_mask = (sspi->fifo_size / 4) - 1;
+	sspi->dat_max_frm_len = spi_comp_data->dat_max_frm_len;
+	sspi->fifo_size = spi_comp_data->fifo_size;
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sspi->base = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(sspi->base)) {
@@ -1170,15 +1201,13 @@ static int spi_sirfsoc_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct sirfsoc_spi *sspi = spi_master_get_devdata(master);
-	struct sirf_spi_register *spi_reg;
 
-	spi_reg = get_sirf_spi_register(sspi);
 	clk_enable(sspi->clk);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + spi_reg->txfifo_op);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + spi_reg->rxfifo_op);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + spi_reg->txfifo_op);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + spi_reg->rxfifo_op);
-	return spi_master_resume(master);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + sspi->regs->txfifo_op);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + sspi->regs->rxfifo_op);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + sspi->regs->txfifo_op);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + sspi->regs->rxfifo_op);
+	return 0;
 }
 #endif
 
-- 
2.3.5
