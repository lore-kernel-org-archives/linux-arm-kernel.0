From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Dec 2012 17:54:41 +0000
Subject: [PATCH v2 2/7] vexpress: Match the "arm,
 sp810" DT entry for clock initialisation
In-Reply-To: <1355939686-23728-1-git-send-email-catalin.marinas@arm.com>
References: <1355939686-23728-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1355939686-23728-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the clk-vexpress.c implementation relies on the vexpress code
to call the vexpress_clk_of_init() function which performs the SP810
initialisation. This patch adds "arm,sp810" to the clock DT match array
allowing of_clk_init() to call the vexpress_sp810_of_setup() function.
In case of CONFIG_ARM64, make vexpress_clk_of_init() an arch_initcall().

Note that SP810 requires the fixed clocks to be already registered.
Since the clock subsystem does not handle DT dependencies, the
corresponding DT entries must be in the correct order.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
---

The "Note" above worries me a bit. There is another way like calling
of_clk_init() twice, with two match arrays - the original one and
another just for sp810. Suggestions welcome.

Not tested on AArch32 code yet.

 drivers/clk/versatile/clk-vexpress.c | 28 +++++++++++++++++-----------
 include/linux/vexpress.h             |  2 +-
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/versatile/clk-vexpress.c b/drivers/clk/versatile/clk-vexpress.c
index 4f83ff9..a3754e7 100644
--- a/drivers/clk/versatile/clk-vexpress.c
+++ b/drivers/clk/versatile/clk-vexpress.c
@@ -98,21 +98,11 @@ struct clk *vexpress_sp810_of_get(struct of_phandle_args *clkspec, void *data)
 	return vexpress_sp810_timerclken[clkspec->args[0]];
 }
 
-static const __initconst struct of_device_id vexpress_fixed_clk_match[] = {
-	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
-	{ .compatible = "arm,vexpress-osc", .data = vexpress_osc_of_setup, },
-	{}
-};
-
-void __init vexpress_clk_of_init(void)
+static void __init vexpress_sp810_of_setup(struct device_node *node)
 {
-	struct device_node *node;
 	struct clk *clk;
 	struct clk *refclk, *timclk;
 
-	of_clk_init(vexpress_fixed_clk_match);
-
-	node = of_find_compatible_node(NULL, NULL, "arm,sp810");
 	vexpress_sp810_init(of_iomap(node, 0));
 	of_clk_add_provider(node, vexpress_sp810_of_get, NULL);
 
@@ -138,4 +128,20 @@ void __init vexpress_clk_of_init(void)
 				"v2m-timer1", "sp804"));
 }
 
+static const __initconst struct of_device_id vexpress_clk_match[] = {
+	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{ .compatible = "arm,vexpress-osc", .data = vexpress_osc_of_setup, },
+	{ .compatible = "arm,sp810", .data = vexpress_sp810_of_setup, },
+	{}
+};
+
+int __init vexpress_clk_of_init(void)
+{
+	of_clk_init(vexpress_clk_match);
+	return 0;
+}
+#ifdef CONFIG_ARM64
+arch_initcall(vexpress_clk_of_init);
+#endif
+
 #endif
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index c52215f..b55ae6a 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -116,6 +116,6 @@ struct clk *vexpress_osc_setup(struct device *dev);
 void vexpress_osc_of_setup(struct device_node *node);
 
 void vexpress_clk_init(void __iomem *sp810_base);
-void vexpress_clk_of_init(void);
+int vexpress_clk_of_init(void);
 
 #endif
