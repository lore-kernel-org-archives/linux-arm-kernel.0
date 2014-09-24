From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 24 Sep 2014 21:45:01 +0530
Subject: [PATCH 11/27] mfd: ab8500-gpadc: use
 pm_runtime_last_busy_and_autosuspend helper
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1411575342-31048-12-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/mfd/ab8500-gpadc.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index 36000f9..46bea3a 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -571,8 +571,7 @@ int ab8500_gpadc_double_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
 	}
 
 	/* Disable VTVout LDO this is required for GPADC */
-	pm_runtime_mark_last_busy(gpadc->dev);
-	pm_runtime_put_autosuspend(gpadc->dev);
+	pm_runtime_last_busy_and_autosuspend(gpadc->dev);
 
 	mutex_unlock(&gpadc->ab8500_gpadc_lock);
 
@@ -910,8 +909,7 @@ static int ab8500_gpadc_resume(struct device *dev)
 	if (ret)
 		dev_err(dev, "Failed to enable vtvout LDO: %d\n", ret);
 
-	pm_runtime_mark_last_busy(gpadc->dev);
-	pm_runtime_put_autosuspend(gpadc->dev);
+	pm_runtime_last_busy_and_autosuspend(gpadc->dev);
 
 	mutex_unlock(&gpadc->ab8500_gpadc_lock);
 	return ret;
-- 
1.7.0.4
