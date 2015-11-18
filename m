From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 15:21:32 +0100
Subject: [PATCH v3] SPI: s3c64xx: pass DMA arguments in platform data
Message-ID: <3835977.ZFLKtOk346@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c64xx platform data already contains a pointer to the
DMA filter function, but not to the associated data.

This simplifies the code and makes it more generic by
passing the data along with the filter function like
we do for other drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: leave pl330 support in place. this is not needed any more, but this
    patch should not remove it. We will however need to come back to
    this for multiplatform support, so a combined s3c64xx+s5p gets the
    right filter function
v3: fix bug in probe function that caused the DT case to use polling mode
v2: This version is now independent of the ASoC changes.

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 07a5a6e6dcaa..b53d4ff3befb 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1105,9 +1105,7 @@ struct platform_device s3c_device_wdt = {
 #ifdef CONFIG_S3C64XX_DEV_SPI0
 static struct resource s3c64xx_spi0_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C_PA_SPI0, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_SPI0_TX),
-	[2] = DEFINE_RES_DMA(DMACH_SPI0_RX),
-	[3] = DEFINE_RES_IRQ(IRQ_SPI0),
+	[1] = DEFINE_RES_IRQ(IRQ_SPI0),
 };
 
 struct platform_device s3c64xx_device_spi0 = {
@@ -1135,6 +1133,8 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 	pd.num_cs = num_cs;
 	pd.src_clk_nr = src_clk_nr;
 	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
+	pd.dma_tx = (void *)DMACH_SPI0_TX;
+	pd.dma_rx = (void *)DMACH_SPI0_RX;
 #if defined(CONFIG_PL330_DMA)
 	pd.filter = pl330_filter;
 #elif defined(CONFIG_S3C64XX_PL080)
@@ -1150,9 +1150,7 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 #ifdef CONFIG_S3C64XX_DEV_SPI1
 static struct resource s3c64xx_spi1_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C_PA_SPI1, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_SPI1_TX),
-	[2] = DEFINE_RES_DMA(DMACH_SPI1_RX),
-	[3] = DEFINE_RES_IRQ(IRQ_SPI1),
+	[1] = DEFINE_RES_IRQ(IRQ_SPI1),
 };
 
 struct platform_device s3c64xx_device_spi1 = {
@@ -1180,12 +1178,15 @@ void __init s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 	pd.num_cs = num_cs;
 	pd.src_clk_nr = src_clk_nr;
 	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi1_cfg_gpio;
+	pd.dma_tx = (void *)DMACH_SPI1_TX;
+	pd.dma_rx = (void *)DMACH_SPI1_RX;
 #if defined(CONFIG_PL330_DMA)
 	pd.filter = pl330_filter;
 #elif defined(CONFIG_S3C64XX_PL080)
 	pd.filter = pl08x_filter_id;
 #endif
 
+
 	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi1);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI1 */
@@ -1193,9 +1194,7 @@ void __init s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 #ifdef CONFIG_S3C64XX_DEV_SPI2
 static struct resource s3c64xx_spi2_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C_PA_SPI2, SZ_256),
-	[1] = DEFINE_RES_DMA(DMACH_SPI2_TX),
-	[2] = DEFINE_RES_DMA(DMACH_SPI2_RX),
-	[3] = DEFINE_RES_IRQ(IRQ_SPI2),
+	[1] = DEFINE_RES_IRQ(IRQ_SPI2),
 };
 
 struct platform_device s3c64xx_device_spi2 = {
@@ -1223,6 +1222,8 @@ void __init s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 	pd.num_cs = num_cs;
 	pd.src_clk_nr = src_clk_nr;
 	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi2_cfg_gpio;
+	pd.dma_tx = (void *)DMACH_SPI2_TX;
+	pd.dma_rx = (void *)DMACH_SPI2_RX;
 #if defined(CONFIG_PL330_DMA)
 	pd.filter = pl330_filter;
 #elif defined(CONFIG_S3C64XX_PL080)
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8e86e7f6663a..b954c5444cca 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -133,7 +133,6 @@
 struct s3c64xx_spi_dma_data {
 	struct dma_chan *ch;
 	enum dma_transfer_direction direction;
-	unsigned int dmach;
 };
 
 /**
@@ -325,7 +324,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 
 		/* Acquire DMA channels */
 		sdd->rx_dma.ch = dma_request_slave_channel_compat(mask, filter,
-				   (void *)(long)sdd->rx_dma.dmach, dev, "rx");
+				   sdd->cntrlr_info->dma_rx, dev, "rx");
 		if (!sdd->rx_dma.ch) {
 			dev_err(dev, "Failed to get RX DMA channel\n");
 			ret = -EBUSY;
@@ -334,7 +333,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 		spi->dma_rx = sdd->rx_dma.ch;
 
 		sdd->tx_dma.ch = dma_request_slave_channel_compat(mask, filter,
-				   (void *)(long)sdd->tx_dma.dmach, dev, "tx");
+				   sdd->cntrlr_info->dma_tx, dev, "tx");
 		if (!sdd->tx_dma.ch) {
 			dev_err(dev, "Failed to get TX DMA channel\n");
 			ret = -EBUSY;
@@ -1028,7 +1027,6 @@ static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 static int s3c64xx_spi_probe(struct platform_device *pdev)
 {
 	struct resource	*mem_res;
-	struct resource	*res;
 	struct s3c64xx_spi_driver_data *sdd;
 	struct s3c64xx_spi_info *sci = dev_get_platdata(&pdev->dev);
 	struct spi_master *master;
@@ -1087,20 +1085,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	sdd->cur_bpw = 8;
 
-	if (!sdd->pdev->dev.of_node) {
-		res = platform_get_resource(pdev, IORESOURCE_DMA,  0);
-		if (!res) {
-			dev_warn(&pdev->dev, "Unable to get SPI tx dma resource. Switching to poll mode\n");
-			sdd->port_conf->quirks = S3C64XX_SPI_QUIRK_POLL;
-		} else
-			sdd->tx_dma.dmach = res->start;
-
-		res = platform_get_resource(pdev, IORESOURCE_DMA,  1);
-		if (!res) {
-			dev_warn(&pdev->dev, "Unable to get SPI rx dma resource. Switching to poll mode\n");
-			sdd->port_conf->quirks = S3C64XX_SPI_QUIRK_POLL;
-		} else
-			sdd->rx_dma.dmach = res->start;
+	if (!sdd->pdev->dev.of_node && (!sci->dma_tx || !sci->dma_rx)) {
+		dev_warn(&pdev->dev, "Unable to get SPI tx/rx DMA data. Switching to poll mode\n");
+		sdd->port_conf->quirks = S3C64XX_SPI_QUIRK_POLL;
 	}
 
 	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
@@ -1197,9 +1184,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
 					sdd->port_id, master->num_chipselect);
-	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\tDMA=[Rx-%d, Tx-%d]\n",
+	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\tDMA=[Rx-%p, Tx-%p]\n",
 					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
-					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
+					sci->dma_rx, sci->dma_tx);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index d3889b98a1a1..fb5625bcca9a 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -40,6 +40,8 @@ struct s3c64xx_spi_info {
 	int num_cs;
 	int (*cfg_gpio)(void);
 	dma_filter_fn filter;
+	void *dma_tx;
+	void *dma_rx;
 };
 
 /**
