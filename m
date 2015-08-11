From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 11 Aug 2015 13:32:56 +0800
Subject: [PATCH 2/3] crypto: sunxi-ss: Add optional reset control support
In-Reply-To: <1439271177-26523-1-git-send-email-wens@csie.org>
References: <1439271177-26523-1-git-send-email-wens@csie.org>
Message-ID: <1439271177-26523-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sun6i and later platforms, the reset control is split out of the
clock gates. Add support for an optional reset control.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/crypto/sunxi-ss/sun4i-ss-core.c | 22 ++++++++++++++++++++++
 drivers/crypto/sunxi-ss/sun4i-ss.h      |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
index 0b79b58c913b..eab6fe227fa0 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/reset.h>
 
 #include "sun4i-ss.h"
 
@@ -253,6 +254,14 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 	}
 	dev_dbg(&pdev->dev, "clock ahb_ss acquired\n");
 
+	ss->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
+	if (IS_ERR(ss->reset)) {
+		if (PTR_ERR(ss->reset) == -EPROBE_DEFER)
+			return PTR_ERR(ss->reset);
+		dev_info(&pdev->dev, "no reset control found\n");
+		ss->reset = NULL;
+	}
+
 	/* Enable both clocks */
 	err = clk_prepare_enable(ss->busclk);
 	if (err != 0) {
@@ -275,6 +284,15 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 		goto error_clk;
 	}
 
+	/* Deassert reset if we have a reset control */
+	if (ss->reset) {
+		err = reset_control_deassert(ss->reset);
+		if (err) {
+			dev_err(&pdev->dev, "Cannot deassert reset control\n");
+			goto error_clk;
+		}
+	}
+
 	/*
 	 * The only impact on clocks below requirement are bad performance,
 	 * so do not print "errors"
@@ -352,6 +370,8 @@ error_alg:
 			break;
 		}
 	}
+	if (ss->reset)
+		reset_control_assert(ss->reset);
 error_clk:
 	clk_disable_unprepare(ss->ssclk);
 error_ssclk:
@@ -376,6 +396,8 @@ static int sun4i_ss_remove(struct platform_device *pdev)
 	}
 
 	writel(0, ss->base + SS_CTL);
+	if (ss->reset)
+		reset_control_assert(ss->reset);
 	clk_disable_unprepare(ss->busclk);
 	clk_disable_unprepare(ss->ssclk);
 	return 0;
diff --git a/drivers/crypto/sunxi-ss/sun4i-ss.h b/drivers/crypto/sunxi-ss/sun4i-ss.h
index db18b2554e6f..8e9c05f6e4d4 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss.h
+++ b/drivers/crypto/sunxi-ss/sun4i-ss.h
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <crypto/scatterwalk.h>
 #include <linux/scatterlist.h>
 #include <linux/interrupt.h>
@@ -129,6 +130,7 @@ struct sun4i_ss_ctx {
 	int irq;
 	struct clk *busclk;
 	struct clk *ssclk;
+	struct reset_control *reset;
 	struct device *dev;
 	struct resource *res;
 	spinlock_t slock; /* control the use of the device */
-- 
2.5.0
