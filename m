From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:44:51 +0000
Subject: [PATCH 21/40] ab8500-btemp: Defer btemp filtering while initialising
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-22-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rupesh Kumar <rupesh.kumar@stericsson.com>

Due to btemp filtering enabled during init, temp values reported
to charge algorithm driver started from 0. As a result,charge
algorithm was going into wrong state and charging was stopped.

Signed-off-by: Rupesh Kumar <rupesh.kumar@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Marcus COOPER <marcus.xm.cooper@stericsson.com>
Reviewed-by: Martin SJOBLOM <martin.w.sjoblom@stericsson.com>
Reviewed-by: Philippe LANGLAIS <philippe.langlais@stericsson.com>
---
 drivers/power/ab8500_btemp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index fa60e3a..91ad3ed 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -609,7 +609,6 @@ static void ab8500_btemp_periodic_work(struct work_struct *work)
 		struct ab8500_btemp, btemp_periodic_work.work);
 
 	if (!di->initialized) {
-		di->initialized = true;
 		/* Identify the battery */
 		if (ab8500_btemp_id(di) < 0)
 			dev_warn(di->dev, "failed to identify the battery\n");
@@ -622,8 +621,9 @@ static void ab8500_btemp_periodic_work(struct work_struct *work)
 	 * same temperature. Else only allow 1 degree change from previous
 	 * reported value in the direction of the new measurement.
 	 */
-	if (bat_temp == di->prev_bat_temp || !di->initialized) {
-		if (di->bat_temp != di->prev_bat_temp || !di->initialized) {
+	if ((bat_temp == di->prev_bat_temp) || !di->initialized) {
+		if ((di->bat_temp != di->prev_bat_temp) || !di->initialized) {
+			di->initialized = true;
 			di->bat_temp = bat_temp;
 			power_supply_changed(&di->btemp_psy);
 		}
-- 
1.7.10.4
