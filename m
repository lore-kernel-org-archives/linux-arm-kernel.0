From: collinsd@codeaurora.org (David Collins)
Date: Fri, 11 May 2018 18:46:47 -0700
Subject: [PATCH 2/2] regulator: of: add support for allowed modes configuration
In-Reply-To: <cover.1526088289.git.collinsd@codeaurora.org>
References: <cover.1526088289.git.collinsd@codeaurora.org>
Message-ID: <58bb4f965515a67a6cbbc726b0d7b092c22b79d7.1526088289.git.collinsd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for configuring the machine constraints
valid_modes_mask element based on a list of allowed modes
specified via a device tree property.

Signed-off-by: David Collins <collinsd@codeaurora.org>
---
 drivers/regulator/of_regulator.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 0d3f73e..d61fed2 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -32,7 +32,7 @@ static void of_get_regulation_constraints(struct device_node *np,
 	struct regulator_state *suspend_state;
 	struct device_node *suspend_np;
 	unsigned int mode;
-	int ret, i;
+	int ret, i, len;
 	u32 pval;
 
 	constraints->name = of_get_property(np, "regulator-name", NULL);
@@ -136,6 +136,33 @@ static void of_get_regulation_constraints(struct device_node *np,
 		}
 	}
 
+	len = of_property_count_elems_of_size(np, "regulator-allowed-modes",
+						sizeof(u32));
+	if (len > 0) {
+		if (desc && desc->of_map_mode) {
+			for (i = 0; i < len; i++) {
+				ret = of_property_read_u32_index(np,
+					"regulator-allowed-modes", i, &pval);
+				if (ret) {
+					pr_err("%s: couldn't read allowed modes index %d, ret=%d\n",
+						np->name, i, ret);
+					break;
+				}
+				mode = desc->of_map_mode(pval);
+				if (mode == REGULATOR_MODE_INVALID)
+					pr_err("%s: invalid regulator-allowed-modes element %u\n",
+						np->name, pval);
+				else
+					constraints->valid_modes_mask |= mode;
+			}
+			if (constraints->valid_modes_mask)
+				constraints->valid_ops_mask
+					|= REGULATOR_CHANGE_MODE;
+		} else {
+			pr_warn("%s: mode mapping not defined\n", np->name);
+		}
+	}
+
 	if (!of_property_read_u32(np, "regulator-system-load", &pval))
 		constraints->system_load = pval;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
