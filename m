From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jul 2015 14:41:54 -0700
Subject: [PATCH v4 1/2] regulator: Add over current protection (OCP) support
In-Reply-To: <1437169315-31530-1-git-send-email-sboyd@codeaurora.org>
References: <1437169315-31530-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1437169315-31530-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some regulators can automatically shut down when they detect an
over current event. Add an op (set_over_current_protection) and a
DT property + constraint to support this capability.

Cc: Rob Herring <robherring2@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes since v3:
 * New patch

 Documentation/devicetree/bindings/regulator/regulator.txt | 1 +
 drivers/regulator/core.c                                  | 9 +++++++++
 drivers/regulator/of_regulator.c                          | 3 +++
 include/linux/regulator/driver.h                          | 1 +
 include/linux/regulator/machine.h                         | 1 +
 5 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index db88feb28c03..24bd422cecd5 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -42,6 +42,7 @@ Optional properties:
 - regulator-system-load: Load in uA present on regulator that is not captured by
   any consumer request.
 - regulator-pull-down: Enable pull down resistor when the regulator is disabled.
+- regulator-over-current-protection: Enable over current protection.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c9f72019bd68..520413e2bca0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1081,6 +1081,15 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		}
 	}
 
+	if (rdev->constraints->over_current_protection
+		&& ops->set_over_current_protection) {
+		ret = ops->set_over_current_protection(rdev);
+		if (ret < 0) {
+			rdev_err(rdev, "failed to set over current protection\n");
+			goto out;
+		}
+	}
+
 	print_constraints(rdev);
 	return 0;
 out:
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index b1c485b24ab2..250700c853bf 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -107,6 +107,9 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!of_property_read_u32(np, "regulator-system-load", &pval))
 		constraints->system_load = pval;
 
+	constraints->over_current_protection = of_property_read_bool(np,
+					"regulator-over-current-protection");
+
 	for (i = 0; i < ARRAY_SIZE(regulator_states); i++) {
 		switch (i) {
 		case PM_SUSPEND_MEM:
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4db9fbe4889d..45932228cbf5 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -148,6 +148,7 @@ struct regulator_ops {
 	int (*get_current_limit) (struct regulator_dev *);
 
 	int (*set_input_current_limit) (struct regulator_dev *, int lim_uA);
+	int (*set_over_current_protection) (struct regulator_dev *);
 
 	/* enable/disable regulator */
 	int (*enable) (struct regulator_dev *);
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index b11be1260129..a1067d0b3991 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -147,6 +147,7 @@ struct regulation_constraints {
 	unsigned ramp_disable:1; /* disable ramp delay */
 	unsigned soft_start:1;	/* ramp voltage slowly */
 	unsigned pull_down:1;	/* pull down resistor when regulator off */
+	unsigned over_current_protection:1; /* auto disable on over current */
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
