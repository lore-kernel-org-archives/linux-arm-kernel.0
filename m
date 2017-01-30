From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Jan 2017 12:41:03 +0100
Subject: [PATCH 01/14] crypto: sun4i-ss - simplify optional reset handling
Message-ID: <20170130114116.22089-1-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_(de)assert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-core.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
index 3ac6c6c4ad18e..e310e311d23ea 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
@@ -258,10 +258,11 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 
 	ss->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
 	if (IS_ERR(ss->reset)) {
-		if (PTR_ERR(ss->reset) == -EPROBE_DEFER)
-			return PTR_ERR(ss->reset);
-		dev_info(&pdev->dev, "no reset control found\n");
-		ss->reset = NULL;
+		err = PTR_ERR(ss->reset);
+		if (err == -EPROBE_DEFER)
+			return err;
+		dev_err(&pdev->dev, "Cannot get reset control err=%d\n", err);
+		return err;
 	}
 
 	/* Enable both clocks */
@@ -287,12 +288,10 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 	}
 
 	/* Deassert reset if we have a reset control */
-	if (ss->reset) {
-		err = reset_control_deassert(ss->reset);
-		if (err) {
-			dev_err(&pdev->dev, "Cannot deassert reset control\n");
-			goto error_clk;
-		}
+	err = reset_control_deassert(ss->reset);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot deassert reset control\n");
+		goto error_clk;
 	}
 
 	/*
@@ -372,8 +371,7 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 			break;
 		}
 	}
-	if (ss->reset)
-		reset_control_assert(ss->reset);
+	reset_control_assert(ss->reset);
 error_clk:
 	clk_disable_unprepare(ss->ssclk);
 error_ssclk:
@@ -398,8 +396,7 @@ static int sun4i_ss_remove(struct platform_device *pdev)
 	}
 
 	writel(0, ss->base + SS_CTL);
-	if (ss->reset)
-		reset_control_assert(ss->reset);
+	reset_control_assert(ss->reset);
 	clk_disable_unprepare(ss->busclk);
 	clk_disable_unprepare(ss->ssclk);
 	return 0;
-- 
2.11.0
