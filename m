From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 6 Dec 2015 10:04:12 +0100
Subject: [PATCH] clk: sunxi: Extend the simple gates and handle the
 Allwinner H3
Message-ID: <20151206100412.1a74b71da8e9ca28c6e61589@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H3 has a clock gate definition similar to the other Allwinner SoCs,
but with a different parent clock for each single gate.

Adding the names of the parent clocks in both the source and output clocks
permits the use of the simple-gates driver to define the bus gates
of all known Allwinner SoCs.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
This patch replaces a part of Jens Kuske's patch
	[PATCH v5 1/4] clk: sunxi: Add H3 clocks support
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 25 +++++++++++++++++++++++
 drivers/clk/sunxi/clk-simple-gates.c              | 14 ++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 8a47b77..5736e6d 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -70,6 +70,7 @@ Required properties:
 	"allwinner,sun8i-a23-usb-clk" - for usb gates + resets on A23
 	"allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets on A80
 	"allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
+	"allwinner,sunxi-gates-clk" - simple gates
 
 Required properties for all clocks:
 - reg : shall be the control register address for the clock.
@@ -93,6 +94,12 @@ The "allwinner,sun9i-a80-mmc-config-clk" clock also requires:
 - #reset-cells : shall be set to 1
 - resets : shall be the reset control phandle for the mmc block.
 
+The "allwinner,sunxi-gates-clk" clock also requires:
+- clock-names : corresponding names of the parent clocks
+when the output clocks have different parents.
+These names must be 4 characters long and must appear as a prefix in
+the names of the output clocks. See example.
+
 For "allwinner,sun7i-a20-gmac-clk", the parent clocks shall be fixed rate
 dummy clocks at 25 MHz and 125 MHz, respectively. See example.
 
@@ -203,3 +210,21 @@ mmc_config_clk: clk at 01c13000 {
 	clock-output-names = "mmc0_config", "mmc1_config",
 			     "mmc2_config", "mmc3_config";
 };
+
+bus_gates: clk at 01c20060 {
+	compatible = "allwinner,sunxi-gates-clk";
+	reg = <0x01c20060 0x14>;
+	clocks = <&ahb1>, <&ahb2>;
+	clock-names = "ahb1", "ahb2";
+	clock-indices = <5>, <6>, <8>,
+			<17>, <18>,
+			<26>, <27>,
+			<28>, <29>,
+			<128>, <135>;
+	clock-output-names = "ahb1_ce", "ahb1_dma", "ahb1_mmc0",
+			     "ahb2_emac", "ahb1_ts",
+			     "ahb1_ehci2", "ahb1_ehci3",
+			     "ahb1_otg_ohci0", "ahb2_ohci1",
+			     "ahb1_ephy", "ahb1_dbg";
+	};
+};
diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index 0214c65..81c4cb0 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -29,12 +29,14 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
 {
 	struct clk_onecell_data *clk_data;
 	const char *clk_parent, *clk_name;
+	char dyn_clk_parent[8];
 	struct property *prop;
 	struct resource res;
 	void __iomem *clk_reg;
 	void __iomem *reg;
 	const __be32 *p;
 	int number, i = 0, j;
+	bool parent_per_gate;
 	u8 clk_bit;
 	u32 index;
 
@@ -42,7 +44,13 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
 	if (IS_ERR(reg))
 		return;
 
-	clk_parent = of_clk_get_parent_name(node, 0);
+	parent_per_gate = of_clk_get_parent_count(node) != 1;
+	if (parent_per_gate) {
+		clk_parent = dyn_clk_parent;
+		dyn_clk_parent[4] = '\0';
+	} else {
+		clk_parent = of_clk_get_parent_name(node, 0);
+	}
 
 	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
 	if (!clk_data)
@@ -58,6 +66,8 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
 	of_property_for_each_u32(node, "clock-indices", prop, p, index) {
 		of_property_read_string_index(node, "clock-output-names",
 					      i, &clk_name);
+		if (parent_per_gate)
+			strncpy(dyn_clk_parent, clk_name, 4);
 
 		clk_reg = reg + 4 * (index / 32);
 		clk_bit = index % 32;
@@ -140,6 +150,8 @@ CLK_OF_DECLARE(sun9i_a80_apb0, "allwinner,sun9i-a80-apb0-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun9i_a80_apb1, "allwinner,sun9i-a80-apb1-gates-clk",
 	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sunxi_gates, "allwinner,sunxi-gates-clk",sunxi-gates
+	       sunxi_simple_gates_init);
 
 static const int sun4i_a10_ahb_critical_clocks[] __initconst = {
 	14,	/* ahb_sdram */

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
