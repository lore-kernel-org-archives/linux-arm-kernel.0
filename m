From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Mon, 8 Jan 2018 02:15:01 +0000
Subject: [PATCH -next] ASoC: mediatek: mt2701: fix return value check in
 mt2701_afe_pcm_dev_probe()
Message-ID: <1515377701-37553-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of error, the function syscon_node_to_regmap() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: dfa3cbb83e09 ("ASoC: mediatek: modify MT2701 AFE driver to adapt mfd device")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index f0cd08f..5bc4e00 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1440,9 +1440,9 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	}
 
 	afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
-	if (!afe->regmap) {
+	if (IS_ERR(afe->regmap)) {
 		dev_err(dev, "could not get regmap from parent\n");
-		return -ENODEV;
+		return PTR_ERR(afe->regmap);
 	}
 
 	mutex_init(&afe->irq_alloc_lock);
