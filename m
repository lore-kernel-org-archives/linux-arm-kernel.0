From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 29 Aug 2012 00:53:02 +0200
Subject: [PATCH] clk: add DT fixed-factor-clock binding support
In-Reply-To: <1346194382-11405-1-git-send-email-gregory.clement@free-electrons.com>
References: <1346194382-11405-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1346194382-11405-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for DT "fixed-factor-clock" binding to the common fixed
factor clock support.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Mike Turquette <mturquette@ti.com>
Cc: Shawn Guo <shawn.guo@freescale.com>
---
 .../bindings/clock/fixed-factor-clock.txt          |   24 ++++++++++++++
 drivers/clk/clk-fixed-factor.c                     |   34 ++++++++++++++++++++
 include/linux/clk-provider.h                       |    2 ++
 3 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-factor-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt b/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
new file mode 100644
index 0000000..7ed236f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
@@ -0,0 +1,24 @@
+Binding for simple fixed factor rate clock sources.
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be "fixed-factor-clock".
+- #clock-cells : from common clock binding; shall be set to 0.
+- div: fixed divider.
+- mult: fixed multiplier.
+- clocks: parent clock.
+
+Optional properties:
+- clock-output-names : From common clock binding.
+
+Example:
+	clock {
+		compatible = "fixed-factor-clock";
+		clocks = <&parentclk>;
+		#clock-cells = <0>;
+		div = <2>;
+		mult = <1>;
+	};
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index a489985..8fdf5e9 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -11,6 +11,7 @@
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 /*
  * DOC: basic fixed multiplier and divider clock that cannot gate
@@ -93,3 +94,36 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 
 	return clk;
 }
+#ifdef CONFIG_OF
+/**
+ * of_fixed_factor_clk_setup() - Setup function for simple fixed factor clock
+ */
+void __init of_fixed_factor_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	u32 div, mult;
+
+	if (of_property_read_u32(node, "div", &div)) {
+		pr_err("%s Fixed factor clock <%s> must have a div property\n",
+			__func__, node->name);
+		return;
+	}
+
+	if (of_property_read_u32(node, "mult", &mult)) {
+		pr_err("%s Fixed factor clock <%s> must have a mult property\n",
+			__func__, node->name);
+		return;
+	}
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
+					mult, div);
+	if (clk)
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+EXPORT_SYMBOL_GPL(of_fixed_factor_clk_setup);
+#endif
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 77335fa..796e68b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -314,6 +314,8 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
 
+void of_fixed_factor_clk_setup(struct device_node *node);
+
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
-- 
1.7.9.5
