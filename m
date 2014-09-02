From: Barry.Song@csr.com (Barry Song)
Date: Tue, 2 Sep 2014 17:01:01 +0800
Subject: [PATCH 1/8] spi: sirf: correct spi gpio and hardware chipselect
 behaviour
In-Reply-To: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1409648468-5436-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

the old codes check the cs-gpios, if the gpio number is 0 like:
<&gpio, 0, 0>, the driver will use the only hardware chipselect.

this is wrong because of_spi_register_master() can read property
cs-gpios from device node and set the spi master's cs number and
gpio cs automatically based on whether the cs-gpios is valid.

this patch fixes the beviour of CSR spi driver and move to a core
level supported way.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 86 +++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 53 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 95ac276..44ec3bb 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -170,8 +170,7 @@ struct sirfsoc_spi {
 	 * command model
 	 */
 	bool	tx_by_cmd;
-
-	int chipselect[0];
+	bool	hw_cs;
 };
 
 static void spi_sirfsoc_rx_word_u8(struct sirfsoc_spi *sspi)
@@ -484,7 +483,7 @@ static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
 {
 	struct sirfsoc_spi *sspi = spi_master_get_devdata(spi->master);
 
-	if (sspi->chipselect[spi->chip_select] == 0) {
+	if (sspi->hw_cs) {
 		u32 regval = readl(sspi->base + SIRFSOC_SPI_CTRL);
 		switch (value) {
 		case BITBANG_CS_ACTIVE:
@@ -502,14 +501,13 @@ static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
 		}
 		writel(regval, sspi->base + SIRFSOC_SPI_CTRL);
 	} else {
-		int gpio = sspi->chipselect[spi->chip_select];
 		switch (value) {
 		case BITBANG_CS_ACTIVE:
-			gpio_direction_output(gpio,
+			gpio_direction_output(spi->cs_gpio,
 					spi->mode & SPI_CS_HIGH ? 1 : 0);
 			break;
 		case BITBANG_CS_INACTIVE:
-			gpio_direction_output(gpio,
+			gpio_direction_output(spi->cs_gpio,
 					spi->mode & SPI_CS_HIGH ? 0 : 1);
 			break;
 		}
@@ -603,8 +601,8 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		sspi->tx_by_cmd = false;
 	}
 	/*
-	 * set spi controller in RISC chipselect mode, we are controlling CS by
-	 * software BITBANG_CS_ACTIVE and BITBANG_CS_INACTIVE.
+	 * it should never set to hardware cs mode because in hardware cs mode,
+	 * cs signal can't controlled by driver.
 	 */
 	regval |= SIRFSOC_SPI_CS_IO_MODE;
 	writel(regval, sspi->base + SIRFSOC_SPI_CTRL);
@@ -627,9 +625,17 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 
 static int spi_sirfsoc_setup(struct spi_device *spi)
 {
+	struct sirfsoc_spi *sspi;
+
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
+	sspi = spi_master_get_devdata(spi->master);
+
+	if (spi->cs_gpio == -ENOENT)
+		sspi->hw_cs = true;
+	else
+		sspi->hw_cs = false;
 	return spi_sirfsoc_setup_transfer(spi, NULL);
 }
 
@@ -638,19 +644,10 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	struct sirfsoc_spi *sspi;
 	struct spi_master *master;
 	struct resource *mem_res;
-	int num_cs, cs_gpio, irq;
-	int i;
-	int ret;
-
-	ret = of_property_read_u32(pdev->dev.of_node,
-			"sirf,spi-num-chipselects", &num_cs);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Unable to get chip select number\n");
-		goto err_cs;
-	}
+	int irq;
+	int i, ret;
 
-	master = spi_alloc_master(&pdev->dev,
-			sizeof(*sspi) + sizeof(int) * num_cs);
+	master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
 	if (!master) {
 		dev_err(&pdev->dev, "Unable to allocate SPI master\n");
 		return -ENOMEM;
@@ -658,32 +655,6 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 	sspi = spi_master_get_devdata(master);
 
-	master->num_chipselect = num_cs;
-
-	for (i = 0; i < master->num_chipselect; i++) {
-		cs_gpio = of_get_named_gpio(pdev->dev.of_node, "cs-gpios", i);
-		if (cs_gpio < 0) {
-			dev_err(&pdev->dev, "can't get cs gpio from DT\n");
-			ret = -ENODEV;
-			goto free_master;
-		}
-
-		sspi->chipselect[i] = cs_gpio;
-		if (cs_gpio == 0)
-			continue; /* use cs from spi controller */
-
-		ret = gpio_request(cs_gpio, DRIVER_NAME);
-		if (ret) {
-			while (i > 0) {
-				i--;
-				if (sspi->chipselect[i] > 0)
-					gpio_free(sspi->chipselect[i]);
-			}
-			dev_err(&pdev->dev, "fail to request cs gpios\n");
-			goto free_master;
-		}
-	}
-
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sspi->base = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(sspi->base)) {
@@ -753,7 +724,21 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	ret = spi_bitbang_start(&sspi->bitbang);
 	if (ret)
 		goto free_dummypage;
-
+	for (i = 0; master->cs_gpios && i < master->num_chipselect; i++) {
+		if (master->cs_gpios[i] == -ENOENT)
+			continue;
+		if (!gpio_is_valid(master->cs_gpios[i])) {
+			dev_err(&pdev->dev, "no valid gpio\n");
+			ret = -EINVAL;
+			goto free_dummypage;
+		}
+		ret = devm_gpio_request(&pdev->dev,
+				master->cs_gpios[i], DRIVER_NAME);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request gpio\n");
+			goto free_dummypage;
+		}
+	}
 	dev_info(&pdev->dev, "registerred, bus number = %d\n", master->bus_num);
 
 	return 0;
@@ -768,7 +753,7 @@ free_rx_dma:
 	dma_release_channel(sspi->rx_chan);
 free_master:
 	spi_master_put(master);
-err_cs:
+
 	return ret;
 }
 
@@ -776,16 +761,11 @@ static int  spi_sirfsoc_remove(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct sirfsoc_spi *sspi;
-	int i;
 
 	master = platform_get_drvdata(pdev);
 	sspi = spi_master_get_devdata(master);
 
 	spi_bitbang_stop(&sspi->bitbang);
-	for (i = 0; i < master->num_chipselect; i++) {
-		if (sspi->chipselect[i] > 0)
-			gpio_free(sspi->chipselect[i]);
-	}
 	kfree(sspi->dummypage);
 	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
