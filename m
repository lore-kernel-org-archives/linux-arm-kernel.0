From: Barry.Song@csr.com (Barry Song)
Date: Tue, 2 Sep 2014 17:02:37 +0800
Subject: [PATCH 8/8] spi: sirf: make DMA transfer mode optional
In-Reply-To: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1409648557-5470-4-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

some customers want a pure PIO transfer mode even though DMA mode is
supported. here we give them a Kconfig option, but still keep the DMA
enabled in default.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/Kconfig    | 10 ++++++++++
 drivers/spi/spi-sirf.c | 11 ++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 62e2242..0f84bd8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -477,6 +477,16 @@ config SPI_SIRF
 	help
 	  SPI driver for CSR SiRFprimaII SoCs
 
+config SPI_SIRF_DMA
+	bool "CSR SiRFprimaII/AtlasVI SPI DMA mode support"
+	depends on SPI_SIRF
+	default y
+	help
+	  CSR SPI driver support DMA and PIO mode, select it let SPI driver support DMA mode
+	  deselect it let SPI controller in PIO mode.
+	  In CSR SPI driver distinguish the config to decide what transfer mode use.
+	  Default configure value is y, if want pure PIO mode deselect it will be OK.
+
 config SPI_SUN4I
 	tristate "Allwinner A10 SoCs SPI controller"
 	depends on ARCH_SUNXI || COMPILE_TEST
diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 67d07b2..f934159 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -333,6 +333,7 @@ static void spi_sirfsoc_cmd_transfer(struct spi_device *spi,
 	sspi->left_rx_word -= t->len;
 }
 
+#ifdef CONFIG_SPI_SIRF_DMA
 static void spi_sirfsoc_dma_transfer(struct spi_device *spi,
 	struct spi_transfer *t)
 {
@@ -407,6 +408,7 @@ static void spi_sirfsoc_dma_transfer(struct spi_device *spi,
 	if (sspi->left_tx_word >= SIRFSOC_SPI_DAT_FRM_LEN_MAX)
 		writel(0, sspi->base + SIRFSOC_SPI_TX_RX_EN);
 }
+#endif
 
 static void spi_sirfsoc_pio_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
@@ -474,8 +476,10 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 	 */
 	if (sspi->tx_by_cmd)
 		spi_sirfsoc_cmd_transfer(spi, t);
+#ifdef CONFIG_SPI_SIRF_DMA
 	else if (IS_DMA_VALID(t))
 		spi_sirfsoc_dma_transfer(spi, t);
+#endif
 	else
 		spi_sirfsoc_pio_transfer(spi, t);
 
@@ -526,6 +530,11 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	u32 regval;
 	u32 txfifo_ctrl, rxfifo_ctrl;
 	u32 fifo_size = SIRFSOC_SPI_FIFO_SIZE / 4;
+#ifdef CONFIG_SPI_SIRF_DMA
+	int spi_use_dma = 1;
+#else
+	int spi_use_dma = 0;
+#endif
 
 	sspi = spi_master_get_devdata(spi->master);
 
@@ -610,7 +619,7 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	regval |= SIRFSOC_SPI_CS_IO_MODE;
 	writel(regval, sspi->base + SIRFSOC_SPI_CTRL);
 
-	if (IS_DMA_VALID(t)) {
+	if (spi_use_dma && IS_DMA_VALID(t)) {
 		/* Enable DMA mode for RX, TX */
 		writel(0, sspi->base + SIRFSOC_SPI_TX_DMA_IO_CTRL);
 		writel(SIRFSOC_SPI_RX_DMA_FLUSH,
-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
