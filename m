From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:28 +0000
Subject: [PATCH 31/46] regulator: ab8500: Don't register external regulators
 on AB8505
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-32-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

ExtSupply regulators are not included on AB8505 based platforms.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Tested-by: Marcus COOPER <marcus.xm.cooper@stericsson.com>
---
 drivers/regulator/ab8500.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 840f23b..c1e1cf9 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -2767,10 +2767,12 @@ static int ab8500_regulator_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	/* register external regulators (before Vaux1, 2 and 3) */
-	err = ab8500_ext_regulator_init(pdev);
-	if (err)
-		return err;
+	if (!is_ab8505(ab8500)) {
+		/* register external regulators (before Vaux1, 2 and 3) */
+		err = ab8500_ext_regulator_init(pdev);
+		if (err)
+			return err;
+	}
 
 	/* register all regulators */
 	for (i = 0; i < regulator_info_size; i++) {
@@ -2812,10 +2814,12 @@ static int ab8500_regulator_remove(struct platform_device *pdev)
 		regulator_unregister(info->regulator);
 	}
 
-	/* remove external regulators (after Vaux1, 2 and 3) */
-	err = ab8500_ext_regulator_exit(pdev);
-	if (err)
-		return err;
+	if (!is_ab8505(ab8500)) {
+		/* remove external regulators (after Vaux1, 2 and 3) */
+		err = ab8500_ext_regulator_exit(pdev);
+		if (err)
+			return err;
+	}
 
 	/* remove regulator debug */
 	err = ab8500_regulator_debug_exit(pdev);
-- 
1.7.10.4
