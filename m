From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Jan 2017 12:41:10 +0100
Subject: [PATCH 08/14] mmc: sunxi: simplify optional reset handling
In-Reply-To: <20170130114116.22089-1-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
Message-ID: <20170130114116.22089-8-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_(de)assert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sunxi-mmc.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b1d1303389a71..cd59a5df6cc86 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1149,7 +1149,7 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 	}
 
 	host->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
-	if (PTR_ERR(host->reset) == -EPROBE_DEFER)
+	if (IS_ERR(host->reset))
 		return PTR_ERR(host->reset);
 
 	ret = clk_prepare_enable(host->clk_ahb);
@@ -1176,12 +1176,10 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		goto error_disable_clk_output;
 	}
 
-	if (!IS_ERR(host->reset)) {
-		ret = reset_control_deassert(host->reset);
-		if (ret) {
-			dev_err(&pdev->dev, "reset err %d\n", ret);
-			goto error_disable_clk_sample;
-		}
+	ret = reset_control_deassert(host->reset);
+	if (ret) {
+		dev_err(&pdev->dev, "reset err %d\n", ret);
+		goto error_disable_clk_sample;
 	}
 
 	/*
@@ -1197,8 +1195,7 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 			sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
 
 error_assert_reset:
-	if (!IS_ERR(host->reset))
-		reset_control_assert(host->reset);
+	reset_control_assert(host->reset);
 error_disable_clk_sample:
 	clk_disable_unprepare(host->clk_sample);
 error_disable_clk_output:
@@ -1281,8 +1278,7 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	disable_irq(host->irq);
 	sunxi_mmc_reset_host(host);
 
-	if (!IS_ERR(host->reset))
-		reset_control_assert(host->reset);
+	reset_control_assert(host->reset);
 
 	clk_disable_unprepare(host->clk_sample);
 	clk_disable_unprepare(host->clk_output);
-- 
2.11.0
