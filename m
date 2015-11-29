From: albeu@free.fr (Alban Bedel)
Date: Sun, 29 Nov 2015 14:15:09 +0100
Subject: [PATCH] clkdev: Fix of_clk_get_by_name() for consistent return values
Message-ID: <1448802909-8490-1-git-send-email-albeu@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When of_clk_get_by_name() is called without name it returns -ENOENT
when the 'clocks' property doesn't exists or is an empty entry.
However when a name is given and the 'clock-names' property doesn't
exists or doesn't contains the requested name it returns -EINVAL.

To get a consistent return value with both code paths we must return
-ENOENT when of_property_match_string() fails.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/clk/clkdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 779b6ff..99a8803 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -72,7 +72,10 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
 		 */
 		if (name)
 			index = of_property_match_string(np, "clock-names", name);
-		clk = __of_clk_get(np, index, dev_id, name);
+		if (index >= 0)
+			clk = __of_clk_get(np, index, dev_id, name);
+		else
+			clk = ERR_PTR(-ENOENT);
 		if (!IS_ERR(clk)) {
 			break;
 		} else if (name && index >= 0) {
-- 
2.0.0
