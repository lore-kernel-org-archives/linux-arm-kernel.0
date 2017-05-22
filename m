From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 22 May 2017 21:59:35 +0800
Subject: [PATCH] pinctrl: zte: fix group_desc initialization
Message-ID: <1495461575-29488-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

There are a couple of issues with group_desc initialization in function
zx_pinctrl_build_state().

 - num_pins is not initialized and remains zero.
 - pins shouldn't be initialized with a pointer to variable in the
   stack.

With them fixed, pin_request() in pinmux_enable_setting() can be invoked
correctly.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Hi Linus,

This is a fix for ZTE pinctrl driver that is queued on your devel branch.

Shawn

 drivers/pinctrl/zte/pinctrl-zx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/zte/pinctrl-zx.c b/drivers/pinctrl/zte/pinctrl-zx.c
index 2aca4e4b3f1c..787e3967bd5c 100644
--- a/drivers/pinctrl/zte/pinctrl-zx.c
+++ b/drivers/pinctrl/zte/pinctrl-zx.c
@@ -282,10 +282,10 @@ static int zx_pinctrl_build_state(struct platform_device *pdev)
 	for (i = 0; i < ngroups; i++) {
 		const struct pinctrl_pin_desc *pindesc = info->pins + i;
 		struct group_desc *group = groups + i;
-		int id = pindesc->number;
 
 		group->name = pindesc->name;
-		group->pins = &id;
+		group->pins = (int *) &pindesc->number;
+		group->num_pins = 1;
 		radix_tree_insert(&pctldev->pin_group_tree, i, group);
 	}
 
-- 
1.9.1
