From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Nov 2015 17:32:12 +0800
Subject: [PATCH v3 1/5] clk: sunxi: Add CLK_OF_DECLARE support for
 sun8i-a23-apb0-clk driver
In-Reply-To: <1448357536-26613-1-git-send-email-wens@csie.org>
References: <1448357536-26613-1-git-send-email-wens@csie.org>
Message-ID: <1448357536-26613-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APBS clock on sun9i is the same as the APB0 clock on sun8i. With
sun9i we are supporting the PRCM clocks by using CLK_OF_DECLARE,
instead of through a PRCM mfd device and subdevices for each clock
and reset control. As such we need a CLK_OF_DECLARE version of
the sun8i-a23-apb0-clk driver.

Also, build it for all Allwinner/sunxi platforms, and not just for
configurations with MFD_SUN6I_PRCM enabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/Makefile         |  4 ++--
 drivers/clk/sunxi/clk-sun8i-apb0.c | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index cb4c299214ce..121333ce34ea 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -10,11 +10,11 @@ obj-y += clk-a10-pll2.o
 obj-y += clk-a20-gmac.o
 obj-y += clk-mod0.o
 obj-y += clk-simple-gates.o
+obj-y += clk-sun8i-apb0.o
 obj-y += clk-sun8i-mbus.o
 obj-y += clk-sun9i-core.o
 obj-y += clk-sun9i-mmc.o
 obj-y += clk-usb.o
 
 obj-$(CONFIG_MFD_SUN6I_PRCM) += \
-	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
-	clk-sun8i-apb0.o
+	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o
diff --git a/drivers/clk/sunxi/clk-sun8i-apb0.c b/drivers/clk/sunxi/clk-sun8i-apb0.c
index 7ae5d2c2cde1..11b2f2fde245 100644
--- a/drivers/clk/sunxi/clk-sun8i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun8i-apb0.c
@@ -17,8 +17,51 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
+static void sun8i_a23_apb0_setup(struct device_node *node)
+{
+	const char *clk_name = node->name;
+	const char *clk_parent;
+	void __iomem *reg;
+	struct resource res;
+	struct clk *clk;
+	int ret;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(reg))
+		return;
+
+	clk_parent = of_clk_get_parent_name(node, 0);
+	if (!clk_parent)
+		goto err_unmap;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	/* The A23 APB0 clock is a standard 2 bit wide divider clock */
+	clk = clk_register_divider(NULL, clk_name, clk_parent, 0, reg,
+				   0, 2, CLK_DIVIDER_POWER_OF_TWO, NULL);
+	if (IS_ERR(clk))
+		goto err_unmap;
+
+	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (ret)
+		goto err_unregister;
+
+	return;
+
+err_unregister:
+	clk_unregister_divider(clk);
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
-- 
2.6.2
