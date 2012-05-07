From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 09:16:12 +0800
Subject: [PATCH RESEND 7/9] ASoC: mxs-saif: adopt pinctrl support
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336353374-28939-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: alsa-devel at alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/mxs/mxs-saif.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 53f4fd8..7fd224b 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/fsl/mxs-dma.h>
+#include <linux/pinctrl/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -625,6 +626,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	struct resource *iores, *dmares;
 	struct mxs_saif *saif;
 	struct mxs_saif_platform_data *pdata;
+	struct pinctrl *pinctrl;
 	int ret = 0;
 
 	if (pdev->id >= ARRAY_SIZE(mxs_saif))
@@ -650,6 +652,12 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		saif->master_id = saif->id;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		return ret;
+	}
+
 	saif->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(saif->clk)) {
 		ret = PTR_ERR(saif->clk);
-- 
1.7.5.4
