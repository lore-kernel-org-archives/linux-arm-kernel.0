From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Thu, 26 Jun 2014 12:02:03 -0300
Subject: [PATCH] arm: mach-omap2: gpmc: ignore non-available nodes
Message-ID: <1403794923-19511-1-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, child nodes of the gpmc node are iterated and probed
regardless of their 'status' property. This means adding 'status =
"disabled";' has no effect.

This patch changes the iteration to only probe nodes marked as
available.

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
---
 arch/arm/mach-omap2/gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2c0c281..8bc1338 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1615,7 +1615,7 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 		return ret;
 	}
 
-	for_each_child_of_node(pdev->dev.of_node, child) {
+	for_each_available_child_of_node(pdev->dev.of_node, child) {
 
 		if (!child->name)
 			continue;
-- 
2.0.0
