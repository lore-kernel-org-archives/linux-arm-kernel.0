From: mniewoeh@stud.hs-offenburg.de (=?iso-8859-1?Q?Michael_Niew=F6hner?=)
Date: Thu, 14 May 2015 21:17:08 +0200
Subject: [PATCH 1/2] regulator: act8865: add restart handler for act8846
In-Reply-To: <2204003.IdqJV6LE2e@phil>
References: <A1C80CFB-CDCA-4F88-BA5F-371918CECD97@stud.hs-offenburg.de>
 <2204003.IdqJV6LE2e@phil>
Message-ID: <D1089B7C-607E-48E2-B349-47B80A0596DA@stud.hs-offenburg.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I reworked the patch and here it is ;-)


The act8846 provides means to reset the system when used as main pmic.
This patch adds a restart handler for power cycling the regulator thus resetting
the board / soc when system-power-controller in dts is set.
This can be useful for example if there is no other means of reset.

Signed-off-by: Michael Niewoehner <mniewoeh@stud.hs-offenburg.de>
---
diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 2ff73d7..836d10b 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -27,6 +27,7 @@
 #include <linux/of_device.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regmap.h>
+#include <linux/reboot.h>
 
 /*
  * ACT8600 Global Register Map.
@@ -133,6 +134,8 @@
 #define	ACT8865_VOLTAGE_NUM	64
 #define ACT8600_SUDCDC_VOLTAGE_NUM	255
 
+#define ACT8846_SIPC_MASK 0x01
+
 struct act8865 {
 	struct regmap *regmap;
 	int off_reg;
@@ -402,6 +405,22 @@ static void act8865_power_off(void)
 	while (1);
 }
 
+static int act8846_power_cycle(struct notifier_block *this,
+	unsigned long code, void *unused)
+{
+	struct act8865 *act8846;
+
+	act8846 = i2c_get_clientdata(act8865_i2c_client);
+	regmap_write(act8846->regmap, ACT8846_GLB_OFF_CTRL, ACT8846_SIPC_MASK);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block act8846_restart_handler = {
+	.notifier_call = act8846_power_cycle,
+	.priority = 129,
+};
+
 static int act8865_pmic_probe(struct i2c_client *client,
 			      const struct i2c_device_id *i2c_id)
 {
@@ -484,6 +503,8 @@ static int act8865_pmic_probe(struct i2c_client *client,
 	}
 
 	if (of_device_is_system_power_controller(dev->of_node)) {
+		int ret;
+
 		if (!pm_power_off && (off_reg > 0)) {
 			act8865_i2c_client = client;
 			act8865->off_reg = off_reg;
@@ -492,6 +513,14 @@ static int act8865_pmic_probe(struct i2c_client *client,
 		} else {
 			dev_err(dev, "Failed to set poweroff capability, already defined\n");
 		}
+
+		if (type == ACT8846) {
+			act8865_i2c_client = client;
+			ret = register_restart_handler(&act8846_restart_handler);
+			if (ret)
+				pr_err("%s: cannot register restart handler, %d\n",
+					__func__, ret);
+		}
 	}
 
 	/* Finally register devices */
