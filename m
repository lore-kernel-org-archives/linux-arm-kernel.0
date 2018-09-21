From: yuehaibing@huawei.com (YueHaibing)
Date: Fri, 21 Sep 2018 09:59:41 +0800
Subject: [PATCH -next] pinctrl: sunxi: fix 'pctrl->functions' allocation in
 sunxi_pinctrl_build_state
Message-ID: <20180921015941.28468-1-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fixes following Smatch static check warning:

 ./drivers/pinctrl/sunxi/pinctrl-sunxi.c:1112 sunxi_pinctrl_build_state()
 warn: passing devm_ allocated variable to kfree. 'pctrl->functions'

As we will be calling krealloc() on pointer 'pctrl->functions', which means
kfree() will be called in there, devm_kzalloc() shouldn't be used with
the allocation in the first place.  Fix the warning by calling kcalloc()
and managing the free procedure in error path on our own.

Fixes: 0e37f88d9ad8 ("ARM: sunxi: Add pinctrl driver for Allwinner SoCs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 3ccbe22..213a5d5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1079,10 +1079,9 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 	 * We suppose that we won't have any more functions than pins,
 	 * we'll reallocate that later anyway
 	 */
-	pctl->functions = devm_kcalloc(&pdev->dev,
-				       pctl->ngroups,
-				       sizeof(*pctl->functions),
-				       GFP_KERNEL);
+	pctl->functions = kcalloc(pctl->ngroups,
+				  sizeof(*pctl->functions),
+				  GFP_KERNEL);
 	if (!pctl->functions)
 		return -ENOMEM;
 
@@ -1133,8 +1132,10 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 
 			func_item = sunxi_pinctrl_find_function_by_name(pctl,
 									func->name);
-			if (!func_item)
+			if (!func_item) {
+				kfree(pctl->functions);
 				return -EINVAL;
+			}
 
 			if (!func_item->groups) {
 				func_item->groups =
@@ -1142,8 +1143,10 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 						     func_item->ngroups,
 						     sizeof(*func_item->groups),
 						     GFP_KERNEL);
-				if (!func_item->groups)
+				if (!func_item->groups) {
+					kfree(pctl->functions);
 					return -ENOMEM;
+				}
 			}
 
 			func_grp = func_item->groups;
-- 
2.7.0
