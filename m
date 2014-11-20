From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 20 Nov 2014 16:55:23 +0100
Subject: [PATCH 4/9] rc: sunxi-cir: Add support for an optional reset
 controller
In-Reply-To: <1416498928-1300-1-git-send-email-hdegoede@redhat.com>
References: <1416498928-1300-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1416498928-1300-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sun6i the cir block is attached to the reset controller, add support
for de-asserting the reset if a reset controller is specified in dt.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/rc/sunxi-cir.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index bcee8e1..895fb65 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/reset.h>
 #include <media/rc-core.h>
 
 #define SUNXI_IR_DEV "sunxi-ir"
@@ -95,6 +96,7 @@ struct sunxi_ir {
 	int             irq;
 	struct clk      *clk;
 	struct clk      *apb_clk;
+	struct reset_control *rst;
 	const char      *map_name;
 };
 
@@ -166,15 +168,29 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 		return PTR_ERR(ir->clk);
 	}
 
+	/* Reset (optional) */
+	ir->rst = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(ir->rst)) {
+		ret = PTR_ERR(ir->rst);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		ir->rst = NULL;
+	} else {
+		ret = reset_control_deassert(ir->rst);
+		if (ret)
+			return ret;
+	}
+
 	ret = clk_set_rate(ir->clk, SUNXI_IR_BASE_CLK);
 	if (ret) {
 		dev_err(dev, "set ir base clock failed!\n");
-		return ret;
+		goto exit_reset_assert;
 	}
 
 	if (clk_prepare_enable(ir->apb_clk)) {
 		dev_err(dev, "try to enable apb_ir_clk failed\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto exit_reset_assert;
 	}
 
 	if (clk_prepare_enable(ir->clk)) {
@@ -271,6 +287,9 @@ exit_clkdisable_clk:
 	clk_disable_unprepare(ir->clk);
 exit_clkdisable_apb_clk:
 	clk_disable_unprepare(ir->apb_clk);
+exit_reset_assert:
+	if (ir->rst)
+		reset_control_assert(ir->rst);
 
 	return ret;
 }
@@ -282,6 +301,8 @@ static int sunxi_ir_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(ir->clk);
 	clk_disable_unprepare(ir->apb_clk);
+	if (ir->rst)
+		reset_control_assert(ir->rst);
 
 	spin_lock_irqsave(&ir->ir_lock, flags);
 	/* disable IR IRQ */
-- 
2.1.0
