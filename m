From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Jul 2013 01:45:39 +0200
Subject: [PATCH] pinctrl: fix a memleak when freeing maps
Message-ID: <1374536739-18966-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We forgot to free the node itself when free:ing a map.

Reported-by: xulinuxkernel <xulinuxkernel@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 5b272bf..2a00239 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1193,6 +1193,7 @@ void pinctrl_unregister_map(struct pinctrl_map const *map)
 	list_for_each_entry(maps_node, &pinctrl_maps, node) {
 		if (maps_node->maps == map) {
 			list_del(&maps_node->node);
+			kfree(maps_node);
 			mutex_unlock(&pinctrl_maps_mutex);
 			return;
 		}
-- 
1.8.1.4
