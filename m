From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 19:42:28 +0100
Subject: [PATCH V3 01/15] ASoC: samsung: i2s: samsung_i2s_get_driver_data()
 cleanup
In-Reply-To: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1421260962-16892-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tidy up the samsung_i2s_get_driver_data() function by using
IS_ENABLE() instead of #ifdef and add missing braces for
the 'else' part. Also ensure we are not dereferencing NULL
'match' pointer.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 86491c9..e5473ee 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1123,15 +1123,14 @@ static const struct of_device_id exynos_i2s_match[];
 static inline const struct samsung_i2s_dai_data *samsung_i2s_get_driver_data(
 						struct platform_device *pdev)
 {
-#ifdef CONFIG_OF
-	if (pdev->dev.of_node) {
+	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
 		const struct of_device_id *match;
 		match = of_match_node(exynos_i2s_match, pdev->dev.of_node);
-		return match->data;
-	} else
-#endif
+		return match ? match->data : NULL;
+	} else {
 		return (struct samsung_i2s_dai_data *)
 				platform_get_device_id(pdev)->driver_data;
+	}
 }
 
 #ifdef CONFIG_PM
-- 
1.7.9.5
