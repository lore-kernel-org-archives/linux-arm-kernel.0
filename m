From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 22 Apr 2016 16:49:31 +0800
Subject: [PATCH v4] i2c: designware-platdrv: fix unbalanced clk enable and
 prepare
Message-ID: <1461314971-5944-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If i2c_dw_probe() fails, we should disable and unprepare the clock,
otherwise the clock enable and prepare is left unbalanced.

In dw_i2c_plat_remove(), we'd better to not rely on runtime PM to
disable and unprepare the clock since CONFIG_PM may be disabled when
configuring the kernel. So we explicitly disable and unprepare the
clock in dw_i2c_plat_remove() rather than implicitly rely on
pm_runtime_put_sync(). To keep the device usage count balanced, we
call pm_runtime_put_noidle() to decrease the usage count.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 Since v3:
  - use runtime PM rather than rpm in commit msg
  - remove duplicated "(" in commit msg

 Since v2:
 ?- s/clk/clock
 ?- describe why use pm_runtime_put_noidle()
 
 Since v1:
 ?- fix commit msg: "not rely on rpm" rather than "rely on rpm"
 ?- call i2c_dw_plat_prepare_clk after pm_rumtime_disable()
 drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d656657..a771781 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -253,8 +253,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	r = i2c_dw_probe(dev);
-	if (r && !dev->pm_runtime_disabled)
-		pm_runtime_disable(&pdev->dev);
+	if (r) {
+		if (!dev->pm_runtime_disabled)
+			pm_runtime_disable(&pdev->dev);
+		i2c_dw_plat_prepare_clk(dev, false);
+	}
 
 	return r;
 }
@@ -264,15 +267,16 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 
 	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (!dev->pm_runtime_disabled)
+		pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 
 	i2c_del_adapter(&dev->adapter);
 
 	i2c_dw_disable(dev);
 
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
-	if (!dev->pm_runtime_disabled)
-		pm_runtime_disable(&pdev->dev);
+	i2c_dw_plat_prepare_clk(dev, false);
 
 	return 0;
 }
-- 
2.8.1
