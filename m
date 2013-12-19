From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Dec 2013 15:55:07 +0000
Subject: [PATCH 10/11] ASoC: ux500_pcm: Differentiate between pdata and DT
 initialisation
In-Reply-To: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1387468508-12286-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If booting with full DT support (i.e. DMA too, the last piece of the
puzzle), then we don't need to use the compatible_request_channel call
back or require some of the historical bumph which probably isn't
required by a platform data start-up now either. This will also be
ripped out in upcoming commits.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_pcm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 3d1c342..55a8634 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -145,15 +145,25 @@ static const struct snd_dmaengine_pcm_config ux500_dmaengine_pcm_config = {
 	.prepare_slave_config = ux500_pcm_prepare_slave_config,
 };
 
+static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
+	.compat_request_channel = ux500_pcm_request_chan,
+	.prepare_slave_config = ux500_pcm_prepare_slave_config,
+};
+
 int ux500_pcm_register_platform(struct platform_device *pdev)
 {
+	const struct snd_dmaengine_pcm_config *pcm_config;
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev,
-			&ux500_dmaengine_pcm_config,
-			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
-			SND_DMAENGINE_PCM_FLAG_COMPAT |
-			SND_DMAENGINE_PCM_FLAG_NO_DT);
+	if (np)
+		pcm_config = &ux500_dmaengine_of_pcm_config;
+	else
+		pcm_config = &ux500_dmaengine_pcm_config;
+
+	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config,
+					 SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
+					 SND_DMAENGINE_PCM_FLAG_COMPAT);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"%s: ERROR: Failed to register platform '%s' (%d)!\n",
-- 
1.8.3.2
