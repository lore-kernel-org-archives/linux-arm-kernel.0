From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 20 Aug 2015 17:19:08 +0800
Subject: [PATCH v2 3/4] spi: mediatek: use BIT() to instead of SPI_CMD_*_OFFSET
In-Reply-To: <1440062349-25513-1-git-send-email-leilk.liu@mediatek.com>
References: <1440062349-25513-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1440062349-25513-4-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes SPI_CMD_*_OFFSET defines, and uses the BIT(x)
defines instead.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 4fa4332..43c1dd5 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -48,15 +48,8 @@
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
@@ -143,9 +136,14 @@ static void mtk_spi_config(struct mtk_spi *mdata,
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
 #ifdef __LITTLE_ENDIAN
@@ -201,9 +199,14 @@ static int mtk_spi_prepare_message(struct spi_master *master,
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
@@ -282,9 +285,9 @@ static void mtk_spi_enable_transfer(struct spi_master *master)
 
 	cmd = readl(mdata->base + SPI_CMD_REG);
 	if (mdata->state == MTK_SPI_IDLE)
-		cmd |= 1 << SPI_CMD_ACT_OFFSET;
+		cmd |= SPI_CMD_ACT;
 	else
-		cmd |= 1 << SPI_CMD_RESUME_OFFSET;
+		cmd |= SPI_CMD_RESUME;
 	writel(cmd, mdata->base + SPI_CMD_REG);
 }
 
-- 
1.8.1.1.dirty
