From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 10:57:52 +0530
Subject: [PATCH 2/5 v2] ASoC: mt8173: Fix platform_get_irq's error checking
In-Reply-To: <874375c0dca41790e47b60ce30f88ab353f97b38.1510982440.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510982440.git.arvind.yadav.cs@gmail.com>
Message-ID: <f683092949c0a6195b09ebbeb690e358094a0506.1510982440.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
chnages in v2 :
              irq_id was unsigned. so changed it to signed.

 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 8a643a3..11f5f2a 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1083,7 +1083,7 @@ static int mt8173_afe_init_audio_clk(struct mtk_base_afe *afe)
 static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	int ret, i;
-	unsigned int irq_id;
+	int irq_id;
 	struct mtk_base_afe *afe;
 	struct mt8173_afe_private *afe_priv;
 	struct resource *res;
@@ -1105,9 +1105,9 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->dev = &pdev->dev;
 
 	irq_id = platform_get_irq(pdev, 0);
-	if (!irq_id) {
+	if (irq_id < 0) {
 		dev_err(afe->dev, "np %s no irq\n", afe->dev->of_node->name);
-		return -ENXIO;
+		return irq_id;
 	}
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
 			       0, "Afe_ISR_Handle", (void *)afe);
-- 
2.7.4
