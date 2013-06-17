From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 16 Jun 2013 19:58:25 -0700
Subject: [PATCH v2 5/5] clk: dt: binding for basic gate clock
In-Reply-To: <1371437905-15567-1-git-send-email-mturquette@linaro.org>
References: <1371437905-15567-1-git-send-email-mturquette@linaro.org>
Message-ID: <1371437905-15567-6-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device Tree binding for the basic clock gate, plus the setup function to
register the clock.  Based on the existing fixed-clock binding.

A different approach to this was proposed in 2012[1] and a similar
binding was proposed more recently[2] if anyone wants some extra
reading.

[1] http://article.gmane.org/gmane.linux.documentation/5679
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137878.html

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
No change since v1, new patch

 .../devicetree/bindings/clock/gate-clock.txt       | 34 ++++++++++++++++++
 drivers/clk/clk-gate.c                             | 40 ++++++++++++++++++++++
 include/linux/clk-provider.h                       |  2 ++
 3 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/gate-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/gate-clock.txt b/Documentation/devicetree/bindings/clock/gate-clock.txt
new file mode 100644
index 0000000..4f1c776
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/gate-clock.txt
@@ -0,0 +1,34 @@
+Binding for simple gate clock.
+
+This binding uses the common clock binding[1].  It assumes a
+register-mapped clock gate controlled by a single bit that has only one
+input clock or parent.  By default setting the specified bit gates the
+clock signal and clearing the bit ungates it.
+
+The binding must provide the register to control the gate and the bit
+shift for the corresponding gate control bit. Some clocks set the bit to
+gate the clock signal, and clear it to ungate the clock signal. The
+optional "set-bit-to-disable" specifies this behavior.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be "gate-clock".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : link to phandle of parent clock
+- reg : base address for register controlling adjustable gate
+- bit-shift : bit shift for programming the clock gate
+
+Optional properties:
+- clock-output-names : from common clock binding.
+- set-bit-to-disable : inverts default gate programming. Setting the bit
+  gates the clock and clearing the bit ungates the clock.
+
+Examples:
+	clock_foo: clock_foo at 4a008100 {
+		compatible = "gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clock_bar>;
+		reg = <0x4a008100 0x4>
+		bit-shift = <3>
+	};
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 790306e..3cbf54e 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -15,6 +15,8 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/string.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 /**
  * DOC: basic gatable clock which can gate and ungate it's ouput
@@ -161,3 +163,41 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 
 	return clk;
 }
+
+#ifdef CONFIG_OF
+/**
+ * of_gate_clk_setup() - Setup function for simple gate rate clock
+ */
+void of_gate_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	void __iomem *reg;
+	const char *parent_name;
+	u8 clk_gate_flags = 0;
+	u8 bit_idx = 0;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	reg = of_iomap(node, 0);
+
+	if (of_property_read_u8(node, "bit-shift", &bit_idx)) {
+		pr_err("%s: missing bit-shift property for %s\n",
+				__func__, node->name);
+		return;
+	}
+
+	if (of_property_read_bool(node, "set-bit-to-disable"))
+		clk_gate_flags |= CLK_GATE_SET_TO_DISABLE;
+
+	clk = clk_register_gate(NULL, clk_name, parent_name, 0, reg, bit_idx,
+			clk_gate_flags, NULL);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+EXPORT_SYMBOL_GPL(of_gate_clk_setup);
+CLK_OF_DECLARE(gate_clk, "gate-clock", of_gate_clk_setup);
+#endif
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 723ce69..4aeaedb 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -232,6 +232,8 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock);
 
+void of_gate_clk_setup(struct device_node *node);
+
 struct clk_div_table {
 	unsigned int	val;
 	unsigned int	div;
-- 
1.8.1.2
