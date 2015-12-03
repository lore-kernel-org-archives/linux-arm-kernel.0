From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Dec 2015 15:05:30 +0800
Subject: [PATCH v5] clk: sunxi: Add CLK_OF_DECLARE support for
 sun8i-a23-apb0-clk driver
Message-ID: <1449126330-21595-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APBS clock on sun9i is the same as the APB0 clock on sun8i. With
sun9i we are supporting the PRCM clocks by using CLK_OF_DECLARE,
instead of through a PRCM mfd device and subdevices for each clock
and reset control. As such we need a CLK_OF_DECLARE version of
the sun8i-a23-apb0-clk driver.

Also, build it for sun9i/A80, and not just for configurations with
MFD_SUN6I_PRCM enabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v4:

  - Keep building clk-sun8i-apb0 for SUN6I_MFD_PRCM.

  - Add an error message and comment for when of_io_request_and_map()
    fails. of_io_request_and_map() merges a bunch of errors into -EINVAL,
    so this might not be the best approach. But I think having an error
    message when we know something is wrong (-EBUSY, -ENOMEM) is better.

---
 drivers/clk/sunxi/Makefile         |  1 +
 drivers/clk/sunxi/clk-sun8i-apb0.c | 80 ++++++++++++++++++++++++++++++++------
 2 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 103efab05ca8..ccf21ba3b6b0 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -15,6 +15,7 @@ obj-y += clk-sun9i-core.o
 obj-y += clk-sun9i-mmc.o
 obj-y += clk-usb.o
 
+obj-$(CONFIG_MACH_SUN9I) += clk-sun8i-apb0.o
 obj-$(CONFIG_MACH_SUN9I) += clk-sun9i-cpus.o
 
 obj-$(CONFIG_MFD_SUN6I_PRCM) += \
diff --git a/drivers/clk/sunxi/clk-sun8i-apb0.c b/drivers/clk/sunxi/clk-sun8i-apb0.c
index 7ae5d2c2cde1..7ba61103a6f5 100644
--- a/drivers/clk/sunxi/clk-sun8i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun8i-apb0.c
@@ -17,13 +17,77 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
+static struct clk *sun8i_a23_apb0_register(struct device_node *node,
+					   void __iomem *reg)
+{
+	const char *clk_name = node->name;
+	const char *clk_parent;
+	struct clk *clk;
+	int ret;
+
+	clk_parent = of_clk_get_parent_name(node, 0);
+	if (!clk_parent)
+		return ERR_PTR(-EINVAL);
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	/* The A23 APB0 clock is a standard 2 bit wide divider clock */
+	clk = clk_register_divider(NULL, clk_name, clk_parent, 0, reg,
+				   0, 2, CLK_DIVIDER_POWER_OF_TWO, NULL);
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (ret)
+		goto err_unregister;
+
+	return clk;
+
+err_unregister:
+	clk_unregister_divider(clk);
+
+	return ERR_PTR(ret);
+}
+
+static void sun8i_a23_apb0_setup(struct device_node *node)
+{
+	void __iomem *reg;
+	struct resource res;
+	struct clk *clk;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(reg)) {
+		/*
+		 * This happens with clk nodes instantiated through mfd,
+		 * as those do not have their resources assigned in the
+		 * device tree. Do not print an error in this case.
+		 */
+		if (PTR_ERR(reg) != -EINVAL)
+			pr_err("Could not get registers for a23-apb0-clk\n");
+
+		return;
+	}
+
+	clk = sun8i_a23_apb0_register(node, reg);
+	if (IS_ERR(clk))
+		goto err_unmap;
+
+	return;
+
+err_unmap:
+	iounmap(reg);
+	of_address_to_resource(node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
+}
+CLK_OF_DECLARE(sun8i_a23_apb0, "allwinner,sun8i-a23-apb0-clk",
+	       sun8i_a23_apb0_setup);
+
 static int sun8i_a23_apb0_clk_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const char *clk_name = np->name;
-	const char *clk_parent;
 	struct resource *r;
 	void __iomem *reg;
 	struct clk *clk;
@@ -33,19 +97,11 @@ static int sun8i_a23_apb0_clk_probe(struct platform_device *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-	clk_parent = of_clk_get_parent_name(np, 0);
-	if (!clk_parent)
-		return -EINVAL;
-
-	of_property_read_string(np, "clock-output-names", &clk_name);
-
-	/* The A23 APB0 clock is a standard 2 bit wide divider clock */
-	clk = clk_register_divider(&pdev->dev, clk_name, clk_parent, 0, reg,
-				   0, 2, CLK_DIVIDER_POWER_OF_TWO, NULL);
+	clk = sun8i_a23_apb0_register(np, reg);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	return of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return 0;
 }
 
 static const struct of_device_id sun8i_a23_apb0_clk_dt_ids[] = {
-- 
2.6.2
