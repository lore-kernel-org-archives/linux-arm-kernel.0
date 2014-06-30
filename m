From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:09:37 +0300
Subject: [PATCH] Input: s3c2410_ts: Move to
 clk_prepare_enable/clk_disable_unprepare
Message-ID: <1404155377-2862-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clk_prepare_enable/clk_disable_unprepare to make the driver
work properly with common clock framework.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/input/touchscreen/s3c2410_ts.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 19cb247..c0e0baa 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -264,7 +264,7 @@ static int s3c2410ts_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	clk_enable(ts.clock);
+	clk_prepare_enable(ts.clock);
 	dev_dbg(dev, "got and enabled clocks\n");
 
 	ts.irq_tc = ret = platform_get_irq(pdev, 0);
@@ -369,7 +369,7 @@ static int s3c2410ts_remove(struct platform_device *pdev)
 	free_irq(ts.irq_tc, ts.input);
 	del_timer_sync(&touch_timer);
 
-	clk_disable(ts.clock);
+	clk_disable_unprepare(ts.clock);
 	clk_put(ts.clock);
 
 	input_unregister_device(ts.input);
@@ -383,7 +383,7 @@ static int s3c2410ts_suspend(struct device *dev)
 {
 	writel(TSC_SLEEP, ts.io + S3C2410_ADCTSC);
 	disable_irq(ts.irq_tc);
-	clk_disable(ts.clock);
+	clk_disable_unprepare(ts.clock);
 
 	return 0;
 }
@@ -393,7 +393,7 @@ static int s3c2410ts_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct s3c2410_ts_mach_info *info = dev_get_platdata(&pdev->dev);
 
-	clk_enable(ts.clock);
+	clk_prepare_enable(ts.clock);
 	enable_irq(ts.irq_tc);
 
 	/* Initialise registers */
-- 
2.0.0
