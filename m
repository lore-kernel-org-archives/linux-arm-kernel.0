From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Feb 2012 14:47:23 +0800
Subject: [PATCH 3/4] ASoC: imx: initialize dma_params burstsize just in imx-ssi
In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1329979644-31046-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not necessary for imx-pcm-dma-mx2 to access imx_ssi.dma_params
for burstsize initialization.  Instead, it can just be done in imx-ssi
probe function once.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/imx-pcm-dma-mx2.c |    5 -----
 sound/soc/imx/imx-ssi.c         |    2 +-
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index f974e61..1737141 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -271,11 +271,6 @@ static struct snd_soc_platform_driver imx_soc_platform_mx2 = {
 
 static int __devinit imx_soc_platform_probe(struct platform_device *pdev)
 {
-	struct imx_ssi *ssi = platform_get_drvdata(pdev);
-
-	ssi->dma_params_tx.burstsize = 6;
-	ssi->dma_params_rx.burstsize = 4;
-
 	return snd_soc_register_platform(&pdev->dev, &imx_soc_platform_mx2);
 }
 
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index dbf43f5..25c6231 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -668,7 +668,7 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	ssi->dma_params_rx.dma_addr = res->start + SSI_SRX0;
 	ssi->dma_params_tx.dma_addr = res->start + SSI_STX0;
 
-	ssi->dma_params_tx.burstsize = 4;
+	ssi->dma_params_tx.burstsize = 6;
 	ssi->dma_params_rx.burstsize = 4;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx0");
-- 
1.7.5.4
