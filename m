From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Jan 2013 12:03:45 +0000
Subject: [PATCH 09/24] pm2301: Remove volt_now & curr_now properties
In-Reply-To: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
References: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358769840-4763-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Loic Pallardy <loic.pallardy@stericsson.com>

There is no support to measure the main charger voltage and
current using AB9540 gpadc. Therefore this has been removed
from the driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rajkumar Kasirajan <rajkumar.kasirajan@stericsson.com>
Reviewed-by: Michel JAOUEN <michel.jaouen@stericsson.com>
Reviewed-by: Rabin VINCENT <rabin.vincent@stericsson.com>
Tested-by: Michel JAOUEN <michel.jaouen@stericsson.com>
---
 drivers/power/pm2301_charger.c |   35 -----------------------------------
 drivers/power/pm2301_charger.h |    1 -
 2 files changed, 36 deletions(-)

diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index 316d5f0..16d8cfe 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -47,9 +47,7 @@ static enum power_supply_property pm2xxx_charger_ac_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
 static int pm2xxx_charger_voltage_map[] = {
@@ -438,19 +436,6 @@ static irqreturn_t  pm2xxx_irq_int(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int pm2xxx_charger_get_ac_voltage(struct pm2xxx_charger *pm2)
-{
-	int vch = 0;
-
-	if (pm2->ac.charger_connected) {
-		vch = ab8500_gpadc_convert(pm2->gpadc, MAIN_CHARGER_V);
-		if (vch < 0)
-			dev_err(pm2->dev, "%s gpadc conv failed,\n", __func__);
-	}
-
-	return vch;
-}
-
 static int pm2xxx_charger_get_ac_cv(struct pm2xxx_charger *pm2)
 {
 	int ret = 0;
@@ -473,19 +458,6 @@ out:
 	return ret;
 }
 
-static int pm2xxx_charger_get_ac_current(struct pm2xxx_charger *pm2)
-{
-	int ich = 0;
-
-	if (pm2->ac.charger_online) {
-		ich = ab8500_gpadc_convert(pm2->gpadc, MAIN_CHARGER_C);
-		if (ich < 0)
-			dev_err(pm2->dev, "%s gpadc conv failed\n", __func__);
-	}
-
-	return ich;
-}
-
 static int pm2xxx_current_to_regval(int curr)
 {
 	int i;
@@ -585,17 +557,10 @@ static int pm2xxx_charger_ac_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = pm2->ac.charger_connected;
 		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		pm2->ac.charger_voltage = pm2xxx_charger_get_ac_voltage(pm2);
-		val->intval = pm2->ac.charger_voltage * 1000;
-		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
 		pm2->ac.cv_active = pm2xxx_charger_get_ac_cv(pm2);
 		val->intval = pm2->ac.cv_active;
 		break;
-	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		val->intval = pm2xxx_charger_get_ac_current(pm2) * 1000;
-		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/power/pm2301_charger.h b/drivers/power/pm2301_charger.h
index cc401d7..4bace67 100644
--- a/drivers/power/pm2301_charger.h
+++ b/drivers/power/pm2301_charger.h
@@ -456,7 +456,6 @@ enum pm2xxx_source_reg_int6 {
 struct pm2xxx_charger_info {
 	int charger_connected;
 	int charger_online;
-	int charger_voltage;
 	int cv_active;
 	bool wd_expired;
 };
-- 
1.7.9.5
