From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 27 Mar 2013 18:20:37 -0300
Subject: [PATCH v2 1/7] clk: sunxi: Add support for AXI, AHB,
 APB0 and APB1 gates
In-Reply-To: <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1364419243-18446-2-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds DT support for all the AXI, AHB, APB0 and APB1
gates present on sunxi SoCs.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Changes from v1:
  - renamed compatibles to sun4i
  - renamed TWI -> I2C
  - added note about gate availability on sun5i

 Documentation/devicetree/bindings/clock/sunxi.txt | 109 +++++++++++++++++++++-
 drivers/clk/sunxi/clk-sunxi.c                     |  88 +++++++++++++++++
 2 files changed, 196 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 20b8479..729f524 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -10,15 +10,23 @@ Required properties:
 	"allwinner,sun4i-pll1-clk" - for the main PLL clock
 	"allwinner,sun4i-cpu-clk" - for the CPU multiplexer clock
 	"allwinner,sun4i-axi-clk" - for the AXI clock
+	"allwinner,sun4i-axi-gates-clk" - for the AXI gates
 	"allwinner,sun4i-ahb-clk" - for the AHB clock
+	"allwinner,sun4i-ahb-gates-clk" - for the AHB gates
 	"allwinner,sun4i-apb0-clk" - for the APB0 clock
+	"allwinner,sun4i-apb0-gates-clk" - for the APB0 gates
 	"allwinner,sun4i-apb1-clk" - for the APB1 clock
 	"allwinner,sun4i-apb1-mux-clk" - for the APB1 clock muxing
+	"allwinner,sun4i-apb1-gates-clk" - for the APB1 gates
 
 Required properties for all clocks:
 - reg : shall be the control register address for the clock.
 - clocks : shall be the input parent clock(s) phandle for the clock
-- #clock-cells : from common clock binding; shall be set to 0.
+- #clock-cells : from common clock binding; shall be set to 0 except for
+	"allwinner,sun4i-*-gates-clk" where it shall be set to 1
+
+Additionally, "allwinner,sun4i-*-gates-clk" clocks require:
+- clock-output-names : the corresponding gate names that the clock controls
 
 For example:
 
@@ -42,3 +50,102 @@ cpu: cpu at 01c20054 {
 	reg = <0x01c20054 0x4>;
 	clocks = <&osc32k>, <&osc24M>, <&pll1>;
 };
+
+
+
+Gate clock outputs
+
+The "allwinner,sun4i-*-gates-clk" clocks provide several gatable outputs;
+their corresponding offsets as present on sun4i are listed below. Note that
+some of these gates are not present on sun5i.
+
+  * AXI gates ("allwinner,sun4i-axi-gates-clk")
+
+    DRAM                                                                0
+
+  * AHB gates ("allwinner,sun4i-ahb-gates-clk")
+
+    USB0                                                                0
+    EHCI0                                                               1
+    OHCI0                                                               2*
+    EHCI1                                                               3
+    OHCI1                                                               4*
+    SS                                                                  5
+    DMA                                                                 6
+    BIST                                                                7
+    MMC0                                                                8
+    MMC1                                                                9
+    MMC2                                                                10
+    MMC3                                                                11
+    MS                                                                  12**
+    NAND                                                                13
+    SDRAM                                                               14
+
+    ACE                                                                 16
+    EMAC                                                                17
+    TS                                                                  18
+
+    SPI0                                                                20
+    SPI1                                                                21
+    SPI2                                                                22
+    SPI3                                                                23
+    PATA                                                                24
+    SATA                                                                25**
+    GPS                                                                 26*
+
+    VE                                                                  32
+    TVD                                                                 33
+    TVE0                                                                34
+    TVE1                                                                35
+    LCD0                                                                36
+    LCD1                                                                37
+
+    CSI0                                                                40
+    CSI1                                                                41
+
+    HDMI                                                                43
+    DE_BE0                                                              44
+    DE_BE1                                                              45
+    DE_FE0                                                              46
+    DE_FE1                                                              47
+
+    MP                                                                  50
+
+    MALI400                                                             52
+
+  * APB0 gates ("allwinner,sun4i-apb0-gates-clk")
+
+    CODEC                                                               0
+    SPDIF                                                               1*
+    AC97                                                                2
+    IIS                                                                 3
+
+    PIO                                                                 5
+    IR0                                                                 6
+    IR1                                                                 7
+
+    KEYPAD                                                              10
+
+  * APB1 gates ("allwinner,sun4i-apb1-gates-clk")
+
+    I2C0                                                                0
+    I2C1                                                                1
+    I2C2                                                                2
+
+    CAN                                                                 4
+    SCR                                                                 5
+    PS20                                                                6
+    PS21                                                                7
+
+    UART0                                                               16
+    UART1                                                               17
+    UART2                                                               18
+    UART3                                                               19
+    UART4                                                               20
+    UART5                                                               21
+    UART6                                                               22
+    UART7                                                               23
+
+Notation:
+ [*]:  The datasheet didn't mention these, but they are present on AW code
+ [**]: The datasheet had this marked as "NC" but they are used on AW code
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index d528a24..244de90 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -302,6 +302,82 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
 }
 
 
+
+/**
+ * sunxi_gates_clk_setup() - Setup function for leaf gates on clocks
+ */
+
+#define SUNXI_GATES_MAX_SIZE	64
+
+struct gates_data {
+	DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
+};
+
+static const __initconst struct gates_data axi_gates_data = {
+	.mask = {1},
+};
+
+static const __initconst struct gates_data ahb_gates_data = {
+	.mask = {0x7F77FFF, 0x14FB3F},
+};
+
+static const __initconst struct gates_data apb0_gates_data = {
+	.mask = {0x4EF},
+};
+
+static const __initconst struct gates_data apb1_gates_data = {
+	.mask = {0xFF00F7},
+};
+
+static void __init sunxi_gates_clk_setup(struct device_node *node,
+					 struct gates_data *data)
+{
+	struct clk_onecell_data *clk_data;
+	const char *clk_parent;
+	const char *clk_name;
+	void *reg;
+	int qty;
+	int i = 0;
+	int j = 0;
+	int ignore;
+
+	reg = of_iomap(node, 0);
+
+	clk_parent = of_clk_get_parent_name(node, 0);
+
+	/* Worst-case size approximation and memory allocation */
+	qty = find_last_bit(data->mask, SUNXI_GATES_MAX_SIZE);
+	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	if (!clk_data)
+		return;
+	clk_data->clks = kzalloc((qty+1) * sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_data->clks) {
+		kfree(clk_data);
+		return;
+	}
+
+	for_each_set_bit(i, data->mask, SUNXI_GATES_MAX_SIZE) {
+		of_property_read_string_index(node, "clock-output-names",
+					      j, &clk_name);
+
+		/* No driver claims this clock, but it should remain gated */
+		ignore = !strcmp("ahb_sdram", clk_name) ? CLK_IGNORE_UNUSED : 0;
+
+		clk_data->clks[i] = clk_register_gate(NULL, clk_name,
+						      clk_parent, ignore,
+						      reg + 4 * (i/32), i % 32,
+						      0, &clk_lock);
+		WARN_ON(IS_ERR(clk_data->clks[i]));
+
+		j++;
+	}
+
+	/* Adjust to the real max */
+	clk_data->clk_num = i;
+
+	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
 /* Matches for of_clk_init */
 static const __initconst struct of_device_id clk_match[] = {
 	{.compatible = "fixed-clock", .data = of_fixed_clk_setup,},
@@ -331,6 +407,15 @@ static const __initconst struct of_device_id clk_mux_match[] = {
 	{}
 };
 
+/* Matches for gate clocks */
+static const __initconst struct of_device_id clk_gates_match[] = {
+	{.compatible = "allwinner,sun4i-axi-gates-clk", .data = &axi_gates_data,},
+	{.compatible = "allwinner,sun4i-ahb-gates-clk", .data = &ahb_gates_data,},
+	{.compatible = "allwinner,sun4i-apb0-gates-clk", .data = &apb0_gates_data,},
+	{.compatible = "allwinner,sun4i-apb1-gates-clk", .data = &apb1_gates_data,},
+	{}
+};
+
 static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_match,
 					      void *function)
 {
@@ -359,4 +444,7 @@ void __init sunxi_init_clocks(void)
 
 	/* Register mux clocks */
 	of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
+
+	/* Register gate clocks */
+	of_sunxi_table_clock_setup(clk_gates_match, sunxi_gates_clk_setup);
 }
-- 
1.8.2
