From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 16 Oct 2014 09:42:05 +0200
Subject: [PATCH v2 5/7] power: 88pm860x_charger: Decrement the power supply's
 device reference counter
In-Reply-To: <1413445327-24862-1-git-send-email-k.kozlowski@samsung.com>
References: <1413445327-24862-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1413445327-24862-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use power_supply_put() to decrement the power supply's device reference
counter.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/power/88pm860x_charger.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_charger.c
index 534b3e2e3487..48aa0d829cb0 100644
--- a/drivers/power/88pm860x_charger.c
+++ b/drivers/power/88pm860x_charger.c
@@ -298,13 +298,18 @@ static int set_charging_fsm(struct pm860x_charger_info *info)
 		return -EINVAL;
 	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW,
 			&data);
-	if (ret)
+	if (ret) {
+		power_supply_put(psy);
 		return ret;
+	}
 	vbatt = data.intval / 1000;
 
 	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_PRESENT, &data);
-	if (ret)
+	if (ret) {
+		power_supply_put(psy);
 		return ret;
+	}
+	power_supply_put(psy);
 
 	mutex_lock(&info->lock);
 	info->present = data.intval;
@@ -447,6 +452,7 @@ static irqreturn_t pm860x_temp_handler(int irq, void *data)
 
 	set_charging_fsm(info);
 out:
+	power_supply_put(psy);
 	return IRQ_HANDLED;
 }
 
@@ -507,6 +513,7 @@ static irqreturn_t pm860x_done_handler(int irq, void *data)
 
 out:
 	mutex_unlock(&info->lock);
+	power_supply_put(psy);
 	dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
 	set_charging_fsm(info);
 
-- 
1.9.1
