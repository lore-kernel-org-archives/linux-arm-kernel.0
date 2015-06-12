From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Jun 2015 17:37:05 -0700
Subject: [PATCH v2 4/6] regulator: Add soft start support
In-Reply-To: <1434069427-3642-1-git-send-email-sboyd@codeaurora.org>
References: <1434069427-3642-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434069427-3642-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some regulators support a "soft start" feature where the voltage
ramps up slowly when the regulator is enabled. Add an op
(set_soft_start) and a DT property + constraint to support this.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 1 +
 drivers/regulator/core.c                                  | 8 ++++++++
 drivers/regulator/of_regulator.c                          | 3 +++
 include/linux/regulator/driver.h                          | 2 ++
 include/linux/regulator/machine.h                         | 1 +
 5 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 6c79fd70ab5a..4b1df61ccbd7 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -19,6 +19,7 @@ Optional properties:
   design requires. This property describes the total system ramp time
   required due to the combination of internal ramping of the regulator itself,
   and board design issues such as trace capacitance and load on the supply.
+- regulator-soft-start: Enable soft start so that voltage ramps slowly
 - regulator-state-mem sub-root node for Suspend-to-RAM mode
   : suspend to memory, the device goes to sleep, but all data stored in memory,
   only some external interrupt can wake the device.
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1d6172a9f65c..88622fc76b81 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1059,6 +1059,14 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		}
 	}
 
+	if (rdev->constraints->soft_start && ops->set_soft_start) {
+		ret = ops->set_soft_start(rdev);
+		if (ret < 0) {
+			rdev_err(rdev, "failed to set soft start\n");
+			goto out;
+		}
+	}
+
 	print_constraints(rdev);
 	return 0;
 out:
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 237b014666fa..72576dd9bf7b 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -84,6 +84,9 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!ret)
 		constraints->enable_time = pval;
 
+	constraints->soft_start = of_property_read_bool(np,
+					"regulator-soft-start");
+
 	if (!of_property_read_u32(np, "regulator-initial-mode", &pval)) {
 		if (desc && desc->of_map_mode) {
 			ret = desc->of_map_mode(pval);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 5eb85e152eb7..02e1e8d4b1bb 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -161,6 +161,8 @@ struct regulator_ops {
 				     unsigned int old_selector,
 				     unsigned int new_selector);
 
+	int (*set_soft_start) (struct regulator_dev *);
+
 	/* report regulator status ... most other accessors report
 	 * control inputs, this reports results of combining inputs
 	 * from Linux (and other sources) with the actual load.
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 8ffb0619a03c..7f7d0a3fe1e1 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -142,6 +142,7 @@ struct regulation_constraints {
 	unsigned boot_on:1;	/* bootloader/firmware enabled regulator */
 	unsigned apply_uV:1;	/* apply uV constraint if min == max */
 	unsigned ramp_disable:1; /* disable ramp delay */
+	unsigned soft_start:1;	/* ramp voltage slowly */
 	unsigned pull_down:1;	/* pull down resistor when regulator off */
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
