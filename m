From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue,  3 Apr 2018 18:29:02 +0300
Subject: [PATCH v2 3/6] spi: sun4i: coding style/readability improvements
In-Reply-To: <20180403152905.1524-1-ssuloev@orpaltech.com>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
Message-ID: <20180403152905.1524-4-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor changes to fulfill the coding style and
improve the readability.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun4i.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 08fd007..899e956 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -83,8 +83,11 @@
 #define SUN4I_FIFO_STA_TF_CNT_MASK		0x7f
 #define SUN4I_FIFO_STA_TF_CNT_BITS		16
 
+#define SUN4I_SPI_MAX_SPEED_HZ		100 * 1000 * 1000
+#define SUN4I_SPI_MIN_SPEED_HZ		3 * 1000
+#define SUN4I_SPI_MODE_BITS		(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST)
+
 struct sun4i_spi {
-	struct spi_master	*master;
 	void __iomem		*base_addr;
 	struct clk		*hclk;
 	struct clk		*mclk;
@@ -418,12 +421,23 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	struct resource	*res;
 	int ret = 0, irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sun4i_spi));
+	master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
 	if (!master) {
 		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
 		return -ENOMEM;
 	}
 
+	master->max_speed_hz = SUN4I_SPI_MAX_SPEED_HZ;
+	master->min_speed_hz = SUN4I_SPI_MIN_SPEED_HZ;
+	master->num_chipselect = 4;
+	master->mode_bits = SUN4I_SPI_MODE_BITS;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->set_cs = sun4i_spi_set_cs;
+	master->transfer_one = sun4i_spi_transfer_one;
+	master->max_transfer_size = sun4i_spi_max_transfer_size;
+	master->dev.of_node = pdev->dev.of_node;
+	master->auto_runtime_pm = true;
+
 	platform_set_drvdata(pdev, master);
 	sspi = spi_master_get_devdata(master);
 
@@ -442,24 +456,12 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun4i_spi_handler,
-			       0, "sun4i-spi", sspi);
+			       0, dev_name(&pdev->dev), sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
 		goto err_free_master;
 	}
 
-	sspi->master = master;
-	master->max_speed_hz = 100 * 1000 * 1000;
-	master->min_speed_hz = 3 * 1000;
-	master->set_cs = sun4i_spi_set_cs;
-	master->transfer_one = sun4i_spi_transfer_one;
-	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->dev.of_node = pdev->dev.of_node;
-	master->auto_runtime_pm = true;
-	master->max_transfer_size = sun4i_spi_max_transfer_size;
-
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
 		dev_err(&pdev->dev, "Unable to acquire AHB clock\n");
-- 
2.16.2
