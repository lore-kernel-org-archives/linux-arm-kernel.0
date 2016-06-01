From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:20 -0700
Subject: [PATCH 21/34] clk: nspire: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-22-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Daniel Tang <dt.tangr@gmail.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-nspire.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-nspire.c b/drivers/clk/clk-nspire.c
index 64f196a90816..f861011d5d21 100644
--- a/drivers/clk/clk-nspire.c
+++ b/drivers/clk/clk-nspire.c
@@ -69,7 +69,7 @@ static void __init nspire_ahbdiv_setup(struct device_node *node,
 {
 	u32 val;
 	void __iomem *io;
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *clk_name = node->name;
 	const char *parent_name;
 	struct nspire_clk_info info;
@@ -85,10 +85,10 @@ static void __init nspire_ahbdiv_setup(struct device_node *node,
 	of_property_read_string(node, "clock-output-names", &clk_name);
 	parent_name = of_clk_get_parent_name(node, 0);
 
-	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
-					1, info.base_ahb_ratio);
-	if (!IS_ERR(clk))
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	hw = clk_hw_register_fixed_factor(NULL, clk_name, parent_name, 0,
+					  1, info.base_ahb_ratio);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
 }
 
 static void __init nspire_ahbdiv_setup_cx(struct device_node *node)
@@ -111,7 +111,7 @@ static void __init nspire_clk_setup(struct device_node *node,
 {
 	u32 val;
 	void __iomem *io;
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *clk_name = node->name;
 	struct nspire_clk_info info;
 
@@ -125,9 +125,10 @@ static void __init nspire_clk_setup(struct device_node *node,
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, info.base_clock);
-	if (!IS_ERR(clk))
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	hw = clk_hw_register_fixed_rate(NULL, clk_name, NULL, 0,
+					info.base_clock);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
 	else
 		return;
 
-- 
2.7.4
