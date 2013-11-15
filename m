From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:18 -0700
Subject: [PATCH 23/31] spi: tegra: convert to standard DMA DT bindings
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-24-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

By using dma_request_slave_channel_or_err(), the DMA slave ID can be
looked up from standard DT properties, and squirrelled away during
channel allocation. Hence, there's no need to use a custom DT property
to store the slave ID.

Cc: treding at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi at vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 drivers/spi/spi-tegra114.c      | 48 +++++++++++++++--------------------------
 drivers/spi/spi-tegra20-slink.c | 48 +++++++++++++++--------------------------
 2 files changed, 34 insertions(+), 62 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f62e6e5e90e3..42b553b72f04 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -178,7 +178,6 @@ struct tegra_spi_data {
 	void __iomem				*base;
 	phys_addr_t				phys;
 	unsigned				irq;
-	int					dma_req_sel;
 	u32					spi_max_frequency;
 	u32					cur_speed;
 
@@ -601,15 +600,15 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 	dma_addr_t dma_phys;
 	int ret;
 	struct dma_slave_config dma_sconfig;
-	dma_cap_mask_t mask;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	dma_chan = dma_request_channel(mask, NULL, NULL);
-	if (!dma_chan) {
-		dev_err(tspi->dev,
-			"Dma channel is not available, will try later\n");
-		return -EPROBE_DEFER;
+	dma_chan = dma_request_slave_channel_or_err(tspi->dev,
+					dma_to_memory ? "rx" : "tx");
+	if (IS_ERR(dma_chan)) {
+		ret = PTR_ERR(dma_chan);
+		if (ret != -EPROBE_DEFER)
+			dev_err(tspi->dev,
+				"Dma channel is not available: %d\n", ret);
+		return ret;
 	}
 
 	dma_buf = dma_alloc_coherent(tspi->dev, tspi->dma_buf_size,
@@ -620,7 +619,6 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 		return -ENOMEM;
 	}
 
-	dma_sconfig.slave_id = tspi->dma_req_sel;
 	if (dma_to_memory) {
 		dma_sconfig.src_addr = tspi->phys + SPI_RX_FIFO;
 		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -1055,11 +1053,6 @@ static void tegra_spi_parse_dt(struct platform_device *pdev,
 	struct tegra_spi_data *tspi)
 {
 	struct device_node *np = pdev->dev.of_node;
-	u32 of_dma[2];
-
-	if (of_property_read_u32_array(np, "nvidia,dma-request-selector",
-				of_dma, 2) >= 0)
-		tspi->dma_req_sel = of_dma[1];
 
 	if (of_property_read_u32(np, "spi-max-frequency",
 				&tspi->spi_max_frequency))
@@ -1138,22 +1131,15 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tspi->max_buf_size = SPI_FIFO_DEPTH << 2;
 	tspi->dma_buf_size = DEFAULT_SPI_DMA_BUF_LEN;
 
-	if (tspi->dma_req_sel) {
-		ret = tegra_spi_init_dma_param(tspi, true);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "RxDma Init failed, err %d\n", ret);
-			goto exit_free_irq;
-		}
-
-		ret = tegra_spi_init_dma_param(tspi, false);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "TxDma Init failed, err %d\n", ret);
-			goto exit_rx_dma_free;
-		}
-		tspi->max_buf_size = tspi->dma_buf_size;
-		init_completion(&tspi->tx_dma_complete);
-		init_completion(&tspi->rx_dma_complete);
-	}
+	ret = tegra_spi_init_dma_param(tspi, true);
+	if (ret < 0)
+		goto exit_free_irq;
+	ret = tegra_spi_init_dma_param(tspi, false);
+	if (ret < 0)
+		goto exit_rx_dma_free;
+	tspi->max_buf_size = tspi->dma_buf_size;
+	init_completion(&tspi->tx_dma_complete);
+	init_completion(&tspi->rx_dma_complete);
 
 	init_completion(&tspi->xfer_completion);
 
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 1305b8f933ba..dd6f26c05947 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -171,7 +171,6 @@ struct tegra_slink_data {
 	void __iomem				*base;
 	phys_addr_t				phys;
 	unsigned				irq;
-	int					dma_req_sel;
 	u32					spi_max_frequency;
 	u32					cur_speed;
 
@@ -630,15 +629,15 @@ static int tegra_slink_init_dma_param(struct tegra_slink_data *tspi,
 	dma_addr_t dma_phys;
 	int ret;
 	struct dma_slave_config dma_sconfig;
-	dma_cap_mask_t mask;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	dma_chan = dma_request_channel(mask, NULL, NULL);
-	if (!dma_chan) {
-		dev_err(tspi->dev,
-			"Dma channel is not available, will try later\n");
-		return -EPROBE_DEFER;
+	dma_chan = dma_request_slave_channel(tspi->dev,
+					     dma_to_memory ? "rx" : "tx");
+	if (IS_ERR(dma_chan)) {
+		ret = PTR_ERR(dma_chan);
+		if (ret != -EPROBE_DEFER)
+			dev_err(tspi->dev,
+				"Dma channel is not available: %d\n", ret);
+		return ret;
 	}
 
 	dma_buf = dma_alloc_coherent(tspi->dev, tspi->dma_buf_size,
@@ -649,7 +648,6 @@ static int tegra_slink_init_dma_param(struct tegra_slink_data *tspi,
 		return -ENOMEM;
 	}
 
-	dma_sconfig.slave_id = tspi->dma_req_sel;
 	if (dma_to_memory) {
 		dma_sconfig.src_addr = tspi->phys + SLINK_RX_FIFO;
 		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -1021,11 +1019,6 @@ static irqreturn_t tegra_slink_isr(int irq, void *context_data)
 static void tegra_slink_parse_dt(struct tegra_slink_data *tspi)
 {
 	struct device_node *np = tspi->dev->of_node;
-	u32 of_dma[2];
-
-	if (of_property_read_u32_array(np, "nvidia,dma-request-selector",
-				of_dma, 2) >= 0)
-		tspi->dma_req_sel = of_dma[1];
 
 	if (of_property_read_u32(np, "spi-max-frequency",
 					&tspi->spi_max_frequency))
@@ -1129,22 +1122,15 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	tspi->max_buf_size = SLINK_FIFO_DEPTH << 2;
 	tspi->dma_buf_size = DEFAULT_SPI_DMA_BUF_LEN;
 
-	if (tspi->dma_req_sel) {
-		ret = tegra_slink_init_dma_param(tspi, true);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "RxDma Init failed, err %d\n", ret);
-			goto exit_free_irq;
-		}
-
-		ret = tegra_slink_init_dma_param(tspi, false);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "TxDma Init failed, err %d\n", ret);
-			goto exit_rx_dma_free;
-		}
-		tspi->max_buf_size = tspi->dma_buf_size;
-		init_completion(&tspi->tx_dma_complete);
-		init_completion(&tspi->rx_dma_complete);
-	}
+	ret = tegra_slink_init_dma_param(tspi, true);
+	if (ret < 0)
+		goto exit_free_irq;
+	ret = tegra_slink_init_dma_param(tspi, false);
+	if (ret < 0)
+		goto exit_rx_dma_free;
+	tspi->max_buf_size = tspi->dma_buf_size;
+	init_completion(&tspi->tx_dma_complete);
+	init_completion(&tspi->rx_dma_complete);
 
 	init_completion(&tspi->xfer_completion);
 
-- 
1.8.1.5
