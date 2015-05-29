From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat, 30 May 2015 01:19:01 +0200
Subject: [PATCH v4] ARM: l2c: add options to overwrite prefetching behavior
Message-ID: <1432941541-18588-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These options make it possible to overwrites the data and instruction
prefetching behavior of the arm pl310 cache controller.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
changes since
v3: 
  * remove arm prefix
  * improve documentation
v2: only set prefetch
v1: set prefetch and aux
 Documentation/devicetree/bindings/arm/l2cc.txt |  5 +++++
 arch/arm/mm/cache-l2x0.c                       | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index 0dbabe9..2251dcc 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -67,6 +67,11 @@ Optional properties:
   disable if zero.
 - arm,prefetch-offset : Override prefetch offset value. Valid values are
   0-7, 15, 23, and 31.
+- prefetch-data : Data prefetch. Value: <0> (forcibly disable), <1>
+  (forcibly enable), property absent (retain settings set by firmware)
+- prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
+  <1> (forcibly enable), property absent (retain settings set by
+  firmware)
 
 Example:
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index e309c8f..2570f83 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1199,6 +1199,26 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		pr_err("L2C-310 OF arm,prefetch-offset property value is missing\n");
 	}
 
+	ret = of_property_read_u32(np, "prefetch-data", &val);
+	if (ret == 0) {
+		if (val)
+			prefetch |= L310_PREFETCH_CTRL_DATA_PREFETCH;
+		else
+			prefetch &= ~L310_PREFETCH_CTRL_DATA_PREFETCH;
+	} else if (ret != -EINVAL) {
+		pr_err("L2C-310 OF prefetch-data property value is missing\n");
+	}
+
+	ret = of_property_read_u32(np, "prefetch-instr", &val);
+	if (ret == 0) {
+		if (val)
+			prefetch |= L310_PREFETCH_CTRL_INSTR_PREFETCH;
+		else
+			prefetch &= ~L310_PREFETCH_CTRL_INSTR_PREFETCH;
+	} else if (ret != -EINVAL) {
+		pr_err("L2C-310 OF prefetch-instr property value is missing\n");
+	}
+
 	l2x0_saved_regs.prefetch_ctrl = prefetch;
 }
 
-- 
2.1.4
