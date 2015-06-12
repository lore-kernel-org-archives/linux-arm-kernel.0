From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Jun 2015 17:31:06 -0700
Subject: [PATCH v2 5/6] regulator: Add input current limit support
In-Reply-To: <1434069067-1371-1-git-send-email-sboyd@codeaurora.org>
References: <1434069067-1371-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434069067-1371-6-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some regulators can limit their input current (typically annotated
as ilim). Add an op (set_input_current_limit) and a DT property +
constraint to support this.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 1 +
 drivers/regulator/core.c                                  | 9 +++++++++
 drivers/regulator/of_regulator.c                          | 4 ++++
 include/linux/regulator/driver.h                          | 3 +++
 include/linux/regulator/machine.h                         | 2 ++
 5 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 4b1df61ccbd7..e29db73e55f4 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -7,6 +7,7 @@ Optional properties:
 - regulator-microvolt-offset: Offset applied to voltages to compensate for voltage drops
 - regulator-min-microamp: smallest current consumers may set
 - regulator-max-microamp: largest current consumers may set
+- regulator-input-current-limit-microamp: maximum input current regulator allows
 - regulator-always-on: boolean, regulator should never be disabled
 - regulator-boot-on: bootloader/firmware enabled regulator
 - regulator-allow-bypass: allow the regulator to go into bypass mode
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 88622fc76b81..46c253e85c9e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1008,6 +1008,15 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 	if (ret != 0)
 		goto out;
 
+	if (rdev->constraints->ilim_uA && ops->set_input_current_limit) {
+		ret = ops->set_input_current_limit(rdev,
+						   rdev->constraints->ilim_uA);
+		if (ret < 0) {
+			rdev_err(rdev, "failed to set input limit\n");
+			goto out;
+		}
+	}
+
 	/* do we need to setup our suspend state */
 	if (rdev->constraints->initial_state) {
 		ret = suspend_prepare(rdev, rdev->constraints->initial_state);
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 72576dd9bf7b..b41d80acbc4a 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -58,6 +58,10 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!of_property_read_u32(np, "regulator-max-microamp", &pval))
 		constraints->max_uA = pval;
 
+	if (!of_property_read_u32(np, "regulator-input-current-limit-microamp",
+				  &pval))
+		constraints->ilim_uA = pval;
+
 	/* Current change possible? */
 	if (constraints->min_uA != constraints->max_uA)
 		constraints->valid_ops_mask |= REGULATOR_CHANGE_CURRENT;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 02e1e8d4b1bb..1de82b081f5a 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -91,6 +91,7 @@ struct regulator_linear_range {
  * @set_current_limit: Configure a limit for a current-limited regulator.
  *                     The driver should select the current closest to max_uA.
  * @get_current_limit: Get the configured limit for a current-limited regulator.
+ * @set_input_current_limit: Configure an input limit.
  *
  * @set_mode: Set the configured operating mode for the regulator.
  * @get_mode: Get the configured operating mode for the regulator.
@@ -145,6 +146,8 @@ struct regulator_ops {
 				 int min_uA, int max_uA);
 	int (*get_current_limit) (struct regulator_dev *);
 
+	int (*set_input_current_limit) (struct regulator_dev *, int lim_uA);
+
 	/* enable/disable regulator */
 	int (*enable) (struct regulator_dev *);
 	int (*disable) (struct regulator_dev *);
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 7f7d0a3fe1e1..85a3b457de51 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -75,6 +75,7 @@ struct regulator_state {
  *
  * @min_uA: Smallest current consumers may set.
  * @max_uA: Largest current consumers may set.
+ * @ilim_uA: Maximum input current.
  * @system_load: Load that isn't captured by any consumer requests.
  *
  * @valid_modes_mask: Mask of modes which may be configured by consumers.
@@ -113,6 +114,7 @@ struct regulation_constraints {
 	/* current output range (inclusive) - for current control */
 	int min_uA;
 	int max_uA;
+	int ilim_uA;
 
 	int system_load;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
