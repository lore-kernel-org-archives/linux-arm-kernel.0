From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:45:10 +0000
Subject: [PATCH 40/40] ab8500-charger: Do not use [delayed_]work_pending()
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-41-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to test whether a (delayed) work item is pending
before queueing, flushing or cancelling it.  Most uses are unnecessary
and quite a few of them are buggy.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/power/ab8500_charger.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index 81c9615..a558318 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -1661,8 +1661,7 @@ static int ab8500_charger_usb_en(struct ux500_charger *charger,
 		dev_dbg(di->dev, "%s Disabled USB charging\n", __func__);
 
 		/* Cancel any pending Vbat check work */
-		if (delayed_work_pending(&di->check_vbat_work))
-			cancel_delayed_work(&di->check_vbat_work);
+		cancel_delayed_work(&di->check_vbat_work);
 
 	}
 	ab8500_power_supply_changed(di, &di->usb_chg.psy);
@@ -3335,11 +3334,8 @@ static int ab8500_charger_resume(struct platform_device *pdev)
 			dev_err(di->dev, "Failed to kick WD!\n");
 
 		/* If not already pending start a new timer */
-		if (!delayed_work_pending(
-			&di->kick_wd_work)) {
-			queue_delayed_work(di->charger_wq, &di->kick_wd_work,
-				round_jiffies(WD_KICK_INTERVAL));
-		}
+		queue_delayed_work(di->charger_wq, &di->kick_wd_work,
+				   round_jiffies(WD_KICK_INTERVAL));
 	}
 
 	/* If we still have a HW failure, schedule a new check */
@@ -3359,12 +3355,9 @@ static int ab8500_charger_suspend(struct platform_device *pdev,
 {
 	struct ab8500_charger *di = platform_get_drvdata(pdev);
 
-	/* Cancel any pending HW failure check */
-	if (delayed_work_pending(&di->check_hw_failure_work))
-		cancel_delayed_work(&di->check_hw_failure_work);
-
-	if (delayed_work_pending(&di->vbus_drop_end_work))
-		cancel_delayed_work(&di->vbus_drop_end_work);
+	/* Cancel any pending jobs */
+	cancel_delayed_work(&di->check_hw_failure_work);
+	cancel_delayed_work(&di->vbus_drop_end_work);
 
 	flush_delayed_work(&di->attach_work);
 	flush_delayed_work(&di->usb_charger_attached_work);
-- 
1.7.10.4
