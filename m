From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 14:47:01 +0200
Subject: [PATCH 01/20] clk: fixed-factor: Pass clk rates change to the parent
In-Reply-To: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1463402840-17062-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A fixed factor clock, if it needs to change its rate, by definition do not
have any choice but to modify its parent rate.

Add the CLK_SET_RATE_PARENT flag to that clock so that it can happen

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/clk-fixed-factor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 75cd6c792cb8..3363abd9b4ae 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -167,7 +167,8 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
 	of_property_read_string(node, "clock-output-names", &clk_name);
 	parent_name = of_clk_get_parent_name(node, 0);
 
-	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
+	clk = clk_register_fixed_factor(NULL, clk_name, parent_name,
+					CLK_SET_RATE_PARENT,
 					mult, div);
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-- 
2.8.2
