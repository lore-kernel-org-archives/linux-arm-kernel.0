From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 22:30:36 +0200
Subject: [PATCH 08/13] clk: sunxi-ng: Add A64 clocks
In-Reply-To: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
Message-ID: <20160726203041.29366-9-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the A64 CCU clocks set.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |  13 +-
 drivers/clk/sunxi-ng/Makefile                      |   2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h              |  68 +++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                | 483 +++++++++++++++++++++
 include/dt-bindings/clock/sun50i-a64-ccu.h         | 132 ++++++
 include/dt-bindings/reset/sun50i-a64-ccu.h         |  97 +++++
 7 files changed, 793 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.h
 create mode 100644 include/dt-bindings/clock/sun50i-a64-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-a64-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index cb91507ffb1e..1502fc6a4aae 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -4,6 +4,7 @@ Allwinner Clock Control Unit Binding
 Required properties :
 - compatible: must contain one of the following compatible:
 		- "allwinner,sun8i-h3-ccu"
+		- "allwinner,sun50i-a64-ccu"
 
 - reg: Must contain the registers base address and length
 - clocks: phandle to the oscillators feeding the CCU. Two are needed:
diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 2afcbd39e41e..81419f63730f 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -51,8 +51,8 @@ config SUNXI_CCU_MP
 
 # SoC Drivers
 
-config SUN8I_H3_CCU
-	bool "Support for the Allwinner H3 CCU"
+config SUNXI_H3_A64_CCU_SUPPORT
+	bool
 	select SUNXI_CCU_DIV
 	select SUNXI_CCU_NK
 	select SUNXI_CCU_NKM
@@ -60,6 +60,15 @@ config SUN8I_H3_CCU
 	select SUNXI_CCU_NM
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
+
+config SUN8I_H3_CCU
+	bool "Support for the Allwinner H3 CCU"
+	select SUNXI_H3_A64_CCU_SUPPORT
 	default MACH_SUN8I
 
+config SUN50I_A64_CCU
+	bool "Support for the Allwinner A64 CCU"
+	select SUNXI_H3_A64_CCU_SUPPORT
+	default ARM64 && ARCH_SUNXI
+
 endif
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 633ce642ffae..d46c460a2cd9 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -17,4 +17,4 @@ obj-$(CONFIG_SUNXI_CCU_NM)	+= ccu_nm.o
 obj-$(CONFIG_SUNXI_CCU_MP)	+= ccu_mp.o
 
 # SoC support
-obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
+obj-$(CONFIG_SUNXI_H3_A64_CCU_SUPPORT)	+= ccu-sun8i-h3.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
new file mode 100644
index 000000000000..127817ace780
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright 2016 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _CCU_SUN50I_A64_H_
+#define _CCU_SUN50I_A64_H_
+
+#include <dt-bindings/clock/sun50i-a64-ccu.h>
+#include <dt-bindings/reset/sun50i-a64-ccu.h>
+
+#define CLK_A64_OSC_12M			0
+#define CLK_A64_PLL_CPUX		1
+#define CLK_A64_PLL_AUDIO_BASE		2
+#define CLK_A64_PLL_AUDIO		3
+#define CLK_A64_PLL_AUDIO_2X		4
+#define CLK_A64_PLL_AUDIO_4X		5
+#define CLK_A64_PLL_AUDIO_8X		6
+#define CLK_A64_PLL_VIDEO0		7
+#define CLK_A64_PLL_VIDEO0_2X		8
+#define CLK_A64_PLL_VE			9
+#define CLK_A64_PLL_DDR0		10
+#define CLK_A64_PLL_PERIPH0		11
+#define CLK_A64_PLL_PERIPH0_2X		12
+#define CLK_A64_PLL_PERIPH1		13
+#define CLK_A64_PLL_PERIPH1_2X		14
+#define CLK_A64_PLL_VIDEO1		15
+#define CLK_A64_PLL_GPU			16
+#define CLK_A64_PLL_MIPI		17
+#define CLK_A64_PLL_HSIC		18
+#define CLK_A64_PLL_DE			19
+#define CLK_A64_PLL_DDR1		20
+#define CLK_A64_CPUX			21
+#define CLK_A64_AXI			22
+#define CLK_A64_APB			23
+#define CLK_A64_AHB1			24
+#define CLK_A64_APB1			25
+#define CLK_A64_APB2			26
+#define CLK_A64_AHB2			27
+
+/* All the bus gates are exported */
+
+/* The first bunch of module clocks are exported */
+
+#define CLK_A64_DRAM			92
+
+/* All the DRAM gates are exported */
+
+/* Some more module clocks are exported */
+
+#define CLK_A64_MBUS			110
+
+/* And the DSI and GPU module clock is exported */
+
+#define CLK_A64_NUMBER		(CLK_A64_GPU + 1)
+
+#endif /* _CCU_SUN50I_A64_H_ */
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 2e91f43937c8..cb0dbeb386b0 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -27,6 +27,7 @@
 #include "ccu_nm.h"
 #include "ccu_phase.h"
 
+#include "ccu-sun50i-a64.h"
 #include "ccu-sun8i-h3.h"
 
 static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpux_clk, "pll-cpux",
@@ -99,6 +100,27 @@ static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph0_clk, "pll-periph0",
 					   2,		/* post-div */
 					   0);
 
+static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph1_a64_clk, "pll-periph1",
+					   "osc24M", 0x02c,
+					   8, 5,	/* N */
+					   4, 2,	/* K */
+					   BIT(31),	/* gate */
+					   BIT(28),	/* lock */
+					   2,		/* post-div */
+					   0);
+
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video1_a64_clk, "pll-video1",
+					"osc24M", 0x030,
+					8, 7,		/* N */
+					0, 4,		/* M */
+					BIT(24),	/* frac enable */
+					BIT(25),	/* frac select */
+					270000000,	/* frac rate 0 */
+					297000000,	/* frac rate 1 */
+					BIT(31),	/* gate */
+					BIT(28),	/* lock */
+					0);
+
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 					"osc24M", 0x038,
 					8, 7,		/* N */
@@ -111,6 +133,35 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 					BIT(28),	/* lock */
 					0);
 
+/*
+ * The output function can be changed to something more complex that
+ * we do not handle yet.
+ *
+ * Hardcode the mode so that we don't fall in that case.
+ */
+#define SUN50I_A64_PLL_MIPI_REG		0x040
+
+static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_mipi_a64_clk, "pll-mipi",
+				    "pll-video0", 0x040,
+				    8, 4,	/* N */
+				    4, 2,	/* K */
+				    0, 4,	/* M */
+				    BIT(31),	/* gate */
+				    BIT(28),	/* lock */
+				    0);
+
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_hsic_a64_clk, "pll-hsic",
+					"osc24M", 0x044,
+					8, 7,		/* N */
+					0, 4,		/* M */
+					BIT(24),	/* frac enable */
+					BIT(25),	/* frac select */
+					270000000,	/* frac rate 0 */
+					297000000,	/* frac rate 1 */
+					BIT(31),	/* gate */
+					BIT(28),	/* lock */
+					0);
+
 static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph1_h3_clk, "pll-periph1",
 					   "osc24M", 0x044,
 					   8, 5,	/* N */
@@ -132,6 +183,14 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
 					BIT(28),	/* lock */
 					0);
 
+static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_ddr1_a64_clk, "pll-ddr1",
+				   "osc24M", 0x04c,
+				   8, 7,	/* N */
+				   0, 2,	/* M */
+				   BIT(31),	/* gate */
+				   BIT(28),	/* lock */
+				   0);
+
 static const char * const cpux_parents[] = { "osc32k", "osc24M",
 					     "pll-cpux" , "pll-cpux" };
 static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
@@ -175,6 +234,15 @@ static struct clk_div_table apb1_div_table[] = {
 static SUNXI_CCU_DIV_TABLE(apb1_clk, "apb1", "ahb1",
 			   0x054, 8, 2, apb1_div_table, 0);
 
+static const char * const apb2_a64_parents[] = { "osc32k", "osc24M",
+						 "pll-periph0-2x" ,
+						 "pll-periph0-2x" };
+static SUNXI_CCU_MP_WITH_MUX(apb2_a64_clk, "apb2", apb2_a64_parents, 0x058,
+			     0, 5,	/* M */
+			     16, 2,	/* P */
+			     24, 2,	/* mux */
+			     0);
+
 static const char * const apb2_h3_parents[] = { "osc32k", "osc24M",
 						"pll-periph0" , "pll-periph0" };
 static SUNXI_CCU_MP_WITH_MUX(apb2_h3_clk, "apb2", apb2_h3_parents, 0x058,
@@ -205,6 +273,8 @@ static struct ccu_mux ahb2_clk = {
 	},
 };
 
+static SUNXI_CCU_GATE(bus_mipi_dsi_a64_clk,	"bus-mipi-dsi",	"ahb1",
+		      0x060, BIT(1), 0);
 static SUNXI_CCU_GATE(bus_ce_clk,	"bus-ce",	"ahb1",
 		      0x060, BIT(5), 0);
 static SUNXI_CCU_GATE(bus_dma_clk,	"bus-dma",	"ahb1",
@@ -292,6 +362,8 @@ static SUNXI_CCU_GATE(bus_i2c1_clk,	"bus-i2c1",	"apb2",
 		      0x06c, BIT(1), 0);
 static SUNXI_CCU_GATE(bus_i2c2_clk,	"bus-i2c2",	"apb2",
 		      0x06c, BIT(2), 0);
+static SUNXI_CCU_GATE(bus_scr_a64_clk,	"bus-scr",	"apb2",
+		      0x06c, BIT(5), 0);
 static SUNXI_CCU_GATE(bus_uart0_clk,	"bus-uart0",	"apb2",
 		      0x06c, BIT(16), 0);
 static SUNXI_CCU_GATE(bus_uart1_clk,	"bus-uart1",	"apb2",
@@ -300,6 +372,8 @@ static SUNXI_CCU_GATE(bus_uart2_clk,	"bus-uart2",	"apb2",
 		      0x06c, BIT(18), 0);
 static SUNXI_CCU_GATE(bus_uart3_clk,	"bus-uart3",	"apb2",
 		      0x06c, BIT(19), 0);
+static SUNXI_CCU_GATE(bus_uart4_a64_clk,	"bus-uart4",	"apb2",
+		      0x06c, BIT(20), 0);
 static SUNXI_CCU_GATE(bus_scr_h3_clk,	"bus-scr",	"apb2",
 		      0x06c, BIT(20), 0);
 
@@ -326,6 +400,15 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(nand_clk, "nand", mod0_default_parents, 0x080,
 				  BIT(31),	/* gate */
 				  0);
 
+static const char * const mmc_default_parents[] = { "osc24M", "pll-periph0-2x",
+						    "pll-periph1-2x" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_a64_clk, "mmc0", mmc_default_parents, 0x088,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
 static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_h3_clk, "mmc0", mod0_default_parents, 0x088,
 				  0, 4,		/* M */
 				  16, 2,	/* P */
@@ -338,6 +421,13 @@ static SUNXI_CCU_PHASE(mmc0_sample_h3_clk, "mmc0_sample", "mmc0",
 static SUNXI_CCU_PHASE(mmc0_output_h3_clk, "mmc0_output", "mmc0",
 		       0x088, 8, 3, 0);
 
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_a64_clk, "mmc1", mmc_default_parents, 0x08c,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
 static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_h3_clk, "mmc1", mod0_default_parents, 0x08c,
 				  0, 4,		/* M */
 				  16, 2,	/* P */
@@ -350,6 +440,13 @@ static SUNXI_CCU_PHASE(mmc1_sample_h3_clk, "mmc1_sample", "mmc1",
 static SUNXI_CCU_PHASE(mmc1_output_h3_clk, "mmc1_output", "mmc1",
 		       0x08c, 8, 3, 0);
 
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_a64_clk, "mmc2", mmc_default_parents, 0x090,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
 static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_h3_clk, "mmc2", mod0_default_parents, 0x090,
 				  0, 4,		/* M */
 				  16, 2,	/* P */
@@ -370,6 +467,14 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", ts_parents, 0x098,
 				  BIT(31),	/* gate */
 				  0);
 
+static SUNXI_CCU_MP_WITH_MUX_GATE(ce_a64_clk, "ce", mmc_default_parents, 0x09c,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+
 static SUNXI_CCU_MP_WITH_MUX_GATE(ce_h3_clk, "ce", mod0_default_parents, 0x09c,
 				  0, 4,		/* M */
 				  16, 2,	/* P */
@@ -409,12 +514,20 @@ static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
 		      0x0cc, BIT(8), 0);
 static SUNXI_CCU_GATE(usb_phy1_clk,	"usb-phy1",	"osc24M",
 		      0x0cc, BIT(9), 0);
+static SUNXI_CCU_GATE(usb_hsic_a64_clk,	"usb-hsic",	"pll-hsic",
+		      0x0cc, BIT(10), 0);
 static SUNXI_CCU_GATE(usb_phy2_h3_clk,	"usb-phy2",	"osc24M",
 		      0x0cc, BIT(10), 0);
+static SUNXI_CCU_GATE(usb_hsic_12m_a64_clk,	"usb-hsic-12M",	"osc12M",
+		      0x0cc, BIT(11), 0);
 static SUNXI_CCU_GATE(usb_phy3_h3_clk,	"usb-phy3",	"osc24M",
 		      0x0cc, BIT(11), 0);
+static SUNXI_CCU_GATE(usb_ohci0_a64_clk,	"usb-ohci0",	"osc12M",
+		      0x0cc, BIT(16), 0);
 static SUNXI_CCU_GATE(usb_ohci0_h3_clk,	"usb-ohci0",	"osc24M",
 		      0x0cc, BIT(16), 0);
+static SUNXI_CCU_GATE(usb_ohci1_a64_clk,	"usb-ohci1",	"usb-ohci0",
+		      0x0cc, BIT(17), 0);
 static SUNXI_CCU_GATE(usb_ohci1_h3_clk,	"usb-ohci1",	"osc24M",
 		      0x0cc, BIT(17), 0);
 static SUNXI_CCU_GATE(usb_ohci2_h3_clk,	"usb-ohci2",	"osc24M",
@@ -422,6 +535,10 @@ static SUNXI_CCU_GATE(usb_ohci2_h3_clk,	"usb-ohci2",	"osc24M",
 static SUNXI_CCU_GATE(usb_ohci3_h3_clk,	"usb-ohci3",	"osc24M",
 		      0x0cc, BIT(19), 0);
 
+static const char * const dram_a64_parents[] = { "pll-ddr0", "pll-ddr1" };
+static SUNXI_CCU_M_WITH_MUX(dram_a64_clk, "dram", dram_a64_parents,
+			    0x0f4, 0, 4, 20, 2, CLK_IS_CRITICAL);
+
 static const char * const dram_h3_parents[] = { "pll-ddr0", "pll-periph0-2x" };
 static SUNXI_CCU_M_WITH_MUX(dram_h3_clk, "dram", dram_h3_parents,
 			    0x0f4, 0, 4, 20, 2, CLK_IS_CRITICAL);
@@ -439,10 +556,30 @@ static const char * const de_parents[] = { "pll-periph0-2x", "pll-de" };
 static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
 				 0x104, 0, 4, 24, 3, BIT(31), 0);
 
+static const char * const tcon0_a64_parents[] = { "pll-mipi", "pll-video0-2x" };
+static const u8 tcon0_a64_table[] = { 0, 2, };
+static SUNXI_CCU_MUX_TABLE_WITH_GATE(tcon0_a64_clk, "tcon0", tcon0_a64_parents,
+				     tcon0_a64_table, 0x118, 24, 3, BIT(31), 0);
+
 static const char * const tcon0_h3_parents[] = { "pll-video0" };
 static SUNXI_CCU_M_WITH_MUX_GATE(tcon0_h3_clk, "tcon0", tcon0_h3_parents,
 				 0x118, 0, 4, 24, 3, BIT(31), 0);
 
+static const char * const tcon1_a64_parents[] = { "pll-video0", "pll-video1" };
+static const u8 tcon1_a64_table[] = { 0, 2, };
+struct ccu_div tcon1_a64_clk = {
+	.enable		= BIT(31),
+	.div		= _SUNXI_CCU_DIV(0, 4),
+	.mux		= _SUNXI_CCU_MUX_TABLE(24, 3, tcon1_a64_table),
+	.common		= {
+		.reg		= 0x11c,
+		.hw.init	= CLK_HW_INIT_PARENTS("tcon1",
+						      tcon1_a64_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
 static const char * const tve_h3_parents[] = { "pll-de", "pll-periph1" };
 static SUNXI_CCU_M_WITH_MUX_GATE(tve_h3_clk, "tve", tve_h3_parents,
 				 0x120, 0, 4, 24, 3, BIT(31), 0);
@@ -458,6 +595,10 @@ static const char * const csi_sclk_parents[] = { "pll-periph0", "pll-periph1" };
 static SUNXI_CCU_M_WITH_MUX_GATE(csi_sclk_clk, "csi-sclk", csi_sclk_parents,
 				 0x134, 16, 4, 24, 3, BIT(31), 0);
 
+static const char * const csi_mclk_a64_parents[] = { "osc24M", "pll-video1", "pll-periph1" };
+static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk_a64_clk, "csi-mclk", csi_mclk_a64_parents,
+				 0x134, 0, 5, 8, 3, BIT(15), 0);
+
 static const char * const csi_mclk_h3_parents[] = { "osc24M", "pll-video0", "pll-periph0" };
 static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk_h3_clk, "csi-mclk", csi_mclk_h3_parents,
 				 0x134, 0, 5, 8, 3, BIT(15), 0);
@@ -467,9 +608,17 @@ static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
 
 static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
 		      0x140, BIT(31), 0);
+
+static SUNXI_CCU_GATE(ac_dig_4x_a64_clk,	"ac-dig-4x",	"pll-audio-4x",
+		      0x140, BIT(30), 0);
+
 static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 		      0x144, BIT(31), 0);
 
+static const char * const hdmi_a64_parents[] = { "pll-video0", "pll-video1" };
+static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_a64_clk, "hdmi", hdmi_a64_parents,
+				 0x150, 0, 4, 24, 2, BIT(31), 0);
+
 static const char * const hdmi_h3_parents[] = { "pll-video0" };
 static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_h3_clk, "hdmi", hdmi_h3_parents,
 				 0x150, 0, 4, 24, 2, BIT(31), 0);
@@ -477,14 +626,25 @@ static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_h3_clk, "hdmi", hdmi_h3_parents,
 static SUNXI_CCU_GATE(hdmi_ddc_clk,	"hdmi-ddc",	"osc24M",
 		      0x154, BIT(31), 0);
 
+static const char * const mbus_a64_parents[] = { "osc24M", "pll-periph0-2x",
+						 "pll-ddr0", "pll-ddr1" };
+static SUNXI_CCU_M_WITH_MUX_GATE(mbus_a64_clk, "mbus", mbus_a64_parents,
+				 0x15c, 0, 3, 24, 2, BIT(31), CLK_IS_CRITICAL);
+
 static const char * const mbus_h3_parents[] = { "osc24M", "pll-periph0-2x", "pll-ddr0" };
 static SUNXI_CCU_M_WITH_MUX_GATE(mbus_h3_clk, "mbus", mbus_h3_parents,
 				 0x15c, 0, 3, 24, 2, BIT(31), CLK_IS_CRITICAL);
 
+static const char * const dsi_dphy_a64_parents[] = { "pll-video0", "pll-periph0" };
+static SUNXI_CCU_M_WITH_MUX_GATE(dsi_dphy_a64_clk, "dsi-dphy", dsi_dphy_a64_parents,
+				 0x168, 0, 3, 24, 2, BIT(31), 0);
+
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 			     0x1a0, 0, 3, BIT(31), 0);
 
 /* Fixed Factor clocks */
+static CLK_FIXED_FACTOR(osc12M_a64_clk, "osc12M", "osc24M", 1, 2, 0);
+
 /* We hardcode the divider to 4 for now */
 static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
 			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
@@ -496,6 +656,10 @@ static CLK_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
 			"pll-audio-base", 1, 2, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR(pll_periph0_2x_clk, "pll-periph0-2x",
 			"pll-periph0", 1, 2, 0);
+static CLK_FIXED_FACTOR(pll_periph1_2x_clk, "pll-periph1-2x",
+			"pll-periph1", 1, 2, 0);
+static CLK_FIXED_FACTOR(pll_video0_2x_clk, "pll-video0-2x",
+			"pll-video0", 1, 2, 0);
 
 static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&pll_cpux_clk.common,
@@ -825,3 +989,322 @@ static void __init sun8i_h3_ccu_setup(struct device_node *node)
 }
 CLK_OF_DECLARE(sun8i_h3_ccu, "allwinner,sun8i-h3-ccu",
 	       sun8i_h3_ccu_setup);
+
+static struct ccu_common *sun50i_a64_ccu_clks[] = {
+	&pll_cpux_clk.common,
+	&pll_audio_base_clk.common,
+	&pll_video0_clk.common,
+	&pll_ve_clk.common,
+	&pll_ddr0_clk.common,
+	&pll_periph0_clk.common,
+	&pll_periph1_a64_clk.common,
+	&pll_video1_a64_clk.common,
+	&pll_gpu_clk.common,
+	&pll_mipi_a64_clk.common,
+	&pll_hsic_a64_clk.common,
+	&pll_de_clk.common,
+	&pll_ddr1_a64_clk.common,
+	&cpux_clk.common,
+	&axi_clk.common,
+	&ahb1_clk.common,
+	&apb1_clk.common,
+	&apb2_a64_clk.common,
+	&ahb2_clk.common,
+	&bus_mipi_dsi_a64_clk.common,
+	&bus_ce_clk.common,
+	&bus_dma_clk.common,
+	&bus_mmc0_clk.common,
+	&bus_mmc1_clk.common,
+	&bus_mmc2_clk.common,
+	&bus_nand_clk.common,
+	&bus_dram_clk.common,
+	&bus_emac_clk.common,
+	&bus_ts_clk.common,
+	&bus_hstimer_clk.common,
+	&bus_spi0_clk.common,
+	&bus_spi1_clk.common,
+	&bus_otg_clk.common,
+	&bus_ehci0_clk.common,
+	&bus_ehci1_clk.common,
+	&bus_ohci0_clk.common,
+	&bus_ohci1_clk.common,
+	&bus_ve_clk.common,
+	&bus_tcon0_clk.common,
+	&bus_tcon1_clk.common,
+	&bus_deinterlace_clk.common,
+	&bus_csi_clk.common,
+	&bus_hdmi_clk.common,
+	&bus_de_clk.common,
+	&bus_gpu_clk.common,
+	&bus_msgbox_clk.common,
+	&bus_spinlock_clk.common,
+	&bus_codec_clk.common,
+	&bus_spdif_clk.common,
+	&bus_pio_clk.common,
+	&bus_ths_clk.common,
+	&bus_i2s0_clk.common,
+	&bus_i2s1_clk.common,
+	&bus_i2s2_clk.common,
+	&bus_i2c0_clk.common,
+	&bus_i2c1_clk.common,
+	&bus_i2c2_clk.common,
+	&bus_scr_a64_clk.common,
+	&bus_uart0_clk.common,
+	&bus_uart1_clk.common,
+	&bus_uart2_clk.common,
+	&bus_uart3_clk.common,
+	&bus_uart4_a64_clk.common,
+	&bus_dbg_clk.common,
+	&ths_clk.common,
+	&nand_clk.common,
+	&mmc0_a64_clk.common,
+	&mmc1_a64_clk.common,
+	&mmc2_a64_clk.common,
+	&ts_clk.common,
+	&ce_a64_clk.common,
+	&spi0_clk.common,
+	&spi1_clk.common,
+	&i2s0_clk.common,
+	&i2s1_clk.common,
+	&i2s2_clk.common,
+	&spdif_clk.common,
+	&usb_phy0_clk.common,
+	&usb_phy1_clk.common,
+	&usb_hsic_a64_clk.common,
+	&usb_hsic_12m_a64_clk.common,
+	&usb_ohci0_a64_clk.common,
+	&usb_ohci1_a64_clk.common,
+	&dram_a64_clk.common,
+	&dram_ve_clk.common,
+	&dram_csi_clk.common,
+	&dram_deinterlace_clk.common,
+	&dram_ts_clk.common,
+	&de_clk.common,
+	&tcon0_a64_clk.common,
+	&tcon1_a64_clk.common,
+	&deinterlace_clk.common,
+	&csi_misc_clk.common,
+	&csi_sclk_clk.common,
+	&csi_mclk_a64_clk.common,
+	&ve_clk.common,
+	&ac_dig_clk.common,
+	&ac_dig_4x_a64_clk.common,
+	&avs_clk.common,
+	&hdmi_a64_clk.common,
+	&hdmi_ddc_clk.common,
+	&mbus_a64_clk.common,
+	&dsi_dphy_a64_clk.common,
+	&gpu_clk.common,
+};
+
+static struct clk_hw_onecell_data sun50i_a64_hw_clks = {
+	.hws	= {
+		[CLK_A64_OSC_12M]	= &osc12M_a64_clk.hw,
+		[CLK_A64_PLL_CPUX]	= &pll_cpux_clk.common.hw,
+		[CLK_A64_PLL_AUDIO_BASE] = &pll_audio_base_clk.common.hw,
+		[CLK_A64_PLL_AUDIO]	= &pll_audio_clk.hw,
+		[CLK_A64_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
+		[CLK_A64_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
+		[CLK_A64_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
+		[CLK_A64_PLL_VIDEO0]	= &pll_video0_clk.common.hw,
+		[CLK_A64_PLL_VIDEO0_2X]	= &pll_video0_2x_clk.hw,
+		[CLK_A64_PLL_VE]	= &pll_ve_clk.common.hw,
+		[CLK_A64_PLL_DDR0]	= &pll_ddr0_clk.common.hw,
+		[CLK_A64_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
+		[CLK_A64_PLL_PERIPH0_2X] = &pll_periph0_2x_clk.hw,
+		[CLK_A64_PLL_PERIPH1]	= &pll_periph1_a64_clk.common.hw,
+		[CLK_A64_PLL_PERIPH1_2X] = &pll_periph1_2x_clk.hw,
+		[CLK_A64_PLL_VIDEO1]	= &pll_video1_a64_clk.common.hw,
+		[CLK_A64_PLL_GPU]	= &pll_gpu_clk.common.hw,
+		[CLK_A64_PLL_MIPI]  	= &pll_mipi_a64_clk.common.hw,
+		[CLK_A64_PLL_HSIC]	= &pll_hsic_a64_clk.common.hw,
+		[CLK_A64_PLL_DE]	= &pll_de_clk.common.hw,
+		[CLK_A64_PLL_DDR1]	= &pll_ddr1_a64_clk.common.hw,
+		[CLK_A64_CPUX]		= &cpux_clk.common.hw,
+		[CLK_A64_AXI]		= &axi_clk.common.hw,
+		[CLK_A64_AHB1]		= &ahb1_clk.common.hw,
+		[CLK_A64_APB1]		= &apb1_clk.common.hw,
+		[CLK_A64_APB2]		= &apb2_a64_clk.common.hw,
+		[CLK_A64_AHB2]		= &ahb2_clk.common.hw,
+		[CLK_A64_BUS_MIPI_DSI]	= &bus_mipi_dsi_a64_clk.common.hw,
+		[CLK_A64_BUS_CE]	= &bus_ce_clk.common.hw,
+		[CLK_A64_BUS_DMA]	= &bus_dma_clk.common.hw,
+		[CLK_A64_BUS_MMC0]	= &bus_mmc0_clk.common.hw,
+		[CLK_A64_BUS_MMC1]	= &bus_mmc1_clk.common.hw,
+		[CLK_A64_BUS_MMC2]	= &bus_mmc2_clk.common.hw,
+		[CLK_A64_BUS_NAND]	= &bus_nand_clk.common.hw,
+		[CLK_A64_BUS_DRAM]	= &bus_dram_clk.common.hw,
+		[CLK_A64_BUS_EMAC]	= &bus_emac_clk.common.hw,
+		[CLK_A64_BUS_TS]	= &bus_ts_clk.common.hw,
+		[CLK_A64_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
+		[CLK_A64_BUS_SPI0]	= &bus_spi0_clk.common.hw,
+		[CLK_A64_BUS_SPI1]	= &bus_spi1_clk.common.hw,
+		[CLK_A64_BUS_OTG]	= &bus_otg_clk.common.hw,
+		[CLK_A64_BUS_EHCI0]	= &bus_ehci0_clk.common.hw,
+		[CLK_A64_BUS_EHCI1]	= &bus_ehci1_clk.common.hw,
+		[CLK_A64_BUS_OHCI0]	= &bus_ohci0_clk.common.hw,
+		[CLK_A64_BUS_OHCI1]	= &bus_ohci1_clk.common.hw,
+		[CLK_A64_BUS_VE]	= &bus_ve_clk.common.hw,
+		[CLK_A64_BUS_TCON0]	= &bus_tcon0_clk.common.hw,
+		[CLK_A64_BUS_TCON1]	= &bus_tcon1_clk.common.hw,
+		[CLK_A64_BUS_DEINTERLACE] = &bus_deinterlace_clk.common.hw,
+		[CLK_A64_BUS_CSI]	= &bus_csi_clk.common.hw,
+		[CLK_A64_BUS_HDMI]	= &bus_hdmi_clk.common.hw,
+		[CLK_A64_BUS_DE]	= &bus_de_clk.common.hw,
+		[CLK_A64_BUS_GPU]	= &bus_gpu_clk.common.hw,
+		[CLK_A64_BUS_MSGBOX]	= &bus_msgbox_clk.common.hw,
+		[CLK_A64_BUS_SPINLOCK]	= &bus_spinlock_clk.common.hw,
+		[CLK_A64_BUS_CODEC]	= &bus_codec_clk.common.hw,
+		[CLK_A64_BUS_SPDIF]	= &bus_spdif_clk.common.hw,
+		[CLK_A64_BUS_PIO]	= &bus_pio_clk.common.hw,
+		[CLK_A64_BUS_THS]	= &bus_ths_clk.common.hw,
+		[CLK_A64_BUS_I2S0]	= &bus_i2s0_clk.common.hw,
+		[CLK_A64_BUS_I2S1]	= &bus_i2s1_clk.common.hw,
+		[CLK_A64_BUS_I2S2]	= &bus_i2s2_clk.common.hw,
+		[CLK_A64_BUS_I2C0]	= &bus_i2c0_clk.common.hw,
+		[CLK_A64_BUS_I2C1]	= &bus_i2c1_clk.common.hw,
+		[CLK_A64_BUS_I2C2]	= &bus_i2c2_clk.common.hw,
+		[CLK_A64_BUS_UART0]	= &bus_uart0_clk.common.hw,
+		[CLK_A64_BUS_UART1]	= &bus_uart1_clk.common.hw,
+		[CLK_A64_BUS_UART2]	= &bus_uart2_clk.common.hw,
+		[CLK_A64_BUS_UART3]	= &bus_uart3_clk.common.hw,
+		[CLK_A64_BUS_UART4]	= &bus_uart4_a64_clk.common.hw,
+		[CLK_A64_BUS_SCR]	= &bus_scr_a64_clk.common.hw,
+		[CLK_A64_BUS_DBG]	= &bus_dbg_clk.common.hw,
+		[CLK_A64_THS]		= &ths_clk.common.hw,
+		[CLK_A64_NAND]		= &nand_clk.common.hw,
+		[CLK_A64_MMC0]		= &mmc0_a64_clk.common.hw,
+		[CLK_A64_MMC1]		= &mmc1_a64_clk.common.hw,
+		[CLK_A64_MMC2]		= &mmc2_a64_clk.common.hw,
+		[CLK_A64_TS]		= &ts_clk.common.hw,
+		[CLK_A64_CE]		= &ce_a64_clk.common.hw,
+		[CLK_A64_SPI0]		= &spi0_clk.common.hw,
+		[CLK_A64_SPI1]		= &spi1_clk.common.hw,
+		[CLK_A64_I2S0]		= &i2s0_clk.common.hw,
+		[CLK_A64_I2S1]		= &i2s1_clk.common.hw,
+		[CLK_A64_I2S2]		= &i2s2_clk.common.hw,
+		[CLK_A64_SPDIF]		= &spdif_clk.common.hw,
+		[CLK_A64_USB_PHY0]	= &usb_phy0_clk.common.hw,
+		[CLK_A64_USB_PHY1]	= &usb_phy1_clk.common.hw,
+		[CLK_A64_USB_HSIC]	= &usb_hsic_a64_clk.common.hw,
+		[CLK_A64_USB_HSIC_12M]	= &usb_hsic_12m_a64_clk.common.hw,
+		[CLK_A64_USB_OHCI0]	= &usb_ohci0_a64_clk.common.hw,
+		[CLK_A64_USB_OHCI1]	= &usb_ohci1_a64_clk.common.hw,
+		[CLK_A64_DRAM]		= &dram_a64_clk.common.hw,
+		[CLK_A64_DRAM_VE]	= &dram_ve_clk.common.hw,
+		[CLK_A64_DRAM_CSI]	= &dram_csi_clk.common.hw,
+		[CLK_A64_DRAM_DEINTERLACE] = &dram_deinterlace_clk.common.hw,
+		[CLK_A64_DRAM_TS]	= &dram_ts_clk.common.hw,
+		[CLK_A64_DE]		= &de_clk.common.hw,
+		[CLK_A64_TCON0]		= &tcon0_a64_clk.common.hw,
+		[CLK_A64_TCON1]		= &tcon1_a64_clk.common.hw,
+		[CLK_A64_DEINTERLACE]	= &deinterlace_clk.common.hw,
+		[CLK_A64_CSI_MISC]	= &csi_misc_clk.common.hw,
+		[CLK_A64_CSI_SCLK]	= &csi_sclk_clk.common.hw,
+		[CLK_A64_CSI_MCLK]	= &csi_mclk_a64_clk.common.hw,
+		[CLK_A64_VE]		= &ve_clk.common.hw,
+		[CLK_A64_AC_DIG]	= &ac_dig_clk.common.hw,
+		[CLK_A64_AC_DIG_4X]	= &ac_dig_4x_a64_clk.common.hw,
+		[CLK_A64_AVS]		= &avs_clk.common.hw,
+		[CLK_A64_HDMI]		= &hdmi_a64_clk.common.hw,
+		[CLK_A64_HDMI_DDC]	= &hdmi_ddc_clk.common.hw,
+		[CLK_A64_MBUS]		= &mbus_a64_clk.common.hw,
+		[CLK_A64_DSI_DPHY]	= &dsi_dphy_a64_clk.common.hw,
+		[CLK_A64_GPU]		= &gpu_clk.common.hw,
+	},
+	.num	= CLK_A64_NUMBER,
+};
+
+static struct ccu_reset_map sun50i_a64_ccu_resets[] = {
+	[RST_A64_USB_PHY0]		=  { 0x0cc, BIT(0) },
+	[RST_A64_USB_PHY1]		=  { 0x0cc, BIT(1) },
+	[RST_A64_USB_HSIC]		=  { 0x0cc, BIT(2) },
+
+
+	[RST_A64_MBUS]			=  { 0x0fc, BIT(31) },
+
+	[RST_A64_BUS_MIPI_DSI]		=  { 0x2c0, BIT(1) },
+	[RST_A64_BUS_CE]		=  { 0x2c0, BIT(5) },
+	[RST_A64_BUS_DMA]		=  { 0x2c0, BIT(6) },
+	[RST_A64_BUS_MMC0]		=  { 0x2c0, BIT(8) },
+	[RST_A64_BUS_MMC1]		=  { 0x2c0, BIT(9) },
+	[RST_A64_BUS_MMC2]		=  { 0x2c0, BIT(10) },
+	[RST_A64_BUS_NAND]		=  { 0x2c0, BIT(13) },
+	[RST_A64_BUS_DRAM]		=  { 0x2c0, BIT(14) },
+	[RST_A64_BUS_EMAC]		=  { 0x2c0, BIT(17) },
+	[RST_A64_BUS_TS]		=  { 0x2c0, BIT(18) },
+	[RST_A64_BUS_HSTIMER]		=  { 0x2c0, BIT(19) },
+	[RST_A64_BUS_SPI0]		=  { 0x2c0, BIT(20) },
+	[RST_A64_BUS_SPI1]		=  { 0x2c0, BIT(21) },
+	[RST_A64_BUS_OTG]		=  { 0x2c0, BIT(23) },
+	[RST_A64_BUS_EHCI0]		=  { 0x2c0, BIT(24) },
+	[RST_A64_BUS_EHCI1]		=  { 0x2c0, BIT(25) },
+	[RST_A64_BUS_OHCI0]		=  { 0x2c0, BIT(28) },
+	[RST_A64_BUS_OHCI1]		=  { 0x2c0, BIT(29) },
+
+	[RST_A64_BUS_VE]		=  { 0x2c4, BIT(0) },
+	[RST_A64_BUS_TCON0]		=  { 0x2c4, BIT(3) },
+	[RST_A64_BUS_TCON1]		=  { 0x2c4, BIT(4) },
+	[RST_A64_BUS_DEINTERLACE]	=  { 0x2c4, BIT(5) },
+	[RST_A64_BUS_CSI]		=  { 0x2c4, BIT(8) },
+	[RST_A64_BUS_HDMI0]		=  { 0x2c4, BIT(10) },
+	[RST_A64_BUS_HDMI1]		=  { 0x2c4, BIT(11) },
+	[RST_A64_BUS_DE]		=  { 0x2c4, BIT(12) },
+	[RST_A64_BUS_GPU]		=  { 0x2c4, BIT(20) },
+	[RST_A64_BUS_MSGBOX]		=  { 0x2c4, BIT(21) },
+	[RST_A64_BUS_SPINLOCK]		=  { 0x2c4, BIT(22) },
+	[RST_A64_BUS_DBG]		=  { 0x2c4, BIT(31) },
+
+	[RST_A64_BUS_LVDS]		=  { 0x2c8, BIT(0) },
+
+	[RST_A64_BUS_CODEC]		=  { 0x2d0, BIT(0) },
+	[RST_A64_BUS_SPDIF]		=  { 0x2d0, BIT(1) },
+	[RST_A64_BUS_THS]		=  { 0x2d0, BIT(8) },
+	[RST_A64_BUS_I2S0]		=  { 0x2d0, BIT(12) },
+	[RST_A64_BUS_I2S1]		=  { 0x2d0, BIT(13) },
+	[RST_A64_BUS_I2S2]		=  { 0x2d0, BIT(14) },
+
+	[RST_A64_BUS_I2C0]		=  { 0x2d4, BIT(0) },
+	[RST_A64_BUS_I2C1]		=  { 0x2d4, BIT(1) },
+	[RST_A64_BUS_I2C2]		=  { 0x2d4, BIT(2) },
+	[RST_A64_BUS_SCR]		=  { 0x2d4, BIT(5) },
+	[RST_A64_BUS_UART0]		=  { 0x2d4, BIT(16) },
+	[RST_A64_BUS_UART1]		=  { 0x2d4, BIT(17) },
+	[RST_A64_BUS_UART2]		=  { 0x2d4, BIT(18) },
+	[RST_A64_BUS_UART3]		=  { 0x2d4, BIT(19) },
+	[RST_A64_BUS_UART4]		=  { 0x2d4, BIT(20) },
+};
+
+static const struct sunxi_ccu_desc sun50i_a64_ccu_desc = {
+	.ccu_clks	= sun50i_a64_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun50i_a64_ccu_clks),
+
+	.hw_clks	= &sun50i_a64_hw_clks,
+
+	.resets		= sun50i_a64_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun50i_a64_ccu_resets),
+};
+
+static void __init sun50i_a64_ccu_setup(struct device_node *node)
+{
+	void __iomem *reg;
+	u32 val;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(reg)) {
+		pr_err("%s: Could not map the clock registers\n",
+		       of_node_full_name(node));
+		return;
+	}
+
+	/* Force the PLL-Audio-1x divider to 4 */
+	val = readl(reg + SUN8I_H3_PLL_AUDIO_REG);
+	val &= ~GENMASK(19, 16);
+	writel(val | (3 << 16), reg + SUN8I_H3_PLL_AUDIO_REG);
+
+	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
+
+	sunxi_ccu_probe(node, reg, &sun50i_a64_ccu_desc);
+}
+CLK_OF_DECLARE(sun50i_a64_ccu, "allwinner,sun50i-a64-ccu",
+	       sun50i_a64_ccu_setup);
diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
new file mode 100644
index 000000000000..192fafc4b443
--- /dev/null
+++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
@@ -0,0 +1,132 @@
+/*
+ * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN50I_A64_H_
+#define _DT_BINDINGS_CLK_SUN50I_A64_H_
+
+#define CLK_A64_BUS_MIPI_DSI		28
+#define CLK_A64_BUS_CE			29
+#define CLK_A64_BUS_DMA			30
+#define CLK_A64_BUS_MMC0		31
+#define CLK_A64_BUS_MMC1		32
+#define CLK_A64_BUS_MMC2		33
+#define CLK_A64_BUS_NAND		34
+#define CLK_A64_BUS_DRAM		35
+#define CLK_A64_BUS_EMAC		36
+#define CLK_A64_BUS_TS			37
+#define CLK_A64_BUS_HSTIMER		38
+#define CLK_A64_BUS_SPI0		39
+#define CLK_A64_BUS_SPI1		40
+#define CLK_A64_BUS_OTG			41
+#define CLK_A64_BUS_EHCI0		42
+#define CLK_A64_BUS_EHCI1		43
+#define CLK_A64_BUS_OHCI0		44
+#define CLK_A64_BUS_OHCI1		45
+#define CLK_A64_BUS_VE			46
+#define CLK_A64_BUS_TCON0		47
+#define CLK_A64_BUS_TCON1		48
+#define CLK_A64_BUS_DEINTERLACE		49
+#define CLK_A64_BUS_CSI			50
+#define CLK_A64_BUS_HDMI		51
+#define CLK_A64_BUS_DE			52
+#define CLK_A64_BUS_GPU			53
+#define CLK_A64_BUS_MSGBOX		54
+#define CLK_A64_BUS_SPINLOCK		55
+#define CLK_A64_BUS_CODEC		56
+#define CLK_A64_BUS_SPDIF		57
+#define CLK_A64_BUS_PIO			58
+#define CLK_A64_BUS_THS			59
+#define CLK_A64_BUS_I2S0		60
+#define CLK_A64_BUS_I2S1		61
+#define CLK_A64_BUS_I2S2		62
+#define CLK_A64_BUS_I2C0		63
+#define CLK_A64_BUS_I2C1		64
+#define CLK_A64_BUS_I2C2		65
+#define CLK_A64_BUS_SCR			66
+#define CLK_A64_BUS_UART0		67
+#define CLK_A64_BUS_UART1		68
+#define CLK_A64_BUS_UART2		69
+#define CLK_A64_BUS_UART3		70
+#define CLK_A64_BUS_UART4		71
+#define CLK_A64_BUS_DBG			72
+#define CLK_A64_THS			73
+#define CLK_A64_NAND			74
+#define CLK_A64_MMC0			75
+#define CLK_A64_MMC1			76
+#define CLK_A64_MMC2			77
+#define CLK_A64_TS			78
+#define CLK_A64_CE			79
+#define CLK_A64_SPI0			80
+#define CLK_A64_SPI1			81
+#define CLK_A64_I2S0			82
+#define CLK_A64_I2S1			83
+#define CLK_A64_I2S2			84
+#define CLK_A64_SPDIF			85
+#define CLK_A64_USB_PHY0		86
+#define CLK_A64_USB_PHY1		87
+#define CLK_A64_USB_HSIC		88
+#define CLK_A64_USB_HSIC_12M		89
+#define CLK_A64_USB_OHCI0		90
+#define CLK_A64_USB_OHCI1		91
+
+#define CLK_A64_DRAM_VE			93
+#define CLK_A64_DRAM_CSI		94
+#define CLK_A64_DRAM_DEINTERLACE	95
+#define CLK_A64_DRAM_TS			96
+#define CLK_A64_DE			97
+#define CLK_A64_TCON0			98
+#define CLK_A64_TCON1			99
+#define CLK_A64_DEINTERLACE		100
+#define CLK_A64_CSI_MISC		101
+#define CLK_A64_CSI_SCLK		102
+#define CLK_A64_CSI_MCLK		103
+#define CLK_A64_VE			104
+#define CLK_A64_AC_DIG			105
+#define CLK_A64_AC_DIG_4X		106
+#define CLK_A64_AVS			107
+#define CLK_A64_HDMI			108
+#define CLK_A64_HDMI_DDC		109
+
+#define CLK_A64_DSI_DPHY		111
+#define CLK_A64_GPU			112
+
+#endif /* _DT_BINDINGS_CLK_SUN50I_A64_H_ */
diff --git a/include/dt-bindings/reset/sun50i-a64-ccu.h b/include/dt-bindings/reset/sun50i-a64-ccu.h
new file mode 100644
index 000000000000..bf5932a7725c
--- /dev/null
+++ b/include/dt-bindings/reset/sun50i-a64-ccu.h
@@ -0,0 +1,97 @@
+/*
+ * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN50I_A64_H_
+#define _DT_BINDINGS_RST_SUN50I_A64_H_
+
+#define RST_A64_USB_PHY0		0
+#define RST_A64_USB_PHY1		1
+#define RST_A64_USB_HSIC		2
+#define RST_A64_MBUS			3
+#define RST_A64_BUS_MIPI_DSI		4
+#define RST_A64_BUS_CE			5
+#define RST_A64_BUS_DMA			6
+#define RST_A64_BUS_MMC0		7
+#define RST_A64_BUS_MMC1		8
+#define RST_A64_BUS_MMC2		9
+#define RST_A64_BUS_NAND		10
+#define RST_A64_BUS_DRAM		11
+#define RST_A64_BUS_EMAC		12
+#define RST_A64_BUS_TS			13
+#define RST_A64_BUS_HSTIMER		14
+#define RST_A64_BUS_SPI0		15
+#define RST_A64_BUS_SPI1		16
+#define RST_A64_BUS_OTG			17
+#define RST_A64_BUS_EHCI0		18
+#define RST_A64_BUS_EHCI1		19
+#define RST_A64_BUS_OHCI0		20
+#define RST_A64_BUS_OHCI1		21
+#define RST_A64_BUS_VE			22
+#define RST_A64_BUS_TCON0		23
+#define RST_A64_BUS_TCON1		24
+#define RST_A64_BUS_DEINTERLACE		25
+#define RST_A64_BUS_CSI			26
+#define RST_A64_BUS_HDMI0		27
+#define RST_A64_BUS_HDMI1		28
+#define RST_A64_BUS_DE			29
+#define RST_A64_BUS_GPU			30
+#define RST_A64_BUS_MSGBOX		31
+#define RST_A64_BUS_SPINLOCK		32
+#define RST_A64_BUS_DBG			33
+#define RST_A64_BUS_LVDS		34
+#define RST_A64_BUS_CODEC		35
+#define RST_A64_BUS_SPDIF		36
+#define RST_A64_BUS_THS			37
+#define RST_A64_BUS_I2S0		38
+#define RST_A64_BUS_I2S1		39
+#define RST_A64_BUS_I2S2		40
+#define RST_A64_BUS_I2C0		41
+#define RST_A64_BUS_I2C1		42
+#define RST_A64_BUS_I2C2		43
+#define RST_A64_BUS_SCR			44
+#define RST_A64_BUS_UART0		45
+#define RST_A64_BUS_UART1		46
+#define RST_A64_BUS_UART2		47
+#define RST_A64_BUS_UART3		48
+#define RST_A64_BUS_UART4		49
+
+#endif /* _DT_BINDINGS_RST_SUN8I_H3_H_ */
-- 
2.9.2
