From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 1 Nov 2012 15:20:01 +0100
Subject: [PATCH 1/2] Input: nomadik-ske-keypad - fixup use of clk
In-Reply-To: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
References: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1351779602-13818-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Do proper error handling for clk and make sure clocks are being
prepared|unprepared as well as enabled|disabled.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/input/keyboard/nomadik-ske-keypad.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 49f5fa6..95dcc9b 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -287,14 +287,19 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 					   keypad->keymap, input);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to build keymap\n");
-		goto err_iounmap;
+		goto err_clk;
 	}
 
 	input_set_capability(input, EV_MSC, MSC_SCAN);
 	if (!plat->no_autorepeat)
 		__set_bit(EV_REP, input->evbit);
 
-	clk_enable(keypad->clk);
+	error = clk_prepare_enable(keypad->clk);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to prepare/enable clk\n");
+		goto err_clk;
+	}
+
 
 	/* go through board initialization helpers */
 	if (keypad->board->init)
@@ -330,7 +335,8 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 err_free_irq:
 	free_irq(keypad->irq, keypad);
 err_clk_disable:
-	clk_disable(keypad->clk);
+	clk_disable_unprepare(keypad->clk);
+err_clk:
 	clk_put(keypad->clk);
 err_iounmap:
 	iounmap(keypad->reg_base);
@@ -351,7 +357,7 @@ static int __devexit ske_keypad_remove(struct platform_device *pdev)
 
 	input_unregister_device(keypad->input);
 
-	clk_disable(keypad->clk);
+	clk_disable_unprepare(keypad->clk);
 	clk_put(keypad->clk);
 
 	if (keypad->board->exit)
-- 
1.7.10
