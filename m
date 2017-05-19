From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 17:55:23 +0200
Subject: [PATCH 5/7] clk: mvebu: cp110: add sdio clock to cp-110 system
 controller
In-Reply-To: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
References: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
Message-ID: <1833f47fdfa5fd05e9135d98e03501d9634a865b.1495208533.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Konstantin Porotchkin <kostap@marvell.com>

This commit updates the CP110 system controller driver to add the
definition for a missing clock.

The SDIO clock is dedicated driving the SDHCI interface and its frequency
is 400MHz (2/5 of PLL source clock).

The SDIO interface should be bound to this clock and not the core clock
as in the older code.
Using the wrong clock lead to a maximum SDHCI frequency of 250 Mhz, while
the HW really supports up to 400 Mhz.

This patch also fixes the NAND clock relationship documentation.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
[gregory.clement at free-electrons.com:
- use sdio instead of emmc to name the clock
- update binding documentation]
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt |  1 +
 drivers/clk/mvebu/cp110-system-controller.c                                | 28 +++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
index 139e46cc6786..e0b9ef5d3dde 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
@@ -34,6 +34,7 @@ The following clocks are available:
    - 0 2	EIP
    - 0 3	Core
    - 0 4	NAND core
+   - 0 5	SDIO core
  - Gatable clocks
    - 1 0	Audio
    - 1 1	Comm Unit
diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index ecbcae321424..8be7ae25c7eb 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -11,15 +11,16 @@
  */
 
 /*
- * CP110 has 5 core clocks:
+ * CP110 has 6 core clocks:
  *
  *  - APLL		(1 Ghz)
  *    - PPv2 core	(1/3 APLL)
  *    - EIP		(1/2 APLL)
- *      - Core		(1/2 EIP)
+ *     - Core		(1/2 EIP)
+ *    - SDIO		(2/5 APLL)
  *
  *  - NAND clock, which is either:
- *    - Equal to the core clock
+ *    - Equal to SDIO clock
  *    - 2/5 APLL
  *
  * CP110 has 32 gatable clocks, for the various peripherals in the
@@ -46,7 +47,7 @@ enum {
 	CP110_CLK_TYPE_GATABLE,
 };
 
-#define CP110_MAX_CORE_CLOCKS		5
+#define CP110_MAX_CORE_CLOCKS		6
 #define CP110_MAX_GATABLE_CLOCKS	32
 
 #define CP110_CLK_NUM \
@@ -57,6 +58,7 @@ enum {
 #define CP110_CORE_EIP			2
 #define CP110_CORE_CORE			3
 #define CP110_CORE_NAND			4
+#define CP110_CORE_SDIO			5
 
 /* A number of gatable clocks need special handling */
 #define CP110_GATE_AUDIO		0
@@ -235,7 +237,8 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
 	struct regmap *regmap;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	const char *ppv2_name, *apll_name, *core_name, *eip_name, *nand_name;
+	const char *ppv2_name, *apll_name, *core_name, *eip_name, *nand_name,
+		*sdio_name;
 	struct clk_hw_onecell_data *cp110_clk_data;
 	struct clk_hw *hw, **cp110_clks;
 	u32 nand_clk_ctrl;
@@ -315,6 +318,17 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
 
 	cp110_clks[CP110_CORE_NAND] = hw;
 
+	/* SDIO clock is APLL/2.5 */
+	sdio_name = cp110_unique_name(dev, syscon_node, "sdio-core");
+	hw = clk_hw_register_fixed_factor(NULL, sdio_name,
+					  apll_name, 0, 2, 5);
+	if (IS_ERR(hw)) {
+		ret = PTR_ERR(hw);
+		goto fail_sdio;
+	}
+
+	cp110_clks[CP110_CORE_SDIO] = hw;
+
 	/* create the unique name for all the gate clocks */
 	for (i = 0; i < ARRAY_SIZE(gate_base_names); i++)
 		gate_name[i] =	cp110_unique_name(dev, syscon_node,
@@ -344,6 +358,8 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
 			parent = ppv2_name;
 			break;
 		case CP110_GATE_SDIO:
+			parent = sdio_name;
+			break;
 		case CP110_GATE_GOP_DP:
 			parent = gate_name[CP110_GATE_GOP];
 			break;
@@ -391,6 +407,8 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
 			cp110_unregister_gate(hw);
 	}
 
+	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_SDIO]);
+fail_sdio:
 	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_NAND]);
 fail_nand:
 	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_CORE]);
-- 
git-series 0.9.1
