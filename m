From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 11 Jan 2017 18:19:04 +0100
Subject: [PATCH v5 01/12] clk: apn806: Add eMMC clock to system controller
 driver
In-Reply-To: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
Message-ID: <e84d52dfbd9f7d2a14a5ec9d53918119fdc90404.1484154449.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Konstantin Porotchkin <kostap@marvell.com>

Add fixed clock of 400MHz to system controller driver.  This clock is
used as SD/eMMC clock source.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
Reviewed-by: Omri Itach <omrii@marvell.com>
Reviewed-by: Hanna Hawa <hannah@marvell.com>
[fixed up conflicts, added error handling --rmk]
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi |  3 ++-
 drivers/clk/mvebu/ap806-system-controller.c   | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index a749ba2edec4..5019c8f4acd0 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -235,7 +235,8 @@
 				#clock-cells = <1>;
 				clock-output-names = "ap-cpu-cluster-0",
 						     "ap-cpu-cluster-1",
-						     "ap-fixed", "ap-mss";
+						     "ap-fixed", "ap-mss",
+						     "ap-emmc";
 				reg = <0x6f4000 0x1000>;
 			};
 		};
diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
index 8181b919f062..0a785076b0c6 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -23,7 +23,7 @@
 #define AP806_SAR_REG			0x400
 #define AP806_SAR_CLKFREQ_MODE_MASK	0x1f
 
-#define AP806_CLK_NUM			4
+#define AP806_CLK_NUM			5
 
 static struct clk *ap806_clks[AP806_CLK_NUM];
 
@@ -117,6 +117,17 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 		goto fail3;
 	}
 
+	/* eMMC Clock is fixed clock divided by 3 */
+	of_property_read_string_index(np, "clock-output-names",
+				      4, &name);
+	ap806_clks[4] = clk_register_fixed_factor(NULL, name, fixedclk_name,
+						  0, 1, 3);
+	if (IS_ERR(ap806_clks[4])) {
+		ret = PTR_ERR(ap806_clks[4]);
+		goto fail4;
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_clk_data);
 	ret = of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_clk_data);
 	if (ret)
 		goto fail_clk_add;
@@ -124,6 +135,8 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	return 0;
 
 fail_clk_add:
+	clk_unregister_fixed_factor(ap806_clks[4]);
+fail4:
 	clk_unregister_fixed_factor(ap806_clks[3]);
 fail3:
 	clk_unregister_fixed_rate(ap806_clks[2]);
-- 
git-series 0.9.1
