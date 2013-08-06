From: shaojie.sun@linaro.org (Shaojie Sun)
Date: Tue,  6 Aug 2013 11:57:37 +0800
Subject: [PATCH] clk: gate: add CLK_GATE_ALWAYS_ON
Message-ID: <1375761457-16364-1-git-send-email-shaojie.sun@linaro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default gate clock could be enable and disable. but
in some debug condition, must keep clock on, and never be closed.
setting this flag then gate clock never be closed.

Signed-off-by: Shaojie Sun <shaojie.sun@linaro.com>
---
 drivers/clk/clk-gate.c       |   24 ++++++++++++++++++++++++
 include/linux/clk-provider.h |    4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 790306e..cc2b00e 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/string.h>
+#include <linux/device.h>
 
 /**
  * DOC: basic gatable clock which can gate and ungate it's ouput
@@ -48,6 +49,9 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 	unsigned long flags = 0;
 	u32 reg;
 
+	if (!enable && (gate->flags & CLK_GATE_ALWAYS_ON))
+		return;
+
 	set ^= enable;
 
 	if (gate->lock)
@@ -159,5 +163,25 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	if (IS_ERR(clk))
 		kfree(gate);
 
+	if (clk_gate_flags & CLK_GATE_ALWAYS_ON) {
+		int ret;
+		if (flags & CLK_SET_PARENT_GATE)
+			pr_debug("%s: %salways on, but need parent gate.\n",
+					__func__, name);
+
+		ret = clk_prepare(clk);
+		if (ret) {
+			pr_debug("%s: %s could not be prepared.\n",
+					__func__, name);
+			return clk;
+		}
+		ret = clk_enable(clk);
+		if (ret) {
+			pr_debug("%s: %s could not be enabled.\n",
+					__func__, name);
+			clk_unprepare(clk);
+		}
+	}
+
 	return clk;
 }
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1ec14a7..641422c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -214,6 +214,9 @@ void of_fixed_clk_setup(struct device_node *np);
  *   of this register, and mask of gate bits are in higher 16-bit of this
  *   register.  While setting the gate bits, higher 16-bit should also be
  *   updated to indicate changing gate bits.
+ * CLK_GATE_ALWAYS_ON - by default this clock could be enable and disable. but
+ *   in some debug condition, must keep this clock on, and never be closed.
+ *   setting this flag then this clock never be closed.
  */
 struct clk_gate {
 	struct clk_hw hw;
@@ -225,6 +228,7 @@ struct clk_gate {
 
 #define CLK_GATE_SET_TO_DISABLE		BIT(0)
 #define CLK_GATE_HIWORD_MASK		BIT(1)
+#define CLK_GATE_ALWAYS_ON		BIT(4)
 
 extern const struct clk_ops clk_gate_ops;
 struct clk *clk_register_gate(struct device *dev, const char *name,
-- 
1.7.9.5
