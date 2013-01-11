From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jan 2013 13:13:01 +0000
Subject: [PATCH 13/18] power: ab8500_fg: Added support for BATT_OVV
In-Reply-To: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1357909986-9262-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hakan Berg <hakan.berg@stericsson.com>

Add support for the battery over-voltage situation

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Hakan Berg <hakan.berg@stericsson.com>
Reviewed-by: Karl KOMIEROWSKI <karl.komierowski@stericsson.com>
---
 drivers/power/ab8500_fg.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 5e8291b..845e64f 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -1840,24 +1840,26 @@ static void ab8500_fg_check_hw_failure_work(struct work_struct *work)
 	 * If we have had a battery over-voltage situation,
 	 * check ovv-bit to see if it should be reset.
 	 */
-	if (di->flags.bat_ovv) {
-		ret = abx500_get_register_interruptible(di->dev,
-			AB8500_CHARGER, AB8500_CH_STAT_REG,
-			&reg_value);
-		if (ret < 0) {
-			dev_err(di->dev, "%s ab8500 read failed\n", __func__);
-			return;
-		}
-		if ((reg_value & BATT_OVV) != BATT_OVV) {
-			dev_dbg(di->dev, "Battery recovered from OVV\n");
-			di->flags.bat_ovv = false;
+	ret = abx500_get_register_interruptible(di->dev,
+		AB8500_CHARGER, AB8500_CH_STAT_REG,
+		&reg_value);
+	if (ret < 0) {
+		dev_err(di->dev, "%s ab8500 read failed\n", __func__);
+		return;
+	}
+	if ((reg_value & BATT_OVV) == BATT_OVV) {
+		if (!di->flags.bat_ovv) {
+			dev_dbg(di->dev, "Battery OVV\n");
+			di->flags.bat_ovv = true;
 			power_supply_changed(&di->fg_psy);
-			return;
 		}
-
 		/* Not yet recovered from ovv, reschedule this test */
 		queue_delayed_work(di->fg_wq, &di->fg_check_hw_failure_work,
 				   round_jiffies(HZ));
+		} else {
+			dev_dbg(di->dev, "Battery recovered from OVV\n");
+			di->flags.bat_ovv = false;
+			power_supply_changed(&di->fg_psy);
 	}
 }
 
@@ -2037,8 +2039,6 @@ static irqreturn_t ab8500_fg_batt_ovv_handler(int irq, void *_di)
 	struct ab8500_fg *di = _di;
 
 	dev_dbg(di->dev, "Battery OVV\n");
-	di->flags.bat_ovv = true;
-	power_supply_changed(&di->fg_psy);
 
 	/* Schedule a new HW failure check */
 	queue_delayed_work(di->fg_wq, &di->fg_check_hw_failure_work, 0);
-- 
1.7.9.5
