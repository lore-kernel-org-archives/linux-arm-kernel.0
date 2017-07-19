From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 19 Jul 2017 17:25:11 +0200
Subject: [PATCH 007/102] bus: sunxi-rsb: explicitly request exclusive reset
 control
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Message-ID: <20170719152646.25903-8-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/bus/sunxi-rsb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 795c9d9c96a6d..c7f585a420d3e 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -670,7 +670,7 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 
 	p_clk_freq = clk_get_rate(rsb->clk);
 
-	rsb->rstc = devm_reset_control_get(dev, NULL);
+	rsb->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(rsb->rstc)) {
 		ret = PTR_ERR(rsb->rstc);
 		dev_err(dev, "failed to retrieve reset controller: %d\n", ret);
-- 
2.11.0
