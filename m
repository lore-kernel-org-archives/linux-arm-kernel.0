From: alexanders83@web.de (Alexander Stein)
Date: Fri, 29 Apr 2016 14:50:03 +0200
Subject: [PATCH 2/2] pinctrl: at91: Merge clk_prepare and clk_enable into
 clk_prepare_enable
In-Reply-To: <1461934203-3206-1-git-send-email-alexanders83@web.de>
References: <1461934203-3206-1-git-send-email-alexanders83@web.de>
Message-ID: <1461934203-3206-2-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This simplifies the normal as well as the error path.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 drivers/pinctrl/pinctrl-at91.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 29d57118e35c..e380333dad46 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1730,14 +1730,9 @@ static int at91_gpio_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = clk_prepare(at91_chip->clock);
-	if (ret)
-		goto clk_prepare_err;
-
-	/* enable PIO controller's clock */
-	ret = clk_enable(at91_chip->clock);
+	ret = clk_prepare_enable(at91_chip->clock);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock, ignoring.\n");
+		dev_err(&pdev->dev, "failed to prepare and enable clock, ignoring.\n");
 		goto clk_enable_err;
 	}
 
@@ -1797,10 +1792,8 @@ static int at91_gpio_probe(struct platform_device *pdev)
 irq_setup_err:
 	gpiochip_remove(chip);
 gpiochip_add_err:
-	clk_disable(at91_chip->clock);
 clk_enable_err:
-	clk_unprepare(at91_chip->clock);
-clk_prepare_err:
+	clk_disable_unprepare(at91_chip->clock);
 err:
 	dev_err(&pdev->dev, "Failure %i for GPIO %i\n", ret, alias_idx);
 
-- 
2.8.1
