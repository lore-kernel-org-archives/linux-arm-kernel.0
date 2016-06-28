From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 28 Jun 2016 09:22:48 +0800
Subject: [PATCH v2 5/7] power: act8945a_charger: Add capacity level property
In-Reply-To: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
References: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1467076970-12206-6-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the power supply capacity level property, it corresponds to
POWER_SUPPLY_CAPACITY_LEVEL_*.

It also utilizes the precision voltage detector function module
to catch the low battery voltage.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v2: None

 drivers/power/act8945a_charger.c | 78 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/power/act8945a_charger.c b/drivers/power/act8945a_charger.c
index be65e5d..9b79f5e 100644
--- a/drivers/power/act8945a_charger.c
+++ b/drivers/power/act8945a_charger.c
@@ -83,6 +83,7 @@ struct act8945a_charger {
 
 	bool init_done;
 	int irq_pin;
+	int lbo_pin;
 };
 
 static int act8945a_get_charger_state(struct regmap *regmap, int *val)
@@ -208,11 +209,70 @@ static int act8945a_get_battery_health(struct regmap *regmap, int *val)
 	return 0;
 }
 
+static int act8945a_get_capacity_level(struct act8945a_charger *charger,
+				       struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int status, state, config;
+	int lbo_level = 1;
+
+	if (gpio_is_valid(charger->lbo_pin))
+		lbo_level = gpio_get_value(charger->lbo_pin);
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATUS, &status);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(regmap, ACT8945A_APCH_CFG, &config);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATE, &state);
+	if (ret < 0)
+		return ret;
+
+	state &= APCH_STATE_CSTATE;
+	state >>= APCH_STATE_CSTATE_SHIFT;
+
+	switch (state) {
+	case APCH_STATE_CSTATE_PRE:
+		*val = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+		break;
+	case APCH_STATE_CSTATE_FAST:
+		if (lbo_level)
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_HIGH;
+		else
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+		break;
+	case APCH_STATE_CSTATE_EOC:
+		if (status & APCH_STATUS_CHGDAT)
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+		else
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+		break;
+	case APCH_STATE_CSTATE_DISABLED:
+	default:
+		if (config & APCH_CFG_SUSCHG) {
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+		} else {
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+			if (!(status & APCH_STATUS_INDAT)) {
+				if (!lbo_level)
+					*val = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+			}
+		}
+		break;
+	}
+
+	return 0;
+}
+
 static enum power_supply_property act8945a_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER
 };
@@ -238,6 +298,10 @@ static int act8945a_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_HEALTH:
 		ret = act8945a_get_battery_health(regmap, &val->intval);
 		break;
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		ret = act8945a_get_capacity_level(charger,
+						  regmap, &val->intval);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = act8945a_charger_model;
 		break;
@@ -364,6 +428,20 @@ static int act8945a_charger_config(struct device *dev,
 		}
 	}
 
+	charger->lbo_pin = of_get_named_gpio(np, "active-semi,lbo-gpios", 0);
+	if (gpio_is_valid(charger->lbo_pin)) {
+		if (!devm_gpio_request(dev, charger->lbo_pin, "lbo-detect")) {
+			ret = devm_request_irq(dev,
+					       gpio_to_irq(charger->lbo_pin),
+					       act8945a_status_changed,
+					       IRQF_TRIGGER_FALLING |
+					       IRQF_TRIGGER_RISING,
+					       "lbo-detect", charger);
+			if (ret)
+				dev_dbg(dev, "failed to request LBO pin IRQ\n");
+		}
+	}
+
 	chglev_pin = of_get_named_gpio_flags(np,
 				"active-semi,chglev-gpios", 0, &flags);
 
-- 
2.7.4
