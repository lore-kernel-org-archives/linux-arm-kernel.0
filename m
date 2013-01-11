From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jan 2013 13:13:05 +0000
Subject: [PATCH 17/18] Power: ab8500_fg: Overflow in current calculation
In-Reply-To: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1357909986-9262-18-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paer-Olof Haakansson <par-olof.hakansson@stericsson.com>

When calculating the average current the nominator will
overflow when the charging current is high.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Henrik S?lver <henrik.solver@stericsson.com>
Reviewed-by: Par-Olof HAKANSSON <par-olof.hakansson@stericsson.com>
Reviewed-by: Jonas ABERG <jonas.aberg@stericsson.com>
Tested-by: Par-Olof HAKANSSON <par-olof.hakansson@stericsson.com>
---
 drivers/power/ab8500_fg.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 845e64f..4bc2c2d 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -805,12 +805,9 @@ static void ab8500_fg_acc_cur_work(struct work_struct *work)
 
 	/*
 	 * Convert to unit value in mA
-	 * Full scale input voltage is
-	 * 66.660mV => LSB = 66.660mV/(4096*res) = 1.627mA
-	 * Given a 250ms conversion cycle time the LSB corresponds
-	 * to 112.9 nAh. Convert to current by dividing by the conversion
+	 * by dividing by the conversion
 	 * time in hours (= samples / (3600 * 4)h)
-	 * 112.9nAh assumes 10mOhm, but fg_res is in 0.1mOhm
+	 * and multiply with 1000
 	 */
 	di->avg_curr = (val * QLSB_NANO_AMP_HOURS_X10 * 36) /
 		(1000 * di->bm->fg_res * (di->fg_samples / 4));
@@ -821,6 +818,8 @@ static void ab8500_fg_acc_cur_work(struct work_struct *work)
 
 	queue_work(di->fg_wq, &di->fg_work);
 
+	dev_dbg(di->dev, "fg_res: %d, fg_samples: %d, gasg: %d, accu_charge: %d \n",
+				di->bm->fg_res, di->fg_samples, val, di->accu_charge);
 	return;
 exit:
 	dev_err(di->dev,
-- 
1.7.9.5
