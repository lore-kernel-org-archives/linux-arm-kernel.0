From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 13 Jun 2014 21:21:23 -0500
Subject: [PATCH] clk: socfpga: Add a second parent option for the dbg_base_clk
Message-ID: <1402712483-2784-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The debug base clock can be bypassed from the main PLL to the OSC1 clock.
The bypass register is the staysoc1(0x10) register that is in the clock
manager.

This patch adds the option to get the correct parent for the debug base
clock.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi   |    2 +-
 drivers/clk/socfpga/clk-periph.c |    9 +++++++++
 drivers/clk/socfpga/clk.h        |    1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 291eff1..26d755b 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -139,7 +139,7 @@
 						dbg_base_clk: dbg_base_clk {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
-							clocks = <&main_pll>;
+							clocks = <&main_pll>, <&osc1>;
 							div-reg = <0xe8 0 9>;
 							reg = <0x50>;
 						};
diff --git a/drivers/clk/socfpga/clk-periph.c b/drivers/clk/socfpga/clk-periph.c
index 46531c3..744785d 100644
--- a/drivers/clk/socfpga/clk-periph.c
+++ b/drivers/clk/socfpga/clk-periph.c
@@ -45,8 +45,17 @@ static unsigned long clk_periclk_recalc_rate(struct clk_hw *hwclk,
 	return parent_rate / div;
 }
 
+static u8 clk_periclk_get_parent(struct clk_hw *hwclk)
+{
+	u32 clk_src;
+
+	clk_src = readl(clk_mgr_base_addr + CLKMGR_DBCTRL);
+	return clk_src & 0x1;
+}
+
 static const struct clk_ops periclk_ops = {
 	.recalc_rate = clk_periclk_recalc_rate,
+	.get_parent = clk_periclk_get_parent,
 };
 
 static __init void __socfpga_periph_init(struct device_node *node,
diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
index d291f60..d036de2 100644
--- a/drivers/clk/socfpga/clk.h
+++ b/drivers/clk/socfpga/clk.h
@@ -23,6 +23,7 @@
 /* Clock Manager offsets */
 #define CLKMGR_CTRL		0x0
 #define CLKMGR_BYPASS		0x4
+#define CLKMGR_DBCTRL		0x10
 #define CLKMGR_L4SRC		0x70
 #define CLKMGR_PERPLL_SRC	0xAC
 
-- 
1.7.9.5
