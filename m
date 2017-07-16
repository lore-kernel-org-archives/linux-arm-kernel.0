From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 16 Jul 2017 21:33:28 +0800
Subject: [PATCH] pinctrl: zte: fix 'functions' allocation in
 zx_pinctrl_build_state()
Message-ID: <1500212008-29321-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It fixes the following Smatch static check warning:

 drivers/pinctrl/zte/pinctrl-zx.c:338 zx_pinctrl_build_state()
 warn: passing devm_ allocated variable to kfree.

As we will be calling krealloc() on pointer 'functions', which means
kfree() will be called in there, devm_kzalloc() shouldn't be used with
the allocation in the first place.  Fix the warning by calling kcalloc()
and managing the free procedure in error path on our own.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: cbff0c4d27f4 ("pinctrl: add ZTE ZX pinctrl driver support")
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pinctrl/zte/pinctrl-zx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/zte/pinctrl-zx.c b/drivers/pinctrl/zte/pinctrl-zx.c
index f828ee340a98..ded366bb6564 100644
--- a/drivers/pinctrl/zte/pinctrl-zx.c
+++ b/drivers/pinctrl/zte/pinctrl-zx.c
@@ -295,8 +295,7 @@ static int zx_pinctrl_build_state(struct platform_device *pdev)
 	pctldev->num_groups = ngroups;
 
 	/* Build function list from pin mux functions */
-	functions = devm_kzalloc(&pdev->dev, info->npins * sizeof(*functions),
-				 GFP_KERNEL);
+	functions = kcalloc(info->npins, sizeof(*functions), GFP_KERNEL);
 	if (!functions)
 		return -ENOMEM;
 
@@ -367,8 +366,10 @@ static int zx_pinctrl_build_state(struct platform_device *pdev)
 						func->num_group_names *
 						sizeof(*func->group_names),
 						GFP_KERNEL);
-				if (!func->group_names)
+				if (!func->group_names) {
+					kfree(functions);
 					return -ENOMEM;
+				}
 			}
 
 			group = func->group_names;
-- 
1.9.1
