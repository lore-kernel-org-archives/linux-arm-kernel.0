From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 30 May 2017 16:22:57 +0530
Subject: [PATCH] Input: s3c2410_ts - Handle return value of clk_prepare_enable
Message-ID: <477d9b0992f4b16454ad1780eb4477433c075226.1496141406.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/touchscreen/s3c2410_ts.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 41d58e8..3b3db8c 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -264,7 +264,11 @@ static int s3c2410ts_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	clk_prepare_enable(ts.clock);
+	ret = clk_prepare_enable(ts.clock);
+	if (ret) {
+		dev_err(dev, "Failed! to enabled clocks\n");
+		goto err_clk_get;
+	}
 	dev_dbg(dev, "got and enabled clocks\n");
 
 	ts.irq_tc = ret = platform_get_irq(pdev, 0);
@@ -353,7 +357,9 @@ static int s3c2410ts_probe(struct platform_device *pdev)
  err_iomap:
 	iounmap(ts.io);
  err_clk:
+	clk_disable_unprepare(ts.clock);
 	del_timer_sync(&touch_timer);
+ err_clk_get:
 	clk_put(ts.clock);
 	return ret;
 }
-- 
1.9.1
