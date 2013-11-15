From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:14 -0700
Subject: [PATCH 19/31] ASoC: tegra: convert to standard DMA DT bindings
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-20-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

By passing no flags when calling snd_dmaengine_pcm_register() from
tegra_pcm.c, we end up using dma_request_slave_channel() rather than
dmaengine_pcm_compat_request_channel(), and hence rely on the standard
DMA DT bindings and stashing the DMA slave ID away during channel
allocation. This means there's no need to use a custom DT property to
store the slave ID. So, remove all the code that parsed it.

Cc: treding at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 sound/soc/tegra/tegra20_ac97.c | 11 -----------
 sound/soc/tegra/tegra20_i2s.c  | 20 +-------------------
 sound/soc/tegra/tegra30_ahub.c | 23 ++++++-----------------
 sound/soc/tegra/tegra30_ahub.h |  9 ++++-----
 sound/soc/tegra/tegra30_i2s.c  | 14 +++++++++-----
 sound/soc/tegra/tegra30_i2s.h  |  3 +++
 sound/soc/tegra/tegra_pcm.c    | 17 ++++++++++++++---
 sound/soc/tegra/tegra_pcm.h    |  5 +++++
 8 files changed, 42 insertions(+), 60 deletions(-)

diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index ae27bcd586d2..d8b98d70ff41 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -313,7 +313,6 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 {
 	struct tegra20_ac97 *ac97;
 	struct resource *mem;
-	u32 of_dma[2];
 	void __iomem *regs;
 	int ret = 0;
 
@@ -348,14 +347,6 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 		goto err_clk_put;
 	}
 
-	if (of_property_read_u32_array(pdev->dev.of_node,
-				       "nvidia,dma-request-selector",
-				       of_dma, 2) < 0) {
-		dev_err(&pdev->dev, "No DMA resource\n");
-		ret = -ENODEV;
-		goto err_clk_put;
-	}
-
 	ac97->reset_gpio = of_get_named_gpio(pdev->dev.of_node,
 					     "nvidia,codec-reset-gpio", 0);
 	if (gpio_is_valid(ac97->reset_gpio)) {
@@ -380,12 +371,10 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 	ac97->capture_dma_data.addr = mem->start + TEGRA20_AC97_FIFO_RX1;
 	ac97->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	ac97->capture_dma_data.maxburst = 4;
-	ac97->capture_dma_data.slave_id = of_dma[1];
 
 	ac97->playback_dma_data.addr = mem->start + TEGRA20_AC97_FIFO_TX1;
 	ac97->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	ac97->playback_dma_data.maxburst = 4;
-	ac97->playback_dma_data.slave_id = of_dma[1];
 
 	ret = tegra_asoc_utils_init(&ac97->util_data, &pdev->dev);
 	if (ret)
diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 364bf6a907e1..1dc869c475e7 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -339,9 +339,7 @@ static const struct regmap_config tegra20_i2s_regmap_config = {
 static int tegra20_i2s_platform_probe(struct platform_device *pdev)
 {
 	struct tegra20_i2s *i2s;
-	struct resource *mem, *memregion, *dmareq;
-	u32 of_dma[2];
-	u32 dma_ch;
+	struct resource *mem, *memregion;
 	void __iomem *regs;
 	int ret;
 
@@ -370,20 +368,6 @@ static int tegra20_i2s_platform_probe(struct platform_device *pdev)
 		goto err_clk_put;
 	}
 
-	dmareq = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!dmareq) {
-		if (of_property_read_u32_array(pdev->dev.of_node,
-					"nvidia,dma-request-selector",
-					of_dma, 2) < 0) {
-			dev_err(&pdev->dev, "No DMA resource\n");
-			ret = -ENODEV;
-			goto err_clk_put;
-		}
-		dma_ch = of_dma[1];
-	} else {
-		dma_ch = dmareq->start;
-	}
-
 	memregion = devm_request_mem_region(&pdev->dev, mem->start,
 					    resource_size(mem), DRV_NAME);
 	if (!memregion) {
@@ -410,12 +394,10 @@ static int tegra20_i2s_platform_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr = mem->start + TEGRA20_I2S_FIFO2;
 	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	i2s->capture_dma_data.maxburst = 4;
-	i2s->capture_dma_data.slave_id = dma_ch;
 
 	i2s->playback_dma_data.addr = mem->start + TEGRA20_I2S_FIFO1;
 	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	i2s->playback_dma_data.maxburst = 4;
-	i2s->playback_dma_data.slave_id = dma_ch;
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 2f1a566dd9cc..572fab23e75f 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -96,8 +96,8 @@ static int tegra30_ahub_runtime_resume(struct device *dev)
 }
 
 int tegra30_ahub_allocate_rx_fifo(enum tegra30_ahub_rxcif *rxcif,
-				  dma_addr_t *fiforeg,
-				  unsigned int *reqsel)
+				  char *dmachan, int dmachan_len,
+				  dma_addr_t *fiforeg)
 {
 	int channel;
 	u32 reg, val;
@@ -111,9 +111,9 @@ int tegra30_ahub_allocate_rx_fifo(enum tegra30_ahub_rxcif *rxcif,
 	__set_bit(channel, ahub->rx_usage);
 
 	*rxcif = TEGRA30_AHUB_RXCIF_APBIF_RX0 + channel;
+	snprintf(dmachan, dmachan_len, "rx%d", channel);
 	*fiforeg = ahub->apbif_addr + TEGRA30_AHUB_CHANNEL_RXFIFO +
 		   (channel * TEGRA30_AHUB_CHANNEL_RXFIFO_STRIDE);
-	*reqsel = ahub->dma_sel + channel;
 
 	pm_runtime_get_sync(ahub->dev);
 
@@ -198,8 +198,8 @@ int tegra30_ahub_free_rx_fifo(enum tegra30_ahub_rxcif rxcif)
 EXPORT_SYMBOL_GPL(tegra30_ahub_free_rx_fifo);
 
 int tegra30_ahub_allocate_tx_fifo(enum tegra30_ahub_txcif *txcif,
-				  dma_addr_t *fiforeg,
-				  unsigned int *reqsel)
+				  char *dmachan, int dmachan_len,
+				  dma_addr_t *fiforeg)
 {
 	int channel;
 	u32 reg, val;
@@ -213,9 +213,9 @@ int tegra30_ahub_allocate_tx_fifo(enum tegra30_ahub_txcif *txcif,
 	__set_bit(channel, ahub->tx_usage);
 
 	*txcif = TEGRA30_AHUB_TXCIF_APBIF_TX0 + channel;
+	snprintf(dmachan, dmachan_len, "tx%d", channel);
 	*fiforeg = ahub->apbif_addr + TEGRA30_AHUB_CHANNEL_TXFIFO +
 		   (channel * TEGRA30_AHUB_CHANNEL_TXFIFO_STRIDE);
-	*reqsel = ahub->dma_sel + channel;
 
 	pm_runtime_get_sync(ahub->dev);
 
@@ -511,7 +511,6 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	struct reset_control *rst;
 	int i;
 	struct resource *res0, *res1, *region;
-	u32 of_dma[2];
 	void __iomem *regs_apbif, *regs_ahub;
 	int ret = 0;
 
@@ -574,16 +573,6 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 		goto err_clk_put_d_audio;
 	}
 
-	if (of_property_read_u32_array(pdev->dev.of_node,
-				"nvidia,dma-request-selector",
-				of_dma, 2) < 0) {
-		dev_err(&pdev->dev,
-			"Missing property nvidia,dma-request-selector\n");
-		ret = -ENODEV;
-		goto err_clk_put_d_audio;
-	}
-	ahub->dma_sel = of_dma[1];
-
 	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res0) {
 		dev_err(&pdev->dev, "No apbif memory resource\n");
diff --git a/sound/soc/tegra/tegra30_ahub.h b/sound/soc/tegra/tegra30_ahub.h
index 1383f8cd3572..fd7ba75ed814 100644
--- a/sound/soc/tegra/tegra30_ahub.h
+++ b/sound/soc/tegra/tegra30_ahub.h
@@ -465,15 +465,15 @@ enum tegra30_ahub_rxcif {
 };
 
 extern int tegra30_ahub_allocate_rx_fifo(enum tegra30_ahub_rxcif *rxcif,
-					 dma_addr_t *fiforeg,
-					 unsigned int *reqsel);
+					 char *dmachan, int dmachan_len,
+					 dma_addr_t *fiforeg);
 extern int tegra30_ahub_enable_rx_fifo(enum tegra30_ahub_rxcif rxcif);
 extern int tegra30_ahub_disable_rx_fifo(enum tegra30_ahub_rxcif rxcif);
 extern int tegra30_ahub_free_rx_fifo(enum tegra30_ahub_rxcif rxcif);
 
 extern int tegra30_ahub_allocate_tx_fifo(enum tegra30_ahub_txcif *txcif,
-					 dma_addr_t *fiforeg,
-					 unsigned int *reqsel);
+					 char *dmachan, int dmachan_len,
+					 dma_addr_t *fiforeg);
 extern int tegra30_ahub_enable_tx_fifo(enum tegra30_ahub_txcif txcif);
 extern int tegra30_ahub_disable_tx_fifo(enum tegra30_ahub_txcif txcif);
 extern int tegra30_ahub_free_tx_fifo(enum tegra30_ahub_txcif txcif);
@@ -524,7 +524,6 @@ struct tegra30_ahub {
 	struct device *dev;
 	struct clk *clk_d_audio;
 	struct clk *clk_apbif;
-	int dma_sel;
 	resource_size_t apbif_addr;
 	struct regmap *regmap_apbif;
 	struct regmap *regmap_ahub;
diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index 531a1ff2101d..362e8f728ddf 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -459,8 +459,9 @@ static int tegra30_i2s_platform_probe(struct platform_device *pdev)
 	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	i2s->playback_dma_data.maxburst = 4;
 	ret = tegra30_ahub_allocate_tx_fifo(&i2s->playback_fifo_cif,
-					    &i2s->playback_dma_data.addr,
-					    &i2s->playback_dma_data.slave_id);
+					    i2s->playback_dma_chan,
+					    sizeof(i2s->playback_dma_chan),
+					    &i2s->playback_dma_data.addr);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not alloc TX FIFO: %d\n", ret);
 		goto err_suspend;
@@ -475,8 +476,9 @@ static int tegra30_i2s_platform_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	i2s->capture_dma_data.maxburst = 4;
 	ret = tegra30_ahub_allocate_rx_fifo(&i2s->capture_fifo_cif,
-					    &i2s->capture_dma_data.addr,
-					    &i2s->capture_dma_data.slave_id);
+					    i2s->capture_dma_chan,
+					    sizeof(i2s->capture_dma_chan),
+					    &i2s->capture_dma_data.addr);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not alloc RX FIFO: %d\n", ret);
 		goto err_unroute_tx_fifo;
@@ -496,7 +498,9 @@ static int tegra30_i2s_platform_probe(struct platform_device *pdev)
 		goto err_unroute_rx_fifo;
 	}
 
-	ret = tegra_pcm_platform_register(&pdev->dev);
+	ret = tegra_pcm_platform_register_with_chan_names(&pdev->dev,
+				&i2s->dma_config, i2s->playback_dma_chan,
+				i2s->capture_dma_chan);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
 		goto err_unregister_component;
diff --git a/sound/soc/tegra/tegra30_i2s.h b/sound/soc/tegra/tegra30_i2s.h
index 4d0b0a30dbfb..774fc6ad2026 100644
--- a/sound/soc/tegra/tegra30_i2s.h
+++ b/sound/soc/tegra/tegra30_i2s.h
@@ -238,11 +238,14 @@ struct tegra30_i2s {
 	struct clk *clk_i2s;
 	enum tegra30_ahub_txcif capture_i2s_cif;
 	enum tegra30_ahub_rxcif capture_fifo_cif;
+	char capture_dma_chan[8];
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
 	enum tegra30_ahub_rxcif playback_i2s_cif;
 	enum tegra30_ahub_txcif playback_fifo_cif;
+	char playback_dma_chan[8];
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
 	struct regmap *regmap;
+	struct snd_dmaengine_pcm_config dma_config;
 };
 
 #endif
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index 7b2d23ba69b3..7ce5c334a660 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -61,12 +61,23 @@ static const struct snd_dmaengine_pcm_config tegra_dmaengine_pcm_config = {
 
 int tegra_pcm_platform_register(struct device *dev)
 {
-	return snd_dmaengine_pcm_register(dev, &tegra_dmaengine_pcm_config,
-			SND_DMAENGINE_PCM_FLAG_NO_DT |
-			SND_DMAENGINE_PCM_FLAG_COMPAT);
+	return snd_dmaengine_pcm_register(dev, &tegra_dmaengine_pcm_config, 0);
 }
 EXPORT_SYMBOL_GPL(tegra_pcm_platform_register);
 
+int tegra_pcm_platform_register_with_chan_names(struct device *dev,
+				struct snd_dmaengine_pcm_config *config,
+				char *txdmachan, char *rxdmachan)
+{
+	*config = tegra_dmaengine_pcm_config;
+	config->dma_dev = dev->parent;
+	config->chan_names[0] = txdmachan;
+	config->chan_names[1] = rxdmachan;
+
+	return snd_dmaengine_pcm_register(dev, config, 0);
+}
+EXPORT_SYMBOL_GPL(tegra_pcm_platform_register_with_chan_names);
+
 void tegra_pcm_platform_unregister(struct device *dev)
 {
 	return snd_dmaengine_pcm_unregister(dev);
diff --git a/sound/soc/tegra/tegra_pcm.h b/sound/soc/tegra/tegra_pcm.h
index 68ad901714a9..7883dec748a3 100644
--- a/sound/soc/tegra/tegra_pcm.h
+++ b/sound/soc/tegra/tegra_pcm.h
@@ -31,7 +31,12 @@
 #ifndef __TEGRA_PCM_H__
 #define __TEGRA_PCM_H__
 
+struct snd_dmaengine_pcm_config;
+
 int tegra_pcm_platform_register(struct device *dev);
+int tegra_pcm_platform_register_with_chan_names(struct device *dev,
+				struct snd_dmaengine_pcm_config *config,
+				char *txdmachan, char *rxdmachan);
 void tegra_pcm_platform_unregister(struct device *dev);
 
 #endif
-- 
1.8.1.5
