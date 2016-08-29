From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 29 Aug 2016 14:26:54 +0200
Subject: [PATCH v3 02/14] drivers: clk: st: Simplify clock binding of STiH4xx
 platforms
In-Reply-To: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1472473626-15398-3-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch reworks the clock binding to avoid too much detail in DT.
Now we have only compatible string per type of clock
(remark from Rob https://lkml.org/lkml/2016/5/25/492)

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/clock/st/st,clkgen-mux.txt |  2 +-
 .../devicetree/bindings/clock/st/st,clkgen-pll.txt | 11 ++--
 .../devicetree/bindings/clock/st/st,clkgen.txt     |  2 +-
 .../devicetree/bindings/clock/st/st,quadfs.txt     |  6 +--
 drivers/clk/st/clkgen-fsyn.c                       | 41 ++++++--------
 drivers/clk/st/clkgen-mux.c                        | 28 ++++------
 drivers/clk/st/clkgen-pll.c                        | 63 ++++++++++------------
 7 files changed, 65 insertions(+), 88 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
index 4d277d6..9a46cb1 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
@@ -10,7 +10,7 @@ This binding uses the common clock binding[1].
 Required properties:
 
 - compatible : shall be:
-	"st,stih407-clkgen-a9-mux",	"st,clkgen-mux"
+	"st,stih407-clkgen-a9-mux"
 
 - #clock-cells : from common clock binding; shall be set to 0.
 
diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
index c9fd674..f207053 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
@@ -9,11 +9,10 @@ Base address is located to the parent node. See clock binding[2]
 Required properties:
 
 - compatible : shall be:
-	"st,stih407-plls-c32-a0",	"st,clkgen-plls-c32"
-	"st,stih407-plls-c32-a9",	"st,clkgen-plls-c32"
-	"sst,plls-c32-cx_0",		"st,clkgen-plls-c32"
-	"sst,plls-c32-cx_1",		"st,clkgen-plls-c32"
-	"st,stih418-plls-c28-a9",	"st,clkgen-plls-c32"
+	"st,clkgen-pll0"
+	"st,clkgen-pll1"
+	"st,stih407-clkgen-plla9"
+	"st,stih418-clkgen-plla9"
 
 - #clock-cells : From common clock binding; shall be set to 1.
 
@@ -29,7 +28,7 @@ Example:
 
 		clockgen_a9_pll: clockgen-a9-pll {
 			#clock-cells = <1>;
-			compatible = "st,stih407-plls-c32-a9", "st,clkgen-plls-c32";
+			compatible = "st,stih407-clkgen-plla9";
 
 			clocks = <&clk_sysin>;
 
diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
index c764d6b..c35390f 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
@@ -48,7 +48,7 @@ Example:
 
 		clk_s_a0_pll: clk-s-a0-pll {
 			#clock-cells = <1>;
-			compatible = "st,stih407-plls-c32-a0", "st,clkgen-plls-c32";
+			compatible = "st,clkgen-pll0";
 
 			clocks = <&clk_sysin>;
 
diff --git a/Documentation/devicetree/bindings/clock/st/st,quadfs.txt b/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
index 6d81b11..d93d493 100644
--- a/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
@@ -11,8 +11,8 @@ This binding uses the common clock binding[1].
 
 Required properties:
 - compatible : shall be:
-  "st,stih407-quadfs660-C",	"st,quadfs"
-  "st,stih407-quadfs660-D",	"st,quadfs"
+  "st,quadfs"
+  "st,quadfs-pll"
 
 
 - #clock-cells : from common clock binding; shall be set to 1.
@@ -33,7 +33,7 @@ Example:
 
 	clk_s_c0_quadfs: clk-s-c0-quadfs at 9103000 {
 		#clock-cells = <1>;
-		compatible = "st,stih407-quadfs660-C", "st,quadfs";
+		compatible = "st,quadfs-pll";
 		reg = <0x9103000 0x1000>;
 
 		clocks = <&clk_sysin>;
diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 942c187..2f11bbd 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -819,18 +819,6 @@ static struct clk * __init st_clk_register_quadfs_fsynth(
 	return clk;
 }
 
-static const struct of_device_id quadfs_of_match[] = {
-	{
-		.compatible = "st,stih407-quadfs660-C",
-		.data = &st_fs660c32_C
-	},
-	{
-		.compatible = "st,stih407-quadfs660-D",
-		.data = &st_fs660c32_D
-	},
-	{}
-};
-
 static void __init st_of_create_quadfs_fsynths(
 		struct device_node *np, const char *pll_name,
 		struct clkgen_quadfs_data *quadfs, void __iomem *reg,
@@ -890,18 +878,14 @@ static void __init st_of_create_quadfs_fsynths(
 	of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
 }
 
-static void __init st_of_quadfs_setup(struct device_node *np)
+static void __init st_of_quadfs_setup(struct device_node *np,
+		struct clkgen_quadfs_data *data)
 {
-	const struct of_device_id *match;
 	struct clk *clk;
 	const char *pll_name, *clk_parent_name;
 	void __iomem *reg;
 	spinlock_t *lock;
 
-	match = of_match_node(quadfs_of_match, np);
-	if (WARN_ON(!match))
-		return;
-
 	reg = of_iomap(np, 0);
 	if (!reg)
 		return;
@@ -920,8 +904,8 @@ static void __init st_of_quadfs_setup(struct device_node *np)
 
 	spin_lock_init(lock);
 
-	clk = st_clk_register_quadfs_pll(pll_name, clk_parent_name,
-			(struct clkgen_quadfs_data *) match->data, reg, lock);
+	clk = st_clk_register_quadfs_pll(pll_name, clk_parent_name, data,
+			reg, lock);
 	if (IS_ERR(clk))
 		goto err_exit;
 	else
@@ -930,11 +914,20 @@ static void __init st_of_quadfs_setup(struct device_node *np)
 			__clk_get_name(clk_get_parent(clk)),
 			(unsigned int)clk_get_rate(clk));
 
-	st_of_create_quadfs_fsynths(np, pll_name,
-				    (struct clkgen_quadfs_data *)match->data,
-				    reg, lock);
+	st_of_create_quadfs_fsynths(np, pll_name, data, reg, lock);
 
 err_exit:
 	kfree(pll_name); /* No longer need local copy of the PLL name */
 }
-CLK_OF_DECLARE(quadfs, "st,quadfs", st_of_quadfs_setup);
+
+static void __init st_of_quadfs660C_setup(struct device_node *np)
+{
+	st_of_quadfs_setup(np, (struct clkgen_quadfs_data *) &st_fs660c32_C);
+}
+CLK_OF_DECLARE(quadfs660C, "st,quadfs-pll", st_of_quadfs660C_setup);
+
+static void __init st_of_quadfs660D_setup(struct device_node *np)
+{
+	st_of_quadfs_setup(np, (struct clkgen_quadfs_data *) &st_fs660c32_D);
+}
+CLK_OF_DECLARE(quadfs660D, "st,quadfs", st_of_quadfs660D_setup);
diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index 6fdb1ab..c514d39 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -53,29 +53,13 @@ static struct clkgen_mux_data stih407_a9_mux_data = {
 	.lock = &clkgen_a9_lock,
 };
 
-static const struct of_device_id mux_of_match[] = {
-	{
-		.compatible = "st,stih407-clkgen-a9-mux",
-		.data = &stih407_a9_mux_data,
-	},
-	{}
-};
-static void __init st_of_clkgen_mux_setup(struct device_node *np)
+static void __init st_of_clkgen_mux_setup(struct device_node *np,
+		struct clkgen_mux_data *data)
 {
-	const struct of_device_id *match;
 	struct clk *clk;
 	void __iomem *reg;
 	const char **parents;
 	int num_parents = 0;
-	const struct clkgen_mux_data *data;
-
-	match = of_match_node(mux_of_match, np);
-	if (!match) {
-		pr_err("%s: No matching data\n", __func__);
-		return;
-	}
-
-	data = match->data;
 
 	reg = of_iomap(np, 0);
 	if (!reg) {
@@ -112,4 +96,10 @@ err:
 err_parents:
 	iounmap(reg);
 }
-CLK_OF_DECLARE(clkgen_mux, "st,clkgen-mux", st_of_clkgen_mux_setup);
+
+static void __init st_of_clkgen_a9_mux_setup(struct device_node *np)
+{
+	st_of_clkgen_mux_setup(np, &stih407_a9_mux_data);
+}
+CLK_OF_DECLARE(clkgen_a9mux, "st,stih407-clkgen-a9-mux",
+		st_of_clkgen_a9_mux_setup);
diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 8a1b1cf..25bda48 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -702,48 +702,17 @@ static struct clk * __init clkgen_odf_register(const char *parent_name,
 	return clk;
 }
 
-static const struct of_device_id c32_pll_of_match[] = {
-	{
-		.compatible = "st,stih407-plls-c32-a0",
-		.data = &st_pll3200c32_407_a0,
-	},
-	{
-		.compatible = "st,plls-c32-cx_0",
-		.data = &st_pll3200c32_cx_0,
-	},
-	{
-		.compatible = "st,plls-c32-cx_1",
-		.data = &st_pll3200c32_cx_1,
-	},
-	{
-		.compatible = "st,stih407-plls-c32-a9",
-		.data = &st_pll3200c32_407_a9,
-	},
-	{
-		.compatible = "st,stih418-plls-c28-a9",
-		.data = &st_pll4600c28_418_a9,
-	},
-	{}
-};
 
-static void __init clkgen_c32_pll_setup(struct device_node *np)
+static void __init clkgen_c32_pll_setup(struct device_node *np,
+		struct clkgen_pll_data *data)
 {
-	const struct of_device_id *match;
 	struct clk *clk;
 	const char *parent_name, *pll_name;
 	void __iomem *pll_base;
 	int num_odfs, odf;
 	struct clk_onecell_data *clk_data;
-	struct clkgen_pll_data	*data;
 	unsigned long pll_flags = 0;
 
-	match = of_match_node(c32_pll_of_match, np);
-	if (!match) {
-		pr_err("%s: No matching data\n", __func__);
-		return;
-	}
-
-	data = (struct clkgen_pll_data *) match->data;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 	if (!parent_name)
@@ -802,4 +771,30 @@ err:
 	kfree(clk_data->clks);
 	kfree(clk_data);
 }
-CLK_OF_DECLARE(clkgen_c32_pll, "st,clkgen-plls-c32", clkgen_c32_pll_setup);
+static void __init clkgen_c32_pll0_setup(struct device_node *np)
+{
+	clkgen_c32_pll_setup(np,
+			(struct clkgen_pll_data *) &st_pll3200c32_cx_0);
+}
+CLK_OF_DECLARE(c32_pll0, "st,clkgen-pll0", clkgen_c32_pll0_setup);
+
+static void __init clkgen_c32_pll1_setup(struct device_node *np)
+{
+	clkgen_c32_pll_setup(np,
+			(struct clkgen_pll_data *) &st_pll3200c32_cx_1);
+}
+CLK_OF_DECLARE(c32_pll1, "st,clkgen-pll1", clkgen_c32_pll1_setup);
+
+static void __init clkgen_c32_plla9_setup(struct device_node *np)
+{
+	clkgen_c32_pll_setup(np,
+			(struct clkgen_pll_data *) &st_pll3200c32_407_a9);
+}
+CLK_OF_DECLARE(c32_plla9, "st,stih407-clkgen-plla9", clkgen_c32_plla9_setup);
+
+static void __init clkgen_c28_plla9_setup(struct device_node *np)
+{
+	clkgen_c32_pll_setup(np,
+			(struct clkgen_pll_data *) &st_pll4600c28_418_a9);
+}
+CLK_OF_DECLARE(c28_plla9, "st,stih418-clkgen-plla9", clkgen_c28_plla9_setup);
-- 
1.9.1
