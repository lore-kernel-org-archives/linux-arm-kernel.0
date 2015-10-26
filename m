From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 26 Oct 2015 16:09:42 +0800
Subject: [PATCH v2 2/5] spi: mediatek: remove mtk_spi_config
In-Reply-To: <1445846985-26229-1-git-send-email-leilk.liu@mediatek.com>
References: <1445846985-26229-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1445846985-26229-3-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtk_spi_config() and mtk_spi_prepare_message() both initialize
spi register, so remove mtk_spi_config() and init all register
in mtk_spi_prepare_message().

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 59 +++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index ecb6c58..7bd84c8 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -131,10 +131,34 @@ static void mtk_spi_reset(struct mtk_spi *mdata)
 	writel(reg_val, mdata->base + SPI_CMD_REG);
 }
 
-static void mtk_spi_config(struct mtk_spi *mdata,
-			   struct mtk_chip_config *chip_config)
+static int mtk_spi_prepare_message(struct spi_master *master,
+				   struct spi_message *msg)
 {
+	u16 cpha, cpol;
 	u32 reg_val;
+	struct mtk_chip_config *chip_config;
+	struct spi_device *spi = msg->spi;
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	cpha = spi->mode & SPI_CPHA ? 1 : 0;
+	cpol = spi->mode & SPI_CPOL ? 1 : 0;
+
+	chip_config = spi->controller_data;
+	if (!chip_config) {
+		chip_config = (void *)&mtk_default_chip_info;
+		spi->controller_data = chip_config;
+	}
+
+	reg_val = readl(mdata->base + SPI_CMD_REG);
+	if (cpha)
+		reg_val |= SPI_CMD_CPHA;
+	else
+		reg_val &= ~SPI_CMD_CPHA;
+	if (cpol)
+		reg_val |= SPI_CMD_CPOL;
+	else
+		reg_val &= ~SPI_CMD_CPOL;
+	writel(reg_val, mdata->base + SPI_CMD_REG);
 
 	reg_val = readl(mdata->base + SPI_CMD_REG);
 
@@ -171,37 +195,6 @@ static void mtk_spi_config(struct mtk_spi *mdata,
 	/* pad select */
 	if (mdata->dev_comp->need_pad_sel)
 		writel(mdata->pad_sel, mdata->base + SPI_PAD_SEL_REG);
-}
-
-static int mtk_spi_prepare_message(struct spi_master *master,
-				   struct spi_message *msg)
-{
-	u32 reg_val;
-	u8 cpha, cpol;
-	struct mtk_chip_config *chip_config;
-	struct spi_device *spi = msg->spi;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
-
-	cpha = spi->mode & SPI_CPHA ? 1 : 0;
-	cpol = spi->mode & SPI_CPOL ? 1 : 0;
-
-	reg_val = readl(mdata->base + SPI_CMD_REG);
-	if (cpha)
-		reg_val |= SPI_CMD_CPHA;
-	else
-		reg_val &= ~SPI_CMD_CPHA;
-	if (cpol)
-		reg_val |= SPI_CMD_CPOL;
-	else
-		reg_val &= ~SPI_CMD_CPOL;
-	writel(reg_val, mdata->base + SPI_CMD_REG);
-
-	chip_config = spi->controller_data;
-	if (!chip_config) {
-		chip_config = (void *)&mtk_default_chip_info;
-		spi->controller_data = chip_config;
-	}
-	mtk_spi_config(mdata, chip_config);
 
 	return 0;
 }
-- 
1.8.1.1.dirty
