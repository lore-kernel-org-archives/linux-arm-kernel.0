From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 01:03:25 +0530
Subject: [PATCH 2/5] ASoC: mt8173: Fix platform_get_irq's error checking
In-Reply-To: <1510947208-17134-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510947208-17134-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510947208-17134-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 8a643a3..eee27bc 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
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
