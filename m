From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 14 Dec 2015 11:06:00 +0100
Subject: [PATCH] clk: sunxi: fix handling return value of
 of_property_match_string
In-Reply-To: <1450087564-28441-1-git-send-email-a.hajda@samsung.com>
References: <1450087564-28441-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1450087564-28441-3-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function can return negative values, so its result should
be assigned to signed variable.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/assign_signed_to_unsigned.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2046107

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/clk/sunxi/clk-sun8i-bus-gates.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun8i-bus-gates.c b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
index 7ab60c5..ecadd97 100644
--- a/drivers/clk/sunxi/clk-sun8i-bus-gates.c
+++ b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
@@ -47,12 +47,12 @@ static void __init sun8i_h3_bus_gates_init(struct device_node *node)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(names); i++) {
-		index = of_property_match_string(node, "clock-names",
-						 names[i]);
-		if (index < 0)
+		int idx = of_property_match_string(node, "clock-names",
+						   names[i]);
+		if (idx < 0)
 			return;
 
-		parents[i] = of_clk_get_parent_name(node, index);
+		parents[i] = of_clk_get_parent_name(node, idx);
 	}
 
 	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
-- 
1.9.1
