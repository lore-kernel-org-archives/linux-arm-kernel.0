From: leilk.liu@mediatek.com (Leilk Liu)
Date: Fri, 2 Jun 2017 15:18:42 +0800
Subject: [PATCH 2/3] spi: mediatek: support adjust register define
In-Reply-To: <1496387923-31674-1-git-send-email-leilk.liu@mediatek.com>
References: <1496387923-31674-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1496387923-31674-3-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch adds support for adjust register design.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c                 |   45 ++++++++++++++++++++++++++----
 include/linux/platform_data/spi-mt65xx.h |    2 ++
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 278867a..3d7cd2d 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -35,11 +35,15 @@
 #define SPI_CMD_REG                       0x0018
 #define SPI_STATUS0_REG                   0x001c
 #define SPI_PAD_SEL_REG                   0x0024
+#define SPI_CFG2_REG                      0x0028
 
 #define SPI_CFG0_SCK_HIGH_OFFSET          0
 #define SPI_CFG0_SCK_LOW_OFFSET           8
 #define SPI_CFG0_CS_HOLD_OFFSET           16
 #define SPI_CFG0_CS_SETUP_OFFSET          24
+#define SPI_ADJUST_CFG0_SCK_LOW_OFFSET    16
+#define SPI_ADJUST_CFG0_CS_HOLD_OFFSET    0
+#define SPI_ADJUST_CFG0_CS_SETUP_OFFSET   16
 
 #define SPI_CFG1_CS_IDLE_OFFSET           0
 #define SPI_CFG1_PACKET_LOOP_OFFSET       8
@@ -55,6 +59,8 @@
 #define SPI_CMD_RST                  BIT(2)
 #define SPI_CMD_PAUSE_EN             BIT(4)
 #define SPI_CMD_DEASSERT             BIT(5)
+#define SPI_CMD_SAMPLE_SEL           BIT(6)
+#define SPI_CMD_CS_POL               BIT(7)
 #define SPI_CMD_CPHA                 BIT(8)
 #define SPI_CMD_CPOL                 BIT(9)
 #define SPI_CMD_RX_DMA               BIT(10)
@@ -80,6 +86,8 @@ struct mtk_spi_compatible {
 	bool need_pad_sel;
 	/* Must explicitly send dummy Tx bytes to do Rx only transfer */
 	bool must_tx;
+	/* some IC design adjust register define */
+	bool adjust_reg;
 };
 
 struct mtk_spi {
@@ -108,6 +116,8 @@ struct mtk_spi {
 static const struct mtk_chip_config mtk_default_chip_info = {
 	.rx_mlsb = 1,
 	.tx_mlsb = 1,
+	.cs_pol = 0,
+	.sample_sel = 0,
 };
 
 static const struct of_device_id mtk_spi_of_match[] = {
@@ -182,6 +192,17 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 	reg_val |= SPI_CMD_RX_ENDIAN;
 #endif
 
+	if (mdata->dev_comp->adjust_reg) {
+		if (chip_config->cs_pol)
+			reg_val |= SPI_CMD_CS_POL;
+		else
+			reg_val &= ~SPI_CMD_CS_POL;
+		if (chip_config->sample_sel)
+			reg_val |= SPI_CMD_SAMPLE_SEL;
+		else
+			reg_val &= ~SPI_CMD_SAMPLE_SEL;
+	}
+
 	/* set finish and pause interrupt always enable */
 	reg_val |= SPI_CMD_FINISH_IE | SPI_CMD_PAUSE_IE;
 
@@ -233,11 +254,25 @@ static void mtk_spi_prepare_transfer(struct spi_master *master,
 	sck_time = (div + 1) / 2;
 	cs_time = sck_time * 2;
 
-	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
-	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
-	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
-	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
-	writel(reg_val, mdata->base + SPI_CFG0_REG);
+	if (mdata->dev_comp->adjust_reg) {
+		reg_val |= (((sck_time - 1) & 0xffff)
+			   << SPI_CFG0_SCK_HIGH_OFFSET);
+		reg_val |= (((sck_time - 1) & 0xffff)
+			   << SPI_ADJUST_CFG0_SCK_LOW_OFFSET);
+		writel(reg_val, mdata->base + SPI_CFG2_REG);
+		reg_val |= (((cs_time - 1) & 0xffff)
+			   << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
+		reg_val |= (((cs_time - 1) & 0xffff)
+			   << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
+		writel(reg_val, mdata->base + SPI_CFG0_REG);
+	} else {
+		reg_val |= (((sck_time - 1) & 0xff)
+			   << SPI_CFG0_SCK_HIGH_OFFSET);
+		reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
+		reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
+		reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
+		writel(reg_val, mdata->base + SPI_CFG0_REG);
+	}
 
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
 	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
diff --git a/include/linux/platform_data/spi-mt65xx.h b/include/linux/platform_data/spi-mt65xx.h
index 54b0448..ba4e4bb 100644
--- a/include/linux/platform_data/spi-mt65xx.h
+++ b/include/linux/platform_data/spi-mt65xx.h
@@ -16,5 +16,7 @@
 struct mtk_chip_config {
 	u32 tx_mlsb;
 	u32 rx_mlsb;
+	u32 cs_pol;
+	u32 sample_sel;
 };
 #endif
-- 
1.7.9.5
