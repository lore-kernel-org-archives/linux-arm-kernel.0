From: tiny.windzz@gmail.com (Yangtao Li)
Date: Wed, 21 Nov 2018 07:43:42 -0500
Subject: [PATCH] soc: bcm: brcmstb: add of_node_put()
Message-ID: <20181121124342.21987-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_find_node_by_path() acquires a reference to the node returned
by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/bcm/brcmstb/common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 14185451901d..95b777fffee6 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -32,12 +32,15 @@ static const struct of_device_id brcmstb_machine_match[] = {
 bool soc_is_brcmstb(void)
 {
 	struct device_node *root;
+	bool rc;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
-	return of_match_node(brcmstb_machine_match, root) != NULL;
+	rc = of_match_node(brcmstb_machine_match, root) != NULL;
+	of_node_put(root);
+	return rc;
 }
 
 u32 brcmstb_get_family_id(void)
-- 
2.17.0
