From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Jun 2016 17:07:22 +0200
Subject: [PATCH 04/10] i2c: designware-platdrv: Disable autosuspend in error
 path in ->probe()
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1465916848-8207-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable runtime PM autosuspend in the error path in ->probe() to make sure
it's disabled at the next probe attempt.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 94ff953..7f67d801 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -249,6 +249,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		if (!IS_ERR(dev->clk))
 			clk_disable_unprepare(dev->clk);
 		pm_runtime_disable(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		if (dev->pm_runtime_disabled)
 			pm_runtime_put_noidle(&pdev->dev);
 	}
-- 
1.9.1
