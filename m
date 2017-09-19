From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Sep 2017 14:47:18 +0100
Subject: Applied "ASoC: zte: spdif: remove duplicate initialization of
 dma_data" to the asoc tree
In-Reply-To: <20170918085638.27110-1-colin.king@canonical.com>
Message-ID: <E1duIru-0008PT-QD@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: zte: spdif: remove duplicate initialization of dma_data

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b6145837218cb984245aea5ccd9201aeb5eb0501 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 18 Sep 2017 09:56:38 +0100
Subject: [PATCH] ASoC: zte: spdif: remove duplicate initialization of dma_data

dma_data is being initialized twice, remove the unused first
initialization and use the latter one instead.  Fixed clang warning:

"warning: Value stored to 'dma_data' during its initialization is
never read"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
