From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 29 May 2017 17:46:02 +0200
Subject: [PATCH 14/15] sound: stm32: use devm_of_platform_populate()
In-Reply-To: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1496072763-31209-15-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of devm_of_platform_populate() simplify driver code
by allowing to delete stm32_sai_remove().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Mark Brown <broonie@kernel.org>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: Alexandre Torgue <alexandre.torgue@st.com>
CC: Olivier Moysan <olivier.moysan@st.com>
CC: alsa-devel at alsa-project.org
CC: linux-arm-kernel at lists.infradead.org
CC: linux-kernel at vger.kernel.org
---
 sound/soc/stm/stm32_sai.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 2a27a26..25304f8 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -34,7 +34,6 @@
 
 static int stm32_sai_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct stm32_sai_data *sai;
 	struct reset_control *rst;
 	struct resource *res;
@@ -86,14 +85,7 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	sai->pdev = pdev;
 	platform_set_drvdata(pdev, sai);
 
-	return of_platform_populate(np, NULL, NULL, &pdev->dev);
-}
-
-static int stm32_sai_remove(struct platform_device *pdev)
-{
-	of_platform_depopulate(&pdev->dev);
-
-	return 0;
+	return devm_of_platform_populate(&pdev->dev);
 }
 
 MODULE_DEVICE_TABLE(of, stm32_sai_ids);
@@ -104,7 +96,6 @@ static int stm32_sai_remove(struct platform_device *pdev)
 		.of_match_table = stm32_sai_ids,
 	},
 	.probe = stm32_sai_probe,
-	.remove = stm32_sai_remove,
 };
 
 module_platform_driver(stm32_sai_driver);
-- 
1.9.1
