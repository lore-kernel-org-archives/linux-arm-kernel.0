From: hramrach@gmail.com (Michal Suchanek)
Date: 13 Jun 2016 17:46:50 -0000
Subject: [PATCH v3 04/13] spi: sunxi: expose maximum transfer size limit
In-Reply-To: <cover.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
Message-ID: <6962eec8da0b5255cafd7782bcc39ca19041c2b1.1465490774.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i spi hardware can trasfer at most 63 bytes of data without DMA
support so report the limitation. Same for sun6i.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-sun4i.c | 6 ++++++
 drivers/spi/spi-sun6i.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index f2848b7..ba2b5c8 100644
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
@@ -411,6 +416,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
+	master->max_transfer_size = sun4i_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 8f6be86..bc29a98 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -153,6 +153,10 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 }
 
+static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
+{
+	return SUN6I_FIFO_DEPTH - 1;
+}
 
 static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
@@ -403,6 +407,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
+	master->max_transfer_size = sun6i_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
-- 
2.8.1
