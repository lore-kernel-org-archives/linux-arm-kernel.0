From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Tue,  2 Apr 2013 18:46:51 +0200
Subject: [PATCH] ARM: at91/tc: fix clock source id for tc block > 1
Message-ID: <1364921211-15756-1-git-send-email-linux-arm@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes wrong clock request for TC block 2.
The second block was using t0_clk, t1_clk and t2_clk clks instead of
t3_clk, t4_clk and t5_clk clks.


Signed-off-by: Boris BREZILLON <linux-arm@overkiz.com>
---
 drivers/misc/atmel_tclib.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index c8d8e38..768a988 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -142,6 +142,8 @@ static int __init tc_probe(struct platform_device *pdev)
 	struct atmel_tc *tc;
 	struct clk	*clk;
 	int		irq;
+	char		clk_id[7];
+	int		clk_offset;
 
 	if (!platform_get_resource(pdev, IORESOURCE_MEM, 0))
 		return -EINVAL;
@@ -156,25 +158,31 @@ static int __init tc_probe(struct platform_device *pdev)
 
 	tc->pdev = pdev;
 
-	clk = clk_get(&pdev->dev, "t0_clk");
-	if (IS_ERR(clk)) {
-		kfree(tc);
-		return -EINVAL;
-	}
-
 	/* Now take SoC information if available */
 	if (pdev->dev.of_node) {
 		const struct of_device_id *match;
 		match = of_match_node(atmel_tcb_dt_ids, pdev->dev.of_node);
 		if (match)
 			tc->tcb_config = match->data;
+		clk_offset = of_alias_get_id(tc->pdev->dev.of_node, "tcb");
+	} else
+		clk_offset = pdev->id;
+	clk_offset *= 3;
+
+	snprintf(clk_id, sizeof(clk_id), "t%d_clk", clk_offset++);
+	clk = clk_get(&pdev->dev, clk_id);
+	if (IS_ERR(clk)) {
+		kfree(tc);
+		return -EINVAL;
 	}
 
 	tc->clk[0] = clk;
-	tc->clk[1] = clk_get(&pdev->dev, "t1_clk");
+	snprintf(clk_id, sizeof(clk_id), "t%d_clk", clk_offset++);
+	tc->clk[1] = clk_get(&pdev->dev, clk_id);
 	if (IS_ERR(tc->clk[1]))
 		tc->clk[1] = clk;
-	tc->clk[2] = clk_get(&pdev->dev, "t2_clk");
+	snprintf(clk_id, sizeof(clk_id), "t%d_clk", clk_offset++);
+	tc->clk[2] = clk_get(&pdev->dev, clk_id);
 	if (IS_ERR(tc->clk[2]))
 		tc->clk[2] = clk;
 
-- 
1.7.9.5
