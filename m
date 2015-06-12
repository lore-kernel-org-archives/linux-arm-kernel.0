From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Jun 2015 17:37:03 -0700
Subject: [PATCH v2 2/6] regulator: Add system_load constraint
In-Reply-To: <1434069427-3642-1-git-send-email-sboyd@codeaurora.org>
References: <1434069427-3642-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434069427-3642-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some regulators have a fixed load that isn't captured by
consumers that the kernel knows about. Add a constraint to
support this.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 2 ++
 drivers/regulator/core.c                                  | 2 ++
 drivers/regulator/of_regulator.c                          | 3 +++
 include/linux/regulator/machine.h                         | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index abb26b58c83e..553d2d0fe6d9 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -37,6 +37,8 @@ Optional properties:
 - regulator-initial-mode: initial operating mode. The set of possible operating
   modes depends on the capabilities of every hardware so each device binding
   documentation explains which values the regulator supports.
+- regulator-system-load: Load in uA present on regulator that is not captured by
+  any consumer request.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9dba0a3d4526..ab383dfe5386 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -678,6 +678,8 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	list_for_each_entry(sibling, &rdev->consumer_list, list)
 		current_uA += sibling->uA_load;
 
+	current_uA += rdev->constraints->system_load;
+
 	if (rdev->desc->ops->set_load) {
 		/* set the optimum mode for our new total regulator load */
 		err = rdev->desc->ops->set_load(rdev, current_uA);
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 856c17d69b7e..b44da860ac22 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -95,6 +95,9 @@ static void of_get_regulation_constraints(struct device_node *np,
 		}
 	}
 
+	if (!of_property_read_u32(np, "regulator-system-load", &pval))
+		constraints->system_load = pval;
+
 	for (i = 0; i < ARRAY_SIZE(regulator_states); i++) {
 		switch (i) {
 		case PM_SUSPEND_MEM:
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index b07562e082c4..01526559c8c3 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -75,6 +75,7 @@ struct regulator_state {
  *
  * @min_uA: Smallest current consumers may set.
  * @max_uA: Largest current consumers may set.
+ * @system_load: Load that isn't captured by any consumer requests.
  *
  * @valid_modes_mask: Mask of modes which may be configured by consumers.
  * @valid_ops_mask: Operations which may be performed by consumers.
@@ -112,6 +113,8 @@ struct regulation_constraints {
 	int min_uA;
 	int max_uA;
 
+	int system_load;
+
 	/* valid regulator operating modes for this machine */
 	unsigned int valid_modes_mask;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
