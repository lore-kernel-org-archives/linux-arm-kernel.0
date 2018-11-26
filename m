From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Mon, 26 Nov 2018 13:15:35 +0100
Subject: [PATCH] firmware: arm_sdei: fix wrong of_node_put() in init function
Message-ID: <20181126121536.28739-1-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After finding a "firmware" dt node arm_sdei tries to match it's
compatible string with it. To do so it's calling of_find_matching_node()
which already takes care of decreasing the refcount on the "firmware"
node. We are then incorrectly decreasing the refcount on that node
again.

This patch removes the unwarranted call to of_node_put().

Fixes: ad6eb31ef903 ("firmware: arm_sdei: Add driver for Software Delegated Exceptions")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/firmware/arm_sdei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1ea71640fdc2..dffb47c6b480 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1017,7 +1017,6 @@ static bool __init sdei_present_dt(void)
 		return false;
 
 	np = of_find_matching_node(fw_np, sdei_of_match);
-	of_node_put(fw_np);
 	if (!np)
 		return false;
 
-- 
2.19.1
