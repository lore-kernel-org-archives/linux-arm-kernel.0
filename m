From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Jan 2017 12:41:07 +0100
Subject: [PATCH 05/14] [media] rc: sunxi-cir: simplify optional reset handling
In-Reply-To: <20170130114116.22089-1-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
Message-ID: <20170130114116.22089-5-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_(de)assert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/rc/sunxi-cir.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index eaadc081760ae..b1e22bd47985e 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -174,16 +174,11 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 
 	/* Reset (optional) */
 	ir->rst = devm_reset_control_get_optional(dev, NULL);
-	if (IS_ERR(ir->rst)) {
-		ret = PTR_ERR(ir->rst);
-		if (ret == -EPROBE_DEFER)
-			return ret;
-		ir->rst = NULL;
-	} else {
-		ret = reset_control_deassert(ir->rst);
-		if (ret)
-			return ret;
-	}
+	if (IS_ERR(ir->rst))
+		return PTR_ERR(ir->rst);
+	ret = reset_control_deassert(ir->rst);
+	if (ret)
+		return ret;
 
 	ret = clk_set_rate(ir->clk, SUNXI_IR_BASE_CLK);
 	if (ret) {
@@ -292,8 +287,7 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 exit_clkdisable_apb_clk:
 	clk_disable_unprepare(ir->apb_clk);
 exit_reset_assert:
-	if (ir->rst)
-		reset_control_assert(ir->rst);
+	reset_control_assert(ir->rst);
 
 	return ret;
 }
@@ -305,8 +299,7 @@ static int sunxi_ir_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(ir->clk);
 	clk_disable_unprepare(ir->apb_clk);
-	if (ir->rst)
-		reset_control_assert(ir->rst);
+	reset_control_assert(ir->rst);
 
 	spin_lock_irqsave(&ir->ir_lock, flags);
 	/* disable IR IRQ */
-- 
2.11.0
