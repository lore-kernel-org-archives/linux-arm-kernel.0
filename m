From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Jun 2015 17:31:04 -0700
Subject: [PATCH v2 3/6] regulator: Add pull down support
In-Reply-To: <1434069067-1371-1-git-send-email-sboyd@codeaurora.org>
References: <1434069067-1371-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434069067-1371-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some regulators need to be configured to pull down a resistor
when the regulator is disabled. Add an op (set_pull_down) and a
DT property + constraint to support this.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 1 +
 drivers/regulator/core.c                                  | 8 ++++++++
 drivers/regulator/of_regulator.c                          | 2 ++
 include/linux/regulator/driver.h                          | 5 +++++
 include/linux/regulator/machine.h                         | 2 ++
 5 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 553d2d0fe6d9..6c79fd70ab5a 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -39,6 +39,7 @@ Optional properties:
   documentation explains which values the regulator supports.
 - regulator-system-load: Load in uA present on regulator that is not captured by
   any consumer request.
+- regulator-pull-down: Enable pull down resistor when the regulator is disabled.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ab383dfe5386..1d6172a9f65c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1051,6 +1051,14 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		}
 	}
 
+	if (rdev->constraints->pull_down && ops->set_pull_down) {
+		ret = ops->set_pull_down(rdev);
+		if (ret < 0) {
+			rdev_err(rdev, "failed to set pull down\n");
+			goto out;
+		}
+	}
+
 	print_constraints(rdev);
 	return 0;
 out:
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index b44da860ac22..237b014666fa 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -67,6 +67,8 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!constraints->always_on) /* status change should be possible. */
 		constraints->valid_ops_mask |= REGULATOR_CHANGE_STATUS;
 
+	constraints->pull_down = of_property_read_bool(np, "regulator-pull-down");
+
 	if (of_property_read_bool(np, "regulator-allow-bypass"))
 		constraints->valid_ops_mask |= REGULATOR_CHANGE_BYPASS;
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index fffa688ac3a7..5eb85e152eb7 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -121,6 +121,9 @@ struct regulator_linear_range {
  * @set_suspend_mode: Set the operating mode for the regulator when the
  *                    system is suspended.
  *
+ * @set_pull_down: Configure the regulator to pull down when the regulator
+ *		   is disabled.
+ *
  * This struct describes regulator operations which can be implemented by
  * regulator chip drivers.
  */
@@ -187,6 +190,8 @@ struct regulator_ops {
 
 	/* set regulator suspend operating mode (defined in consumer.h) */
 	int (*set_suspend_mode) (struct regulator_dev *, unsigned int mode);
+
+	int (*set_pull_down) (struct regulator_dev *);
 };
 
 /*
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 01526559c8c3..8ffb0619a03c 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -87,6 +87,7 @@ struct regulator_state {
  *           applied.
  * @apply_uV: Apply the voltage constraint when initialising.
  * @ramp_disable: Disable ramp delay when initialising or when setting voltage.
+ * @pull_down: Enable pull down when regulator is disabled.
  *
  * @input_uV: Input voltage for regulator when supplied by another regulator.
  *
@@ -141,6 +142,7 @@ struct regulation_constraints {
 	unsigned boot_on:1;	/* bootloader/firmware enabled regulator */
 	unsigned apply_uV:1;	/* apply uV constraint if min == max */
 	unsigned ramp_disable:1; /* disable ramp delay */
+	unsigned pull_down:1;	/* pull down resistor when regulator off */
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
