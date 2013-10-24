From: valentin.ilie@gmail.com (Valentin Ilie)
Date: Thu, 24 Oct 2013 15:25:13 +0300
Subject: [PATCH] clk: sunxi: fix memory leaks
Message-ID: <1382617513-9259-1-git-send-email-valentin.ilie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the if condition is true, "fixed" and "gate" should be free'd before return.

Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 34ee69f..a970b55 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -48,8 +48,11 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
 		return;
 	}
 
-	if (of_property_read_u32(node, "clock-frequency", &rate))
+	if (of_property_read_u32(node, "clock-frequency", &rate)) {
+		kfree(fixed);
+		kfree(gate);
 		return;
+	}
 
 	/* set up gate and fixed rate properties */
 	gate->reg = of_iomap(node, 0);
-- 
1.8.1.2
