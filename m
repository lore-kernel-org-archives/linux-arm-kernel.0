From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  1 May 2016 19:36:58 +0900
Subject: [PATCH 2/7] reset: ath79: use devm_reset_controller_register()
In-Reply-To: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462099023-11819-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_reset_controller_register() for the reset controller
registration and remove the unregister call from the .remove callback.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/reset-ath79.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/reset/reset-ath79.c b/drivers/reset/reset-ath79.c
index ccb940a..16d410c 100644
--- a/drivers/reset/reset-ath79.c
+++ b/drivers/reset/reset-ath79.c
@@ -112,7 +112,7 @@ static int ath79_reset_probe(struct platform_device *pdev)
 	ath79_reset->rcdev.of_reset_n_cells = 1;
 	ath79_reset->rcdev.nr_resets = 32;
 
-	err = reset_controller_register(&ath79_reset->rcdev);
+	err = devm_reset_controller_register(&pdev->dev, &ath79_reset->rcdev);
 	if (err)
 		return err;
 
@@ -131,7 +131,6 @@ static int ath79_reset_remove(struct platform_device *pdev)
 	struct ath79_reset *ath79_reset = platform_get_drvdata(pdev);
 
 	unregister_restart_handler(&ath79_reset->restart_nb);
-	reset_controller_unregister(&ath79_reset->rcdev);
 
 	return 0;
 }
-- 
1.9.1
