From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 17 Jul 2016 00:15:23 +0900
Subject: [PATCH] clk: zynq: avoid retrieving clock names from DT property
Message-ID: <1468682123-1434-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "clock-output-names" property is useful for generic clock
providers such as fixed-clock, fixed-factor-clock, etc.

On the other hand, it should not be used for really SoC-specific
clock providers like this one.  As you see in "enum zynq_clk" in
this driver, it is written as if it already knows all the clock
names.  Besides, this is instantiated only once, so no clock name
conflict would happen even if the clock names are hard-coded in the
driver.

The device tree (arch/arm/boot/dts/zynq-7000.dtsi) will be fixed
later.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This patch was tested on Zynq Zedboard.


 .../devicetree/bindings/clock/zynq-7000.txt         | 13 -------------
 drivers/clk/zynq/clkc.c                             | 21 ++++++++++++---------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/zynq-7000.txt b/Documentation/devicetree/bindings/clock/zynq-7000.txt
index d93746c..562ff3f 100644
--- a/Documentation/devicetree/bindings/clock/zynq-7000.txt
+++ b/Documentation/devicetree/bindings/clock/zynq-7000.txt
@@ -17,8 +17,6 @@ Required properties:
  - reg : SLCR offset and size taken via syscon < 0x100 0x100 >
  - ps-clk-frequency : Frequency of the oscillator providing ps_clk in HZ
 		      (usually 33 MHz oscillators are used for Zynq platforms)
- - clock-output-names : List of strings used to name the clock outputs. Shall be
-			a list of the outputs given below.
 
 Optional properties:
  - clocks : as described in the clock bindings
@@ -93,17 +91,6 @@ Example:
 		compatible = "xlnx,ps7-clkc";
 		ps-clk-frequency = <33333333>;
 		reg = <0x100 0x100>;
-		clock-output-names = "armpll", "ddrpll", "iopll", "cpu_6or4x",
-				"cpu_3or2x", "cpu_2x", "cpu_1x", "ddr2x", "ddr3x",
-				"dci", "lqspi", "smc", "pcap", "gem0", "gem1",
-				"fclk0", "fclk1", "fclk2", "fclk3", "can0", "can1",
-				"sdio0", "sdio1", "uart0", "uart1", "spi0", "spi1",
-				"dma", "usb0_aper", "usb1_aper", "gem0_aper",
-				"gem1_aper", "sdio0_aper", "sdio1_aper",
-				"spi0_aper", "spi1_aper", "can0_aper", "can1_aper",
-				"i2c0_aper", "i2c1_aper", "uart0_aper", "uart1_aper",
-				"gpio_aper", "lqspi_aper", "smc_aper", "swdt",
-				"dbg_trc", "dbg_apb";
 		# optional props
 		clocks = <&clkc 16>, <&clk_foo>;
 		clock-names = "gem1_emio_clk", "can_mio_clk_23";
diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 88a2cab..c5a3ed3 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -68,6 +68,18 @@ enum zynq_clk {
 	i2c0_aper, i2c1_aper, uart0_aper, uart1_aper, gpio_aper, lqspi_aper,
 	smc_aper, swdt, dbg_trc, dbg_apb, clk_max};
 
+static const char * const clk_output_name[] = {
+	"armpll", "ddrpll", "iopll",
+	"cpu_6or4x", "cpu_3or2x", "cpu_2x", "cpu_1x",
+	"ddr2x", "ddr3x", "dci",
+	"lqspi", "smc", "pcap", "gem0", "gem1", "fclk0", "fclk1", "fclk2", "fclk3", "can0", "can1",
+	"sdio0", "sdio1", "uart0", "uart1", "spi0", "spi1", "dma",
+	"usb0_aper", "usb1_aper", "gem0_aper", "gem1_aper",
+	"sdio0_aper", "sdio1_aper", "spi0_aper", "spi1_aper", "can0_aper", "can1_aper",
+	"i2c0_aper", "i2c1_aper", "uart0_aper", "uart1_aper", "gpio_aper", "lqspi_aper",
+	"smc_aper", "swdt", "dbg_trc", "dbg_apb"
+};
+
 static struct clk *ps_clk;
 static struct clk *clks[clk_max];
 static struct clk_onecell_data clk_data;
@@ -231,7 +243,6 @@ static void __init zynq_clk_setup(struct device_node *np)
 	struct clk *clk;
 	char *clk_name;
 	unsigned int fclk_enable = 0;
-	const char *clk_output_name[clk_max];
 	const char *cpu_parents[4];
 	const char *periph_parents[4];
 	const char *swdt_ext_clk_mux_parents[2];
@@ -240,14 +251,6 @@ static void __init zynq_clk_setup(struct device_node *np)
 
 	pr_info("Zynq clock init\n");
 
-	/* get clock output names from DT */
-	for (i = 0; i < clk_max; i++) {
-		if (of_property_read_string_index(np, "clock-output-names",
-				  i, &clk_output_name[i])) {
-			pr_err("%s: clock output name not in DT\n", __func__);
-			BUG();
-		}
-	}
 	cpu_parents[0] = clk_output_name[armpll];
 	cpu_parents[1] = clk_output_name[armpll];
 	cpu_parents[2] = clk_output_name[ddrpll];
-- 
1.9.1
