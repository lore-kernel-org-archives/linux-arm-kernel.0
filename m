From: hramrach@gmail.com (Michal Suchanek)
Date: 26 May 2016 19:25:24 -0000
Subject: [PATCH 3/5] spi: sunxi: expose maximum transfer size limit
In-Reply-To: <cover.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
Message-ID: <5fffb7eca6f4b70853d92be2403595d6d06bede7.1464130597.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i spi hardware can trasfer at most 63 bytes of data without DMA
support so report the limitation. Same on sun6i.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-sun4i.c | 6 ++++++
 drivers/spi/spi-sun6i.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 04f1b77..bf52b09 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -167,6 +167,11 @@ static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 }
 
+static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
+{
+	return SUN4I_FIFO_DEPTH - 1;
+}
+
 static int sun4i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
@@ -407,6 +412,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
+	master->max_transfer_size = sun4i_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 8954a62..f491a41 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -154,6 +154,11 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 }
 
 
+static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
+{
+	return SUN6I_FIFO_DEPTH - 1;
+}
+
 static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
@@ -418,6 +423,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
+	master->max_transfer_size = sun6i_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
-- 
2.8.1
