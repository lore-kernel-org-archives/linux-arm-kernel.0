From: david@lechnology.com (David Lechner)
Date: Thu,  4 Jan 2018 18:38:12 -0600
Subject: [PATCH 7/7] clk: sunxi: make use of clk_alloc_onecell_data()
In-Reply-To: <1515112695-3160-1-git-send-email-david@lechnology.com>
References: <1515112695-3160-1-git-send-email-david@lechnology.com>
Message-ID: <1515112695-3160-8-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper function clk_alloc_onecell_data() to allocate struct
clk_onecell_data.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/sunxi/clk-a10-pll2.c        | 14 ++++----------
 drivers/clk/sunxi/clk-mod0.c            | 13 +++----------
 drivers/clk/sunxi/clk-simple-gates.c    | 13 +++----------
 drivers/clk/sunxi/clk-sun8i-bus-gates.c | 13 +++----------
 drivers/clk/sunxi/clk-sunxi.c           | 14 ++++----------
 drivers/clk/sunxi/clk-usb.c             |  8 +-------
 6 files changed, 18 insertions(+), 57 deletions(-)

diff --git a/drivers/clk/sunxi/clk-a10-pll2.c b/drivers/clk/sunxi/clk-a10-pll2.c
index d8eab90..54b8386 100644
--- a/drivers/clk/sunxi/clk-a10-pll2.c
+++ b/drivers/clk/sunxi/clk-a10-pll2.c
@@ -58,13 +58,11 @@ static void __init sun4i_pll2_setup(struct device_node *node,
 	if (IS_ERR(reg))
 		return;
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	clk_data = clk_alloc_onecell_data(SUN4I_PLL2_OUTPUTS);
 	if (!clk_data)
 		goto err_unmap;
 
-	clks = kcalloc(SUN4I_PLL2_OUTPUTS, sizeof(struct clk *), GFP_KERNEL);
-	if (!clks)
-		goto err_free_data;
+	clks = clk_data->clks;
 
 	parent = of_clk_get_parent_name(node, 0);
 	prediv_clk = clk_register_divider(NULL, "pll2-prediv",
@@ -75,7 +73,7 @@ static void __init sun4i_pll2_setup(struct device_node *node,
 					  &sun4i_a10_pll2_lock);
 	if (IS_ERR(prediv_clk)) {
 		pr_err("Couldn't register the prediv clock\n");
-		goto err_free_array;
+		goto err_free_data;
 	}
 
 	/* Setup the gate part of the PLL2 */
@@ -166,8 +164,6 @@ static void __init sun4i_pll2_setup(struct device_node *node,
 							    2, 1);
 	WARN_ON(IS_ERR(clks[SUN4I_A10_PLL2_8X]));
 
-	clk_data->clks = clks;
-	clk_data->clk_num = SUN4I_PLL2_OUTPUTS;
 	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 
 	return;
@@ -178,10 +174,8 @@ static void __init sun4i_pll2_setup(struct device_node *node,
 	kfree(gate);
 err_unregister_prediv:
 	clk_unregister_divider(prediv_clk);
-err_free_array:
-	kfree(clks);
 err_free_data:
-	kfree(clk_data);
+	clk_free_onecell_data(clk_data);
 err_unmap:
 	iounmap(reg);
 }
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index 4417ae1..d14c3f1 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -315,18 +315,13 @@ static void __init sunxi_mmc_setup(struct device_node *node,
 		return;
 	}
 
-	clk_data = kmalloc(sizeof(*clk_data), GFP_KERNEL);
+	clk_data = clk_alloc_onecell_data(3);
 	if (!clk_data)
 		return;
 
-	clk_data->clks = kcalloc(3, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
-		goto err_free_data;
-
-	clk_data->clk_num = 3;
 	clk_data->clks[0] = sunxi_factors_register(node, data, lock, reg);
 	if (!clk_data->clks[0])
-		goto err_free_clks;
+		goto err_free_data;
 
 	parent = __clk_get_name(clk_data->clks[0]);
 
@@ -366,10 +361,8 @@ static void __init sunxi_mmc_setup(struct device_node *node,
 
 	return;
 
-err_free_clks:
-	kfree(clk_data->clks);
 err_free_data:
-	kfree(clk_data);
+	clk_free_onecell_data(clk_data);
 }
 
 static DEFINE_SPINLOCK(sun4i_a10_mmc_lock);
diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index a085c3b..4685358 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -44,16 +44,12 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
 
 	clk_parent = of_clk_get_parent_name(node, 0);
 
-	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
-	if (!clk_data)
-		goto err_unmap;
-
 	number = of_property_count_u32_elems(node, "clock-indices");
 	of_property_read_u32_index(node, "clock-indices", number - 1, &number);
 
-	clk_data->clks = kcalloc(number + 1, sizeof(struct clk *), GFP_KERNEL);
-	if (!clk_data->clks)
-		goto err_free_data;
+	clk_data = clk_alloc_onecell_data(number + 1);
+	if (!clk_data)
+		goto err_unmap;
 
 	of_property_for_each_u32(node, "clock-indices", prop, p, index) {
 		of_property_read_string_index(node, "clock-output-names",
@@ -80,13 +76,10 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
 
 	}
 
-	clk_data->clk_num = number + 1;
 	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 
 	return;
 
-err_free_data:
-	kfree(clk_data);
 err_unmap:
 	iounmap(reg);
 	of_address_to_resource(node, 0, &res);
diff --git a/drivers/clk/sunxi/clk-sun8i-bus-gates.c b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
index bee305b..f3a3e05 100644
--- a/drivers/clk/sunxi/clk-sun8i-bus-gates.c
+++ b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
@@ -54,16 +54,12 @@ static void __init sun8i_h3_bus_gates_init(struct device_node *node)
 		parents[i] = of_clk_get_parent_name(node, idx);
 	}
 
-	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
-	if (!clk_data)
-		goto err_unmap;
-
 	number = of_property_count_u32_elems(node, "clock-indices");
 	of_property_read_u32_index(node, "clock-indices", number - 1, &number);
 
-	clk_data->clks = kcalloc(number + 1, sizeof(struct clk *), GFP_KERNEL);
-	if (!clk_data->clks)
-		goto err_free_data;
+	clk_data = clk_alloc_onecell_data(number + 1);
+	if (!clk_data)
+		goto err_unmap;
 
 	i = 0;
 	of_property_for_each_u32(node, "clock-indices", prop, p, index) {
@@ -98,13 +94,10 @@ static void __init sun8i_h3_bus_gates_init(struct device_node *node)
 		}
 	}
 
-	clk_data->clk_num = number + 1;
 	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 
 	return;
 
-err_free_data:
-	kfree(clk_data);
 err_unmap:
 	iounmap(reg);
 	of_address_to_resource(node, 0, &res);
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index aa4add5..5a09d35 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1012,15 +1012,11 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 		return NULL;
 	}
 
-	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	clk_data = clk_alloc_onecell_data(ndivs);
 	if (!clk_data)
 		goto out_unmap;
 
-	clks = kcalloc(ndivs, sizeof(*clks), GFP_KERNEL);
-	if (!clks)
-		goto free_clkdata;
-
-	clk_data->clks = clks;
+	clks = clk_data->clks;
 
 	/* It's not a good idea to have automatic reparenting changing
 	 * our RAM clock! */
@@ -1045,7 +1041,7 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 		if (data->div[i].gate) {
 			gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 			if (!gate)
-				goto free_clks;
+				goto free_clkdata;
 
 			gate->reg = reg;
 			gate->bit_idx = data->div[i].gate;
@@ -1106,10 +1102,8 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 	return clks;
 free_gate:
 	kfree(gate);
-free_clks:
-	kfree(clks);
 free_clkdata:
-	kfree(clk_data);
+	clk_free_onecell_data(clk_data);
 out_unmap:
 	iounmap(reg);
 	return NULL;
diff --git a/drivers/clk/sunxi/clk-usb.c b/drivers/clk/sunxi/clk-usb.c
index fe0c3d16..4358d33 100644
--- a/drivers/clk/sunxi/clk-usb.c
+++ b/drivers/clk/sunxi/clk-usb.c
@@ -118,16 +118,10 @@ static void __init sunxi_usb_clk_setup(struct device_node *node,
 	qty = find_last_bit((unsigned long *)&data->clk_mask,
 			    SUNXI_USB_MAX_SIZE);
 
-	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	clk_data = clk_alloc_onecell_data(qty + 1);
 	if (!clk_data)
 		return;
 
-	clk_data->clks = kzalloc((qty+1) * sizeof(struct clk *), GFP_KERNEL);
-	if (!clk_data->clks) {
-		kfree(clk_data);
-		return;
-	}
-
 	for_each_set_bit(i, (unsigned long *)&data->clk_mask,
 			 SUNXI_USB_MAX_SIZE) {
 		of_property_read_string_index(node, "clock-output-names",
-- 
2.7.4
