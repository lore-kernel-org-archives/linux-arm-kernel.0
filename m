From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  5 Dec 2015 21:16:42 +0800
Subject: [PATCH resend 1/6] clk: sunxi: Add DRAM gates support for sun4i-a10
In-Reply-To: <1449321407-4531-1-git-send-email-wens@csie.org>
References: <1449321407-4531-1-git-send-email-wens@csie.org>
Message-ID: <1449321407-4531-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10/A20 share the same set of DRAM clock gates, which controls
direct memory access for some peripherals.

On the A10, bit 15 controls the system's DRAM clock output (possibly
to the DRAM chips), which we need to keep on.

On the A20 this has been moved to the DRAM controller, becoming a no-op.
However it is still listed in the user manual, so add it anyway.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/clk-simple-gates.c              | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 153ac72869e8..ef0b452806b1 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -57,6 +57,7 @@ Required properties:
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
 	"allwinner,sun9i-a80-apbs-gates-clk" - for the APBS gates on A80
+	"allwinner,sun4i-a10-dram-gates-clk" - for the DRAM gates on A10
 	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
 	"allwinner,sun4i-a10-mmc-clk" - for the MMC clock
 	"allwinner,sun9i-a80-mmc-clk" - for mmc module clocks on A80
diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index c8acc0612c15..f4da52b5ca0e 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -160,3 +160,15 @@ CLK_OF_DECLARE(sun5i_a13_ahb, "allwinner,sun5i-a13-ahb-gates-clk",
 	       sun4i_a10_ahb_init);
 CLK_OF_DECLARE(sun7i_a20_ahb, "allwinner,sun7i-a20-ahb-gates-clk",
 	       sun4i_a10_ahb_init);
+
+static const int sun4i_a10_dram_critical_clocks[] __initconst = {
+	15,	/* dram_output */
+};
+
+static void __init sun4i_a10_dram_init(struct device_node *node)
+{
+	sunxi_simple_gates_setup(node, sun4i_a10_dram_critical_clocks,
+				 ARRAY_SIZE(sun4i_a10_dram_critical_clocks));
+}
+CLK_OF_DECLARE(sun4i_a10_dram, "allwinner,sun4i-a10-dram-gates-clk",
+	       sun4i_a10_dram_init);
-- 
2.6.2
