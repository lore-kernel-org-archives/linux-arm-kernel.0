From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu,  3 May 2018 20:26:42 +0300
Subject: [PATCH v1] pinctrl: armada-37xx: Convert to use match_string() helper
Message-ID: <20180503172642.21031-1-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new helper returns index of the matching string in an array.
We are going to use it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 29 ++++++---------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 5b63248c8209..0f1eafba0ded 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -214,18 +214,6 @@ static inline void armada_37xx_update_reg(unsigned int *reg,
 	}
 }
 
-static int armada_37xx_get_func_reg(struct armada_37xx_pin_group *grp,
-				    const char *func)
-{
-	int f;
-
-	for (f = 0; (f < NB_FUNCS) && grp->funcs[f]; f++)
-		if (!strcmp(grp->funcs[f], func))
-			return f;
-
-	return -ENOTSUPP;
-}
-
 static struct armada_37xx_pin_group *armada_37xx_find_next_grp_by_pin(
 	struct armada_37xx_pinctrl *info, int pin, int *grp)
 {
@@ -344,10 +332,9 @@ static int armada_37xx_pmx_set_by_name(struct pinctrl_dev *pctldev,
 	dev_dbg(info->dev, "enable function %s group %s\n",
 		name, grp->name);
 
-	func = armada_37xx_get_func_reg(grp, name);
-
+	func = match_string(grp->funcs, NB_FUNCS, name);
 	if (func < 0)
-		return func;
+		return -ENOTSUPP;
 
 	val = grp->val[func];
 
@@ -932,12 +919,12 @@ static int armada_37xx_fill_func(struct armada_37xx_pinctrl *info)
 			struct armada_37xx_pin_group *gp = &info->groups[g];
 			int f;
 
-			for (f = 0; (f < NB_FUNCS) && gp->funcs[f]; f++) {
-				if (strcmp(gp->funcs[f], name) == 0) {
-					*groups = gp->name;
-					groups++;
-				}
-			}
+			f = match_string(gp->funcs, NB_FUNCS, name);
+			if (f < 0)
+				continue;
+
+			*groups = gp->name;
+			groups++;
 		}
 	}
 	return 0;
-- 
2.17.0
