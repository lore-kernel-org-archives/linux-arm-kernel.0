From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 May 2018 17:41:44 +0100 (BST)
Subject: Applied "regulator: of: add support for allowed modes configuration"
 to the regulator tree
In-Reply-To: <58bb4f965515a67a6cbbc726b0d7b092c22b79d7.1526088289.git.collinsd@codeaurora.org>
Message-ID: <20180517164144.0CD3D44007E@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: of: add support for allowed modes configuration

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 54557ad9737e28b06b632cce723ef2373fe6bf12 Mon Sep 17 00:00:00 2001
From: David Collins <collinsd@codeaurora.org>
Date: Fri, 11 May 2018 18:46:47 -0700
Subject: [PATCH] regulator: of: add support for allowed modes configuration

Add support for configuring the machine constraints
valid_modes_mask element based on a list of allowed modes
specified via a device tree property.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/of_regulator.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 0d3f73eacb99..d61fed28fdb9 100644
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
2.17.0
