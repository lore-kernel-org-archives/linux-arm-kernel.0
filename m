From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 14 Feb 2017 10:40:56 +0100
Subject: [PATCH v3 02/18] power: supply: power_supply_core: add
 constant-current-charge optional property
In-Reply-To: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
Message-ID: <20170214094112.27426-3-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the constant-current-charge property to the list of optional
properties for the battery.

The constant charge current is critical for batteries as they can't
handle all charge currents.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v3

 drivers/power/supply/power_supply_core.c | 3 +++
 include/linux/power_supply.h             | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ced8fef..c844def 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -498,6 +498,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->energy_full_design_uwh = -EINVAL;
 	info->charge_full_design_uah = -EINVAL;
 	info->voltage_min_design_uv  = -EINVAL;
+	info->constant_charge_current_ua  = -EINVAL;
 
 	if (!psy->of_node) {
 		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
@@ -522,6 +523,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->charge_full_design_uah);
 	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
 			     &info->voltage_min_design_uv);
+	of_property_read_u32(battery_np, "constant-charge-current-microamp",
+			     &info->constant_charge_current_ua);
 
 	return 0;
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e84f1d3..f723a8e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -301,6 +301,7 @@ struct power_supply_battery_info {
 	int energy_full_design_uwh;	/* microWatt-hours */
 	int charge_full_design_uah;	/* microAmp-hours */
 	int voltage_min_design_uv;	/* microVolts */
+	int constant_charge_current_ua; /* microAmps */
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
-- 
2.9.3
