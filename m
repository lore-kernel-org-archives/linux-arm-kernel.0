From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  3 Mar 2015 10:21:58 +0800
Subject: [PATCH 1/3] clk: sunxi: sun6i-apb0: Add support for sun9i A80 apbs
 gates
In-Reply-To: <1425349320-2754-1-git-send-email-wens@csie.org>
References: <1425349320-2754-1-git-send-email-wens@csie.org>
Message-ID: <1425349320-2754-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the PRCM apbs clock gates found on the
Allwinner A80 SoC.

The gate bitmask is not complete. The lowest 7 bits seem to be the
same as found on the A31, judging by Allwinner's kernel sources and
what was enabled by the bootloader. Bits 17 and 18 are documented
in the SDK sources.

This still leaves some peripherals missing, such as the dma controller,
a second i2c controller, and 2 PS/2 controllers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c          | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 3f1dcd879af7..60c85071d022 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -54,6 +54,7 @@ Required properties:
 	"allwinner,sun9i-a80-apb1-gates-clk" - for the APB1 gates on A80
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
+	"allwinner,sun9i-a80-apbs-gates-clk" - for the APBS gates on A80
 	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
 	"allwinner,sun4i-a10-mmc-clk" - for the MMC clock
 	"allwinner,sun9i-a80-mmc-clk" - for mmc module clocks on A80
diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index 64f3e46d383c..0039b7375a40 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -29,9 +29,15 @@ static const struct gates_data sun8i_a23_apb0_gates __initconst = {
 	.mask = {0x5D},
 };
 
+/* XXX This is an imcomplete mask due to a lack of documents */
+static const struct gates_data sun9i_a80_apbs_gates __initconst = {
+	.mask = {0x6007f},
+};
+
 static const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-apb0-gates-clk", .data = &sun6i_a31_apb0_gates },
 	{ .compatible = "allwinner,sun8i-a23-apb0-gates-clk", .data = &sun8i_a23_apb0_gates },
+	{ .compatible = "allwinner,sun9i-a80-apbs-gates-clk", .data = &sun9i_a80_apbs_gates },
 	{ /* sentinel */ }
 };
 
-- 
2.1.4
