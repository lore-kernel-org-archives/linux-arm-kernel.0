From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 17:58:02 +0200
Subject: [PATCH 2/5] clk: mvebu: ap806: do not depend anymore of the
 *-clock-output-names
In-Reply-To: <cover.fd6093dbad53cdac70eef4e53b238768721218ac.1495209464.git-series.gregory.clement@free-electrons.com>
References: <cover.fd6093dbad53cdac70eef4e53b238768721218ac.1495209464.git-series.gregory.clement@free-electrons.com>
Message-ID: <83d2035a1d00773c8e4c4d09134c81b0cd24152c.1495209464.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it was done for the cp110, this patch modifies the way the clock names
are created. The name of each clock is now created by using its physical
address as a prefix (as it was done for the platform device
names). Thanks to this we have an automatic way to compute a unique name.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt |  4 ----
 drivers/clk/mvebu/ap806-system-controller.c                               | 46 ++++++++++++++++++++++++----------------------
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 8968371d84e2..3faab71dff9f 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -21,15 +21,11 @@ Required properties:
      "marvell,ap806-system-controller", "syscon"
  - reg: register area of the AP806 system controller
  - #clock-cells: must be set to 1
- - clock-output-names: must be defined to:
-    "ap-cpu-cluster-0", "ap-cpu-cluster-1", "ap-fixed", "ap-mss"
 
 Example:
 
 	syscon: system-controller at 6f4000 {
 		compatible = "marvell,ap806-system-controller", "syscon";
 		#clock-cells = <1>;
-		clock-output-names = "ap-cpu-cluster-0", "ap-cpu-cluster-1",
-				     "ap-fixed", "ap-mss";
 		reg = <0x6f4000 0x1000>;
 	};
diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
index b2666b5c944f..95ae16e203ea 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -32,6 +32,18 @@ static struct clk_onecell_data ap806_clk_data = {
 	.clk_num = AP806_CLK_NUM,
 };
 
+static char *ap806_unique_name(struct device *dev, struct device_node *np,
+			       char *name)
+{
+	const __be32 *reg;
+	u64 addr;
+
+	reg = of_get_property(np, "reg", NULL);
+	addr = of_translate_address(np, reg);
+	return devm_kasprintf(dev, GFP_KERNEL, "%llx-%s",
+			(unsigned long long)addr, name);
+}
+
 static int ap806_syscon_clk_probe(struct platform_device *pdev)
 {
 	unsigned int freq_mode, cpuclk_freq;
@@ -98,8 +110,7 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	cpuclk_freq *= 1000 * 1000;
 
 	/* CPU clocks depend on the Sample At Reset configuration */
-	of_property_read_string_index(np, "clock-output-names",
-				      0, &name);
+	name = ap806_unique_name(dev, np, "cpu-cluster-0");
 	ap806_clks[0] = clk_register_fixed_rate(dev, name, NULL,
 						0, cpuclk_freq);
 	if (IS_ERR(ap806_clks[0])) {
@@ -107,8 +118,7 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 		goto fail0;
 	}
 
-	of_property_read_string_index(np, "clock-output-names",
-				      1, &name);
+	name = ap806_unique_name(dev, np, "cpu-cluster-1");
 	ap806_clks[1] = clk_register_fixed_rate(dev, name, NULL, 0,
 						cpuclk_freq);
 	if (IS_ERR(ap806_clks[1])) {
@@ -117,8 +127,7 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	}
 
 	/* Fixed clock is always 1200 Mhz */
-	of_property_read_string_index(np, "clock-output-names",
-				      2, &fixedclk_name);
+	fixedclk_name = ap806_unique_name(dev, np, "fixed");
 	ap806_clks[2] = clk_register_fixed_rate(dev, fixedclk_name, NULL,
 						0, 1200 * 1000 * 1000);
 	if (IS_ERR(ap806_clks[2])) {
@@ -127,8 +136,7 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	}
 
 	/* MSS Clock is fixed clock divided by 6 */
-	of_property_read_string_index(np, "clock-output-names",
-				      3, &name);
+	name = ap806_unique_name(dev, np, "mss");
 	ap806_clks[3] = clk_register_fixed_factor(NULL, name, fixedclk_name,
 						  0, 1, 6);
 	if (IS_ERR(ap806_clks[3])) {
@@ -136,20 +144,14 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 		goto fail3;
 	}
 
-	/* eMMC Clock is fixed clock divided by 3 */
-	if (of_property_read_string_index(np, "clock-output-names",
-					  4, &name)) {
-		ap806_clk_data.clk_num--;
-		dev_warn(&pdev->dev,
-			 "eMMC clock missing: update the device tree!\n");
-	} else {
-		ap806_clks[4] = clk_register_fixed_factor(NULL, name,
-							  fixedclk_name,
-							  0, 1, 3);
-		if (IS_ERR(ap806_clks[4])) {
-			ret = PTR_ERR(ap806_clks[4]);
-			goto fail4;
-		}
+	/* SDIO(/eMMC) Clock is fixed clock divided by 3 */
+	name = ap806_unique_name(dev, np, "sdio");
+	ap806_clks[4] = clk_register_fixed_factor(NULL, name,
+						  fixedclk_name,
+						  0, 1, 3);
+	if (IS_ERR(ap806_clks[4])) {
+		ret = PTR_ERR(ap806_clks[4]);
+		goto fail4;
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_clk_data);
-- 
git-series 0.9.1
