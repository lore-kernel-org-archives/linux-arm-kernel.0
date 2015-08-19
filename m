From: leilk.liu@mediatek.com (Leilk Liu)
Date: Wed, 19 Aug 2015 11:37:56 +0800
Subject: [PATCH 1/3] spi: mediatek: revise coding style
In-Reply-To: <1439955478-2733-1-git-send-email-leilk.liu@mediatek.com>
References: <1439955478-2733-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1439955478-2733-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch revises mediatek spi driver coding styles.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 125 ++++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index c467ce0..814bca4 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -48,15 +49,8 @@
 #define SPI_CFG1_PACKET_LOOP_MASK         0xff00
 #define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
 
-#define SPI_CMD_ACT_OFFSET                0
-#define SPI_CMD_RESUME_OFFSET             1
-#define SPI_CMD_CPHA_OFFSET               8
-#define SPI_CMD_CPOL_OFFSET               9
-#define SPI_CMD_TXMSBF_OFFSET             12
-#define SPI_CMD_RXMSBF_OFFSET             13
-#define SPI_CMD_RX_ENDIAN_OFFSET          14
-#define SPI_CMD_TX_ENDIAN_OFFSET          15
-
+#define SPI_CMD_ACT                  BIT(0)
+#define SPI_CMD_RESUME               BIT(1)
 #define SPI_CMD_RST                  BIT(2)
 #define SPI_CMD_PAUSE_EN             BIT(4)
 #define SPI_CMD_DEASSERT             BIT(5)
@@ -71,12 +65,10 @@
 #define SPI_CMD_FINISH_IE            BIT(16)
 #define SPI_CMD_PAUSE_IE             BIT(17)
 
-#define MTK_SPI_QUIRK_PAD_SELECT 1
-/* Must explicitly send dummy Tx bytes to do Rx only transfer */
-#define MTK_SPI_QUIRK_MUST_TX 1
-
 #define MT8173_SPI_MAX_PAD_SEL 3
 
+#define MTK_SPI_PAUSE_INT_STATUS 0x2
+
 #define MTK_SPI_IDLE 0
 #define MTK_SPI_PAUSED 1
 
@@ -84,8 +76,9 @@
 #define MTK_SPI_PACKET_SIZE 1024
 
 struct mtk_spi_compatible {
-	u32 need_pad_sel;
-	u32 must_tx;
+	bool need_pad_sel;
+	/* Must explicitly send dummy Tx bytes to do Rx only transfer */
+	bool must_tx;
 };
 
 struct mtk_spi {
@@ -100,19 +93,11 @@ struct mtk_spi {
 	const struct mtk_spi_compatible *dev_comp;
 };
 
-static const struct mtk_spi_compatible mt6589_compat = {
-	.need_pad_sel = 0,
-	.must_tx = 0,
-};
-
-static const struct mtk_spi_compatible mt8135_compat = {
-	.need_pad_sel = 0,
-	.must_tx = 0,
-};
-
+static const struct mtk_spi_compatible mt6589_compat;
+static const struct mtk_spi_compatible mt8135_compat;
 static const struct mtk_spi_compatible mt8173_compat = {
-	.need_pad_sel = MTK_SPI_QUIRK_PAD_SELECT,
-	.must_tx = MTK_SPI_QUIRK_MUST_TX,
+	.need_pad_sel = true,
+	.must_tx = true,
 };
 
 /*
@@ -156,14 +141,24 @@ static void mtk_spi_config(struct mtk_spi *mdata,
 	reg_val = readl(mdata->base + SPI_CMD_REG);
 
 	/* set the mlsbx and mlsbtx */
-	reg_val &= ~(SPI_CMD_TXMSBF | SPI_CMD_RXMSBF);
-	reg_val |= (chip_config->tx_mlsb << SPI_CMD_TXMSBF_OFFSET);
-	reg_val |= (chip_config->rx_mlsb << SPI_CMD_RXMSBF_OFFSET);
+	if (chip_config->tx_mlsb)
+		reg_val |= SPI_CMD_TXMSBF;
+	else
+		reg_val &= ~SPI_CMD_TXMSBF;
+	if (chip_config->rx_mlsb)
+		reg_val |= SPI_CMD_RXMSBF;
+	else
+		reg_val &= ~SPI_CMD_RXMSBF;
 
 	/* set the tx/rx endian */
-	reg_val &= ~(SPI_CMD_TX_ENDIAN | SPI_CMD_RX_ENDIAN);
-	reg_val |= (chip_config->tx_endian << SPI_CMD_TX_ENDIAN_OFFSET);
-	reg_val |= (chip_config->rx_endian << SPI_CMD_RX_ENDIAN_OFFSET);
+	if (chip_config->tx_endian)
+		reg_val |= SPI_CMD_TX_ENDIAN;
+	else
+		reg_val &= ~SPI_CMD_TX_ENDIAN;
+	if (chip_config->rx_endian)
+		reg_val |= SPI_CMD_RX_ENDIAN;
+	else
+		reg_val &= ~SPI_CMD_RX_ENDIAN;
 
 	/* set finish and pause interrupt always enable */
 	reg_val |= SPI_CMD_FINISH_IE | SPI_CMD_PAUSE_EN;
@@ -196,7 +191,7 @@ static int mtk_spi_prepare_hardware(struct spi_master *master)
 
 	trans = list_first_entry(&msg->transfers, struct spi_transfer,
 				 transfer_list);
-	if (trans->cs_change == 0) {
+	if (!trans->cs_change) {
 		mdata->state = MTK_SPI_IDLE;
 		mtk_spi_reset(mdata);
 	}
@@ -226,9 +221,14 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 	cpol = spi->mode & SPI_CPOL ? 1 : 0;
 
 	reg_val = readl(mdata->base + SPI_CMD_REG);
-	reg_val &= ~(SPI_CMD_CPHA | SPI_CMD_CPOL);
-	reg_val |= (cpha << SPI_CMD_CPHA_OFFSET);
-	reg_val |= (cpol << SPI_CMD_CPOL_OFFSET);
+	if (cpha)
+		reg_val |= SPI_CMD_CPHA;
+	else
+		reg_val &= ~SPI_CMD_CPHA;
+	if (cpol)
+		reg_val |= SPI_CMD_CPOL;
+	else
+		reg_val &= ~SPI_CMD_CPOL;
 	writel(reg_val, mdata->base + SPI_CMD_REG);
 
 	chip_config = spi->controller_data;
@@ -257,8 +257,7 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 static void mtk_spi_prepare_transfer(struct spi_master *master,
 				     struct spi_transfer *xfer)
 {
-	u32 spi_clk_hz, div, high_time, low_time, holdtime,
-	    setuptime, cs_idletime, reg_val = 0;
+	u32 spi_clk_hz, div, sck_time, cs_time, reg_val = 0;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	spi_clk_hz = clk_get_rate(mdata->spi_clk);
@@ -267,21 +266,18 @@ static void mtk_spi_prepare_transfer(struct spi_master *master,
 	else
 		div = 1;
 
-	high_time = (div + 1) / 2;
-	low_time = (div + 1) / 2;
-	holdtime = (div + 1) / 2 * 2;
-	setuptime = (div + 1) / 2 * 2;
-	cs_idletime = (div + 1) / 2 * 2;
+	sck_time = (div + 1) / 2;
+	cs_time = sck_time * 2;
 
-	reg_val |= (((high_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
-	reg_val |= (((low_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
-	reg_val |= (((holdtime - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
-	reg_val |= (((setuptime - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
+	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
+	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
+	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
+	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
 	writel(reg_val, mdata->base + SPI_CFG0_REG);
 
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
 	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
-	reg_val |= (((cs_idletime - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
+	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
 }
 
@@ -290,11 +286,11 @@ static void mtk_spi_setup_packet(struct spi_master *master)
 	u32 packet_size, packet_loop, reg_val;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	packet_size = min_t(unsigned, mdata->xfer_len, MTK_SPI_PACKET_SIZE);
+	packet_size = min_t(u32, mdata->xfer_len, MTK_SPI_PACKET_SIZE);
 	packet_loop = mdata->xfer_len / packet_size;
 
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
-	reg_val &= ~(SPI_CFG1_PACKET_LENGTH_MASK + SPI_CFG1_PACKET_LOOP_MASK);
+	reg_val &= ~(SPI_CFG1_PACKET_LENGTH_MASK | SPI_CFG1_PACKET_LOOP_MASK);
 	reg_val |= (packet_size - 1) << SPI_CFG1_PACKET_LENGTH_OFFSET;
 	reg_val |= (packet_loop - 1) << SPI_CFG1_PACKET_LOOP_OFFSET;
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
@@ -302,20 +298,20 @@ static void mtk_spi_setup_packet(struct spi_master *master)
 
 static void mtk_spi_enable_transfer(struct spi_master *master)
 {
-	int cmd;
+	u32 cmd;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	cmd = readl(mdata->base + SPI_CMD_REG);
 	if (mdata->state == MTK_SPI_IDLE)
-		cmd |= 1 << SPI_CMD_ACT_OFFSET;
+		cmd |= SPI_CMD_ACT;
 	else
-		cmd |= 1 << SPI_CMD_RESUME_OFFSET;
+		cmd |= SPI_CMD_RESUME;
 	writel(cmd, mdata->base + SPI_CMD_REG);
 }
 
-static int mtk_spi_get_mult_delta(int xfer_len)
+static int mtk_spi_get_mult_delta(u32 xfer_len)
 {
-	int mult_delta;
+	u32 mult_delta;
 
 	if (xfer_len > MTK_SPI_PACKET_SIZE)
 		mult_delta = xfer_len % MTK_SPI_PACKET_SIZE;
@@ -459,7 +455,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	struct spi_transfer *trans = mdata->cur_transfer;
 
 	reg_val = readl(mdata->base + SPI_STATUS0_REG);
-	if (reg_val & 0x2)
+	if (reg_val & MTK_SPI_PAUSE_INT_STATUS)
 		mdata->state = MTK_SPI_PAUSED;
 	else
 		mdata->state = MTK_SPI_IDLE;
@@ -527,7 +523,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	struct mtk_spi *mdata;
 	const struct of_device_id *of_id;
 	struct resource *res;
-	int	irq, ret;
+	int irq, ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
 	if (!master) {
@@ -693,8 +689,10 @@ static int mtk_spi_resume(struct device *dev)
 
 	if (!pm_runtime_suspended(dev)) {
 		ret = clk_prepare_enable(mdata->spi_clk);
-		if (ret < 0)
+		if (ret < 0) {
+			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
 			return ret;
+		}
 	}
 
 	ret = spi_master_resume(master);
@@ -720,8 +718,15 @@ static int mtk_spi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	int ret;
 
-	return clk_prepare_enable(mdata->spi_clk);
+	ret = clk_prepare_enable(mdata->spi_clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 #endif /* CONFIG_PM */
 
-- 
1.8.1.1.dirty
