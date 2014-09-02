From: Barry.Song@csr.com (Barry Song)
Date: Tue, 2 Sep 2014 17:01:02 +0800
Subject: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and cleanup
 callbacks
In-Reply-To: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1409648468-5436-3-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

move spi controller's gpio request work out from probe() to spi device
register stage, so after spi device register spi controller can deactive
device's gpio chipselect. old code can't do it because gpio request has
not be done until device register is finised in spi_bitbang_start.
and add cleanup function to free CS gpio.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 58 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 44ec3bb..a21e423 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -626,7 +626,7 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 static int spi_sirfsoc_setup(struct spi_device *spi)
 {
 	struct sirfsoc_spi *sspi;
-
+	int ret = 0;
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
@@ -634,9 +634,41 @@ static int spi_sirfsoc_setup(struct spi_device *spi)
 
 	if (spi->cs_gpio == -ENOENT)
 		sspi->hw_cs = true;
-	else
+	else {
 		sspi->hw_cs = false;
-	return spi_sirfsoc_setup_transfer(spi, NULL);
+		if (!spi_get_ctldata(spi)) {
+			void *cs = kmalloc(sizeof(int), GFP_KERNEL);
+			if (!cs) {
+				ret = -ENOMEM;
+				goto exit;
+			}
+			ret = gpio_is_valid(spi->cs_gpio);
+			if (!ret) {
+				dev_err(&spi->dev, "no valid gpio\n");
+				ret = -ENOENT;
+				goto exit;
+			}
+			ret = gpio_request(spi->cs_gpio, DRIVER_NAME);
+			if (ret) {
+				dev_err(&spi->dev, "failed to request gpio\n");
+				goto exit;
+			}
+			spi_set_ctldata(spi, cs);
+		}
+	}
+	writel(readl(sspi->base + SIRFSOC_SPI_CTRL) | SIRFSOC_SPI_CS_IO_MODE,
+			sspi->base + SIRFSOC_SPI_CTRL);
+	spi_sirfsoc_chipselect(spi, BITBANG_CS_INACTIVE);
+exit:
+	return ret;
+}
+
+static void spi_sirfsoc_cleanup(struct spi_device *spi)
+{
+	if (spi_get_ctldata(spi)) {
+		gpio_free(spi->cs_gpio);
+		kfree(spi_get_ctldata(spi));
+	}
 }
 
 static int spi_sirfsoc_probe(struct platform_device *pdev)
@@ -645,7 +677,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct resource *mem_res;
 	int irq;
-	int i, ret;
+	int ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
 	if (!master) {
@@ -677,6 +709,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	sspi->bitbang.setup_transfer = spi_sirfsoc_setup_transfer;
 	sspi->bitbang.txrx_bufs = spi_sirfsoc_transfer;
 	sspi->bitbang.master->setup = spi_sirfsoc_setup;
+	sspi->bitbang.master->cleanup = spi_sirfsoc_cleanup;
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(12) |
@@ -723,22 +756,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 
 	ret = spi_bitbang_start(&sspi->bitbang);
 	if (ret)
-		goto free_dummypage;
-	for (i = 0; master->cs_gpios && i < master->num_chipselect; i++) {
-		if (master->cs_gpios[i] == -ENOENT)
-			continue;
-		if (!gpio_is_valid(master->cs_gpios[i])) {
-			dev_err(&pdev->dev, "no valid gpio\n");
-			ret = -EINVAL;
-			goto free_dummypage;
-		}
-		ret = devm_gpio_request(&pdev->dev,
-				master->cs_gpios[i], DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to request gpio\n");
-			goto free_dummypage;
-		}
-	}
+		goto free_clk;
 	dev_info(&pdev->dev, "registerred, bus number = %d\n", master->bus_num);
 
 	return 0;
-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
