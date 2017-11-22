From: olivier.moysan@st.com (Olivier Moysan)
Date: Wed, 22 Nov 2017 16:02:27 +0100
Subject: [PATCH 3/3] ASoC: stm32: sai: use devm_of_platform_populate()
In-Reply-To: <1511362947-14747-1-git-send-email-olivier.moysan@st.com>
References: <1511362947-14747-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1511362947-14747-4-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_of_platform_populate() instead of of_platform_depopulate()
to simplify driver code.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 0a1f064..d743b7d 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -124,7 +124,6 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 
 static int stm32_sai_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct stm32_sai_data *sai;
 	struct reset_control *rst;
 	struct resource *res;
@@ -184,14 +183,7 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	sai->set_sync = &stm32_sai_set_sync;
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
@@ -202,7 +194,6 @@ static int stm32_sai_remove(struct platform_device *pdev)
 		.of_match_table = stm32_sai_ids,
 	},
 	.probe = stm32_sai_probe,
-	.remove = stm32_sai_remove,
 };
 
 module_platform_driver(stm32_sai_driver);
-- 
1.9.1
