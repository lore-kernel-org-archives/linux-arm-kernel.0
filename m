From: colin.king@canonical.com (Colin King)
Date: Mon, 18 Sep 2017 09:56:38 +0100
Subject: [PATCH] ASoC: zte: spdif: remove duplicate initialization of dma_data
Message-ID: <20170918085638.27110-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

dma_data is being initialized twice, remove the unused first
initialization and use the latter one instead.  Fixed clang warning:

"warning: Value stored to 'dma_data' during its initialization is
never read"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/zte/zx-spdif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/zte/zx-spdif.c b/sound/soc/zte/zx-spdif.c
index b143f9f682d2..17b6ce35037a 100644
--- a/sound/soc/zte/zx-spdif.c
+++ b/sound/soc/zte/zx-spdif.c
@@ -139,11 +139,11 @@ static int zx_spdif_hw_params(struct snd_pcm_substream *substream,
 {
 	struct zx_spdif_info *zx_spdif = dev_get_drvdata(socdai->dev);
 	struct zx_spdif_info *spdif = snd_soc_dai_get_drvdata(socdai);
-	struct snd_dmaengine_dai_dma_data *dma_data = &zx_spdif->dma_data;
+	struct snd_dmaengine_dai_dma_data *dma_data =
+		snd_soc_dai_get_dma_data(socdai, substream);
 	u32 val, ch_num, rate;
 	int ret;
 
-	dma_data = snd_soc_dai_get_dma_data(socdai, substream);
 	dma_data->addr_width = params_width(params) >> 3;
 
 	val = readl_relaxed(zx_spdif->reg_base + ZX_CTRL);
-- 
2.14.1
