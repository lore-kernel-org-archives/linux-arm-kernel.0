From: standby24x7@gmail.com (Masanari Iida)
Date: Tue, 11 Feb 2014 22:25:41 +0900
Subject: [PATCH] clk:ti: Fix memory leak in of_ti_composite_divider_clk_setup()
Message-ID: <1392125141-14769-1-git-send-email-standby24x7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cppcheck detected following error
[drivers/clk/ti/divider.c:480]: (error) Memory leak: div

The original code forgot to free div and just returned.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/clk/ti/divider.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index a15e445..a105d94 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -477,7 +477,6 @@ static void __init of_ti_composite_divider_clk_setup(struct device_node *node)
 		goto cleanup;
 
 	if (!ti_clk_add_component(node, &div->hw, CLK_COMPONENT_TYPE_DIVIDER))
-		return;
 
 cleanup:
 	kfree(div->table);
-- 
1.9.rc1
