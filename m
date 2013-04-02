From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 02 Apr 2013 16:53:02 +0530
Subject: [PATCH 2/2] ASoC: Samsung: set drvdata before adding secondary device
In-Reply-To: <1364901782-16619-1-git-send-email-padma.v@samsung.com>
References: <1364901782-16619-1-git-send-email-padma.v@samsung.com>
Message-ID: <1364901782-16619-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prathyush K <prathyush.k@samsung.com>

Currently, a new platform device is created for secondary device
by calling platform_device_register_resndata and then the drvdata
is set for this device.

The following patch has been added to driver core:
"driver core: fix possible missing of device probe".

This results in the added device getting probed immediately but
the drvdata for the secondary device is not yet set.
This patch removes the platform_device_register_resndata call and
instead calls platform_device_alloc, platform_set_drvdata and
platform_device_add which fixes the above issue.

Signed-off-by: Prathyush K <prathyush.k@samsung.com>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

Based on Kukjin for-next branch

 sound/soc/samsung/i2s.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index f1fc064..6bbeb0b 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -972,6 +972,7 @@ static const struct snd_soc_dai_ops samsung_i2s_dai_ops = {
 static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 {
 	struct i2s_dai *i2s;
+	int ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dai), GFP_KERNEL);
 	if (i2s == NULL)
@@ -996,15 +997,17 @@ static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 		i2s->i2s_dai_drv.capture.channels_max = 2;
 		i2s->i2s_dai_drv.capture.rates = SAMSUNG_I2S_RATES;
 		i2s->i2s_dai_drv.capture.formats = SAMSUNG_I2S_FMTS;
+		dev_set_drvdata(&i2s->pdev->dev, i2s);
 	} else {	/* Create a new platform_device for Secondary */
-		i2s->pdev = platform_device_register_resndata(NULL,
-				"samsung-i2s-sec", -1, NULL, 0, NULL, 0);
+		i2s->pdev = platform_device_alloc("samsung-i2s-sec", -1);
 		if (IS_ERR(i2s->pdev))
 			return NULL;
-	}
 
-	/* Pre-assign snd_soc_dai_set_drvdata */
-	dev_set_drvdata(&i2s->pdev->dev, i2s);
+		platform_set_drvdata(i2s->pdev, i2s);
+		ret = platform_device_add(i2s->pdev);
+		if (ret < 0)
+			return NULL;
+	}
 
 	return i2s;
 }
-- 
1.7.4.4
