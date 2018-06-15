From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 15 Jun 2018 10:15:01 +0200
Subject: [RFC] cpcap: allow modifying voltages and currents
Message-ID: <20180615081501.GA31594@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This allows user to disable the green LED, so that it can be used for
other notifications. It also allows him to set lower voltage limits,
and adjust current: lower current and voltage limits will result in
longer battery lifetime.

Currently I'm using

POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,

attributes to control it. Do we have something suitable for LED
control? Are the current/voltage limits ok to use?

Best regards,
								Pavel


diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 98ba078..839e365 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2017 Tony Lindgren <tony@atomide.com>
  *
- * Some parts of the code based on earlie Motorola mapphone Linux kernel
+ * Some parts of the code based on earlier Motorola mapphone Linux kernel
  * drivers:
  *
  * Copyright (C) 2009-2010 Motorola, Inc.
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index e4905be..7de07ae 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -93,6 +93,17 @@
 #define CPCAP_REG_CRM_VCHRG_4V42	CPCAP_REG_CRM_VCHRG(0xe)
 #define CPCAP_REG_CRM_VCHRG_4V44	CPCAP_REG_CRM_VCHRG(0xf)
 
+static int voltage_to_register(int microvolt)
+{
+	switch (microvolt/1000) {
+	case 3800: return CPCAP_REG_CRM_VCHRG_3V80;
+	case 4100: return CPCAP_REG_CRM_VCHRG_4V10;
+	case 4200: return CPCAP_REG_CRM_VCHRG_4V20;
+	case 4350: return CPCAP_REG_CRM_VCHRG_4V35;
+	default: return -EINVAL;
+	}
+}
+
 /*
  * CPCAP_REG_CRM charge currents. These seem to match MC13783UG.pdf
  * values in "Table 8-3. Charge Path Regulator Current Limit
@@ -116,6 +127,18 @@
 #define CPCAP_REG_CRM_ICHRG_1A596	CPCAP_REG_CRM_ICHRG(0xe)
 #define CPCAP_REG_CRM_ICHRG_NO_LIMIT	CPCAP_REG_CRM_ICHRG(0xf)
 
+static int current_to_register(int microamp)
+{
+	switch (microamp/1000) {
+	case 0:    return CPCAP_REG_CRM_ICHRG_0A000;
+	case 70:   return CPCAP_REG_CRM_ICHRG_0A070;
+	case 177:  return CPCAP_REG_CRM_ICHRG_0A177;
+	case 532:  return CPCAP_REG_CRM_ICHRG_0A532;
+	case 1596: return CPCAP_REG_CRM_ICHRG_1A596;
+	default: return -EINVAL;
+	}
+}
+
 enum {
 	CPCAP_CHARGER_IIO_BATTDET,
 	CPCAP_CHARGER_IIO_VOLTAGE,
@@ -142,6 +165,10 @@ struct cpcap_charger_ddata {
 	atomic_t active;
 
 	int status;
+
+	int led_enabled;
+	int limit_current;
+	int limit_voltage;
 };
 
 struct cpcap_interrupt_desc {
@@ -163,11 +190,17 @@ struct cpcap_charger_ints_state {
 	bool battdetb;
 };
 
+#define POWER_SUPPLY_PROP_INDICATION POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT
+
 static enum power_supply_property cpcap_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+
+        POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_INDICATION,
 };
 
 static bool cpcap_charger_battery_found(struct cpcap_charger_ddata *ddata)
@@ -229,6 +262,7 @@ static int cpcap_charger_get_property(struct power_supply *psy,
 		val->intval = ddata->status;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		/* FIXME? Display voltage even when not charging? */
 		if (ddata->status == POWER_SUPPLY_STATUS_CHARGING)
 			val->intval = cpcap_charger_get_charge_voltage(ddata) *
 				1000;
@@ -245,6 +279,50 @@ static int cpcap_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = ddata->status == POWER_SUPPLY_STATUS_CHARGING;
 		break;
+		
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		// -> charger -- current limit
+		val->intval = ddata->limit_current;
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		val->intval = ddata->limit_voltage;
+		break;
+	case POWER_SUPPLY_PROP_INDICATION:
+		val->intval = ddata->led_enabled;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cpcap_charger_set_property(struct power_supply *psy,
+				      enum power_supply_property psp,
+				      const union power_supply_propval *val)
+{
+	struct cpcap_charger_ddata *ddata = dev_get_drvdata(psy->dev.parent);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		printk("charge current: %d\n", val->intval);
+		if (current_to_register(val->intval) < 0)
+			return -EINVAL;
+		ddata->limit_current = val->intval;
+		schedule_delayed_work(&ddata->detect_work, 0);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		printk("charge voltage: %d\n", val->intval);
+		if (voltage_to_register(val->intval) < 0)
+			return -EINVAL;
+		ddata->limit_voltage = val->intval;
+		schedule_delayed_work(&ddata->detect_work, 0);
+		break;
+	case POWER_SUPPLY_PROP_INDICATION:
+		printk("hack indication: %d\n", val->intval);
+		ddata->led_enabled = !!val->intval;
+		schedule_delayed_work(&ddata->detect_work, 0);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -296,7 +374,7 @@ static int cpcap_charger_set_state(struct cpcap_charger_ddata *ddata,
 	}
 
 	error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM, 0x3fff,
-				   CPCAP_REG_CRM_CHRG_LED_EN |
+				   ddata->led_enabled * CPCAP_REG_CRM_CHRG_LED_EN |
 				   trickle_current |
 				   CPCAP_REG_CRM_FET_OVRD |
 				   CPCAP_REG_CRM_FET_CTRL |
@@ -440,16 +518,38 @@ static void cpcap_usb_detect(struct work_struct *work)
 		return;
 
 	if (cpcap_charger_vbus_valid(ddata) && s.chrgcurr1) {
-		int max_current;
+		int m_voltage, m_current;
+		int reg_current, reg_voltage;
 
 		if (cpcap_charger_battery_found(ddata))
-			max_current = CPCAP_REG_CRM_ICHRG_1A596;
+			m_current = 1596000;
 		else
-			max_current = CPCAP_REG_CRM_ICHRG_0A532;
+			m_current = 532000;
+
+		if (m_current > ddata->limit_current)
+			m_current = ddata->limit_current;
+		
+		m_voltage = 4350000;
+		if (m_voltage > ddata->limit_voltage)
+			m_voltage = ddata->limit_voltage;
+
+		printk("Charging, %d uV, %d uA\n", m_voltage, m_current);
+		
+		reg_voltage = voltage_to_register(m_voltage);
+		if (reg_voltage < 0) {
+			dev_err(ddata->dev, "%s impossible voltage\n", __func__);
+			return;
+		}
+			
+		reg_current = current_to_register(m_current);
+		if (reg_current < 0) {
+			dev_err(ddata->dev, "%s impossible current\n", __func__);
+			return;
+		}
 
 		error = cpcap_charger_set_state(ddata,
-						CPCAP_REG_CRM_VCHRG_4V35,
-						max_current, 0);
+						reg_voltage,
+						reg_current, 0);
 		if (error)
 			goto out_err;
 	} else {
@@ -579,12 +679,27 @@ static int cpcap_charger_init_iio(struct cpcap_charger_ddata *ddata)
 	return error;
 }
 
+static int cpcap_charger_property_is_writeable(struct power_supply *psy,
+						 enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_INDICATION:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static const struct power_supply_desc cpcap_charger_usb_desc = {
 	.name		= "usb",
 	.type		= POWER_SUPPLY_TYPE_USB,
 	.properties	= cpcap_charger_props,
 	.num_properties	= ARRAY_SIZE(cpcap_charger_props),
 	.get_property	= cpcap_charger_get_property,
+	.set_property	= cpcap_charger_set_property,
+	.property_is_writeable = cpcap_charger_property_is_writeable,
 };
 
 #ifdef CONFIG_OF
@@ -619,6 +734,10 @@ static int cpcap_charger_probe(struct platform_device *pdev)
 	if (!ddata->reg)
 		return -ENODEV;
 
+	ddata->limit_current = 1596000;
+	ddata->limit_voltage = 4350000;
+	ddata->led_enabled = 1;
+
 	INIT_LIST_HEAD(&ddata->irq_list);
 	INIT_DELAYED_WORK(&ddata->detect_work, cpcap_usb_detect);
 	INIT_DELAYED_WORK(&ddata->vbus_work, cpcap_charger_vbus_work);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180615/b6a49a75/attachment.sig>
