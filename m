From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 02 Apr 2013 16:53:01 +0530
Subject: [PATCH 1/2] ASoC: Samsung: return error if drvdata is not set
Message-ID: <1364901782-16619-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prathyush K <prathyush.k@samsung.com>

This patch fixes a possible crash in case drvdata for the secondary
device is not set.

Signed-off-by: Prathyush K <prathyush.k@samsung.com>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

Based on Kukjin for-next branch

 sound/soc/samsung/i2s.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d7231e3..f1fc064 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1107,6 +1107,10 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	if (samsung_dai_type == TYPE_SEC) {
 		sec_dai = dev_get_drvdata(&pdev->dev);
+		if (!sec_dai) {
+			dev_err(&pdev->dev, "Unable to get drvdata\n");
+			return -EFAULT;
+		}
 		snd_soc_register_dai(&sec_dai->pdev->dev,
 			&sec_dai->i2s_dai_drv);
 		asoc_dma_platform_register(&pdev->dev);
-- 
1.7.4.4
