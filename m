From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 17 Jan 2017 02:01:14 +0800
Subject: [PATCH v2 2/4] clk: sunxi-ng: add support for V3s CCU
In-Reply-To: <20170116180116.36729-2-icenowy@aosc.xyz>
References: <20170116180116.36729-2-icenowy@aosc.xyz>
Message-ID: <20170116180116.36729-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V3s has a similar but cut-down CCU to H3.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---

I think I should make a comparsion between V3s and H3 CCU here:
(I won't mention the missing/added clocks here, only list conflicting clocks)

- "bus-ehci0" is at different bit (The bit that is "bus-ehci0" on V3s is
  "bus-ehci2" on H3)
- The mux of "ce" is different. (According the view at V3s datasheet by the
  author of sun4i-ss, V3s may have sun4i-ss, not sun8i-ce)
- The mux of "de" is different. (V3s do not have "pll-de", but it can mux "de"
  to "pll-video")
- Clocks about CSI largely differs. (As V3s is designed as a camera SoC, and
  it have an extra "pll-isp")

 drivers/clk/sunxi-ng/Kconfig              |  11 +
 drivers/clk/sunxi-ng/Makefile             |   1 +
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c      | 590 ++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h      |  63 ++++
 include/dt-bindings/clock/sun8i-v3s-ccu.h | 107 ++++++
 include/dt-bindings/reset/sun8i-v3s-ccu.h |  78 ++++
 6 files changed, 850 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
 create mode 100644 include/dt-bindings/clock/sun8i-v3s-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-v3s-ccu.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 8454c6e3dd65..1ca48255802f 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -109,4 +109,15 @@ config SUN8I_H3_CCU
 	select SUNXI_CCU_PHASE
 	default MACH_SUN8I
 
+config SUN8I_V3S_CCU
+	bool "Support for the Allwinner V3s CCU"
+	select SUNXI_CCU_DIV
+	select SUNXI_CCU_NK
+	select SUNXI_CCU_NKM
+	select SUNXI_CCU_NKMP
+	select SUNXI_CCU_NM
+	select SUNXI_CCU_MP
+	select SUNXI_CCU_PHASE
+	default MACH_SUN8I
+
 endif
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 24fbc6e5deb8..d1cd81a0f112 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
 obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
 obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
 obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
+obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
new file mode 100644
index 000000000000..e569af9338c2
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -0,0 +1,590 @@
+/*
+ * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * Based on ccu-sun8i-h3.c, which is:
+ * Copyright (c) 2016 Maxime Ripard. All rights reserved.
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
+#include "ccu_nk.h"
+#include "ccu_nkm.h"
+#include "ccu_nkmp.h"
+#include "ccu_nm.h"
+#include "ccu_phase.h"
+
+#include "ccu-sun8i-v3s.h"
+
+static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpu_clk, "pll-cpu",
+				     "osc24M", 0x000,
+				     8, 5,	/* N */
+				     4, 2,	/* K */
+				     0, 2,	/* M */
+				     16, 2,	/* P */
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
+#define SUN8I_V3S_PLL_AUDIO_REG	0x008
+
+static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
+				   "osc24M", 0x008,
+				   8, 7,	/* N */
+				   0, 5,	/* M */
+				   BIT(31),	/* gate */
+				   BIT(28),	/* lock */
+				   0);
+
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video_clk, "pll-video",
+					"osc24M", 0x0010,
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
+					"osc24M", 0x0018,
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
+static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph0_clk, "pll-periph0",
+					   "osc24M", 0x028,
+					   8, 5,	/* N */
+					   4, 2,	/* K */
+					   BIT(31),	/* gate */
+					   BIT(28),	/* lock */
+					   2,		/* post-div */
+					   0);
+
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_isp_clk, "pll-isp",
+					"osc24M", 0x002c,
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
+static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph1_clk, "pll-periph1",
+					   "osc24M", 0x044,
+					   8, 5,	/* N */
+					   4, 2,	/* K */
+					   BIT(31),	/* gate */
+					   BIT(28),	/* lock */
+					   2,		/* post-div */
+					   0);
+
+static const char * const cpu_parents[] = { "osc32k", "osc24M",
+					     "pll-cpu" , "pll-cpu" };
+static SUNXI_CCU_MUX(cpu_clk, "cpu", cpu_parents,
+		     0x050, 16, 2, CLK_IS_CRITICAL);
+
+static SUNXI_CCU_M(axi_clk, "axi", "cpu", 0x050, 0, 2, 0);
+
+static const char * const ahb1_parents[] = { "osc32k", "osc24M",
+					     "axi" , "pll-periph0" };
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
+static SUNXI_CCU_DIV_TABLE(apb1_clk, "apb1", "ahb1",
+			   0x054, 8, 2, apb1_div_table, 0);
+
+static const char * const apb2_parents[] = { "osc32k", "osc24M",
+					     "pll-periph0" , "pll-periph0" };
+static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", apb2_parents, 0x058,
+			     0, 5,	/* M */
+			     16, 2,	/* P */
+			     24, 2,	/* mux */
+			     0);
+
+static const char * const ahb2_parents[] = { "ahb1" , "pll-periph0" };
+static const struct ccu_mux_fixed_prediv ahb2_fixed_predivs[] = {
+	{ .index = 1, .div = 2 },
+};
+static struct ccu_mux ahb2_clk = {
+	.mux		= {
+		.shift	= 0,
+		.width	= 1,
+		.fixed_predivs	= ahb2_fixed_predivs,
+		.n_predivs	= ARRAY_SIZE(ahb2_fixed_predivs),
+	},
+
+	.common		= {
+		.reg		= 0x05c,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("ahb2",
+						      ahb2_parents,
+						      &ccu_mux_ops,
+						      0),
+	},
+};
+
+static SUNXI_CCU_GATE(bus_ce_clk,	"bus-ce",	"ahb1",
+		      0x060, BIT(5), 0);
+static SUNXI_CCU_GATE(bus_dma_clk,	"bus-dma",	"ahb1",
+		      0x060, BIT(6), 0);
+static SUNXI_CCU_GATE(bus_mmc0_clk,	"bus-mmc0",	"ahb1",
+		      0x060, BIT(8), 0);
+static SUNXI_CCU_GATE(bus_mmc1_clk,	"bus-mmc1",	"ahb1",
+		      0x060, BIT(9), 0);
+static SUNXI_CCU_GATE(bus_mmc2_clk,	"bus-mmc2",	"ahb1",
+		      0x060, BIT(10), 0);
+static SUNXI_CCU_GATE(bus_dram_clk,	"bus-dram",	"ahb1",
+		      0x060, BIT(14), 0);
+static SUNXI_CCU_GATE(bus_emac_clk,	"bus-emac",	"ahb2",
+		      0x060, BIT(17), 0);
+static SUNXI_CCU_GATE(bus_hstimer_clk,	"bus-hstimer",	"ahb1",
+		      0x060, BIT(19), 0);
+static SUNXI_CCU_GATE(bus_spi0_clk,	"bus-spi0",	"ahb1",
+		      0x060, BIT(20), 0);
+static SUNXI_CCU_GATE(bus_otg_clk,	"bus-otg",	"ahb1",
+		      0x060, BIT(24), 0);
+static SUNXI_CCU_GATE(bus_ehci0_clk,	"bus-ehci0",	"ahb1",
+		      0x060, BIT(26), 0);
+static SUNXI_CCU_GATE(bus_ohci0_clk,	"bus-ohci0",	"ahb1",
+		      0x060, BIT(29), 0);
+
+static SUNXI_CCU_GATE(bus_ve_clk,	"bus-ve",	"ahb1",
+		      0x064, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_tcon0_clk,	"bus-tcon0",	"ahb1",
+		      0x064, BIT(4), 0);
+static SUNXI_CCU_GATE(bus_csi_clk,	"bus-csi",	"ahb1",
+		      0x064, BIT(8), 0);
+static SUNXI_CCU_GATE(bus_de_clk,	"bus-de",	"ahb1",
+		      0x064, BIT(12), 0);
+
+static SUNXI_CCU_GATE(bus_codec_clk,	"bus-codec",	"apb1",
+		      0x068, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_pio_clk,	"bus-pio",	"apb1",
+		      0x068, BIT(5), 0);
+
+static SUNXI_CCU_GATE(bus_i2c0_clk,	"bus-i2c0",	"apb2",
+		      0x06c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_i2c1_clk,	"bus-i2c1",	"apb2",
+		      0x06c, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_uart0_clk,	"bus-uart0",	"apb2",
+		      0x06c, BIT(16), 0);
+static SUNXI_CCU_GATE(bus_uart1_clk,	"bus-uart1",	"apb2",
+		      0x06c, BIT(17), 0);
+static SUNXI_CCU_GATE(bus_uart2_clk,	"bus-uart2",	"apb2",
+		      0x06c, BIT(18), 0);
+
+static SUNXI_CCU_GATE(bus_ephy_clk,	"bus-ephy",	"ahb1",
+		      0x070, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_dbg_clk,	"bus-dbg",	"ahb1",
+		      0x070, BIT(7), 0);
+
+static const char * const mod0_default_parents[] = { "osc24M", "pll-periph0",
+						     "pll-periph1" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mod0_default_parents, 0x088,
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
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mod0_default_parents, 0x08c,
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
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_parents, 0x090,
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
+static const char * const ce_parents[] = { "osc24M", "pll-periph0", };
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x09c,
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
+static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
+		      0x0cc, BIT(8), 0);
+static SUNXI_CCU_GATE(usb_ohci0_clk,	"usb-ohci0",	"osc24M",
+		      0x0cc, BIT(16), 0);
+
+static const char * const dram_parents[] = { "pll-ddr", "pll-periph0-2x" };
+static SUNXI_CCU_M_WITH_MUX(dram_clk, "dram", dram_parents,
+			    0x0f4, 0, 4, 20, 2, CLK_IS_CRITICAL);
+
+static SUNXI_CCU_GATE(dram_ve_clk,	"dram-ve",	"dram",
+		      0x100, BIT(0), 0);
+static SUNXI_CCU_GATE(dram_csi_clk,	"dram-csi",	"dram",
+		      0x100, BIT(1), 0);
+static SUNXI_CCU_GATE(dram_ehci_clk,	"dram-ehci",	"dram",
+		      0x100, BIT(17), 0);
+static SUNXI_CCU_GATE(dram_ohci_clk,	"dram-ohci",	"dram",
+		      0x100, BIT(18), 0);
+
+static const char * const de_parents[] = { "pll-video", "pll-periph0" };
+static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
+				 0x104, 0, 4, 24, 2, BIT(31), 0);
+
+static const char * const tcon_parents[] = { "pll-video" };
+static SUNXI_CCU_M_WITH_MUX_GATE(tcon_clk, "tcon", tcon_parents,
+				 0x118, 0, 4, 24, 3, BIT(31), 0);
+
+static SUNXI_CCU_GATE(csi_misc_clk,	"csi-misc",	"osc24M",
+		      0x130, BIT(31), 0);
+
+static const char * const csi_mclk_parents[] = { "osc24M", "pll-video",
+						 "pll-periph0", "pll-periph1" };
+static SUNXI_CCU_M_WITH_MUX_GATE(csi0_mclk_clk, "csi0-mclk", csi_mclk_parents,
+				 0x130, 0, 5, 8, 3, BIT(15), 0);
+
+static const char * const csi1_sclk_parents[] = { "pll-video", "pll-isp" };
+static SUNXI_CCU_M_WITH_MUX_GATE(csi1_sclk_clk, "csi-sclk", csi1_sclk_parents,
+				 0x134, 16, 4, 24, 3, BIT(31), 0);
+
+static SUNXI_CCU_M_WITH_MUX_GATE(csi1_mclk_clk, "csi-mclk", csi_mclk_parents,
+				 0x134, 0, 5, 8, 3, BIT(15), 0);
+
+static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
+			     0x13c, 16, 3, BIT(31), 0);
+
+static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
+		      0x140, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
+		      0x144, BIT(31), 0);
+
+static const char * const mbus_parents[] = { "osc24M", "pll-periph0-2x", "pll-ddr" };
+static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents,
+				 0x15c, 0, 3, 24, 2, BIT(31), CLK_IS_CRITICAL);
+
+static const char * const mipi_csi_parents[] = { "pll-video", "pll-periph0",
+						 "pll-isp" };
+static SUNXI_CCU_M_WITH_MUX_GATE(mipi_csi_clk, "mipi-csi", mipi_csi_parents,
+			     0x16c, 0, 3, 24, 2, BIT(31), 0);
+
+static struct ccu_common *sun8i_v3s_ccu_clks[] = {
+	&pll_cpu_clk.common,
+	&pll_audio_base_clk.common,
+	&pll_video_clk.common,
+	&pll_ve_clk.common,
+	&pll_ddr_clk.common,
+	&pll_periph0_clk.common,
+	&pll_isp_clk.common,
+	&pll_periph1_clk.common,
+	&cpu_clk.common,
+	&axi_clk.common,
+	&ahb1_clk.common,
+	&apb1_clk.common,
+	&apb2_clk.common,
+	&ahb2_clk.common,
+	&bus_ce_clk.common,
+	&bus_dma_clk.common,
+	&bus_mmc0_clk.common,
+	&bus_mmc1_clk.common,
+	&bus_mmc2_clk.common,
+	&bus_dram_clk.common,
+	&bus_emac_clk.common,
+	&bus_hstimer_clk.common,
+	&bus_spi0_clk.common,
+	&bus_otg_clk.common,
+	&bus_ehci0_clk.common,
+	&bus_ohci0_clk.common,
+	&bus_ve_clk.common,
+	&bus_tcon0_clk.common,
+	&bus_csi_clk.common,
+	&bus_de_clk.common,
+	&bus_codec_clk.common,
+	&bus_pio_clk.common,
+	&bus_i2c0_clk.common,
+	&bus_i2c1_clk.common,
+	&bus_uart0_clk.common,
+	&bus_uart1_clk.common,
+	&bus_uart2_clk.common,
+	&bus_ephy_clk.common,
+	&bus_dbg_clk.common,
+	&mmc0_clk.common,
+	&mmc0_sample_clk.common,
+	&mmc0_output_clk.common,
+	&mmc1_clk.common,
+	&mmc1_sample_clk.common,
+	&mmc1_output_clk.common,
+	&mmc2_clk.common,
+	&mmc2_sample_clk.common,
+	&mmc2_output_clk.common,
+	&ce_clk.common,
+	&spi0_clk.common,
+	&usb_phy0_clk.common,
+	&usb_ohci0_clk.common,
+	&dram_clk.common,
+	&dram_ve_clk.common,
+	&dram_csi_clk.common,
+	&dram_ohci_clk.common,
+	&dram_ehci_clk.common,
+	&de_clk.common,
+	&tcon_clk.common,
+	&csi_misc_clk.common,
+	&csi0_mclk_clk.common,
+	&csi1_sclk_clk.common,
+	&csi1_mclk_clk.common,
+	&ve_clk.common,
+	&ac_dig_clk.common,
+	&avs_clk.common,
+	&mbus_clk.common,
+	&mipi_csi_clk.common,
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
+static CLK_FIXED_FACTOR(pll_periph0_2x_clk, "pll-periph0-2x",
+			"pll-periph0", 1, 2, 0);
+
+static struct clk_hw_onecell_data sun8i_v3s_hw_clks = {
+	.hws	= {
+		[CLK_PLL_CPU]		= &pll_cpu_clk.common.hw,
+		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
+		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
+		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
+		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
+		[CLK_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
+		[CLK_PLL_VIDEO]		= &pll_video_clk.common.hw,
+		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
+		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
+		[CLK_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
+		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
+		[CLK_PLL_ISP]		= &pll_isp_clk.common.hw,
+		[CLK_PLL_PERIPH1]	= &pll_periph1_clk.common.hw,
+		[CLK_CPU]		= &cpu_clk.common.hw,
+		[CLK_AXI]		= &axi_clk.common.hw,
+		[CLK_AHB1]		= &ahb1_clk.common.hw,
+		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_APB2]		= &apb2_clk.common.hw,
+		[CLK_AHB2]		= &ahb2_clk.common.hw,
+		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
+		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
+		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
+		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
+		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
+		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
+		[CLK_BUS_EMAC]		= &bus_emac_clk.common.hw,
+		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
+		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
+		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
+		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
+		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
+		[CLK_BUS_VE]		= &bus_ve_clk.common.hw,
+		[CLK_BUS_TCON0]		= &bus_tcon0_clk.common.hw,
+		[CLK_BUS_CSI]		= &bus_csi_clk.common.hw,
+		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
+		[CLK_BUS_CODEC]		= &bus_codec_clk.common.hw,
+		[CLK_BUS_PIO]		= &bus_pio_clk.common.hw,
+		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
+		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
+		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
+		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
+		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
+		[CLK_BUS_EPHY]		= &bus_ephy_clk.common.hw,
+		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
+		[CLK_MMC0]		= &mmc0_clk.common.hw,
+		[CLK_MMC0_SAMPLE]	= &mmc0_sample_clk.common.hw,
+		[CLK_MMC0_OUTPUT]	= &mmc0_output_clk.common.hw,
+		[CLK_MMC1]		= &mmc1_clk.common.hw,
+		[CLK_MMC1_SAMPLE]	= &mmc1_sample_clk.common.hw,
+		[CLK_MMC1_OUTPUT]	= &mmc1_output_clk.common.hw,
+		[CLK_CE]		= &ce_clk.common.hw,
+		[CLK_SPI0]		= &spi0_clk.common.hw,
+		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
+		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
+		[CLK_DRAM]		= &dram_clk.common.hw,
+		[CLK_DRAM_VE]		= &dram_ve_clk.common.hw,
+		[CLK_DRAM_CSI]		= &dram_csi_clk.common.hw,
+		[CLK_DRAM_EHCI]		= &dram_ehci_clk.common.hw,
+		[CLK_DRAM_OHCI]		= &dram_ohci_clk.common.hw,
+		[CLK_DE]		= &de_clk.common.hw,
+		[CLK_TCON0]		= &tcon_clk.common.hw,
+		[CLK_CSI_MISC]		= &csi_misc_clk.common.hw,
+		[CLK_CSI0_MCLK]		= &csi0_mclk_clk.common.hw,
+		[CLK_CSI1_SCLK]		= &csi1_sclk_clk.common.hw,
+		[CLK_CSI1_MCLK]		= &csi1_mclk_clk.common.hw,
+		[CLK_VE]		= &ve_clk.common.hw,
+		[CLK_AC_DIG]		= &ac_dig_clk.common.hw,
+		[CLK_AVS]		= &avs_clk.common.hw,
+		[CLK_MBUS]		= &mbus_clk.common.hw,
+		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun8i_v3s_ccu_resets[] = {
+	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
+
+	[RST_MBUS]		=  { 0x0fc, BIT(31) },
+
+	[RST_BUS_CE]		=  { 0x2c0, BIT(5) },
+	[RST_BUS_DMA]		=  { 0x2c0, BIT(6) },
+	[RST_BUS_MMC0]		=  { 0x2c0, BIT(8) },
+	[RST_BUS_MMC1]		=  { 0x2c0, BIT(9) },
+	[RST_BUS_MMC2]		=  { 0x2c0, BIT(10) },
+	[RST_BUS_DRAM]		=  { 0x2c0, BIT(14) },
+	[RST_BUS_EMAC]		=  { 0x2c0, BIT(17) },
+	[RST_BUS_HSTIMER]	=  { 0x2c0, BIT(19) },
+	[RST_BUS_SPI0]		=  { 0x2c0, BIT(20) },
+	[RST_BUS_OTG]		=  { 0x2c0, BIT(23) },
+	[RST_BUS_EHCI0]		=  { 0x2c0, BIT(26) },
+	[RST_BUS_OHCI0]		=  { 0x2c0, BIT(29) },
+
+	[RST_BUS_VE]		=  { 0x2c4, BIT(0) },
+	[RST_BUS_TCON0]		=  { 0x2c4, BIT(3) },
+	[RST_BUS_CSI]		=  { 0x2c4, BIT(8) },
+	[RST_BUS_DE]		=  { 0x2c4, BIT(12) },
+	[RST_BUS_DBG]		=  { 0x2c4, BIT(31) },
+
+	[RST_BUS_EPHY]		=  { 0x2c8, BIT(2) },
+
+	[RST_BUS_CODEC]		=  { 0x2d0, BIT(0) },
+
+	[RST_BUS_I2C0]		=  { 0x2d8, BIT(0) },
+	[RST_BUS_I2C1]		=  { 0x2d8, BIT(1) },
+	[RST_BUS_UART0]		=  { 0x2d8, BIT(16) },
+	[RST_BUS_UART1]		=  { 0x2d8, BIT(17) },
+	[RST_BUS_UART2]		=  { 0x2d8, BIT(18) },
+};
+
+static const struct sunxi_ccu_desc sun8i_v3s_ccu_desc = {
+	.ccu_clks	= sun8i_v3s_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_v3s_ccu_clks),
+
+	.hw_clks	= &sun8i_v3s_hw_clks,
+
+	.resets		= sun8i_v3s_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun8i_v3s_ccu_resets),
+};
+
+static void __init sun8i_v3s_ccu_setup(struct device_node *node)
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
+	val = readl(reg + SUN8I_V3S_PLL_AUDIO_REG);
+	val &= ~GENMASK(19, 16);
+	writel(val | (3 << 16), reg + SUN8I_V3S_PLL_AUDIO_REG);
+
+	sunxi_ccu_probe(node, reg, &sun8i_v3s_ccu_desc);
+}
+CLK_OF_DECLARE(sun8i_v3s_ccu, "allwinner,sun8i-v3s-ccu",
+	       sun8i_v3s_ccu_setup);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
new file mode 100644
index 000000000000..77fee2a4888e
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.xyz>
+ * 
+ * Based on ccu-sun8i-h3.h, which is:
+ * Copyright (c) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
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
+#ifndef _CCU_SUN8I_H3_H_
+#define _CCU_SUN8I_H3_H_
+
+#include <dt-bindings/clock/sun8i-v3s-ccu.h>
+#include <dt-bindings/reset/sun8i-v3s-ccu.h>
+
+#define CLK_PLL_CPU		0
+#define CLK_PLL_AUDIO_BASE	1
+#define CLK_PLL_AUDIO		2
+#define CLK_PLL_AUDIO_2X	3
+#define CLK_PLL_AUDIO_4X	4
+#define CLK_PLL_AUDIO_8X	5
+#define CLK_PLL_VIDEO		6
+#define CLK_PLL_VE		7
+#define CLK_PLL_DDR		8
+#define CLK_PLL_PERIPH0		9
+#define CLK_PLL_PERIPH0_2X	10
+#define CLK_PLL_ISP		11
+#define CLK_PLL_PERIPH1		12
+/* Reserve one number for not implemented and not used PLL_DDR1 */
+
+/* The CPU clock is exported */
+
+#define CLK_AXI			15
+#define CLK_AHB1		16
+#define CLK_APB1		17
+#define CLK_APB2		18
+#define CLK_AHB2		19
+
+/* All the bus gates are exported */
+
+/* The first bunch of module clocks are exported */
+
+#define CLK_DRAM		58
+
+/* All the DRAM gates are exported */
+
+/* Some more module clocks are exported */
+
+#define CLK_MBUS		72
+
+/* And the GPU module clock is exported */
+
+#define CLK_NUMBER		(CLK_MIPI_CSI + 1)
+
+#endif /* _CCU_SUN8I_H3_H_ */
diff --git a/include/dt-bindings/clock/sun8i-v3s-ccu.h b/include/dt-bindings/clock/sun8i-v3s-ccu.h
new file mode 100644
index 000000000000..c0d5d5599c87
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-v3s-ccu.h
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * Based on sun8i-h3-ccu.h, which is:
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
+#ifndef _DT_BINDINGS_CLK_SUN8I_V3S_H_
+#define _DT_BINDINGS_CLK_SUN8I_V3S_H_
+
+#define CLK_CPU			14
+
+#define CLK_BUS_CE		20
+#define CLK_BUS_DMA		21
+#define CLK_BUS_MMC0		22
+#define CLK_BUS_MMC1		23
+#define CLK_BUS_MMC2		24
+#define CLK_BUS_DRAM		25
+#define CLK_BUS_EMAC		26
+#define CLK_BUS_HSTIMER		27
+#define CLK_BUS_SPI0		28
+#define CLK_BUS_OTG		29
+#define CLK_BUS_EHCI0		30
+#define CLK_BUS_OHCI0		31
+#define CLK_BUS_VE		32
+#define CLK_BUS_TCON0		33
+#define CLK_BUS_CSI		34
+#define CLK_BUS_DE		35
+#define CLK_BUS_CODEC		36
+#define CLK_BUS_PIO		37
+#define CLK_BUS_I2C0		38
+#define CLK_BUS_I2C1		39
+#define CLK_BUS_UART0		40
+#define CLK_BUS_UART1		41
+#define CLK_BUS_UART2		42
+#define CLK_BUS_EPHY		43
+#define CLK_BUS_DBG		44
+
+#define CLK_MMC0		45
+#define CLK_MMC0_SAMPLE		46
+#define CLK_MMC0_OUTPUT		47
+#define CLK_MMC1		48
+#define CLK_MMC1_SAMPLE		49
+#define CLK_MMC1_OUTPUT		50
+#define CLK_MMC2		51
+#define CLK_MMC2_SAMPLE		52
+#define CLK_MMC2_OUTPUT		53
+#define CLK_CE			54
+#define CLK_SPI0		55
+#define CLK_USB_PHY0		56
+#define CLK_USB_OHCI0		57
+
+#define CLK_DRAM_VE		59
+#define CLK_DRAM_CSI		60
+#define CLK_DRAM_EHCI		61
+#define CLK_DRAM_OHCI		62
+#define CLK_DE			63
+#define CLK_TCON0		64
+#define CLK_CSI_MISC		65
+#define CLK_CSI0_MCLK		66
+#define CLK_CSI1_SCLK		67
+#define CLK_CSI1_MCLK		68
+#define CLK_VE			69
+#define CLK_AC_DIG		70
+#define CLK_AVS			71
+
+#define CLK_MIPI_CSI		73
+
+#endif /* _DT_BINDINGS_CLK_SUN8I_V3S_H_ */
diff --git a/include/dt-bindings/reset/sun8i-v3s-ccu.h b/include/dt-bindings/reset/sun8i-v3s-ccu.h
new file mode 100644
index 000000000000..b58ef21a2e18
--- /dev/null
+++ b/include/dt-bindings/reset/sun8i-v3s-ccu.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * Based on sun8i-v3s-ccu.h, which is
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
+#ifndef _DT_BINDINGS_RST_SUN8I_V3S_H_
+#define _DT_BINDINGS_RST_SUN8I_V3S_H_
+
+#define RST_USB_PHY0		0
+
+#define RST_MBUS		1
+
+#define RST_BUS_CE		5
+#define RST_BUS_DMA		6
+#define RST_BUS_MMC0		7
+#define RST_BUS_MMC1		8
+#define RST_BUS_MMC2		9
+#define RST_BUS_DRAM		11
+#define RST_BUS_EMAC		12
+#define RST_BUS_HSTIMER		14
+#define RST_BUS_SPI0		15
+#define RST_BUS_OTG		17
+#define RST_BUS_EHCI0		18
+#define RST_BUS_OHCI0		22
+#define RST_BUS_VE		26
+#define RST_BUS_TCON0		27
+#define RST_BUS_CSI		30
+#define RST_BUS_DE		34
+#define RST_BUS_DBG		38
+#define RST_BUS_EPHY		39
+#define RST_BUS_CODEC		40
+#define RST_BUS_I2C0		46
+#define RST_BUS_I2C1		47
+#define RST_BUS_UART0		49
+#define RST_BUS_UART1		50
+#define RST_BUS_UART2		51
+
+#endif /* _DT_BINDINGS_RST_SUN8I_H3_H_ */
-- 
2.11.0
