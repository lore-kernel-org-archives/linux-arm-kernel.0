From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Mon, 7 May 2018 01:39:45 +0000
Subject: [PATCH -next] ASoC: fix return value check in
 mt6351_codec_driver_probe()
Message-ID: <1525657185-73163-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of error, the function dev_get_regmap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/mt6351.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index e739f07..f73dcd7 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1472,8 +1472,8 @@ static int mt6351_codec_driver_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 
 	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (IS_ERR(priv->regmap))
-		return PTR_ERR(priv->regmap);
+	if (!priv->regmap)
+		return -ENODEV;
 
 	dev_dbg(priv->dev, "%s(), dev name %s\n",
 		__func__, dev_name(&pdev->dev));
