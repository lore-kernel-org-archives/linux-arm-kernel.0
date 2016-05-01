From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  1 May 2016 19:36:59 +0900
Subject: [PATCH 3/7] reset: lpc18xx: use devm_reset_controller_register()
In-Reply-To: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462099023-11819-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_reset_controller_register() for the reset controller
registration and remove the unregister call from the .remove callback.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/reset-lpc18xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
index 3b8a4f5..dd4f27e 100644
--- a/drivers/reset/reset-lpc18xx.c
+++ b/drivers/reset/reset-lpc18xx.c
@@ -199,7 +199,7 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rc);
 
-	ret = reset_controller_register(&rc->rcdev);
+	ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register device\n");
 		goto dis_clks;
@@ -229,8 +229,6 @@ static int lpc18xx_rgu_remove(struct platform_device *pdev)
 	if (ret)
 		dev_warn(&pdev->dev, "failed to unregister restart handler\n");
 
-	reset_controller_unregister(&rc->rcdev);
-
 	clk_disable_unprepare(rc->clk_delay);
 	clk_disable_unprepare(rc->clk_reg);
 
-- 
1.9.1
