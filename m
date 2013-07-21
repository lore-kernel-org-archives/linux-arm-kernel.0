From: rizhao@nvidia.com (Richard Zhao)
Date: Sun, 21 Jul 2013 10:34:09 +0800
Subject: [PATCH] ASoC: tegra: correct playback_dma_data setup
Message-ID: <1374374049-30732-1-git-send-email-rizhao@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The errors were caused by copy/paste mistake in below commit
since v3.10:
3489d50 ASoC: tegra: Use common DAI DMA data struct

It also corrects slave_id initialization in tegra20_ac97 driver.

Signed-off-by: Richard Zhao <rizhao@nvidia.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: <stable@vger.kernel.org> # 3.10
---
 sound/soc/tegra/tegra20_ac97.c  | 6 +++---
 sound/soc/tegra/tegra20_spdif.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index e58233f..6c48662 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -389,9 +389,9 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 	ac97->capture_dma_data.slave_id = of_dma[1];
 
 	ac97->playback_dma_data.addr = mem->start + TEGRA20_AC97_FIFO_TX1;
-	ac97->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	ac97->capture_dma_data.maxburst = 4;
-	ac97->capture_dma_data.slave_id = of_dma[0];
+	ac97->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	ac97->playback_dma_data.maxburst = 4;
+	ac97->playback_dma_data.slave_id = of_dma[1];
 
 	ret = tegra_asoc_utils_init(&ac97->util_data, &pdev->dev);
 	if (ret)
diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 5eaa12c..551b3c9 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -323,8 +323,8 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	}
 
 	spdif->playback_dma_data.addr = mem->start + TEGRA20_SPDIF_DATA_OUT;
-	spdif->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	spdif->capture_dma_data.maxburst = 4;
+	spdif->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	spdif->playback_dma_data.maxburst = 4;
 	spdif->playback_dma_data.slave_id = dmareq->start;
 
 	pm_runtime_enable(&pdev->dev);
-- 
1.8.1.5
