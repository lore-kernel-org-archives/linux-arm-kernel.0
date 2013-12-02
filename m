From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  2 Dec 2013 18:00:21 +0000
Subject: [PATCH 2/3] ASoC: ux500_pcm: Differentiate between pdata and DT
 initialisation
In-Reply-To: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1386007222-10081-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If booting with full DT support (i.e. DMA too, the last piece of the
puzzle), then we don't need to use the compatible request channel call
back. We also require slightly different flags to inform the core that
we are booting with DT.

Cc: alsa-devel at alsa-project.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_pcm.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 2f1bdb7..00cdd7b 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -134,15 +134,31 @@ static const struct snd_dmaengine_pcm_config ux500_dmaengine_pcm_config = {
 	.prepare_slave_config = ux500_pcm_prepare_slave_config,
 };
 
+static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
+	.prepare_slave_config = ux500_pcm_prepare_slave_config,
+};
+
 int ux500_pcm_register_platform(struct platform_device *pdev)
 {
+	const struct snd_dmaengine_pcm_config *pcm_config;
+	struct device_node *np = pdev->dev.of_node;
+	unsigned int pcm_flags;
 	int ret;
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev,
-			&ux500_dmaengine_pcm_config,
-			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
-			SND_DMAENGINE_PCM_FLAG_COMPAT |
-			SND_DMAENGINE_PCM_FLAG_NO_DT);
+	if (np) {
+		pcm_config = &ux500_dmaengine_of_pcm_config;
+
+		pcm_flags = SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
+			SND_DMAENGINE_PCM_FLAG_COMPAT;
+	} else {
+		pcm_config = &ux500_dmaengine_pcm_config;
+
+		pcm_flags = SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
+			SND_DMAENGINE_PCM_FLAG_NO_DT |
+			SND_DMAENGINE_PCM_FLAG_COMPAT;
+	}
+
+	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config, pcm_flags);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"%s: ERROR: Failed to register platform '%s' (%d)!\n",
-- 
1.8.3.2
