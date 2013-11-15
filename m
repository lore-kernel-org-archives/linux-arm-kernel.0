From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:13 -0700
Subject: [PATCH 18/31] ASoC: tegra: allocate AHUB FIFO during probe() not
 startup()
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-19-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Teh Tegra30 I2S driver currently allocates DMA FIFOs from the AHUB only
when an audio stream starts playback. This is theoretically nice for
resource sharing, but makes no practical difference for any configuration
the drivers currently support. However, this deferral prevents conversion
to the standard DMA DT bindings, since conversion requires knowledge of
the specific DMA channel to be allocated, which in turn depends on which
specific FIFO was allocated.

For this reason, move the FIFO allocate into probe() to allow later
conversion to the standard DMA DT bindings.

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
 sound/soc/tegra/tegra30_i2s.c | 91 ++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 44 deletions(-)

diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index 231a785b3921..531a1ff2101d 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -73,47 +73,6 @@ static int tegra30_i2s_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int tegra30_i2s_startup(struct snd_pcm_substream *substream,
-			struct snd_soc_dai *dai)
-{
-	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	int ret;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		ret = tegra30_ahub_allocate_tx_fifo(&i2s->playback_fifo_cif,
-					&i2s->playback_dma_data.addr,
-					&i2s->playback_dma_data.slave_id);
-		i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		i2s->playback_dma_data.maxburst = 4;
-		tegra30_ahub_set_rx_cif_source(i2s->playback_i2s_cif,
-					       i2s->playback_fifo_cif);
-	} else {
-		ret = tegra30_ahub_allocate_rx_fifo(&i2s->capture_fifo_cif,
-					&i2s->capture_dma_data.addr,
-					&i2s->capture_dma_data.slave_id);
-		i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		i2s->capture_dma_data.maxburst = 4;
-		tegra30_ahub_set_rx_cif_source(i2s->capture_fifo_cif,
-					       i2s->capture_i2s_cif);
-	}
-
-	return ret;
-}
-
-static void tegra30_i2s_shutdown(struct snd_pcm_substream *substream,
-			struct snd_soc_dai *dai)
-{
-	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		tegra30_ahub_unset_rx_cif_source(i2s->playback_i2s_cif);
-		tegra30_ahub_free_tx_fifo(i2s->playback_fifo_cif);
-	} else {
-		tegra30_ahub_unset_rx_cif_source(i2s->capture_fifo_cif);
-		tegra30_ahub_free_rx_fifo(i2s->capture_fifo_cif);
-	}
-}
-
 static int tegra30_i2s_set_fmt(struct snd_soc_dai *dai,
 				unsigned int fmt)
 {
@@ -317,8 +276,6 @@ static int tegra30_i2s_probe(struct snd_soc_dai *dai)
 }
 
 static struct snd_soc_dai_ops tegra30_i2s_dai_ops = {
-	.startup	= tegra30_i2s_startup,
-	.shutdown	= tegra30_i2s_shutdown,
 	.set_fmt	= tegra30_i2s_set_fmt,
 	.hw_params	= tegra30_i2s_hw_params,
 	.trigger	= tegra30_i2s_trigger,
@@ -499,12 +456,44 @@ static int tegra30_i2s_platform_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
+	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	i2s->playback_dma_data.maxburst = 4;
+	ret = tegra30_ahub_allocate_tx_fifo(&i2s->playback_fifo_cif,
+					    &i2s->playback_dma_data.addr,
+					    &i2s->playback_dma_data.slave_id);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not alloc TX FIFO: %d\n", ret);
+		goto err_suspend;
+	}
+	ret = tegra30_ahub_set_rx_cif_source(i2s->playback_i2s_cif,
+					     i2s->playback_fifo_cif);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not route TX FIFO: %d\n", ret);
+		goto err_free_tx_fifo;
+	}
+
+	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	i2s->capture_dma_data.maxburst = 4;
+	ret = tegra30_ahub_allocate_rx_fifo(&i2s->capture_fifo_cif,
+					    &i2s->capture_dma_data.addr,
+					    &i2s->capture_dma_data.slave_id);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not alloc RX FIFO: %d\n", ret);
+		goto err_unroute_tx_fifo;
+	}
+	ret = tegra30_ahub_set_rx_cif_source(i2s->capture_fifo_cif,
+					     i2s->capture_i2s_cif);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not route TX FIFO: %d\n", ret);
+		goto err_free_rx_fifo;
+	}
+
 	ret = snd_soc_register_component(&pdev->dev, &tegra30_i2s_component,
 				   &i2s->dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
 		ret = -ENOMEM;
-		goto err_suspend;
+		goto err_unroute_rx_fifo;
 	}
 
 	ret = tegra_pcm_platform_register(&pdev->dev);
@@ -517,6 +506,14 @@ static int tegra30_i2s_platform_probe(struct platform_device *pdev)
 
 err_unregister_component:
 	snd_soc_unregister_component(&pdev->dev);
+err_unroute_rx_fifo:
+	tegra30_ahub_unset_rx_cif_source(i2s->capture_fifo_cif);
+err_free_rx_fifo:
+	tegra30_ahub_free_rx_fifo(i2s->capture_fifo_cif);
+err_unroute_tx_fifo:
+	tegra30_ahub_unset_rx_cif_source(i2s->playback_i2s_cif);
+err_free_tx_fifo:
+	tegra30_ahub_free_tx_fifo(i2s->playback_fifo_cif);
 err_suspend:
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra30_i2s_runtime_suspend(&pdev->dev);
@@ -539,6 +536,12 @@ static int tegra30_i2s_platform_remove(struct platform_device *pdev)
 	tegra_pcm_platform_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 
+	tegra30_ahub_unset_rx_cif_source(i2s->capture_fifo_cif);
+	tegra30_ahub_free_rx_fifo(i2s->capture_fifo_cif);
+
+	tegra30_ahub_unset_rx_cif_source(i2s->playback_i2s_cif);
+	tegra30_ahub_free_tx_fifo(i2s->playback_fifo_cif);
+
 	clk_put(i2s->clk_i2s);
 
 	return 0;
-- 
1.8.1.5
