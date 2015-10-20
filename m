From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Oct 2015 14:37:28 +0200
Subject: [PATCH 2/3] regulator: core: Propagate voltage changes to supply
 regulators
In-Reply-To: <1445344649-9559-1-git-send-email-s.hauer@pengutronix.de>
References: <1445344649-9559-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1445344649-9559-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now changing the voltage of a regulator only ever effected the
regulator itself, but never its supplies. It's a common pattern though
to put LDO regulators behind switching regulators. The switching
regulators efficiently drop the input voltage but have a high ripple on
their output. The output is then cleaned up by the LDOs. For higher
energy efficiency the voltage drop at the LDOs should be minimized. For
this scenario we need to propagate the voltage change to the supply
regulators. Another scenario where voltage propagation is desired is
a regulator which only consists of a switch and thus cannot regulate
voltages itself. In this case we can pass setting voltages to the
supply.

This patch adds support for voltage propagation. We do voltage
propagation when the current regulator has a minimum dropout voltage
specified or if the current regulator lacks a get_voltage operation
(indicating it's a switch and not a regulator).

Changing the supply voltage must be done carefully. When we are
increasing the current regulators output we must first increase the
supply voltage and then the regulator itself. When we are decreasing the
current regulators voltage we must decrease the supply voltage after
changing the current regulators voltage.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/regulator/core.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index fd22380..7ef69e5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2826,6 +2826,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int ret = 0;
 	int old_min_uV, old_max_uV;
 	int current_uV;
+	int best_supply_uV = 0;
+	int supply_change_uV = 0;
 
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
@@ -2869,10 +2871,58 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (ret < 0)
 		goto out2;
 
+	if (rdev->supply && (rdev->desc->min_dropout_uV ||
+				!rdev->desc->ops->get_voltage)) {
+		int current_supply_uV;
+		int selector;
+
+		selector = regulator_map_voltage(rdev, min_uV, max_uV);
+		if (selector < 0) {
+			ret = selector;
+			goto out2;
+		}
+
+		best_supply_uV = _regulator_list_voltage(regulator, selector, 0);
+		if (best_supply_uV < 0) {
+			ret = best_supply_uV;
+			goto out2;
+		}
+
+		best_supply_uV += rdev->desc->min_dropout_uV;
+
+		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
+		if (current_supply_uV < 0) {
+			ret = current_supply_uV;
+			goto out2;
+		}
+
+		supply_change_uV = best_supply_uV - current_supply_uV;
+	}
+
+	if (supply_change_uV > 0) {
+		ret = regulator_set_voltage_unlocked(rdev->supply,
+				best_supply_uV, INT_MAX);
+		if (ret) {
+			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
+					ret);
+			goto out2;
+		}
+	}
+
 	ret = _regulator_do_set_voltage(rdev, min_uV, max_uV);
 	if (ret < 0)
 		goto out2;
 
+	if (supply_change_uV < 0) {
+		ret = regulator_set_voltage_unlocked(rdev->supply,
+				best_supply_uV, INT_MAX);
+		if (ret)
+			dev_warn(&rdev->dev, "Failed to decrease supply voltage: %d\n",
+					ret);
+		/* No need to fail here */
+		ret = 0;
+	}
+
 out:
 	return ret;
 out2:
@@ -2904,11 +2954,11 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
-	mutex_lock(&regulator->rdev->mutex);
+	regulator_lock_supply(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV);
 
-	mutex_unlock(&regulator->rdev->mutex);
+	regulator_unlock_supply(regulator->rdev);
 
 	return ret;
 }
-- 
2.6.1
