From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:19:10 +0200
Subject: [PATCH 35/39] ARM: u300: move the gated system controller clocks to DT
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-36-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This moves the slow, fast, AHB bridge and "rest" clocks on
the U300 system controller over to registration from the
device tree.

Acked-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/clock/ste-u300-syscon-clock.txt       |  57 ++++
 arch/arm/boot/dts/ste-u300.dts                     | 149 ++++++++++
 arch/arm/mach-u300/timer.c                         |   2 +-
 drivers/clk/clk-u300.c                             | 320 ++++++++++++++-------
 4 files changed, 418 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt b/Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt
new file mode 100644
index 0000000..b6a30f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt
@@ -0,0 +1,57 @@
+Clock bindings for ST-Ericsson U300 System Controller Clocks
+
+Bindings for the gated system controller clocks:
+
+Required properties:
+- compatible: must be "stericsson,u300-syscon-clk"
+- #clock-cells: must be <0>
+- clock-type: specifies the type of clock:
+  0 = slow clock
+  1 = fast clock
+  2 = rest/remaining clock
+- clock-id: specifies the clock in the type range
+
+Optional properties:
+- clocks: parent clock(s)
+
+The available clocks per type are as follows:
+
+Type:  ID:   Clock:
+-------------------
+0      0     Slow peripheral bridge clock
+0      1     UART0 clock
+0      4     GPIO clock
+0      6     RTC clock
+0      7     Application timer clock
+0      8     Access timer clock
+
+1      0     Fast peripheral bridge clock
+1      1     I2C bus 0 clock
+1      2     I2C bus 1 clock
+1      5     MMC interface peripheral (silicon) clock
+1      6     SPI clock
+
+2      3     CPU clock
+2      4     DMA controller clock
+2      5     External Memory Interface (EMIF) clock
+2      6     NAND flask interface clock
+2      8     XGAM graphics engine clock
+2      9     Shared External Memory Interface (SEMI) clock
+2      10    AHB Subsystem Bridge clock
+2      12    Interrupt controller clock
+
+Example:
+
+gpio_clk: gpio_clk at 13M {
+	#clock-cells = <0>;
+	compatible = "stericsson,u300-syscon-clk";
+	clock-type = <0>; /* Slow */
+	clock-id = <4>;
+	clocks = <&slow_clk>;
+};
+
+gpio: gpio at c0016000 {
+	compatible = "stericsson,gpio-coh901";
+	(...)
+	clocks = <&gpio_clk>;
+};
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 203ec1fc..7edc5e5 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -43,6 +43,49 @@
 			compatible = "fixed-clock";
 			clock-frequency = <13000000>;
 		};
+		/* Slow bridge clocks under PLL13 */
+		slow_clk: slow_clk at 13M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <0>; /* Slow */
+			clock-id = <0>;
+			clocks = <&pll13>;
+		};
+		uart0_clk: uart0_clk at 13M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <0>; /* Slow */
+			clock-id = <1>;
+			clocks = <&slow_clk>;
+		};
+		gpio_clk: gpio_clk at 13M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <0>; /* Slow */
+			clock-id = <4>;
+			clocks = <&slow_clk>;
+		};
+		rtc_clk: rtc_clk at 13M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <0>; /* Slow */
+			clock-id = <6>;
+			clocks = <&slow_clk>;
+		};
+		apptimer_clk: app_tmr_clk at 13M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <0>; /* Slow */
+			clock-id = <7>;
+			clocks = <&slow_clk>;
+		};
+		acc_tmr_clk at 13M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <0>; /* Slow */
+			clock-id = <8>;
+			clocks = <&slow_clk>;
+		};
 		pll208: pll208 at 208M {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -55,6 +98,13 @@
 			clock-mult = <1>;
 			clocks = <&pll208>;
 		};
+		cpu_clk at 208M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <2>; /* Rest */
+			clock-id = <3>;
+			clocks = <&app208>;
+		};
 		app104: app_104_clk at 104M {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
@@ -62,6 +112,13 @@
 			clock-mult = <1>;
 			clocks = <&pll208>;
 		};
+		semi_clk at 104M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <2>; /* Rest */
+			clock-id = <9>;
+			clocks = <&app104>;
+		};
 		app52: app_52_clk at 52M {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
@@ -69,6 +126,49 @@
 			clock-mult = <1>;
 			clocks = <&pll208>;
 		};
+		/* AHB subsystem clocks */
+		ahb_clk: ahb_subsys_clk at 52M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <2>; /* Rest */
+			clock-id = <10>;
+			clocks = <&app52>;
+		};
+		intcon_clk at 52M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <2>; /* Rest */
+			clock-id = <12>;
+			clocks = <&ahb_clk>;
+		};
+		emif_clk at 52M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <2>; /* Rest */
+			clock-id = <5>;
+			clocks = <&ahb_clk>;
+		};
+		dmac_clk: dmac_clk at 52M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <2>; /* Rest */
+			clock-id = <4>;
+			clocks = <&app52>;
+		};
+		fsmc_clk: fsmc_clk at 52M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <2>; /* Rest */
+			clock-id = <6>;
+			clocks = <&app52>;
+		};
+		xgam_clk: xgam_clk at 52M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <2>; /* Rest */
+			clock-id = <8>;
+			clocks = <&app52>;
+		};
 		app26: app_26_clk at 26M {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
@@ -76,6 +176,42 @@
 			clock-mult = <1>;
 			clocks = <&app52>;
 		};
+		/* Fast bridge  clocks */
+		fast_clk: fast_clk at 26M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <1>; /* Fast */
+			clock-id = <0>;
+			clocks = <&app26>;
+		};
+		i2c0_clk: i2c0_clk at 26M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <1>; /* Fast */
+			clock-id = <1>;
+			clocks = <&fast_clk>;
+		};
+		i2c1_clk: i2c1_clk at 26M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <1>; /* Fast */
+			clock-id = <2>;
+			clocks = <&fast_clk>;
+		};
+		mmc_pclk: mmc_p_clk at 26M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <1>; /* Fast */
+			clock-id = <5>;
+			clocks = <&fast_clk>;
+		};
+		spi_clk: spi_p_clk at 26M {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-clk";
+			clock-type = <1>; /* Fast */
+			clock-id = <6>;
+			clocks = <&fast_clk>;
+		};
 	};
 
 	timer: timer at c0014000 {
@@ -83,6 +219,7 @@
 		reg = <0xc0014000 0x1000>;
 		interrupt-parent = <&vica>;
 		interrupts = <24 25 26 27>;
+		clocks = <&apptimer_clk>;
 	};
 
 	gpio: gpio at c0016000 {
@@ -90,6 +227,7 @@
 		reg = <0xc0016000 0x1000>;
 		interrupt-parent = <&vicb>;
 		interrupts = <0 1 2 18 21 22 23>;
+		clocks = <&gpio_clk>;
 		interrupt-names = "gpio0", "gpio1", "gpio2", "gpio3",
 				"gpio4", "gpio5", "gpio6";
 		interrupt-controller;
@@ -116,6 +254,7 @@
 		reg = <0xc0017000 0x1000>;
 		interrupt-parent = <&vicb>;
 		interrupts = <10>;
+		clocks = <&rtc_clk>;
 	};
 
 	dmac: dma-controller at c00020000 {
@@ -125,6 +264,7 @@
 		interrupts = <2>;
 		#dma-cells = <1>;
 		dma-channels = <40>;
+		clocks = <&dmac_clk>;
 	};
 
 	/* A NAND flash of 128 MiB */
@@ -138,6 +278,7 @@
 			<0x80010000 0x4000>;	/* NAND Base CMD */
 		reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
 		nand-skip-bbtscan;
+		clocks = <&fsmc_clk>;
 
 		partition at 0 {
 		label = "boot records";
@@ -158,6 +299,7 @@
 		reg = <0xc0004000 0x1000>;
 		interrupt-parent = <&vicb>;
 		interrupts = <8>;
+		clocks = <&i2c0_clk>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		ab3100: ab3100 at 0x48 {
@@ -235,6 +377,7 @@
 		reg = <0xc0005000 0x1000>;
 		interrupt-parent = <&vicb>;
 		interrupts = <9>;
+		clocks = <&i2c1_clk>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		fwcam0: fwcam at 0x10 {
@@ -270,6 +413,8 @@
 			reg = <0xc0013000 0x1000>;
 			interrupt-parent = <&vica>;
 			interrupts = <22>;
+			clocks = <&uart0_clk>, <&uart0_clk>;
+			clock-names = "apb_pclk", "uart0_clk";
 			dmas = <&dmac 17 &dmac 18>;
 			dma-names = "tx", "rx";
 		};
@@ -288,6 +433,8 @@
 			reg = <0xc0001000 0x1000>;
 			interrupt-parent = <&vicb>;
 			interrupts = <6 7>;
+			clocks = <&mmc_pclk>;
+			clock-names = "apb_pclk";
 			max-frequency = <24000000>;
 			bus-width = <4>; // SD-card slot
 			mmc-cap-mmc-highspeed;
@@ -304,6 +451,8 @@
 			reg = <0xc0006000 0x1000>;
 			interrupt-parent = <&vica>;
 			interrupts = <23>;
+			clocks = <&spi_clk>, <&spi_clk>;
+			clock-names = "apb_pclk", "spi_clk";
 			dmas = <&dmac 27 &dmac 28>;
 			dma-names = "tx", "rx";
 			num-cs = <3>;
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 2e1c81d..390ae5f 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -375,7 +375,7 @@ static void __init u300_timer_init_of(struct device_node *np)
 	pr_info("U300 GP1 timer @ base: %p, IRQ: %d\n", u300_timer_base, irq);
 
 	/* Clock the interrupt controller */
-	clk = clk_get_sys("apptimer", NULL);
+	clk = of_clk_get(np, 0);
 	BUG_ON(IS_ERR(clk));
 	clk_prepare_enable(clk);
 	rate = clk_get_rate(clk);
diff --git a/drivers/clk/clk-u300.c b/drivers/clk/clk-u300.c
index bebd6c9..5f234d3 100644
--- a/drivers/clk/clk-u300.c
+++ b/drivers/clk/clk-u300.c
@@ -728,6 +728,213 @@ syscon_clk_register(struct device *dev, const char *name,
 	return clk;
 }
 
+#define U300_CLK_TYPE_SLOW 0
+#define U300_CLK_TYPE_FAST 1
+#define U300_CLK_TYPE_REST 2
+
+/**
+ * struct u300_clock - defines the bits and pieces for a certain clock
+ * @type: the clock type, slow fast or rest
+ * @id: the bit in the slow/fast/rest register for this clock
+ * @hw_ctrld: whether the clock is hardware controlled
+ * @clk_val: a value to poke in the one-write enable/disable registers
+ */
+struct u300_clock {
+	u8 type;
+	u8 id;
+	bool hw_ctrld;
+	u16 clk_val;
+};
+
+struct u300_clock const __initconst u300_clk_lookup[] = {
+	{
+		.type = U300_CLK_TYPE_REST,
+		.id = 3,
+		.hw_ctrld = true,
+		.clk_val = U300_SYSCON_SBCER_CPU_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_REST,
+		.id = 4,
+		.hw_ctrld = true,
+		.clk_val = U300_SYSCON_SBCER_DMAC_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_REST,
+		.id = 5,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_EMIF_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_REST,
+		.id = 6,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_NANDIF_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_REST,
+		.id = 8,
+		.hw_ctrld = true,
+		.clk_val = U300_SYSCON_SBCER_XGAM_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_REST,
+		.id = 9,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_SEMI_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_REST,
+		.id = 10,
+		.hw_ctrld = true,
+		.clk_val = U300_SYSCON_SBCER_AHB_SUBSYS_BRIDGE_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_REST,
+		.id = 12,
+		.hw_ctrld = false,
+		/* INTCON: cannot be enabled, just taken out of reset */
+		.clk_val = 0xFFFFU,
+	},
+	{
+		.type = U300_CLK_TYPE_FAST,
+		.id = 0,
+		.hw_ctrld = true,
+		.clk_val = U300_SYSCON_SBCER_FAST_BRIDGE_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_FAST,
+		.id = 1,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_I2C0_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_FAST,
+		.id = 2,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_I2C1_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_FAST,
+		.id = 5,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_MMC_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_FAST,
+		.id = 6,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_SPI_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_SLOW,
+		.id = 0,
+		.hw_ctrld = true,
+		.clk_val = U300_SYSCON_SBCER_SLOW_BRIDGE_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_SLOW,
+		.id = 1,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_UART_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_SLOW,
+		.id = 4,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_GPIO_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_SLOW,
+		.id = 6,
+		.hw_ctrld = true,
+		/* No clock enable register bit */
+		.clk_val = 0xFFFFU,
+	},
+	{
+		.type = U300_CLK_TYPE_SLOW,
+		.id = 7,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_APP_TMR_CLK_EN,
+	},
+	{
+		.type = U300_CLK_TYPE_SLOW,
+		.id = 8,
+		.hw_ctrld = false,
+		.clk_val = U300_SYSCON_SBCER_ACC_TMR_CLK_EN,
+	},
+};
+
+static void __init of_u300_syscon_clk_init(struct device_node *np)
+{
+	struct clk *clk = ERR_PTR(-EINVAL);
+	const char *clk_name = np->name;
+	const char *parent_name;
+	void __iomem *res_reg;
+	void __iomem *en_reg;
+	u32 clk_type;
+	u32 clk_id;
+	int i;
+
+	if (of_property_read_u32(np, "clock-type", &clk_type)) {
+		pr_err("%s: syscon clock \"%s\" missing clock-type property\n",
+		       __func__, clk_name);
+		return;
+	}
+	if (of_property_read_u32(np, "clock-id", &clk_id)) {
+		pr_err("%s: syscon clock \"%s\" missing clock-id property\n",
+		       __func__, clk_name);
+		return;
+	}
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	switch (clk_type) {
+	case U300_CLK_TYPE_SLOW:
+		res_reg = syscon_vbase + U300_SYSCON_RSR;
+		en_reg = syscon_vbase + U300_SYSCON_CESR;
+		break;
+	case U300_CLK_TYPE_FAST:
+		res_reg = syscon_vbase + U300_SYSCON_RFR;
+		en_reg = syscon_vbase + U300_SYSCON_CEFR;
+		break;
+	case U300_CLK_TYPE_REST:
+		res_reg = syscon_vbase + U300_SYSCON_RRR;
+		en_reg = syscon_vbase + U300_SYSCON_CERR;
+		break;
+	default:
+		pr_err("unknown clock type %x specified\n", clk_type);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(u300_clk_lookup); i++) {
+		const struct u300_clock *u3clk = &u300_clk_lookup[i];
+
+		if (u3clk->type == clk_type && u3clk->id == clk_id)
+			clk = syscon_clk_register(NULL,
+						  clk_name, parent_name,
+						  0, u3clk->hw_ctrld,
+						  res_reg, u3clk->id,
+						  en_reg, u3clk->id,
+						  u3clk->clk_val);
+	}
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+
+		/*
+		 * Some few system clocks - device tree does not
+		 * represent clocks without a corresponding device node.
+		 * for now we add these three clocks here.
+		 */
+		if (clk_type == U300_CLK_TYPE_REST && clk_id == 5)
+			clk_register_clkdev(clk, NULL, "pl172");
+		if (clk_type == U300_CLK_TYPE_REST && clk_id == 9)
+			clk_register_clkdev(clk, NULL, "semi");
+		if (clk_type == U300_CLK_TYPE_REST && clk_id == 12)
+			clk_register_clkdev(clk, NULL, "intcon");
+	}
+}
+
 /**
  * struct clk_mclk - U300 MCLK clock (MMC/SD clock)
  * @hw: corresponding clock hardware entry
@@ -941,6 +1148,10 @@ static const __initconst struct of_device_id u300_clk_match[] = {
 		.compatible = "fixed-factor-clock",
 		.data = of_fixed_factor_clk_setup,
 	},
+	{
+		.compatible = "stericsson,u300-syscon-clk",
+		.data = of_u300_syscon_clk_init,
+	},
 };
 
 void __init u300_clk_init(void __iomem *base)
@@ -965,115 +1176,6 @@ void __init u300_clk_init(void __iomem *base)
 
 	of_clk_init(u300_clk_match);
 
-	/* Directly on the AMBA interconnect */
-	clk = syscon_clk_register(NULL, "cpu_clk", "app_208_clk", 0, true,
-				  syscon_vbase + U300_SYSCON_RRR, 3,
-				  syscon_vbase + U300_SYSCON_CERR, 3,
-				  U300_SYSCON_SBCER_CPU_CLK_EN);
-	clk = syscon_clk_register(NULL, "dmac_clk", "app_52_clk", 0, true,
-				  syscon_vbase + U300_SYSCON_RRR, 4,
-				  syscon_vbase + U300_SYSCON_CERR, 4,
-				  U300_SYSCON_SBCER_DMAC_CLK_EN);
-	clk_register_clkdev(clk, NULL, "dma");
-	clk = syscon_clk_register(NULL, "fsmc_clk", "app_52_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RRR, 6,
-				  syscon_vbase + U300_SYSCON_CERR, 6,
-				  U300_SYSCON_SBCER_NANDIF_CLK_EN);
-	clk_register_clkdev(clk, NULL, "fsmc-nand");
-	clk = syscon_clk_register(NULL, "xgam_clk", "app_52_clk", 0, true,
-				  syscon_vbase + U300_SYSCON_RRR, 8,
-				  syscon_vbase + U300_SYSCON_CERR, 8,
-				  U300_SYSCON_SBCER_XGAM_CLK_EN);
-	clk_register_clkdev(clk, NULL, "xgam");
-	clk = syscon_clk_register(NULL, "semi_clk", "app_104_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RRR, 9,
-				  syscon_vbase + U300_SYSCON_CERR, 9,
-				  U300_SYSCON_SBCER_SEMI_CLK_EN);
-	clk_register_clkdev(clk, NULL, "semi");
-
-	/* AHB bridge clocks */
-	clk = syscon_clk_register(NULL, "ahb_subsys_clk", "app_52_clk", 0, true,
-				  syscon_vbase + U300_SYSCON_RRR, 10,
-				  syscon_vbase + U300_SYSCON_CERR, 10,
-				  U300_SYSCON_SBCER_AHB_SUBSYS_BRIDGE_CLK_EN);
-	clk = syscon_clk_register(NULL, "intcon_clk", "ahb_subsys_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RRR, 12,
-				  syscon_vbase + U300_SYSCON_CERR, 12,
-				  /* Cannot be enabled, just taken out of reset */
-				  0xFFFFU);
-	clk_register_clkdev(clk, NULL, "intcon");
-	clk = syscon_clk_register(NULL, "emif_clk", "ahb_subsys_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RRR, 5,
-				  syscon_vbase + U300_SYSCON_CERR, 5,
-				  U300_SYSCON_SBCER_EMIF_CLK_EN);
-	clk_register_clkdev(clk, NULL, "pl172");
-
-	/* FAST bridge clocks */
-	clk = syscon_clk_register(NULL, "fast_clk", "app_26_clk", 0, true,
-				  syscon_vbase + U300_SYSCON_RFR, 0,
-				  syscon_vbase + U300_SYSCON_CEFR, 0,
-				  U300_SYSCON_SBCER_FAST_BRIDGE_CLK_EN);
-	clk = syscon_clk_register(NULL, "i2c0_p_clk", "fast_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RFR, 1,
-				  syscon_vbase + U300_SYSCON_CEFR, 1,
-				  U300_SYSCON_SBCER_I2C0_CLK_EN);
-	clk_register_clkdev(clk, NULL, "stu300.0");
-	clk = syscon_clk_register(NULL, "i2c1_p_clk", "fast_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RFR, 2,
-				  syscon_vbase + U300_SYSCON_CEFR, 2,
-				  U300_SYSCON_SBCER_I2C1_CLK_EN);
-	clk_register_clkdev(clk, NULL, "stu300.1");
-	clk = syscon_clk_register(NULL, "mmc_p_clk", "fast_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RFR, 5,
-				  syscon_vbase + U300_SYSCON_CEFR, 5,
-				  U300_SYSCON_SBCER_MMC_CLK_EN);
-	clk_register_clkdev(clk, "apb_pclk", "mmci");
-	clk = syscon_clk_register(NULL, "spi_p_clk", "fast_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RFR, 6,
-				  syscon_vbase + U300_SYSCON_CEFR, 6,
-				  U300_SYSCON_SBCER_SPI_CLK_EN);
-	/* The SPI has no external clock for the outward bus, uses the pclk */
-	clk_register_clkdev(clk, NULL, "pl022");
-	clk_register_clkdev(clk, "apb_pclk", "pl022");
-
-	/* SLOW bridge clocks */
-	clk = syscon_clk_register(NULL, "slow_clk", "pll13", 0, true,
-				  syscon_vbase + U300_SYSCON_RSR, 0,
-				  syscon_vbase + U300_SYSCON_CESR, 0,
-				  U300_SYSCON_SBCER_SLOW_BRIDGE_CLK_EN);
-	clk = syscon_clk_register(NULL, "uart0_clk", "slow_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RSR, 1,
-				  syscon_vbase + U300_SYSCON_CESR, 1,
-				  U300_SYSCON_SBCER_UART_CLK_EN);
-	/* Same clock is used for APB and outward bus */
-	clk_register_clkdev(clk, NULL, "uart0");
-	clk_register_clkdev(clk, "apb_pclk", "uart0");
-	clk = syscon_clk_register(NULL, "gpio_clk", "slow_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RSR, 4,
-				  syscon_vbase + U300_SYSCON_CESR, 4,
-				  U300_SYSCON_SBCER_GPIO_CLK_EN);
-	clk_register_clkdev(clk, NULL, "u300-gpio");
-	clk = syscon_clk_register(NULL, "keypad_clk", "slow_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RSR, 5,
-				  syscon_vbase + U300_SYSCON_CESR, 6,
-				  U300_SYSCON_SBCER_KEYPAD_CLK_EN);
-	clk_register_clkdev(clk, NULL, "coh901461-keypad");
-	clk = syscon_clk_register(NULL, "rtc_clk", "slow_clk", 0, true,
-				  syscon_vbase + U300_SYSCON_RSR, 6,
-				  /* No clock enable register bit */
-				  NULL, 0, 0xFFFFU);
-	clk_register_clkdev(clk, NULL, "rtc-coh901331");
-	clk = syscon_clk_register(NULL, "app_tmr_clk", "slow_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RSR, 7,
-				  syscon_vbase + U300_SYSCON_CESR, 7,
-				  U300_SYSCON_SBCER_APP_TMR_CLK_EN);
-	clk_register_clkdev(clk, NULL, "apptimer");
-	clk = syscon_clk_register(NULL, "acc_tmr_clk", "slow_clk", 0, false,
-				  syscon_vbase + U300_SYSCON_RSR, 8,
-				  syscon_vbase + U300_SYSCON_CESR, 8,
-				  U300_SYSCON_SBCER_ACC_TMR_CLK_EN);
-	clk_register_clkdev(clk, NULL, "timer");
-
 	/* Then this special MMC/SD clock */
 	clk = mclk_clk_register(NULL, "mmc_clk", "mmc_p_clk", false);
 	clk_register_clkdev(clk, NULL, "mmci");
-- 
1.7.11.3
