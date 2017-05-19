From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 17:55:21 +0200
Subject: [PATCH 3/7] clk: mvebu: cp110: do not depend anymore of the
 *-clock-output-names
In-Reply-To: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
References: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
Message-ID: <e47d288af5d42d4cc145eb7fa708f984a0fc0d9d.1495208533.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the *-clock-output-names property was a convenient way to have a
unique name for each clock even when there are multiple cp110 blocks
as we can find on Armada 8K.

However it has some drawbacks: the main one being a stronger link than
necessary between the driver and the device tree. For example the clock
name can't be changed, removed or moved. It is still the early stage of
introduction of the Armada 7K/8K and the hardware is still not totally
documented, especially for the clock part. By removing the use of
*-clock-output-names it will be easier to add new clocks without breaking
the compatibility.

The name of each clock is now created by using its physical address as a
prefix (as it was done for the platform device names). Thanks to this we
have an automatic way to compute a unique name.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt |  14 +----------
 drivers/clk/mvebu/cp110-system-controller.c                                | 106 ++++++++++++++++++++++++++++++++++++++++++++----------------------------
 2 files changed, 65 insertions(+), 55 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
index eb6cf44caa0f..47f1cf800e25 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
@@ -59,14 +59,6 @@ Required properties:
      "marvell,cp110-system-controller0", "syscon";
  - reg: register area of the CP110 system controller 0
  - #clock-cells: must be set to 2
- - core-clock-output-names must be set to:
-	"cpm-apll", "cpm-ppv2-core", "cpm-eip", "cpm-core", "cpm-nand-core"
- - gate-clock-output-names must be set to:
-	"cpm-audio", "cpm-communit", "cpm-nand", "cpm-ppv2", "cpm-sdio",
-	"cpm-mg-domain", "cpm-mg-core", "cpm-xor1", "cpm-xor0", "cpm-gop-dp", "none",
-	"cpm-pcie_x10", "cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor", "cpm-sata",
-	"cpm-sata-usb", "cpm-main", "cpm-gop", "none", "none", "cpm-slow-io",
-	"cpm-usb3h0", "cpm-usb3h1", "cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 
 Example:
 
@@ -74,10 +66,4 @@ Example:
 		compatible = "marvell,cp110-system-controller0", "syscon";
 		reg = <0x440000 0x1000>;
 		#clock-cells = <2>;
-		core-clock-output-names = "cpm-apll", "cpm-ppv2-core", "cpm-eip", "cpm-core", "cpm-nand-core";
-		gate-clock-output-names = "cpm-audio", "cpm-communit", "cpm-nand", "cpm-ppv2", "cpm-sdio",
-			"cpm-mg-domain", "cpm-mg-core", "cpm-xor1", "cpm-xor0", "cpm-gop-dp", "none",
-			"cpm-pcie_x10", "cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor", "cpm-sata",
-			"cpm-sata-usb", "cpm-main", "cpm-gop", "none", "none", "cpm-slow-io",
-			"cpm-usb3h0", "cpm-usb3h1", "cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 	};
diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index 2a75397f9304..c7df8a69ed9a 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -84,6 +84,33 @@ enum {
 #define CP110_GATE_EIP150		25
 #define CP110_GATE_EIP197		26
 
+const char *gate_base_names[] = {
+	[CP110_GATE_AUDIO]	= "audio",
+	[CP110_GATE_COMM_UNIT]	= "communit",
+	[CP110_GATE_NAND]	= "nand",
+	[CP110_GATE_PPV2]	= "ppv2",
+	[CP110_GATE_SDIO]	= "sdio",
+	[CP110_GATE_MG]		= "mg-domain",
+	[CP110_GATE_MG_CORE]	= "mg-core",
+	[CP110_GATE_XOR1]	= "xor1",
+	[CP110_GATE_XOR0]	= "xor0",
+	[CP110_GATE_GOP_DP]	= "gop-dp",
+	[CP110_GATE_PCIE_X1_0]	= "pcie_x10",
+	[CP110_GATE_PCIE_X1_1]	= "pcie_x11",
+	[CP110_GATE_PCIE_X4]	= "pcie_x4",
+	[CP110_GATE_PCIE_XOR]	= "pcie-xor",
+	[CP110_GATE_SATA]	= "sata",
+	[CP110_GATE_SATA_USB]	= "sata-usb",
+	[CP110_GATE_MAIN]	= "main",
+	[CP110_GATE_GOP]	= "gop",
+	[CP110_GATE_SLOW_IO]	= "slow-io",
+	[CP110_GATE_USB3H0]	= "usb3h0",
+	[CP110_GATE_USB3H1]	= "usb3h1",
+	[CP110_GATE_USB3DEV]	= "usb3dev",
+	[CP110_GATE_EIP150]	= "eip150",
+	[CP110_GATE_EIP197]	= "eip197"
+};
+
 struct cp110_gate_clk {
 	struct clk_hw hw;
 	struct regmap *regmap;
@@ -186,15 +213,33 @@ static struct clk_hw *cp110_of_clk_get(struct of_phandle_args *clkspec,
 	return ERR_PTR(-EINVAL);
 }
 
+static char *cp110_unique_name(struct device *dev, const char *name)
+{
+	struct device_node *np = dev->of_node;
+	const __be32 *reg;
+	u64 addr;
+
+	/* Do not create a name if there is no clock */
+	if (!name)
+		return NULL;
+
+	reg = of_get_property(np, "reg", NULL);
+	addr = of_translate_address(np, reg);
+	return devm_kasprintf(dev, GFP_KERNEL, "%llx-%s",
+			      (unsigned long long)addr, name);
+}
+
 static int cp110_syscon_clk_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	const char *ppv2_name, *apll_name, *core_name, *eip_name, *nand_name;
 	struct clk_hw_onecell_data *cp110_clk_data;
 	struct clk_hw *hw, **cp110_clks;
 	u32 nand_clk_ctrl;
 	int i, ret;
+	char *gate_name[ARRAY_SIZE(gate_base_names)];
 
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -205,7 +250,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	cp110_clk_data = devm_kzalloc(&pdev->dev, sizeof(*cp110_clk_data) +
+	cp110_clk_data = devm_kzalloc(dev, sizeof(*cp110_clk_data) +
 				      sizeof(struct clk_hw *) * CP110_CLK_NUM,
 				      GFP_KERNEL);
 	if (!cp110_clk_data)
@@ -215,8 +260,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	cp110_clk_data->num = CP110_CLK_NUM;
 
 	/* Register the APLL which is the root of the hw tree */
-	of_property_read_string_index(np, "core-clock-output-names",
-				      CP110_CORE_APLL, &apll_name);
+	apll_name = cp110_unique_name(dev, "apll");
 	hw = clk_hw_register_fixed_rate(NULL, apll_name, NULL, 0,
 					1000 * 1000 * 1000);
 	if (IS_ERR(hw)) {
@@ -227,8 +271,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	cp110_clks[CP110_CORE_APLL] = hw;
 
 	/* PPv2 is APLL/3 */
-	of_property_read_string_index(np, "core-clock-output-names",
-				      CP110_CORE_PPV2, &ppv2_name);
+	ppv2_name = cp110_unique_name(dev, "ppv2-core");
 	hw = clk_hw_register_fixed_factor(NULL, ppv2_name, apll_name, 0, 1, 3);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
@@ -238,8 +281,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	cp110_clks[CP110_CORE_PPV2] = hw;
 
 	/* EIP clock is APLL/2 */
-	of_property_read_string_index(np, "core-clock-output-names",
-				      CP110_CORE_EIP, &eip_name);
+	eip_name = cp110_unique_name(dev, "eip");
 	hw = clk_hw_register_fixed_factor(NULL, eip_name, apll_name, 0, 1, 2);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
@@ -249,8 +291,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	cp110_clks[CP110_CORE_EIP] = hw;
 
 	/* Core clock is EIP/2 */
-	of_property_read_string_index(np, "core-clock-output-names",
-				      CP110_CORE_CORE, &core_name);
+	core_name = cp110_unique_name(dev, "core");
 	hw = clk_hw_register_fixed_factor(NULL, core_name, eip_name, 0, 1, 2);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
@@ -258,10 +299,8 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	}
 
 	cp110_clks[CP110_CORE_CORE] = hw;
-
 	/* NAND can be either APLL/2.5 or core clock */
-	of_property_read_string_index(np, "core-clock-output-names",
-				      CP110_CORE_NAND, &nand_name);
+	nand_name = cp110_unique_name(dev, "nand-core");
 	if (nand_clk_ctrl & NF_CLOCK_SEL_400_MASK)
 		hw = clk_hw_register_fixed_factor(NULL, nand_name,
 						   apll_name, 0, 2, 5);
@@ -275,18 +314,14 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 
 	cp110_clks[CP110_CORE_NAND] = hw;
 
-	for (i = 0; i < CP110_MAX_GATABLE_CLOCKS; i++) {
-		const char *parent, *name;
-		int ret;
-
-		ret = of_property_read_string_index(np,
-						    "gate-clock-output-names",
-						    i, &name);
-		/* Reached the end of the list? */
-		if (ret < 0)
-			break;
+	/* create the unique name for all the gate clocks */
+	for (i = 0; i < ARRAY_SIZE(gate_base_names); i++)
+		gate_name[i] =	cp110_unique_name(dev, gate_base_names[i]);
 
-		if (!strcmp(name, "none"))
+	for (i = 0; i < ARRAY_SIZE(gate_base_names); i++) {
+		const char *parent;
+
+		if (gate_name[i] == NULL)
 			continue;
 
 		switch (i) {
@@ -295,14 +330,10 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 		case CP110_GATE_EIP150:
 		case CP110_GATE_EIP197:
 		case CP110_GATE_SLOW_IO:
-			of_property_read_string_index(np,
-						      "gate-clock-output-names",
-						      CP110_GATE_MAIN, &parent);
+			parent = gate_name[CP110_GATE_MAIN];
 			break;
 		case CP110_GATE_MG:
-			of_property_read_string_index(np,
-						      "gate-clock-output-names",
-						      CP110_GATE_MG_CORE, &parent);
+			parent = gate_name[CP110_GATE_MG_CORE];
 			break;
 		case CP110_GATE_NAND:
 			parent = nand_name;
@@ -312,34 +343,27 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 			break;
 		case CP110_GATE_SDIO:
 		case CP110_GATE_GOP_DP:
-			of_property_read_string_index(np,
-						      "gate-clock-output-names",
-						      CP110_GATE_GOP, &parent);
-
+			parent = gate_name[CP110_GATE_GOP];
 			break;
 		case CP110_GATE_XOR1:
 		case CP110_GATE_XOR0:
 		case CP110_GATE_PCIE_X1_0:
 		case CP110_GATE_PCIE_X1_1:
 		case CP110_GATE_PCIE_X4:
-			of_property_read_string_index(np,
-						      "gate-clock-output-names",
-						      CP110_GATE_PCIE_XOR, &parent);
+			parent = gate_name[CP110_GATE_PCIE_XOR];
 			break;
 		case CP110_GATE_SATA:
 		case CP110_GATE_USB3H0:
 		case CP110_GATE_USB3H1:
 		case CP110_GATE_USB3DEV:
-			of_property_read_string_index(np,
-						      "gate-clock-output-names",
-						      CP110_GATE_SATA_USB, &parent);
+			parent = gate_name[CP110_GATE_SATA_USB];
 			break;
 		default:
 			parent = core_name;
 			break;
 		}
+		hw = cp110_register_gate(gate_name[i], parent, regmap, i);
 
-		hw = cp110_register_gate(name, parent, regmap, i);
 		if (IS_ERR(hw)) {
 			ret = PTR_ERR(hw);
 			goto fail_gate;
-- 
git-series 0.9.1
