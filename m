From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  1 Feb 2016 17:39:26 +0000
Subject: [PATCH 07/11] clk: sunxi: add generic allwinner,sunxi name
In-Reply-To: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1454348370-3816-8-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only difference between the different compatible matches at the
end of clk-sunxi.c are the critical clocks. Two SoCs get away so far
without any, so there is no reason to enumerate those SoCs in here
explicitly, though we have to keep them in for compatibility reasons.

Rename the init function to highlight this generic feature and add a
new, generic DT compatible string which can be used as a fallback value
in the future should a particular SoC don't need any special treatment.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/arm/sunxi.txt |  4 ++++
 drivers/clk/sunxi/clk-sunxi.c                   | 14 ++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index 7e79fcc..980e065 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -14,3 +14,7 @@ using one of the following compatible strings:
   allwinner,sun8i-a83t
   allwinner,sun8i-h3
   allwinner,sun9i-a80
+
+For Allwinner SoCs without any specific needs the generic fallback value of:
+  allwinner,sunxi
+can be used.
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index e460a6b..efcce85 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1052,14 +1052,12 @@ CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
 CLK_OF_DECLARE(sun8i_a33_clk_init, "allwinner,sun8i-a33", sun6i_init_clocks);
 CLK_OF_DECLARE(sun8i_h3_clk_init, "allwinner,sun8i-h3", sun6i_init_clocks);
 
-static void __init sun8i_a83t_init_clocks(struct device_node *node)
+static void __init sunxi_generic_init_clocks(struct device_node *node)
 {
 	sunxi_init_clocks(NULL, 0);
 }
-CLK_OF_DECLARE(sun8i_a83t_clk_init, "allwinner,sun8i-a83t", sun8i_a83t_init_clocks);
-
-static void __init sun9i_init_clocks(struct device_node *node)
-{
-	sunxi_init_clocks(NULL, 0);
-}
-CLK_OF_DECLARE(sun9i_a80_clk_init, "allwinner,sun9i-a80", sun9i_init_clocks);
+CLK_OF_DECLARE(sun8i_a83t_clk_init, "allwinner,sun8i-a83t",
+	       sunxi_generic_init_clocks);
+CLK_OF_DECLARE(sun9i_a80_clk_init, "allwinner,sun9i-a80",
+	       sunxi_generic_init_clocks);
+CLK_OF_DECLARE(sunxi_clk_init, "allwinner,sunxi", sunxi_generic_init_clocks);
-- 
2.6.4
