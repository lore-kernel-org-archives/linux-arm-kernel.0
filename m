From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 15 Aug 2016 16:13:14 +0800
Subject: [PATCH v2 4/5] clk: sunxi-ng: Add A31/A31s clocks
In-Reply-To: <1471248795-17951-1-git-send-email-wens@csie.org>
References: <1471248795-17951-1-git-send-email-wens@csie.org>
Message-ID: <1471248795-17951-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new style driver for the clock control unit in Allwinner A31/A31s.

A few clocks are still missing:

    - MIPI PLL's HDMI mode support
    - EMAC clock

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v1:

  - Explicitly specify number of fixed pre-dividers, instead of trailing
    empty divider entry.
---
 .../devicetree/bindings/clock/sunxi-ccu.txt        |    3 +-
 drivers/clk/sunxi-ng/Kconfig                       |   10 +
 drivers/clk/sunxi-ng/Makefile                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               | 1235 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun6i-a31.h               |   72 ++
 include/dt-bindings/clock/sun6i-a31-ccu.h          |  187 +++
 include/dt-bindings/reset/sun6i-a31-ccu.h          |  106 ++
 7 files changed, 1613 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-a31.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-a31.h
 create mode 100644 include/dt-bindings/clock/sun6i-a31-ccu.h
 create mode 100644 include/dt-bindings/reset/sun6i-a31-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index cb91507ffb1e..eac458720b28 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -2,7 +2,8 @@ Allwinner Clock Control Unit Binding
 ------------------------------------
 
 Required properties :
-- compatible: must contain one of the following compatible:
+- compatible: must contain one of the following compatibles:
+		- "allwinner,sun6i-a31-ccu"
 		- "allwinner,sun8i-h3-ccu"
 
 - reg: Must contain the registers base address and length
diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 2afcbd39e41e..a1dee861474c 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -51,6 +51,16 @@ config SUNXI_CCU_MP
 
 # SoC Drivers
 
+config SUN6I_A31_CCU
+	bool "Support for the Allwinner A31/A31s CCU"
+	select SUNXI_CCU_DIV
+	select SUNXI_CCU_NK
+	select SUNXI_CCU_NKM
+	select SUNXI_CCU_NM
+	select SUNXI_CCU_MP
+	select SUNXI_CCU_PHASE
+	default MACH_SUN6I
+
 config SUN8I_H3_CCU
 	bool "Support for the Allwinner H3 CCU"
 	select SUNXI_CCU_DIV
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 633ce642ffae..261438b00215 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -17,4 +17,5 @@ obj-$(CONFIG_SUNXI_CCU_NM)	+= ccu_nm.o
 obj-$(CONFIG_SUNXI_CCU_MP)	+= ccu_mp.o
 
 # SoC support
+obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
 obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
new file mode 100644
index 000000000000..8c1dd4f2aac8
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -0,0 +1,1235 @@
+/*
+ * Copyright (c) 2016 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * Based on ccu-sun8i-h3.c by Maxime Ripard.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mp.h"
+#include "ccu_mult.h"
+#include "ccu_mux.h"
+#include "ccu_nk.h"
+#include "ccu_nkm.h"
+#include "ccu_nkmp.h"
+#include "ccu_nm.h"
+#include "ccu_phase.h"
+
+#include "ccu-sun6i-a31.h"
+
+static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_cpu_clk, "pll-cpu",
+				     "osc24M", 0x000,
+				     8, 5,	/* N */
+				     4, 2,	/* K */
+				     0, 2,	/* M */
+				     BIT(31),	/* gate */
+				     BIT(28),	/* lock */
+				     0);
+
+/*
+ * The Audio PLL is supposed to have 4 outputs: 3 fixed factors from
+ * the base (2x, 4x and 8x), and one variable divider (the one true
+ * pll audio).
+ *
+ * We don't have any need for the variable divider for now, so we just
+ * hardcode it to match with the clock names
+ */
+#define SUN6I_A31_PLL_AUDIO_REG	0x008
+
+static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
+				   "osc24M", 0x008,
+				   8, 7,	/* N */
+				   0, 5,	/* M */
+				   BIT(31),	/* gate */
+				   BIT(28),	/* lock */
+				   0);
+
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video0_clk, "pll-video0",
+					"osc24M", 0x010,
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
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
+					"osc24M", 0x018,
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
+static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_ddr_clk, "pll-ddr",
+				    "osc24M", 0x020,
+				    8, 5,	/* N */
+				    4, 2,	/* K */
+				    0, 2,	/* M */
+				    BIT(31),	/* gate */
+				    BIT(28),	/* lock */
+				    0);
+
+static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph_clk, "pll-periph",
+					   "osc24M", 0x028,
+					   8, 5,	/* N */
+					   4, 2,	/* K */
+					   BIT(31),	/* gate */
+					   BIT(28),	/* lock */
+					   2,		/* post-div */
+					   0);
+
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video1_clk, "pll-video1",
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
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
+					"osc24M", 0x038,
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
+/*
+ * The MIPI PLL has 2 modes: "MIPI" and "HDMI".
+ *
+ * The MIPI mode is a standard NKM-style clock. The HDMI mode is an
+ * integer / fractional clock with switchable multipliers and dividers.
+ * This is not supported here. We hardcode the PLL to MIPI mode.
+ */
+#define SUN6I_A31_PLL_MIPI_REG	0x040
+
+static const char * const pll_mipi_parents[] = { "pll-video0", "pll-video1" };
+static SUNXI_CCU_NKM_WITH_MUX_GATE_LOCK(pll_mipi_clk, "pll-mipi",
+					pll_mipi_parents, 0x040,
+					8, 4,	/* N */
+					4, 2,	/* K */
+					0, 4,	/* M */
+					21, 0,	/* mux */
+					BIT(31),	/* gate */
+					BIT(28),	/* lock */
+					0);
+
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll9_clk, "pll9",
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
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll10_clk, "pll10",
+					"osc24M", 0x048,
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
+static const char * const cpux_parents[] = { "osc32k", "osc24M",
+					     "pll-cpu", "pll-cpu" };
+static SUNXI_CCU_MUX(cpu_clk, "cpu", cpux_parents,
+		     0x050, 16, 2, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+static struct clk_div_table axi_div_table[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 3 },
+	{ .val = 3, .div = 4 },
+	{ .val = 4, .div = 4 },
+	{ .val = 5, .div = 4 },
+	{ .val = 6, .div = 4 },
+	{ .val = 7, .div = 4 },
+	{ /* Sentinel */ },
+};
+
+static SUNXI_CCU_DIV_TABLE(axi_clk, "axi", "cpu",
+			   0x050, 0, 3, axi_div_table, 0);
+
+static const char * const ahb1_parents[] = { "osc32k", "osc24M",
+					     "axi", "pll-periph" };
+
+static struct ccu_div ahb1_clk = {
+	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
+
+	.mux		= {
+		.shift	= 12,
+		.width	= 2,
+
+		.variable_prediv	= {
+			.index	= 3,
+			.shift	= 6,
+			.width	= 2,
+		},
+	},
+
+	.common		= {
+		.reg		= 0x054,
+		.features	= CCU_FEATURE_VARIABLE_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("ahb1",
+						      ahb1_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct clk_div_table apb1_div_table[] = {
+	{ .val = 0, .div = 2 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 4 },
+	{ .val = 3, .div = 8 },
+	{ /* Sentinel */ },
+};
+
+static SUNXI_CCU_DIV_TABLE(apb1_clk, "apb1", "ahb1",
+			   0x054, 8, 2, apb1_div_table, 0);
+
+static const char * const apb2_parents[] = { "osc32k", "osc24M",
+					     "pll-periph", "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", apb2_parents, 0x058,
+			     0, 5,	/* M */
+			     16, 2,	/* P */
+			     24, 2,	/* mux */
+			     0);
+
+static SUNXI_CCU_GATE(ahb1_mipidsi_clk,	"ahb1-mipidsi",	"ahb1",
+		      0x060, BIT(1), 0);
+static SUNXI_CCU_GATE(ahb1_ss_clk,	"ahb1-ss",	"ahb1",
+		      0x060, BIT(5), 0);
+static SUNXI_CCU_GATE(ahb1_dma_clk,	"ahb1-dma",	"ahb1",
+		      0x060, BIT(6), 0);
+static SUNXI_CCU_GATE(ahb1_mmc0_clk,	"ahb1-mmc0",	"ahb1",
+		      0x060, BIT(8), 0);
+static SUNXI_CCU_GATE(ahb1_mmc1_clk,	"ahb1-mmc1",	"ahb1",
+		      0x060, BIT(9), 0);
+static SUNXI_CCU_GATE(ahb1_mmc2_clk,	"ahb1-mmc2",	"ahb1",
+		      0x060, BIT(10), 0);
+static SUNXI_CCU_GATE(ahb1_mmc3_clk,	"ahb1-mmc3",	"ahb1",
+		      0x060, BIT(12), 0);
+static SUNXI_CCU_GATE(ahb1_nand1_clk,	"ahb1-nand1",	"ahb1",
+		      0x060, BIT(13), 0);
+static SUNXI_CCU_GATE(ahb1_nand0_clk,	"ahb1-nand0",	"ahb1",
+		      0x060, BIT(13), 0);
+static SUNXI_CCU_GATE(ahb1_sdram_clk,	"ahb1-sdram",	"ahb1",
+		      0x060, BIT(14), 0);
+static SUNXI_CCU_GATE(ahb1_emac_clk,	"ahb1-emac",	"ahb1",
+		      0x060, BIT(17), 0);
+static SUNXI_CCU_GATE(ahb1_ts_clk,	"ahb1-ts",	"ahb1",
+		      0x060, BIT(18), 0);
+static SUNXI_CCU_GATE(ahb1_hstimer_clk,	"ahb1-hstimer",	"ahb1",
+		      0x060, BIT(19), 0);
+static SUNXI_CCU_GATE(ahb1_spi0_clk,	"ahb1-spi0",	"ahb1",
+		      0x060, BIT(20), 0);
+static SUNXI_CCU_GATE(ahb1_spi1_clk,	"ahb1-spi1",	"ahb1",
+		      0x060, BIT(21), 0);
+static SUNXI_CCU_GATE(ahb1_spi2_clk,	"ahb1-spi2",	"ahb1",
+		      0x060, BIT(22), 0);
+static SUNXI_CCU_GATE(ahb1_spi3_clk,	"ahb1-spi3",	"ahb1",
+		      0x060, BIT(23), 0);
+static SUNXI_CCU_GATE(ahb1_otg_clk,	"ahb1-otg",	"ahb1",
+		      0x060, BIT(24), 0);
+static SUNXI_CCU_GATE(ahb1_ehci0_clk,	"ahb1-ehci0",	"ahb1",
+		      0x060, BIT(26), 0);
+static SUNXI_CCU_GATE(ahb1_ehci1_clk,	"ahb1-ehci1",	"ahb1",
+		      0x060, BIT(27), 0);
+static SUNXI_CCU_GATE(ahb1_ohci0_clk,	"ahb1-ohci0",	"ahb1",
+		      0x060, BIT(29), 0);
+static SUNXI_CCU_GATE(ahb1_ohci1_clk,	"ahb1-ohci1",	"ahb1",
+		      0x060, BIT(30), 0);
+static SUNXI_CCU_GATE(ahb1_ohci2_clk,	"ahb1-ohci2",	"ahb1",
+		      0x060, BIT(31), 0);
+
+static SUNXI_CCU_GATE(ahb1_ve_clk,	"ahb1-ve",	"ahb1",
+		      0x064, BIT(0), 0);
+static SUNXI_CCU_GATE(ahb1_lcd0_clk,	"ahb1-lcd0",	"ahb1",
+		      0x064, BIT(4), 0);
+static SUNXI_CCU_GATE(ahb1_lcd1_clk,	"ahb1-lcd1",	"ahb1",
+		      0x064, BIT(5), 0);
+static SUNXI_CCU_GATE(ahb1_csi_clk,	"ahb1-csi",	"ahb1",
+		      0x064, BIT(8), 0);
+static SUNXI_CCU_GATE(ahb1_hdmi_clk,	"ahb1-hdmi",	"ahb1",
+		      0x064, BIT(11), 0);
+static SUNXI_CCU_GATE(ahb1_be0_clk,	"ahb1-be0",	"ahb1",
+		      0x064, BIT(12), 0);
+static SUNXI_CCU_GATE(ahb1_be1_clk,	"ahb1-be1",	"ahb1",
+		      0x064, BIT(13), 0);
+static SUNXI_CCU_GATE(ahb1_fe0_clk,	"ahb1-fe0",	"ahb1",
+		      0x064, BIT(14), 0);
+static SUNXI_CCU_GATE(ahb1_fe1_clk,	"ahb1-fe1",	"ahb1",
+		      0x064, BIT(15), 0);
+static SUNXI_CCU_GATE(ahb1_mp_clk,	"ahb1-mp",	"ahb1",
+		      0x064, BIT(18), 0);
+static SUNXI_CCU_GATE(ahb1_gpu_clk,	"ahb1-gpu",	"ahb1",
+		      0x064, BIT(20), 0);
+static SUNXI_CCU_GATE(ahb1_deu0_clk,	"ahb1-deu0",	"ahb1",
+		      0x064, BIT(23), 0);
+static SUNXI_CCU_GATE(ahb1_deu1_clk,	"ahb1-deu1",	"ahb1",
+		      0x064, BIT(24), 0);
+static SUNXI_CCU_GATE(ahb1_drc0_clk,	"ahb1-drc0",	"ahb1",
+		      0x064, BIT(25), 0);
+static SUNXI_CCU_GATE(ahb1_drc1_clk,	"ahb1-drc1",	"ahb1",
+		      0x064, BIT(26), 0);
+
+static SUNXI_CCU_GATE(apb1_codec_clk,	"apb1-codec",	"apb1",
+		      0x068, BIT(0), 0);
+static SUNXI_CCU_GATE(apb1_spdif_clk,	"apb1-spdif",	"apb1",
+		      0x068, BIT(1), 0);
+static SUNXI_CCU_GATE(apb1_digital_mic_clk,	"apb1-digital-mic",	"apb1",
+		      0x068, BIT(4), 0);
+static SUNXI_CCU_GATE(apb1_pio_clk,	"apb1-pio",	"apb1",
+		      0x068, BIT(5), 0);
+static SUNXI_CCU_GATE(apb1_daudio0_clk,	"apb1-daudio0",	"apb1",
+		      0x068, BIT(12), 0);
+static SUNXI_CCU_GATE(apb1_daudio1_clk,	"apb1-daudio1",	"apb1",
+		      0x068, BIT(13), 0);
+
+static SUNXI_CCU_GATE(apb2_i2c0_clk,	"apb2-i2c0",	"apb2",
+		      0x06c, BIT(0), 0);
+static SUNXI_CCU_GATE(apb2_i2c1_clk,	"apb2-i2c1",	"apb2",
+		      0x06c, BIT(1), 0);
+static SUNXI_CCU_GATE(apb2_i2c2_clk,	"apb2-i2c2",	"apb2",
+		      0x06c, BIT(2), 0);
+static SUNXI_CCU_GATE(apb2_i2c3_clk,	"apb2-i2c3",	"apb2",
+		      0x06c, BIT(3), 0);
+static SUNXI_CCU_GATE(apb2_uart0_clk,	"apb2-uart0",	"apb2",
+		      0x06c, BIT(16), 0);
+static SUNXI_CCU_GATE(apb2_uart1_clk,	"apb2-uart1",	"apb2",
+		      0x06c, BIT(17), 0);
+static SUNXI_CCU_GATE(apb2_uart2_clk,	"apb2-uart2",	"apb2",
+		      0x06c, BIT(18), 0);
+static SUNXI_CCU_GATE(apb2_uart3_clk,	"apb2-uart3",	"apb2",
+		      0x06c, BIT(19), 0);
+static SUNXI_CCU_GATE(apb2_uart4_clk,	"apb2-uart4",	"apb2",
+		      0x06c, BIT(20), 0);
+static SUNXI_CCU_GATE(apb2_uart5_clk,	"apb2-uart5",	"apb2",
+		      0x06c, BIT(21), 0);
+
+static const char * const mod0_default_parents[] = { "osc24M", "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(nand0_clk, "nand0", mod0_default_parents,
+				  0x080,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(nand1_clk, "nand1", mod0_default_parents,
+				  0x084,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mod0_default_parents,
+				  0x088,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_PHASE(mmc0_sample_clk, "mmc0_sample", "mmc0",
+		       0x088, 20, 3, 0);
+static SUNXI_CCU_PHASE(mmc0_output_clk, "mmc0_output", "mmc0",
+		       0x088, 8, 3, 0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mod0_default_parents,
+				  0x08c,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_PHASE(mmc1_sample_clk, "mmc1_sample", "mmc1",
+		       0x08c, 20, 3, 0);
+static SUNXI_CCU_PHASE(mmc1_output_clk, "mmc1_output", "mmc1",
+		       0x08c, 8, 3, 0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_parents,
+				  0x090,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_PHASE(mmc2_sample_clk, "mmc2_sample", "mmc2",
+		       0x090, 20, 3, 0);
+static SUNXI_CCU_PHASE(mmc2_output_clk, "mmc2_output", "mmc2",
+		       0x090, 8, 3, 0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc3_clk, "mmc3", mod0_default_parents,
+				  0x094,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_PHASE(mmc3_sample_clk, "mmc3_sample", "mmc3",
+		       0x094, 20, 3, 0);
+static SUNXI_CCU_PHASE(mmc3_output_clk, "mmc3_output", "mmc3",
+		       0x094, 8, 3, 0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", mod0_default_parents, 0x098,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(ss_clk, "ss", mod0_default_parents, 0x09c,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi0_clk, "spi0", mod0_default_parents, 0x0a0,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", mod0_default_parents, 0x0a4,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi2_clk, "spi2", mod0_default_parents, 0x0a8,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi3_clk, "spi3", mod0_default_parents, 0x0ac,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const char * const daudio_parents[] = { "pll-audio-8x", "pll-audio-4x",
+					       "pll-audio-2x", "pll-audio" };
+static SUNXI_CCU_MUX_WITH_GATE(daudio0_clk, "daudio0", daudio_parents,
+			       0x0b0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_MUX_WITH_GATE(daudio1_clk, "daudio1", daudio_parents,
+			       0x0b4, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M_WITH_GATE(spdif_clk, "spdif", "pll-audio",
+			     0x0c0, 0, 4, BIT(31), CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
+		      0x0cc, BIT(8), 0);
+static SUNXI_CCU_GATE(usb_phy1_clk,	"usb-phy1",	"osc24M",
+		      0x0cc, BIT(9), 0);
+static SUNXI_CCU_GATE(usb_phy2_clk,	"usb-phy2",	"osc24M",
+		      0x0cc, BIT(10), 0);
+static SUNXI_CCU_GATE(usb_ohci0_clk,	"usb-ohci0",	"osc24M",
+		      0x0cc, BIT(16), 0);
+static SUNXI_CCU_GATE(usb_ohci1_clk,	"usb-ohci1",	"osc24M",
+		      0x0cc, BIT(17), 0);
+static SUNXI_CCU_GATE(usb_ohci2_clk,	"usb-ohci2",	"osc24M",
+		      0x0cc, BIT(18), 0);
+
+/* TODO emac clk not supported yet */
+
+static const char * const dram_parents[] = { "pll-ddr", "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(mdfs_clk, "mdfs", dram_parents, 0x0f0,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  CLK_IS_CRITICAL);
+
+static SUNXI_CCU_M_WITH_MUX(sdram0_clk, "sdram0", dram_parents,
+			    0x0f4, 0, 4, 4, 1, CLK_IS_CRITICAL);
+static SUNXI_CCU_M_WITH_MUX(sdram1_clk, "sdram1", dram_parents,
+			    0x0f4, 8, 4, 12, 1, CLK_IS_CRITICAL);
+
+static SUNXI_CCU_GATE(dram_ve_clk,	"dram-ve",	"mdfs",
+		      0x100, BIT(0), 0);
+static SUNXI_CCU_GATE(dram_csi_isp_clk,	"dram-csi-isp",	"mdfs",
+		      0x100, BIT(1), 0);
+static SUNXI_CCU_GATE(dram_ts_clk,	"dram-ts",	"mdfs",
+		      0x100, BIT(3), 0);
+static SUNXI_CCU_GATE(dram_drc0_clk,	"dram-drc0",	"mdfs",
+		      0x100, BIT(16), 0);
+static SUNXI_CCU_GATE(dram_drc1_clk,	"dram-drc1",	"mdfs",
+		      0x100, BIT(17), 0);
+static SUNXI_CCU_GATE(dram_deu0_clk,	"dram-deu0",	"mdfs",
+		      0x100, BIT(18), 0);
+static SUNXI_CCU_GATE(dram_deu1_clk,	"dram-deu1",	"mdfs",
+		      0x100, BIT(19), 0);
+static SUNXI_CCU_GATE(dram_fe0_clk,	"dram-fe0",	"mdfs",
+		      0x100, BIT(24), 0);
+static SUNXI_CCU_GATE(dram_fe1_clk,	"dram-fe1",	"mdfs",
+		      0x100, BIT(25), 0);
+static SUNXI_CCU_GATE(dram_be0_clk,	"dram-be0",	"mdfs",
+		      0x100, BIT(26), 0);
+static SUNXI_CCU_GATE(dram_be1_clk,	"dram-be1",	"mdfs",
+		      0x100, BIT(27), 0);
+static SUNXI_CCU_GATE(dram_mp_clk,	"dram-mp",	"mdfs",
+		      0x100, BIT(28), 0);
+
+static const char * const de_parents[] = { "pll-video0", "pll-video1",
+					   "pll-periph-2x", "pll-gpu",
+					   "pll9", "pll10" };
+static SUNXI_CCU_M_WITH_MUX_GATE(be0_clk, "be0", de_parents,
+				 0x104, 0, 4, 24, 3, BIT(31), 0);
+static SUNXI_CCU_M_WITH_MUX_GATE(be1_clk, "be1", de_parents,
+				 0x108, 0, 4, 24, 3, BIT(31), 0);
+static SUNXI_CCU_M_WITH_MUX_GATE(fe0_clk, "fe0", de_parents,
+				 0x10c, 0, 4, 24, 3, BIT(31), 0);
+static SUNXI_CCU_M_WITH_MUX_GATE(fe1_clk, "fe1", de_parents,
+				 0x110, 0, 4, 24, 3, BIT(31), 0);
+
+static const char * const mp_parents[] = { "pll-video0", "pll-video1",
+					   "pll9", "pll10" };
+static SUNXI_CCU_M_WITH_MUX_GATE(mp_clk, "mp", mp_parents,
+				 0x114, 0, 4, 24, 3, BIT(31), 0);
+
+static const char * const lcd_ch0_parents[] = { "pll-video0", "pll-video1",
+						"pll-video0-2x",
+						"pll-video1-2x", "pll-mipi" };
+static SUNXI_CCU_MUX_WITH_GATE(lcd0_ch0_clk, "lcd0-ch0", lcd_ch0_parents,
+			       0x118, 24, 2, BIT(31), 0);
+static SUNXI_CCU_MUX_WITH_GATE(lcd1_ch0_clk, "lcd1-ch0", lcd_ch0_parents,
+			       0x11c, 24, 2, BIT(31), 0);
+
+static const char * const lcd_ch1_parents[] = { "pll-video0", "pll-video1",
+						"pll-video0-2x",
+						"pll-video1-2x" };
+static SUNXI_CCU_M_WITH_MUX_GATE(lcd0_ch1_clk, "lcd0-ch1", lcd_ch1_parents,
+				 0x12c, 0, 4, 24, 3, BIT(31), 0);
+static SUNXI_CCU_M_WITH_MUX_GATE(lcd1_ch1_clk, "lcd1-ch1", lcd_ch1_parents,
+				 0x12c, 0, 4, 24, 3, BIT(31), 0);
+
+static const char * const csi_sclk_parents[] = { "pll-video0", "pll-video1",
+						 "pll9", "pll10", "pll-mipi",
+						 "pll-ve" };
+static SUNXI_CCU_M_WITH_MUX_GATE(csi0_sclk_clk, "csi0-sclk", csi_sclk_parents,
+				 0x134, 16, 4, 24, 3, BIT(31), 0);
+
+static const char * const csi_mclk_parents[] = { "pll-video0", "pll-video1",
+						 "osc24M" };
+static const u8 csi_mclk_table[] = { 0, 1, 5 };
+static struct ccu_div csi0_mclk_clk = {
+	.enable		= BIT(15),
+	.div		= _SUNXI_CCU_DIV(0, 4),
+	.mux		= SUNXI_CLK_MUX_TABLE(8, 3, csi_mclk_table),
+	.common		= {
+		.reg		= 0x134,
+		.hw.init	= CLK_HW_INIT_PARENTS("csi0-mclk",
+						      csi_mclk_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div csi1_mclk_clk = {
+	.enable		= BIT(15),
+	.div		= _SUNXI_CCU_DIV(0, 4),
+	.mux		= SUNXI_CLK_MUX_TABLE(8, 3, csi_mclk_table),
+	.common		= {
+		.reg		= 0x138,
+		.hw.init	= CLK_HW_INIT_PARENTS("csi1-mclk",
+						      csi_mclk_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
+			     0x13c, 16, 3, BIT(31), 0);
+
+static SUNXI_CCU_GATE(codec_clk,	"codec",	"pll-audio",
+		      0x140, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
+		      0x144, BIT(31), 0);
+static SUNXI_CCU_GATE(digital_mic_clk,	"digital-mic",	"pll-audio",
+		      0x148, BIT(31), CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", lcd_ch1_parents,
+				 0x150, 0, 4, 24, 2, BIT(31), 0);
+
+static SUNXI_CCU_GATE(hdmi_ddc_clk, "hdmi-ddc", "osc24M", 0x150, BIT(31), 0);
+
+static SUNXI_CCU_GATE(ps_clk, "ps", "lcd1-ch1", 0x140, BIT(31), 0);
+
+static const char * const mbus_parents[] = { "osc24M", "pll-periph",
+					     "pll-ddr" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(mbus0_clk, "mbus0", mbus_parents, 0x15c,
+				  0, 3,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  CLK_IS_CRITICAL);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(mbus1_clk, "mbus1", mbus_parents, 0x160,
+				  0, 3,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  CLK_IS_CRITICAL);
+
+static SUNXI_CCU_M_WITH_MUX_GATE(mipi_dsi_clk, "mipi-dsi", lcd_ch1_parents,
+				 0x168, 16, 3, 24, 2, BIT(31), 0);
+static SUNXI_CCU_M_WITH_MUX_GATE(mipi_dsi_dphy_clk, "mipi-dsi-dphy",
+				 lcd_ch1_parents, 0x168, 0, 3, 8, 2,
+				 BIT(15), 0);
+static SUNXI_CCU_M_WITH_MUX_GATE(mipi_csi_dphy_clk, "mipi-csi-dphy",
+				 lcd_ch1_parents, 0x168, 0, 3, 8, 2,
+				 BIT(15), 0);
+
+static SUNXI_CCU_M_WITH_MUX_GATE(iep_drc0_clk, "iep-drc0", de_parents,
+				 0x180, 0, 3, 24, 2, BIT(31), 0);
+static SUNXI_CCU_M_WITH_MUX_GATE(iep_drc1_clk, "iep-drc1", de_parents,
+				 0x184, 0, 3, 24, 2, BIT(31), 0);
+static SUNXI_CCU_M_WITH_MUX_GATE(iep_deu0_clk, "iep-deu0", de_parents,
+				 0x188, 0, 3, 24, 2, BIT(31), 0);
+static SUNXI_CCU_M_WITH_MUX_GATE(iep_deu1_clk, "iep-deu1", de_parents,
+				 0x18c, 0, 3, 24, 2, BIT(31), 0);
+
+static const char * const gpu_parents[] = { "pll-gpu", "pll-periph-2x",
+					    "pll-video0", "pll-video1",
+					    "pll9", "pll10" };
+static const struct ccu_mux_fixed_prediv gpu_predivs[] = {
+	{ .index = 1, .div = 3, },
+};
+
+static struct ccu_div gpu_core_clk = {
+	.enable		= BIT(31),
+	.div		= _SUNXI_CCU_DIV(0, 3),
+	.mux		= {
+		.shift		= 24,
+		.width		= 3,
+		.n_predivs	= ARRAY_SIZE(gpu_predivs),
+		.fixed_predivs	= gpu_predivs,
+	},
+	.common		= {
+		.reg		= 0x1a0,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("gpu-core",
+						      gpu_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div gpu_memory_clk = {
+	.enable		= BIT(31),
+	.div		= _SUNXI_CCU_DIV(0, 3),
+	.mux		= {
+		.shift		= 24,
+		.width		= 3,
+		.n_predivs	= ARRAY_SIZE(gpu_predivs),
+		.fixed_predivs	= gpu_predivs,
+	},
+	.common		= {
+		.reg		= 0x1a4,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("gpu-memory",
+						      gpu_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div gpu_hyd_clk = {
+	.enable		= BIT(31),
+	.div		= _SUNXI_CCU_DIV(0, 3),
+	.mux		= {
+		.shift		= 24,
+		.width		= 3,
+		.n_predivs	= ARRAY_SIZE(gpu_predivs),
+		.fixed_predivs	= gpu_predivs,
+	},
+	.common		= {
+		.reg		= 0x1a8,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("gpu-hyd",
+						      gpu_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static SUNXI_CCU_M_WITH_MUX_GATE(ats_clk, "ats", mod0_default_parents, 0x1b0,
+				 0, 3,		/* M */
+				 24, 2,		/* mux */
+				 BIT(31),	/* gate */
+				 0);
+
+static SUNXI_CCU_M_WITH_MUX_GATE(trace_clk, "trace", mod0_default_parents,
+				 0x1b0,
+				 0, 3,		/* M */
+				 24, 2,		/* mux */
+				 BIT(31),	/* gate */
+				 0);
+
+static const char * const clk_out_parents[] = { "osc24M", "osc32k", "osc24M",
+						"axi", "ahb1" };
+static const u8 clk_out_table[] = { 0, 1, 2, 11, 13 };
+
+static const struct ccu_mux_fixed_prediv clk_out_predivs[] = {
+	{ .index = 0, .div = 750, },
+	{ .index = 3, .div = 4, },
+	{ .index = 4, .div = 4, },
+};
+
+static struct ccu_mp out_a_clk = {
+	.enable		= BIT(31),
+	.m		= _SUNXI_CCU_DIV(8, 5),
+	.p		= _SUNXI_CCU_DIV(20, 2),
+	.mux		= {
+		.shift		= 24,
+		.width		= 4,
+		.table		= clk_out_table,
+		.n_predivs	= ARRAY_SIZE(clk_out_predivs),
+		.fixed_predivs	= clk_out_predivs,
+	},
+	.common		= {
+		.reg		= 0x300,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("out-a",
+						      clk_out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_mp out_b_clk = {
+	.enable		= BIT(31),
+	.m		= _SUNXI_CCU_DIV(8, 5),
+	.p		= _SUNXI_CCU_DIV(20, 2),
+	.mux		= {
+		.shift		= 24,
+		.width		= 4,
+		.table		= clk_out_table,
+		.n_predivs	= ARRAY_SIZE(clk_out_predivs),
+		.fixed_predivs	= clk_out_predivs,
+	},
+	.common		= {
+		.reg		= 0x304,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("out-b",
+						      clk_out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_mp out_c_clk = {
+	.enable		= BIT(31),
+	.m		= _SUNXI_CCU_DIV(8, 5),
+	.p		= _SUNXI_CCU_DIV(20, 2),
+	.mux		= {
+		.shift		= 24,
+		.width		= 4,
+		.table		= clk_out_table,
+		.n_predivs	= ARRAY_SIZE(clk_out_predivs),
+		.fixed_predivs	= clk_out_predivs,
+	},
+	.common		= {
+		.reg		= 0x308,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("out-c",
+						      clk_out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_common *sun6i_a31_ccu_clks[] = {
+	&pll_cpu_clk.common,
+	&pll_audio_base_clk.common,
+	&pll_video0_clk.common,
+	&pll_ve_clk.common,
+	&pll_ddr_clk.common,
+	&pll_periph_clk.common,
+	&pll_video1_clk.common,
+	&pll_gpu_clk.common,
+	&pll_mipi_clk.common,
+	&pll9_clk.common,
+	&pll10_clk.common,
+	&cpu_clk.common,
+	&axi_clk.common,
+	&ahb1_clk.common,
+	&apb1_clk.common,
+	&apb2_clk.common,
+	&ahb1_mipidsi_clk.common,
+	&ahb1_ss_clk.common,
+	&ahb1_dma_clk.common,
+	&ahb1_mmc0_clk.common,
+	&ahb1_mmc1_clk.common,
+	&ahb1_mmc2_clk.common,
+	&ahb1_mmc3_clk.common,
+	&ahb1_nand1_clk.common,
+	&ahb1_nand0_clk.common,
+	&ahb1_sdram_clk.common,
+	&ahb1_emac_clk.common,
+	&ahb1_ts_clk.common,
+	&ahb1_hstimer_clk.common,
+	&ahb1_spi0_clk.common,
+	&ahb1_spi1_clk.common,
+	&ahb1_spi2_clk.common,
+	&ahb1_spi3_clk.common,
+	&ahb1_otg_clk.common,
+	&ahb1_ehci0_clk.common,
+	&ahb1_ehci1_clk.common,
+	&ahb1_ohci0_clk.common,
+	&ahb1_ohci1_clk.common,
+	&ahb1_ohci2_clk.common,
+	&ahb1_ve_clk.common,
+	&ahb1_lcd0_clk.common,
+	&ahb1_lcd1_clk.common,
+	&ahb1_csi_clk.common,
+	&ahb1_hdmi_clk.common,
+	&ahb1_be0_clk.common,
+	&ahb1_be1_clk.common,
+	&ahb1_fe0_clk.common,
+	&ahb1_fe1_clk.common,
+	&ahb1_mp_clk.common,
+	&ahb1_gpu_clk.common,
+	&ahb1_deu0_clk.common,
+	&ahb1_deu1_clk.common,
+	&ahb1_drc0_clk.common,
+	&ahb1_drc1_clk.common,
+	&apb1_codec_clk.common,
+	&apb1_spdif_clk.common,
+	&apb1_digital_mic_clk.common,
+	&apb1_pio_clk.common,
+	&apb1_daudio0_clk.common,
+	&apb1_daudio1_clk.common,
+	&apb2_i2c0_clk.common,
+	&apb2_i2c1_clk.common,
+	&apb2_i2c2_clk.common,
+	&apb2_i2c3_clk.common,
+	&apb2_uart0_clk.common,
+	&apb2_uart1_clk.common,
+	&apb2_uart2_clk.common,
+	&apb2_uart3_clk.common,
+	&apb2_uart4_clk.common,
+	&apb2_uart5_clk.common,
+	&nand0_clk.common,
+	&nand1_clk.common,
+	&mmc0_clk.common,
+	&mmc0_sample_clk.common,
+	&mmc0_output_clk.common,
+	&mmc1_clk.common,
+	&mmc1_sample_clk.common,
+	&mmc1_output_clk.common,
+	&mmc2_clk.common,
+	&mmc2_sample_clk.common,
+	&mmc2_output_clk.common,
+	&mmc3_clk.common,
+	&mmc3_sample_clk.common,
+	&mmc3_output_clk.common,
+	&ts_clk.common,
+	&ss_clk.common,
+	&spi0_clk.common,
+	&spi1_clk.common,
+	&spi2_clk.common,
+	&spi3_clk.common,
+	&daudio0_clk.common,
+	&daudio1_clk.common,
+	&spdif_clk.common,
+	&usb_phy0_clk.common,
+	&usb_phy1_clk.common,
+	&usb_phy2_clk.common,
+	&usb_ohci0_clk.common,
+	&usb_ohci1_clk.common,
+	&usb_ohci2_clk.common,
+	&mdfs_clk.common,
+	&sdram0_clk.common,
+	&sdram1_clk.common,
+	&dram_ve_clk.common,
+	&dram_csi_isp_clk.common,
+	&dram_ts_clk.common,
+	&dram_drc0_clk.common,
+	&dram_drc1_clk.common,
+	&dram_deu0_clk.common,
+	&dram_deu1_clk.common,
+	&dram_fe0_clk.common,
+	&dram_fe1_clk.common,
+	&dram_be0_clk.common,
+	&dram_be1_clk.common,
+	&dram_mp_clk.common,
+	&be0_clk.common,
+	&be1_clk.common,
+	&fe0_clk.common,
+	&fe1_clk.common,
+	&mp_clk.common,
+	&lcd0_ch0_clk.common,
+	&lcd1_ch0_clk.common,
+	&lcd0_ch1_clk.common,
+	&lcd1_ch1_clk.common,
+	&csi0_sclk_clk.common,
+	&csi0_mclk_clk.common,
+	&csi1_mclk_clk.common,
+	&ve_clk.common,
+	&codec_clk.common,
+	&avs_clk.common,
+	&digital_mic_clk.common,
+	&hdmi_clk.common,
+	&hdmi_ddc_clk.common,
+	&ps_clk.common,
+	&mbus0_clk.common,
+	&mbus1_clk.common,
+	&mipi_dsi_clk.common,
+	&mipi_dsi_dphy_clk.common,
+	&mipi_csi_dphy_clk.common,
+	&iep_drc0_clk.common,
+	&iep_drc1_clk.common,
+	&iep_deu0_clk.common,
+	&iep_deu1_clk.common,
+	&gpu_core_clk.common,
+	&gpu_memory_clk.common,
+	&gpu_hyd_clk.common,
+	&ats_clk.common,
+	&trace_clk.common,
+	&out_a_clk.common,
+	&out_b_clk.common,
+	&out_c_clk.common,
+};
+
+/* We hardcode the divider to 4 for now */
+static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
+			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
+			"pll-audio-base", 2, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
+			"pll-audio-base", 1, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
+			"pll-audio-base", 1, 2, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR(pll_periph_2x_clk, "pll-periph-2x",
+			"pll-periph", 1, 2, 0);
+static CLK_FIXED_FACTOR(pll_video0_2x_clk, "pll-video0-2x",
+			"pll-video0", 1, 2, 0);
+static CLK_FIXED_FACTOR(pll_video1_2x_clk, "pll-video1-2x",
+			"pll-video1", 1, 2, 0);
+
+static struct clk_hw_onecell_data sun6i_a31_hw_clks = {
+	.hws	= {
+		[CLK_PLL_CPU]		= &pll_cpu_clk.common.hw,
+		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
+		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
+		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
+		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
+		[CLK_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
+		[CLK_PLL_VIDEO0]	= &pll_video0_clk.common.hw,
+		[CLK_PLL_VIDEO0_2X]	= &pll_video0_2x_clk.hw,
+		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
+		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
+		[CLK_PLL_PERIPH]	= &pll_periph_clk.common.hw,
+		[CLK_PLL_PERIPH_2X]	= &pll_periph_2x_clk.hw,
+		[CLK_PLL_VIDEO1]	= &pll_video1_clk.common.hw,
+		[CLK_PLL_VIDEO1_2X]	= &pll_video1_2x_clk.hw,
+		[CLK_PLL_GPU]		= &pll_gpu_clk.common.hw,
+		[CLK_PLL_MIPI]		= &pll_mipi_clk.common.hw,
+		[CLK_PLL9]		= &pll9_clk.common.hw,
+		[CLK_PLL10]		= &pll10_clk.common.hw,
+		[CLK_CPU]		= &cpu_clk.common.hw,
+		[CLK_AXI]		= &axi_clk.common.hw,
+		[CLK_AHB1]		= &ahb1_clk.common.hw,
+		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_APB2]		= &apb2_clk.common.hw,
+		[CLK_AHB1_MIPIDSI]	= &ahb1_mipidsi_clk.common.hw,
+		[CLK_AHB1_SS]		= &ahb1_ss_clk.common.hw,
+		[CLK_AHB1_DMA]		= &ahb1_dma_clk.common.hw,
+		[CLK_AHB1_MMC0]		= &ahb1_mmc0_clk.common.hw,
+		[CLK_AHB1_MMC1]		= &ahb1_mmc1_clk.common.hw,
+		[CLK_AHB1_MMC2]		= &ahb1_mmc2_clk.common.hw,
+		[CLK_AHB1_MMC3]		= &ahb1_mmc3_clk.common.hw,
+		[CLK_AHB1_NAND1]	= &ahb1_nand1_clk.common.hw,
+		[CLK_AHB1_NAND0]	= &ahb1_nand0_clk.common.hw,
+		[CLK_AHB1_SDRAM]	= &ahb1_sdram_clk.common.hw,
+		[CLK_AHB1_EMAC]		= &ahb1_emac_clk.common.hw,
+		[CLK_AHB1_TS]		= &ahb1_ts_clk.common.hw,
+		[CLK_AHB1_HSTIMER]	= &ahb1_hstimer_clk.common.hw,
+		[CLK_AHB1_SPI0]		= &ahb1_spi0_clk.common.hw,
+		[CLK_AHB1_SPI1]		= &ahb1_spi1_clk.common.hw,
+		[CLK_AHB1_SPI2]		= &ahb1_spi2_clk.common.hw,
+		[CLK_AHB1_SPI3]		= &ahb1_spi3_clk.common.hw,
+		[CLK_AHB1_OTG]		= &ahb1_otg_clk.common.hw,
+		[CLK_AHB1_EHCI0]	= &ahb1_ehci0_clk.common.hw,
+		[CLK_AHB1_EHCI1]	= &ahb1_ehci1_clk.common.hw,
+		[CLK_AHB1_OHCI0]	= &ahb1_ohci0_clk.common.hw,
+		[CLK_AHB1_OHCI1]	= &ahb1_ohci1_clk.common.hw,
+		[CLK_AHB1_OHCI2]	= &ahb1_ohci2_clk.common.hw,
+		[CLK_AHB1_VE]		= &ahb1_ve_clk.common.hw,
+		[CLK_AHB1_LCD0]		= &ahb1_lcd0_clk.common.hw,
+		[CLK_AHB1_LCD1]		= &ahb1_lcd1_clk.common.hw,
+		[CLK_AHB1_CSI]		= &ahb1_csi_clk.common.hw,
+		[CLK_AHB1_HDMI]		= &ahb1_hdmi_clk.common.hw,
+		[CLK_AHB1_BE0]		= &ahb1_be0_clk.common.hw,
+		[CLK_AHB1_BE1]		= &ahb1_be1_clk.common.hw,
+		[CLK_AHB1_FE0]		= &ahb1_fe0_clk.common.hw,
+		[CLK_AHB1_FE1]		= &ahb1_fe1_clk.common.hw,
+		[CLK_AHB1_MP]		= &ahb1_mp_clk.common.hw,
+		[CLK_AHB1_GPU]		= &ahb1_gpu_clk.common.hw,
+		[CLK_AHB1_DEU0]		= &ahb1_deu0_clk.common.hw,
+		[CLK_AHB1_DEU1]		= &ahb1_deu1_clk.common.hw,
+		[CLK_AHB1_DRC0]		= &ahb1_drc0_clk.common.hw,
+		[CLK_AHB1_DRC1]		= &ahb1_drc1_clk.common.hw,
+		[CLK_APB1_CODEC]	= &apb1_codec_clk.common.hw,
+		[CLK_APB1_SPDIF]	= &apb1_spdif_clk.common.hw,
+		[CLK_APB1_DIGITAL_MIC]	= &apb1_digital_mic_clk.common.hw,
+		[CLK_APB1_PIO]		= &apb1_pio_clk.common.hw,
+		[CLK_APB1_DAUDIO0]	= &apb1_daudio0_clk.common.hw,
+		[CLK_APB1_DAUDIO1]	= &apb1_daudio1_clk.common.hw,
+		[CLK_APB2_I2C0]		= &apb2_i2c0_clk.common.hw,
+		[CLK_APB2_I2C1]		= &apb2_i2c1_clk.common.hw,
+		[CLK_APB2_I2C2]		= &apb2_i2c2_clk.common.hw,
+		[CLK_APB2_I2C3]		= &apb2_i2c3_clk.common.hw,
+		[CLK_APB2_UART0]	= &apb2_uart0_clk.common.hw,
+		[CLK_APB2_UART1]	= &apb2_uart1_clk.common.hw,
+		[CLK_APB2_UART2]	= &apb2_uart2_clk.common.hw,
+		[CLK_APB2_UART3]	= &apb2_uart3_clk.common.hw,
+		[CLK_APB2_UART4]	= &apb2_uart4_clk.common.hw,
+		[CLK_APB2_UART5]	= &apb2_uart5_clk.common.hw,
+		[CLK_NAND0]		= &nand0_clk.common.hw,
+		[CLK_NAND1]		= &nand1_clk.common.hw,
+		[CLK_MMC0]		= &mmc0_clk.common.hw,
+		[CLK_MMC0_SAMPLE]	= &mmc0_sample_clk.common.hw,
+		[CLK_MMC0_OUTPUT]	= &mmc0_output_clk.common.hw,
+		[CLK_MMC1]		= &mmc1_clk.common.hw,
+		[CLK_MMC1_SAMPLE]	= &mmc1_sample_clk.common.hw,
+		[CLK_MMC1_OUTPUT]	= &mmc1_output_clk.common.hw,
+		[CLK_MMC2]		= &mmc2_clk.common.hw,
+		[CLK_MMC2_SAMPLE]	= &mmc2_sample_clk.common.hw,
+		[CLK_MMC2_OUTPUT]	= &mmc2_output_clk.common.hw,
+		[CLK_MMC3]		= &mmc3_clk.common.hw,
+		[CLK_MMC3_SAMPLE]	= &mmc3_sample_clk.common.hw,
+		[CLK_MMC3_OUTPUT]	= &mmc3_output_clk.common.hw,
+		[CLK_TS]		= &ts_clk.common.hw,
+		[CLK_SS]		= &ss_clk.common.hw,
+		[CLK_SPI0]		= &spi0_clk.common.hw,
+		[CLK_SPI1]		= &spi1_clk.common.hw,
+		[CLK_SPI2]		= &spi2_clk.common.hw,
+		[CLK_SPI3]		= &spi3_clk.common.hw,
+		[CLK_DAUDIO0]		= &daudio0_clk.common.hw,
+		[CLK_DAUDIO1]		= &daudio1_clk.common.hw,
+		[CLK_SPDIF]		= &spdif_clk.common.hw,
+		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
+		[CLK_USB_PHY1]		= &usb_phy1_clk.common.hw,
+		[CLK_USB_PHY2]		= &usb_phy2_clk.common.hw,
+		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
+		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
+		[CLK_USB_OHCI2]		= &usb_ohci2_clk.common.hw,
+		[CLK_MDFS]		= &mdfs_clk.common.hw,
+		[CLK_SDRAM0]		= &sdram0_clk.common.hw,
+		[CLK_SDRAM1]		= &sdram1_clk.common.hw,
+		[CLK_DRAM_VE]		= &dram_ve_clk.common.hw,
+		[CLK_DRAM_CSI_ISP]	= &dram_csi_isp_clk.common.hw,
+		[CLK_DRAM_TS]		= &dram_ts_clk.common.hw,
+		[CLK_DRAM_DRC0]		= &dram_drc0_clk.common.hw,
+		[CLK_DRAM_DRC1]		= &dram_drc1_clk.common.hw,
+		[CLK_DRAM_DEU0]		= &dram_deu0_clk.common.hw,
+		[CLK_DRAM_DEU1]		= &dram_deu1_clk.common.hw,
+		[CLK_DRAM_FE0]		= &dram_fe0_clk.common.hw,
+		[CLK_DRAM_FE1]		= &dram_fe1_clk.common.hw,
+		[CLK_DRAM_BE0]		= &dram_be0_clk.common.hw,
+		[CLK_DRAM_BE1]		= &dram_be1_clk.common.hw,
+		[CLK_DRAM_MP]		= &dram_mp_clk.common.hw,
+		[CLK_BE0]		= &be0_clk.common.hw,
+		[CLK_BE1]		= &be1_clk.common.hw,
+		[CLK_FE0]		= &fe0_clk.common.hw,
+		[CLK_FE1]		= &fe1_clk.common.hw,
+		[CLK_MP]		= &mp_clk.common.hw,
+		[CLK_LCD0_CH0]		= &lcd0_ch0_clk.common.hw,
+		[CLK_LCD1_CH0]		= &lcd1_ch0_clk.common.hw,
+		[CLK_LCD0_CH1]		= &lcd0_ch1_clk.common.hw,
+		[CLK_LCD1_CH1]		= &lcd1_ch1_clk.common.hw,
+		[CLK_CSI0_SCLK]		= &csi0_sclk_clk.common.hw,
+		[CLK_CSI0_MCLK]		= &csi0_mclk_clk.common.hw,
+		[CLK_CSI1_MCLK]		= &csi1_mclk_clk.common.hw,
+		[CLK_VE]		= &ve_clk.common.hw,
+		[CLK_CODEC]		= &codec_clk.common.hw,
+		[CLK_AVS]		= &avs_clk.common.hw,
+		[CLK_DIGITAL_MIC]	= &digital_mic_clk.common.hw,
+		[CLK_HDMI]		= &hdmi_clk.common.hw,
+		[CLK_HDMI_DDC]		= &hdmi_ddc_clk.common.hw,
+		[CLK_PS]		= &ps_clk.common.hw,
+		[CLK_MBUS0]		= &mbus0_clk.common.hw,
+		[CLK_MBUS1]		= &mbus1_clk.common.hw,
+		[CLK_MIPI_DSI]		= &mipi_dsi_clk.common.hw,
+		[CLK_MIPI_DSI_DPHY]	= &mipi_dsi_dphy_clk.common.hw,
+		[CLK_MIPI_CSI_DPHY]	= &mipi_csi_dphy_clk.common.hw,
+		[CLK_IEP_DRC0]		= &iep_drc0_clk.common.hw,
+		[CLK_IEP_DRC1]		= &iep_drc1_clk.common.hw,
+		[CLK_IEP_DEU0]		= &iep_deu0_clk.common.hw,
+		[CLK_IEP_DEU1]		= &iep_deu1_clk.common.hw,
+		[CLK_GPU_CORE]		= &gpu_core_clk.common.hw,
+		[CLK_GPU_MEMORY]	= &gpu_memory_clk.common.hw,
+		[CLK_GPU_HYD]		= &gpu_hyd_clk.common.hw,
+		[CLK_ATS]		= &ats_clk.common.hw,
+		[CLK_TRACE]		= &trace_clk.common.hw,
+		[CLK_OUT_A]		= &out_a_clk.common.hw,
+		[CLK_OUT_B]		= &out_b_clk.common.hw,
+		[CLK_OUT_C]		= &out_c_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun6i_a31_ccu_resets[] = {
+	[RST_USB_PHY0]		= { 0x0cc, BIT(0) },
+	[RST_USB_PHY1]		= { 0x0cc, BIT(1) },
+	[RST_USB_PHY2]		= { 0x0cc, BIT(2) },
+
+	[RST_AHB1_MIPI_DSI]	= { 0x2c0, BIT(1) },
+	[RST_AHB1_SS]		= { 0x2c0, BIT(5) },
+	[RST_AHB1_DMA]		= { 0x2c0, BIT(6) },
+	[RST_AHB1_MMC0]		= { 0x2c0, BIT(8) },
+	[RST_AHB1_MMC1]		= { 0x2c0, BIT(9) },
+	[RST_AHB1_MMC2]		= { 0x2c0, BIT(10) },
+	[RST_AHB1_MMC3]		= { 0x2c0, BIT(11) },
+	[RST_AHB1_NAND1]	= { 0x2c0, BIT(12) },
+	[RST_AHB1_NAND0]	= { 0x2c0, BIT(13) },
+	[RST_AHB1_SDRAM]	= { 0x2c0, BIT(14) },
+	[RST_AHB1_EMAC]		= { 0x2c0, BIT(17) },
+	[RST_AHB1_TS]		= { 0x2c0, BIT(18) },
+	[RST_AHB1_HSTIMER]	= { 0x2c0, BIT(19) },
+	[RST_AHB1_SPI0]		= { 0x2c0, BIT(20) },
+	[RST_AHB1_SPI1]		= { 0x2c0, BIT(21) },
+	[RST_AHB1_SPI2]		= { 0x2c0, BIT(22) },
+	[RST_AHB1_SPI3]		= { 0x2c0, BIT(23) },
+	[RST_AHB1_OTG]		= { 0x2c0, BIT(24) },
+	[RST_AHB1_EHCI0]	= { 0x2c0, BIT(26) },
+	[RST_AHB1_EHCI1]	= { 0x2c0, BIT(27) },
+	[RST_AHB1_OHCI0]	= { 0x2c0, BIT(29) },
+	[RST_AHB1_OHCI1]	= { 0x2c0, BIT(30) },
+	[RST_AHB1_OHCI2]	= { 0x2c0, BIT(31) },
+
+	[RST_AHB1_VE]		= { 0x2c4, BIT(0) },
+	[RST_AHB1_LCD0]		= { 0x2c4, BIT(4) },
+	[RST_AHB1_LCD1]		= { 0x2c4, BIT(5) },
+	[RST_AHB1_CSI]		= { 0x2c4, BIT(8) },
+	[RST_AHB1_HDMI]		= { 0x2c4, BIT(11) },
+	[RST_AHB1_BE0]		= { 0x2c4, BIT(12) },
+	[RST_AHB1_BE1]		= { 0x2c4, BIT(13) },
+	[RST_AHB1_FE0]		= { 0x2c4, BIT(14) },
+	[RST_AHB1_FE1]		= { 0x2c4, BIT(15) },
+	[RST_AHB1_MP]		= { 0x2c4, BIT(18) },
+	[RST_AHB1_GPU]		= { 0x2c4, BIT(20) },
+	[RST_AHB1_DEU0]		= { 0x2c4, BIT(23) },
+	[RST_AHB1_DEU1]		= { 0x2c4, BIT(24) },
+	[RST_AHB1_DRC0]		= { 0x2c4, BIT(25) },
+	[RST_AHB1_DRC1]		= { 0x2c4, BIT(26) },
+	[RST_AHB1_LVDS]		= { 0x2c8, BIT(0) },
+
+	[RST_APB1_CODEC]	= { 0x2d0, BIT(0) },
+	[RST_APB1_SPDIF]	= { 0x2d0, BIT(1) },
+	[RST_APB1_DIGITAL_MIC]	= { 0x2d0, BIT(4) },
+	[RST_APB1_DAUDIO0]	= { 0x2d0, BIT(12) },
+	[RST_APB1_DAUDIO1]	= { 0x2d0, BIT(13) },
+
+	[RST_APB2_I2C0]		= { 0x2d8, BIT(0) },
+	[RST_APB2_I2C1]		= { 0x2d8, BIT(1) },
+	[RST_APB2_I2C2]		= { 0x2d8, BIT(2) },
+	[RST_APB2_I2C3]		= { 0x2d8, BIT(3) },
+	[RST_APB2_UART0]	= { 0x2d8, BIT(16) },
+	[RST_APB2_UART1]	= { 0x2d8, BIT(17) },
+	[RST_APB2_UART2]	= { 0x2d8, BIT(18) },
+	[RST_APB2_UART3]	= { 0x2d8, BIT(19) },
+	[RST_APB2_UART4]	= { 0x2d8, BIT(20) },
+	[RST_APB2_UART5]	= { 0x2d8, BIT(21) },
+};
+
+static const struct sunxi_ccu_desc sun6i_a31_ccu_desc = {
+	.ccu_clks	= sun6i_a31_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun6i_a31_ccu_clks),
+
+	.hw_clks	= &sun6i_a31_hw_clks,
+
+	.resets		= sun6i_a31_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun6i_a31_ccu_resets),
+};
+
+static struct ccu_mux_nb sun6i_a31_cpu_nb = {
+	.common		= &cpu_clk.common,
+	.cm		= &cpu_clk.mux,
+	.delay_us	= 1, /* > 8 clock cycles at 24 MHz */
+	.bypass_index	= 1, /* index of 24 MHz oscillator */
+};
+
+static void __init sun6i_a31_ccu_setup(struct device_node *node)
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
+	val = readl(reg + SUN6I_A31_PLL_AUDIO_REG);
+	val &= ~GENMASK(19, 16);
+	writel(val | (3 << 16), reg + SUN6I_A31_PLL_AUDIO_REG);
+
+	/* Force PLL-MIPI to MIPI mode */
+	val = readl(reg + SUN6I_A31_PLL_MIPI_REG);
+	val &= BIT(16);
+	writel(val, reg + SUN6I_A31_PLL_MIPI_REG);
+
+	sunxi_ccu_probe(node, reg, &sun6i_a31_ccu_desc);
+
+	ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
+				  &sun6i_a31_cpu_nb);
+}
+CLK_OF_DECLARE(sun6i_a31_ccu, "allwinner,sun6i-a31-ccu",
+	       sun6i_a31_ccu_setup);
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.h b/drivers/clk/sunxi-ng/ccu-sun6i-a31.h
new file mode 100644
index 000000000000..4e434011e9e7
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.h
@@ -0,0 +1,72 @@
+/*
+ * Copyright 2016 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
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
+#ifndef _CCU_SUN6I_A31_H_
+#define _CCU_SUN6I_A31_H_
+
+#include <dt-bindings/clock/sun6i-a31-ccu.h>
+#include <dt-bindings/reset/sun6i-a31-ccu.h>
+
+#define CLK_PLL_CPU		0
+#define CLK_PLL_AUDIO_BASE	1
+#define CLK_PLL_AUDIO		2
+#define CLK_PLL_AUDIO_2X	3
+#define CLK_PLL_AUDIO_4X	4
+#define CLK_PLL_AUDIO_8X	5
+#define CLK_PLL_VIDEO0		6
+#define CLK_PLL_VIDEO0_2X	7
+#define CLK_PLL_VE		8
+#define CLK_PLL_DDR		9
+
+/* The PLL_PERIPH clock is exported */
+
+#define CLK_PLL_PERIPH_2X	11
+#define CLK_PLL_VIDEO1		12
+#define CLK_PLL_VIDEO1_2X	13
+#define CLK_PLL_GPU		14
+#define CLK_PLL_MIPI		15
+#define CLK_PLL9		16
+#define CLK_PLL10		17
+
+/* The CPUX clock is exported */
+
+#define CLK_AXI			19
+#define CLK_AHB1		20
+#define CLK_APB1		21
+#define CLK_APB2		22
+
+/* All the bus gates are exported */
+
+/* The first bunch of module clocks are exported */
+
+/* EMAC clock is not implemented */
+
+#define CLK_MDFS		107
+#define CLK_SDRAM0		108
+#define CLK_SDRAM1		109
+
+/* All the DRAM gates are exported */
+
+/* Some more module clocks are exported */
+
+#define CLK_MBUS0		141
+#define CLK_MBUS1		142
+
+/* Some more module clocks and external clock outputs are exported */
+
+#define CLK_NUMBER		(CLK_OUT_C + 1)
+
+#endif /* _CCU_SUN6I_A31_H_ */
diff --git a/include/dt-bindings/clock/sun6i-a31-ccu.h b/include/dt-bindings/clock/sun6i-a31-ccu.h
new file mode 100644
index 000000000000..4482530fb6f5
--- /dev/null
+++ b/include/dt-bindings/clock/sun6i-a31-ccu.h
@@ -0,0 +1,187 @@
+/*
+ * Copyright (C) 2016 Chen-Yu Tsai <wens@csie.org>
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
+#ifndef _DT_BINDINGS_CLK_SUN6I_A31_H_
+#define _DT_BINDINGS_CLK_SUN6I_A31_H_
+
+#define CLK_PLL_PERIPH		10
+
+#define CLK_CPU			18
+
+#define CLK_AHB1_MIPIDSI	23
+#define CLK_AHB1_SS		24
+#define CLK_AHB1_DMA		25
+#define CLK_AHB1_MMC0		26
+#define CLK_AHB1_MMC1		27
+#define CLK_AHB1_MMC2		28
+#define CLK_AHB1_MMC3		29
+#define CLK_AHB1_NAND1		30
+#define CLK_AHB1_NAND0		31
+#define CLK_AHB1_SDRAM		32
+#define CLK_AHB1_EMAC		33
+#define CLK_AHB1_TS		34
+#define CLK_AHB1_HSTIMER	35
+#define CLK_AHB1_SPI0		36
+#define CLK_AHB1_SPI1		37
+#define CLK_AHB1_SPI2		38
+#define CLK_AHB1_SPI3		39
+#define CLK_AHB1_OTG		40
+#define CLK_AHB1_EHCI0		41
+#define CLK_AHB1_EHCI1		42
+#define CLK_AHB1_OHCI0		43
+#define CLK_AHB1_OHCI1		44
+#define CLK_AHB1_OHCI2		45
+#define CLK_AHB1_VE		46
+#define CLK_AHB1_LCD0		47
+#define CLK_AHB1_LCD1		48
+#define CLK_AHB1_CSI		49
+#define CLK_AHB1_HDMI		50
+#define CLK_AHB1_BE0		51
+#define CLK_AHB1_BE1		52
+#define CLK_AHB1_FE0		53
+#define CLK_AHB1_FE1		54
+#define CLK_AHB1_MP		55
+#define CLK_AHB1_GPU		56
+#define CLK_AHB1_DEU0		57
+#define CLK_AHB1_DEU1		58
+#define CLK_AHB1_DRC0		59
+#define CLK_AHB1_DRC1		60
+
+#define CLK_APB1_CODEC		61
+#define CLK_APB1_SPDIF		62
+#define CLK_APB1_DIGITAL_MIC	63
+#define CLK_APB1_PIO		64
+#define CLK_APB1_DAUDIO0	65
+#define CLK_APB1_DAUDIO1	66
+
+#define CLK_APB2_I2C0		67
+#define CLK_APB2_I2C1		68
+#define CLK_APB2_I2C2		69
+#define CLK_APB2_I2C3		70
+#define CLK_APB2_UART0		71
+#define CLK_APB2_UART1		72
+#define CLK_APB2_UART2		73
+#define CLK_APB2_UART3		74
+#define CLK_APB2_UART4		75
+#define CLK_APB2_UART5		76
+
+#define CLK_NAND0		77
+#define CLK_NAND1		78
+#define CLK_MMC0		79
+#define CLK_MMC0_SAMPLE		80
+#define CLK_MMC0_OUTPUT		81
+#define CLK_MMC1		82
+#define CLK_MMC1_SAMPLE		83
+#define CLK_MMC1_OUTPUT		84
+#define CLK_MMC2		85
+#define CLK_MMC2_SAMPLE		86
+#define CLK_MMC2_OUTPUT		87
+#define CLK_MMC3		88
+#define CLK_MMC3_SAMPLE		89
+#define CLK_MMC3_OUTPUT		90
+#define CLK_TS			91
+#define CLK_SS			92
+#define CLK_SPI0		93
+#define CLK_SPI1		94
+#define CLK_SPI2		95
+#define CLK_SPI3		96
+#define CLK_DAUDIO0		97
+#define CLK_DAUDIO1		98
+#define CLK_SPDIF		99
+#define CLK_USB_PHY0		100
+#define CLK_USB_PHY1		101
+#define CLK_USB_PHY2		102
+#define CLK_USB_OHCI0		103
+#define CLK_USB_OHCI1		104
+#define CLK_USB_OHCI2		105
+
+#define CLK_DRAM_VE		110
+#define CLK_DRAM_CSI_ISP	111
+#define CLK_DRAM_TS		112
+#define CLK_DRAM_DRC0		113
+#define CLK_DRAM_DRC1		114
+#define CLK_DRAM_DEU0		115
+#define CLK_DRAM_DEU1		116
+#define CLK_DRAM_FE0		117
+#define CLK_DRAM_FE1		118
+#define CLK_DRAM_BE0		119
+#define CLK_DRAM_BE1		120
+#define CLK_DRAM_MP		121
+
+#define CLK_BE0			122
+#define CLK_BE1			123
+#define CLK_FE0			124
+#define CLK_FE1			125
+#define CLK_MP			126
+#define CLK_LCD0_CH0		127
+#define CLK_LCD1_CH0		128
+#define CLK_LCD0_CH1		129
+#define CLK_LCD1_CH1		130
+#define CLK_CSI0_SCLK		131
+#define CLK_CSI0_MCLK		132
+#define CLK_CSI1_MCLK		133
+#define CLK_VE			134
+#define CLK_CODEC		135
+#define CLK_AVS			136
+#define CLK_DIGITAL_MIC		137
+#define CLK_HDMI		138
+#define CLK_HDMI_DDC		139
+#define CLK_PS			140
+
+#define CLK_MIPI_DSI		143
+#define CLK_MIPI_DSI_DPHY	144
+#define CLK_MIPI_CSI_DPHY	145
+#define CLK_IEP_DRC0		146
+#define CLK_IEP_DRC1		147
+#define CLK_IEP_DEU0		148
+#define CLK_IEP_DEU1		149
+#define CLK_GPU_CORE		150
+#define CLK_GPU_MEMORY		151
+#define CLK_GPU_HYD		152
+#define CLK_ATS			153
+#define CLK_TRACE		154
+
+#define CLK_OUT_A		155
+#define CLK_OUT_B		156
+#define CLK_OUT_C		157
+
+#endif /* _DT_BINDINGS_CLK_SUN6I_A31_H_ */
diff --git a/include/dt-bindings/reset/sun6i-a31-ccu.h b/include/dt-bindings/reset/sun6i-a31-ccu.h
new file mode 100644
index 000000000000..fbff365ed6e1
--- /dev/null
+++ b/include/dt-bindings/reset/sun6i-a31-ccu.h
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2016 Chen-Yu Tsai <wens@csie.org>
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
+#ifndef _DT_BINDINGS_RST_SUN6I_A31_H_
+#define _DT_BINDINGS_RST_SUN6I_A31_H_
+
+#define RST_USB_PHY0		0
+#define RST_USB_PHY1		1
+#define RST_USB_PHY2		2
+
+#define RST_AHB1_MIPI_DSI	3
+#define RST_AHB1_SS		4
+#define RST_AHB1_DMA		5
+#define RST_AHB1_MMC0		6
+#define RST_AHB1_MMC1		7
+#define RST_AHB1_MMC2		8
+#define RST_AHB1_MMC3		9
+#define RST_AHB1_NAND1		10
+#define RST_AHB1_NAND0		11
+#define RST_AHB1_SDRAM		12
+#define RST_AHB1_EMAC		13
+#define RST_AHB1_TS		14
+#define RST_AHB1_HSTIMER	15
+#define RST_AHB1_SPI0		16
+#define RST_AHB1_SPI1		17
+#define RST_AHB1_SPI2		18
+#define RST_AHB1_SPI3		19
+#define RST_AHB1_OTG		20
+#define RST_AHB1_EHCI0		21
+#define RST_AHB1_EHCI1		22
+#define RST_AHB1_OHCI0		23
+#define RST_AHB1_OHCI1		24
+#define RST_AHB1_OHCI2		25
+#define RST_AHB1_VE		26
+#define RST_AHB1_LCD0		27
+#define RST_AHB1_LCD1		28
+#define RST_AHB1_CSI		29
+#define RST_AHB1_HDMI		30
+#define RST_AHB1_BE0		31
+#define RST_AHB1_BE1		32
+#define RST_AHB1_FE0		33
+#define RST_AHB1_FE1		34
+#define RST_AHB1_MP		35
+#define RST_AHB1_GPU		36
+#define RST_AHB1_DEU0		37
+#define RST_AHB1_DEU1		38
+#define RST_AHB1_DRC0		39
+#define RST_AHB1_DRC1		40
+#define RST_AHB1_LVDS		41
+
+#define RST_APB1_CODEC		42
+#define RST_APB1_SPDIF		43
+#define RST_APB1_DIGITAL_MIC	44
+#define RST_APB1_DAUDIO0	45
+#define RST_APB1_DAUDIO1	46
+#define RST_APB2_I2C0		47
+#define RST_APB2_I2C1		48
+#define RST_APB2_I2C2		49
+#define RST_APB2_I2C3		50
+#define RST_APB2_UART0		51
+#define RST_APB2_UART1		52
+#define RST_APB2_UART2		53
+#define RST_APB2_UART3		54
+#define RST_APB2_UART4		55
+#define RST_APB2_UART5		56
+
+#endif /* _DT_BINDINGS_RST_SUN6I_A31_H_ */
-- 
2.8.1
