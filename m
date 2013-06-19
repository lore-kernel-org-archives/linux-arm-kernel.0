From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 19 Jun 2013 16:18:53 +0300
Subject: [PATCHv2 02/11] CLK: use of_property_read_u32 instead of read_u8
In-Reply-To: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
Message-ID: <1371647942-4811-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_property_read_u8 does not work properly because of endianess problem
with its current implementation, and this causes it to always return
0 with little endian architectures. Instead, use property_read_u32
until this is fixed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-divider.c |    4 ++--
 drivers/clk/clk-gate.c    |    4 ++--
 drivers/clk/clk-mux.c     |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 17ea475..3413602 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -361,7 +361,7 @@ void of_divider_clk_setup(struct device_node *node)
 	const char *parent_name;
 	u8 clk_divider_flags = 0;
 	u32 mask = 0;
-	u8 shift = 0;
+	u32 shift = 0;
 	struct clk_div_table *table;
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
@@ -375,7 +375,7 @@ void of_divider_clk_setup(struct device_node *node)
 		return;
 	}
 
-	if (of_property_read_u8(node, "bit-shift", &shift)) {
+	if (of_property_read_u32(node, "bit-shift", &shift)) {
 		shift = __ffs(mask);
 		pr_debug("%s: bit-shift property defaults to 0x%x for %s\n",
 				__func__, shift, node->name);
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 72cf99d..61b4dc1 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -162,7 +162,7 @@ void of_gate_clk_setup(struct device_node *node)
 	void __iomem *reg;
 	const char *parent_name;
 	u8 clk_gate_flags = 0;
-	u8 bit_idx = 0;
+	u32 bit_idx = 0;
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
@@ -170,7 +170,7 @@ void of_gate_clk_setup(struct device_node *node)
 
 	reg = of_iomap(node, 0);
 
-	if (of_property_read_u8(node, "bit-shift", &bit_idx)) {
+	if (of_property_read_u32(node, "bit-shift", &bit_idx)) {
 		pr_err("%s: missing bit-shift property for %s\n",
 				__func__, node->name);
 		return;
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index c9f9f32..e63dd1b 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -170,7 +170,7 @@ void of_mux_clk_setup(struct device_node *node)
 	int i;
 	u8 clk_mux_flags = 0;
 	u32 mask = 0;
-	u8 shift = 0;
+	u32 shift = 0;
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
@@ -194,7 +194,7 @@ void of_mux_clk_setup(struct device_node *node)
 		return;
 	}
 
-	if (of_property_read_u8(node, "bit-shift", &shift)) {
+	if (of_property_read_u32(node, "bit-shift", &shift)) {
 		shift = __ffs(mask);
 		pr_debug("%s: bit-shift property defaults to 0x%x for %s\n",
 				__func__, shift, node->name);
-- 
1.7.9.5
