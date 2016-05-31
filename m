From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 31 May 2016 09:32:41 +0200
Subject: [PATCH RFC 2/2] clk: sunxi-ng: Add the A83T clocks
In-Reply-To: <cover.1464680865.git.moinejf@free.fr>
References: <cover.1464680865.git.moinejf@free.fr>
Message-ID: <8c3b58f5a6119c7f1114b35ad53151bb0a5f6c19.1464680865.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clocks and resets found in the A83T CCU.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c  | 755 +++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/sun8i-a83t.h | 150 +++++++
 include/dt-bindings/reset/sun8i-a83t.h |  96 +++++
 3 files changed, 1001 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
 create mode 100644 include/dt-bindings/clock/sun8i-a83t.h
 create mode 100644 include/dt-bindings/reset/sun8i-a83t.h

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
new file mode 100644
index 0000000..96178b5
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -0,0 +1,753 @@
+/*
+ * Copyright (c) 2016 Jean-Francois Moine <moinejf@free.fr>
+ * Based on the H3 version from
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
+#include <linux/rational.h>
+
+#include <dt-bindings/clock/sun8i-a83t.h>
+#include <dt-bindings/reset/sun8i-a83t.h>
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+#include "ccu_factor.h"
+#include "ccu_fixed_factor.h"
+#include "ccu_gate.h"
+#include "ccu_m.h"
+#include "ccu_mp.h"
+#include "ccu_ndmp.h"
+#include "ccu_p.h"
+#include "ccu_phase.h"
+
+/* 2 * cpux */
+/*	rate = 24MHz * n */
+static struct ccu_ndmp pll_c0cpux_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(0),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 7),
+
+	.common		= {
+		.reg		= 0x000,
+		.features	= CCU_FEATURE_N0,
+		.hw.init	= SUNXI_HW_INIT("pll-cpux",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+static struct ccu_ndmp pll_c1cpux_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(1),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 7),
+
+	.common		= {
+		.reg		= 0x004,
+		.features	= CCU_FEATURE_N0,
+		.hw.init	= SUNXI_HW_INIT("pll-cpux",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+/* audio */
+/*	rate = 24MHz * n / (d1 + 1) / (d2 + 1) / (p + 1) */
+static struct ccu_ndmp pll_audio_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(2),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 8),
+	.d1		= SUNXI_CLK_FACTOR(16, 1),
+	.d2		= SUNXI_CLK_FACTOR(18, 1),
+	.m		= SUNXI_CLK_FACTOR(0, 6),	/* (p) post div */
+
+	.common		= {
+		.reg		= 0x008,
+		.features	= CCU_FEATURE_N0,
+		.hw.init	= SUNXI_HW_INIT("pll-audio",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+/* video 0 */
+/*	rate = 24MHz * n / (d1 + 1) >> p */
+static struct ccu_ndmp pll_video0_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(3),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 7),
+	.d1		= SUNXI_CLK_FACTOR(16, 1),
+	.p		= SUNXI_CLK_FACTOR(0, 2),
+
+	.common		= {
+		.reg		= 0x010,
+		.features	= CCU_FEATURE_N0,
+		.hw.init	= SUNXI_HW_INIT("pll-video0",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+/* video engine */
+/*	rate = 24MHz * n / (d1 + 1) / (d2 + 1) */
+static struct ccu_ndmp pll_ve_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(4),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 8),
+	.d1		= SUNXI_CLK_FACTOR(16, 1),
+	.d2		= SUNXI_CLK_FACTOR(18, 1),
+
+	.common		= {
+		.reg		= 0x018,
+		.features	= CCU_FEATURE_N0,
+		.hw.init	= SUNXI_HW_INIT("pll-ve",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+/* ddr */
+/*	rate = 24MHz * (n + 1) / (d1 + 1) / (d2 + 1)
+ *	bit 21: DDR_CLOCK = PLL_DDR / PLL_PERIPH (default DDR)
+ *	bit 22: to be set after rate is changed */
+static struct ccu_ndmp pll_ddr_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(5),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 6),
+	.d1		= SUNXI_CLK_FACTOR(16, 1),
+	.d2		= SUNXI_CLK_FACTOR(18, 1),
+
+	.common		= {
+		.reg		= 0x020,
+		.hw.init	= SUNXI_HW_INIT("pll-ddr",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+/* periph - must be 600MHz (n=25, d1=d2=0) */
+/*	rate = 24MHz * n / (d1 + 1) / (d2 + 1) */
+static struct ccu_ndmp pll_periph_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(6),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 8),
+	.d1		= SUNXI_CLK_FACTOR(16, 1),
+	.d2		= SUNXI_CLK_FACTOR(18, 1),
+
+	.common		= {
+		.reg		= 0x028,
+		.features	= CCU_FEATURE_N0,
+		.hw.init	= SUNXI_HW_INIT("pll-periph",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+/* gpu */
+/*	rate = 24MHz * n / (d1 + 1) / (d2 + 1) */
+static struct ccu_ndmp pll_gpu_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(7),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 8),
+	.d1		= SUNXI_CLK_FACTOR(16, 1),
+	.d2		= SUNXI_CLK_FACTOR(18, 1),
+
+	.common		= {
+		.reg		= 0x038,
+		.features	= CCU_FEATURE_N0,
+		.hw.init	= SUNXI_HW_INIT("pll-gpu",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+/* hsic */
+/*	rate = 24MHz * n / (d1 + 1) / (d2 + 1) */
+static struct ccu_ndmp pll_hsic_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(8),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 7),
+	.d1		= SUNXI_CLK_FACTOR(16, 1),
+	.d2		= SUNXI_CLK_FACTOR(18, 1),
+
+	.common		= {
+		.reg		= 0x044,
+		.features	= CCU_FEATURE_N0,
+		.hw.init	= SUNXI_HW_INIT("pll-hsic",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+/* display engine */
+/*	rate = 24MHz * n / (d1 + 1) / (d2 + 1) */
+static struct ccu_ndmp pll_de_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(9),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 7),
+	.d1		= SUNXI_CLK_FACTOR(16, 1),
+	.d2		= SUNXI_CLK_FACTOR(18, 1),
+
+	.common		= {
+		.reg		= 0x048,
+		.features	= CCU_FEATURE_N0,
+		.hw.init	= SUNXI_HW_INIT("pll-de",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+/* video 1 */
+/*	rate = 24MHz * n / (d1 + 1) >> p */
+static struct ccu_ndmp pll_video1_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(10),
+	.reg_lock	= 0x20c,
+
+	.n		= SUNXI_CLK_FACTOR(8, 7),
+	.d1		= SUNXI_CLK_FACTOR(16, 1),
+	.p		= SUNXI_CLK_FACTOR(0, 2),
+
+	.common		= {
+		.reg		= 0x04c,
+		.features	= CCU_FEATURE_N0,
+		.hw.init	= SUNXI_HW_INIT("pll-video1",
+						"osc24M",
+						&ccu_ndmp_ops,
+						0),
+	},
+};
+
+static const char * const c0cpux_parents[] = { "osc24M", "pll-c0cpux" };
+static SUNXI_CCU_MUX(c0cpux_clk, "c0cpux", c0cpux_parents,
+		     0x050, 12, 1, CLK_IS_CRITICAL);
+
+static SUNXI_CCU_M(axi0_clk, "axi0", "c0cpux", 0x050, 0, 2, 0);
+
+static const char * const c1cpux_parents[] = { "osc24M", "pll-c1cpux" };
+static SUNXI_CCU_MUX(c1cpux_clk, "c1cpux", c1cpux_parents,
+		     0x050, 28, 1, CLK_IS_CRITICAL);
+
+static SUNXI_CCU_M(axi1_clk, "axi1", "c1cpux", 0x050, 16, 2, 0);
+
+static const char * const ahb1_parents[] = { "osc32k", "osc24M", "pll-periph" };
+static struct ccu_p ahb1_clk = {
+	.p		= SUNXI_CLK_FACTOR(4, 2),
+
+	.mux		= {
+		.shift	= 12,
+		.width	= 2,
+
+		.variable_prediv	= {
+			.index	= 2,
+			.shift	= 6,
+			.width	= 2,
+		},
+	},
+
+	.common		= {
+		.reg		= 0x054,
+		.features	= CCU_FEATURE_VARIABLE_PREDIV,
+		.hw.init	= SUNXI_HW_INIT_PARENTS("ahb1",
+							ahb1_parents,
+							&ccu_p_ops,
+							0),
+	},
+};
+
+static SUNXI_CCU_M(apb1_clk, "apb1", "ahb1", 0x054, 8, 2, 0);
+
+static const char * const apb2_parents[] = { "osc32k", "osc24M",
+					     "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", apb2_parents, 0x058,
+			     0, 5,	/* M */
+			     16, 2,	/* P */
+			     24, 2,	/* mux */
+			     0);
+
+static const char * const ahb2_parents[] = { "ahb1" , "pll-periph" };
+static struct ccu_mux ahb2_clk = {
+	.mux		= {
+		.shift	= 0,
+		.width	= 2,
+
+		.fixed_prediv	= {
+			.index	= 1,
+			.div	= 2,
+		},
+	},
+
+	.common		= {
+		.reg		= 0x05c,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= SUNXI_HW_INIT_PARENTS("ahb2",
+							ahb2_parents,
+							&ccu_mux_ops,
+							0),
+	},
+};
+
+static SUNXI_CCU_GATE(bus_mipidsi_clk,	"bus-mipidsi",	"ahb1",
+		      0x060, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_ss_clk,	"bus-ss",	"ahb1",
+		      0x060, BIT(5), 0);
+static SUNXI_CCU_GATE(bus_dma_clk,	"bus-dma",	"ahb1",
+		      0x060, BIT(6), 0);
+static SUNXI_CCU_GATE(bus_mmc0_clk,	"bus-mmc0",	"ahb1",
+		      0x060, BIT(8), 0);
+static SUNXI_CCU_GATE(bus_mmc1_clk,	"bus-mmc1",	"ahb1",
+		      0x060, BIT(9), 0);
+static SUNXI_CCU_GATE(bus_mmc2_clk,	"bus-mmc2",	"ahb1",
+		      0x060, BIT(10), 0);
+static SUNXI_CCU_GATE(bus_nand_clk,	"bus-nand",	"ahb1",
+		      0x060, BIT(13), 0);
+static SUNXI_CCU_GATE(bus_dram_clk,	"bus-dram",	"ahb1",
+		      0x060, BIT(14), 0);
+static SUNXI_CCU_GATE(bus_emac_clk,	"bus-emac",	"ahb2",
+		      0x060, BIT(17), 0);
+static SUNXI_CCU_GATE(bus_hstimer_clk,	"bus-hstimer",	"ahb1",
+		      0x060, BIT(19), 0);
+static SUNXI_CCU_GATE(bus_spi0_clk,	"bus-spi0",	"ahb1",
+		      0x060, BIT(20), 0);
+static SUNXI_CCU_GATE(bus_spi1_clk,	"bus-spi1",	"ahb1",
+		      0x060, BIT(21), 0);
+static SUNXI_CCU_GATE(bus_usbdrd_clk,	"bus-usbdrd",	"ahb2",
+		      0x060, BIT(24), 0);
+static SUNXI_CCU_GATE(bus_ehci0_clk,	"bus-ehci0",	"ahb2",
+		      0x060, BIT(26), 0);
+static SUNXI_CCU_GATE(bus_ehci1_clk,	"bus-ehci1",	"ahb2",
+		      0x060, BIT(27), 0);
+static SUNXI_CCU_GATE(bus_ohci0_clk,	"bus-ohci0",	"ahb2",
+		      0x060, BIT(29), 0);
+
+static SUNXI_CCU_GATE(bus_ve_clk,	"bus-ve",	"ahb1",
+		      0x064, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_tcon0_clk,	"bus-tcon0",	"ahb1",
+		      0x064, BIT(3), 0);
+static SUNXI_CCU_GATE(bus_tcon1_clk,	"bus-tcon1",	"ahb1",
+		      0x064, BIT(4), 0);
+static SUNXI_CCU_GATE(bus_csi_clk,	"bus-csi",	"ahb1",
+		      0x064, BIT(8), 0);
+static SUNXI_CCU_GATE(bus_hdmi_clk,	"bus-hdmi",	"ahb1",
+		      0x064, BIT(11), 0);
+static SUNXI_CCU_GATE(bus_de_clk,	"bus-de",	"ahb1",
+		      0x064, BIT(12), 0);
+static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
+		      0x064, BIT(20), 0);
+static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
+		      0x064, BIT(21), 0);
+static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
+		      0x064, BIT(22), 0);
+
+static SUNXI_CCU_GATE(bus_spdif_clk,	"bus-spdif",	"apb1",
+		      0x068, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_pio_clk,	"bus-pio",	"apb1",
+		      0x068, BIT(5), 0);
+static SUNXI_CCU_GATE(bus_daudio0_clk,	"bus-daudio0",	"apb1",
+		      0x068, BIT(12), 0);
+static SUNXI_CCU_GATE(bus_daudio1_clk,	"bus-daudio1",	"apb1",
+		      0x068, BIT(13), 0);
+static SUNXI_CCU_GATE(bus_daudio2_clk,	"bus-daudio2",	"apb1",
+		      0x068, BIT(14), 0);
+static SUNXI_CCU_GATE(bus_tdm_clk,	"bus-tdm",	"apb1",
+		      0x068, BIT(15), 0);
+
+static SUNXI_CCU_GATE(bus_i2c0_clk,	"bus-i2c0",	"apb2",
+		      0x06c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_i2c1_clk,	"bus-i2c1",	"apb2",
+		      0x06c, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_i2c2_clk,	"bus-i2c2",	"apb2",
+		      0x06c, BIT(2), 0);
+static SUNXI_CCU_GATE(bus_uart0_clk,	"bus-uart0",	"apb2",
+		      0x06c, BIT(16), 0);
+static SUNXI_CCU_GATE(bus_uart1_clk,	"bus-uart1",	"apb2",
+		      0x06c, BIT(17), 0);
+static SUNXI_CCU_GATE(bus_uart2_clk,	"bus-uart2",	"apb2",
+		      0x06c, BIT(18), 0);
+static SUNXI_CCU_GATE(bus_uart3_clk,	"bus-uart3",	"apb2",
+		      0x06c, BIT(19), 0);
+static SUNXI_CCU_GATE(bus_uart4_clk,	"bus-uart4",	"apb2",
+		      0x06c, BIT(20), 0);
+
+static const char * const cci400_parents[] = { "ocs24M", "pll-periph",
+					"pll_hsic" };
+static SUNXI_CCU_M_WITH_MUX(cci400_clk, "cci400", cci400_parents,
+			    0x078, 0, 2, 24, 2, 0);
+
+static const char * const nand_parents[] = { "osc24M", "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(nand_clk, "nand", nand_parents, 0x080,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const char * const mmc0_parents[] = { "osc24M", "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc0_parents, 0x088,
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
+static const char * const mmc1_parents[] = { "osc24M", "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mmc1_parents, 0x08c,
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
+static const char * const mmc2_parents[] = { "osc24M", "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mmc2_parents, 0x090,
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
+static const char * const ss_parents[] = { "osc24M", "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(ss_clk, "ss", ss_parents, 0x09c,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const char * const spi0_parents[] = { "osc24M", "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi0_clk, "spi0", spi0_parents, 0x0a0,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const char * const spi1_parents[] = { "osc24M", "pll-periph" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", spi1_parents, 0x0a4,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_M(daudio0_clk, "daudio0", "pll-audio",
+				0x0b0, 0, 4, 0);
+
+static SUNXI_CCU_M(daudio1_clk, "daudio1", "pll-audio",
+				0x0b4, 0, 4, 0);
+
+static SUNXI_CCU_M(daudio2_clk, "daudio2", "pll-audio",
+				0x0b8, 0, 4, 0);
+
+static SUNXI_CCU_M(tdm_clk, "tdm", "pll-audio",
+				0x0bc, 0, 4, 0);
+
+static SUNXI_CCU_M(spdif_clk, "spdif", "pll-audio",
+				0x0c0, 0, 4, 0);
+
+static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
+		      0x0cc, BIT(8), 0);
+static SUNXI_CCU_GATE(usb_phy1_clk,	"usb-phy1",	"osc24M",
+		      0x0cc, BIT(9), 0);
+static SUNXI_CCU_GATE(hsic_clk,		"hsic",		"pll-hsic",
+		      0x0cc, BIT(10), 0);
+static SUNXI_CCU_GATE(osc12m_clk,	"osc12M",	"osc24M",
+		      0x0cc, BIT(11), 0);
+static SUNXI_CCU_GATE(ohci0_clk,	"ohci0",	"osc24M",
+		      0x0cc, BIT(16), 0);
+
+static SUNXI_CCU_M(dram_clk, "dram", "pll-ddr",
+			    0x0f4, 0, 4, 0);
+/* bit 16 SDRCLK_UPD (configuration update) */
+
+/* pll_ddr config not done */
+
+static SUNXI_CCU_GATE(dram_ve_clk,	"dram-ve",	"dram",
+		      0x100, BIT(0), 0);
+static SUNXI_CCU_GATE(dram_csi_clk,	"dram-csi",	"dram",
+		      0x100, BIT(1), 0);
+
+static SUNXI_CCU_GATE(tcon0_clk, "tcon0", "pll-video0",
+			     0x118, BIT(31), 0);
+
+static SUNXI_CCU_M_WITH_GATE(tcon1_clk, "tcon1", "pll-video1",
+			     0x11c, 0, 4, BIT(31), 0);
+
+static SUNXI_CCU_GATE(csi_misc_clk,	"csi-misc",	"osc24M",
+		      0x130, BIT(16), 0);
+
+static SUNXI_CCU_GATE(mipi_csi_clk,	"mipi-csi",	"osc24M",
+		      0x130, BIT(31), 0);
+
+static const char * const csi_sclk_parents[] = { "pll-periph",
+				NULL, NULL, NULL, NULL, "pll-ve" };
+static SUNXI_CCU_M_WITH_MUX_GATE(csi_sclk_clk, "csi-sclk", csi_sclk_parents,
+				 0x134, 16, 4, 24, 3, BIT(31), 0);
+
+static const char * const csi_mclk_parents[] = { NULL, NULL, NULL, "pll-periph",
+				NULL, "osc24M"};
+static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk_clk, "csi-mclk", csi_mclk_parents,
+				 0x134, 0, 5, 8, 3, BIT(15), 0);
+
+static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
+			     0x13c, 16, 3, BIT(31), 0);
+
+static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
+		      0x144, BIT(31), 0);
+
+static SUNXI_CCU_M_WITH_GATE(hdmi_clk, "hdmi", "pll-video",
+			     0x150, 0, 4, BIT(31), 0);
+
+static SUNXI_CCU_GATE(hdmi_ddc_clk,	"hdmi-ddc",	"osc24M",
+		      0x154, BIT(31), 0);
+
+static const char * const mbus_parents[] = { "osc24M", "pll-periph", "pll-ddr" };
+static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents,
+				 0x15c, 0, 3, 24, 2, BIT(31), CLK_IS_CRITICAL);
+
+static SUNXI_CCU_M_WITH_GATE(mipi_dsi0_clk, "mipi-dsi0", "pll-video0",
+			     0x168, 0, 4, BIT(31), 0);
+
+static const char * const mipi_dsi1_parents[] = { "osc24M",
+				NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+				NULL, "pll-video0" };
+static SUNXI_CCU_M_WITH_MUX_GATE(mipi_dsi1_clk, "mipi-dsi1", mipi_dsi1_parents,
+				 0x16c, 0, 4, 24, 4, BIT(31), 0);
+
+static SUNXI_CCU_M_WITH_GATE(gpu_core_clk, "gpu-core", "pll-gpu",
+			     0x1a0, 0, 3, BIT(31), 0);
+
+static const char * const gpu_mem_parents[] = { "pll-gpu", "pll-periph" };
+static SUNXI_CCU_M_WITH_MUX_GATE(gpu_mem_clk, "gpu-mem", gpu_mem_parents,
+				 0x1a4, 0, 3, 24, 1, BIT(31), 0);
+
+static SUNXI_CCU_M_WITH_GATE(gpu_hyd_clk, "gpu-hyd", "pll-gpu",
+			     0x1a8, 0, 3, BIT(31), 0);
+
+static struct ccu_common *sun8i_a83t_ccu_clks[] = {
+	[CLK_PLL_C0CPUX]	= &pll_c0cpux_clk.common,
+	[CLK_PLL_C1CPUX]	= &pll_c1cpux_clk.common,
+	[CLK_PLL_AUDIO]		= &pll_audio_clk.common,
+	[CLK_PLL_VIDEO0]	= &pll_video0_clk.common,
+	[CLK_PLL_VE]		= &pll_ve_clk.common,
+	[CLK_PLL_DDR]		= &pll_ddr_clk.common,
+	[CLK_PLL_PERIPH]	= &pll_periph_clk.common,
+	[CLK_PLL_GPU]		= &pll_gpu_clk.common,
+	[CLK_PLL_HSIC]		= &pll_hsic_clk.common,
+	[CLK_PLL_DE]		= &pll_de_clk.common,
+	[CLK_PLL_VIDEO1]	= &pll_video1_clk.common,
+	[CLK_C0CPUX]		= &c0cpux_clk.common,
+	[CLK_AXI0]		= &axi0_clk.common,
+	[CLK_C1CPUX]		= &c1cpux_clk.common,
+	[CLK_AXI1]		= &axi1_clk.common,
+	[CLK_AHB1]		= &ahb1_clk.common,
+	[CLK_APB1]		= &apb1_clk.common,
+	[CLK_APB2]		= &apb2_clk.common,
+	[CLK_AHB2]		= &ahb2_clk.common,
+	[CLK_BUS_MIPIDSI]	= &bus_mipidsi_clk.common,
+	[CLK_BUS_SS]		= &bus_ss_clk.common,
+	[CLK_BUS_DMA]		= &bus_dma_clk.common,
+	[CLK_BUS_MMC0]		= &bus_mmc0_clk.common,
+	[CLK_BUS_MMC1]		= &bus_mmc1_clk.common,
+	[CLK_BUS_MMC2]		= &bus_mmc2_clk.common,
+	[CLK_BUS_NAND]		= &bus_nand_clk.common,
+	[CLK_BUS_DRAM]		= &bus_dram_clk.common,
+	[CLK_BUS_EMAC]		= &bus_emac_clk.common,
+	[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common,
+	[CLK_BUS_SPI0]		= &bus_spi0_clk.common,
+	[CLK_BUS_SPI1]		= &bus_spi1_clk.common,
+	[CLK_BUS_USBDRD]	= &bus_usbdrd_clk.common,
+	[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common,
+	[CLK_BUS_EHCI1]		= &bus_ehci1_clk.common,
+	[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common,
+	[CLK_BUS_VE]		= &bus_ve_clk.common,
+	[CLK_BUS_TCON0]		= &bus_tcon0_clk.common,
+	[CLK_BUS_TCON1]		= &bus_tcon1_clk.common,
+	[CLK_BUS_CSI]		= &bus_csi_clk.common,
+	[CLK_BUS_HDMI]		= &bus_hdmi_clk.common,
+	[CLK_BUS_DE]		= &bus_de_clk.common,
+	[CLK_BUS_GPU]		= &bus_gpu_clk.common,
+	[CLK_BUS_MSGBOX]	= &bus_msgbox_clk.common,
+	[CLK_BUS_SPINLOCK]	= &bus_spinlock_clk.common,
+	[CLK_BUS_SPDIF]		= &bus_spdif_clk.common,
+	[CLK_BUS_PIO]		= &bus_pio_clk.common,
+	[CLK_BUS_DAUDIO0]	= &bus_daudio0_clk.common,
+	[CLK_BUS_DAUDIO1]	= &bus_daudio1_clk.common,
+	[CLK_BUS_DAUDIO2]	= &bus_daudio2_clk.common,
+	[CLK_BUS_TDM]		= &bus_tdm_clk.common,
+	[CLK_BUS_I2C0]		= &bus_i2c0_clk.common,
+	[CLK_BUS_I2C1]		= &bus_i2c1_clk.common,
+	[CLK_BUS_I2C2]		= &bus_i2c2_clk.common,
+	[CLK_BUS_UART0]		= &bus_uart0_clk.common,
+	[CLK_BUS_UART1]		= &bus_uart1_clk.common,
+	[CLK_BUS_UART2]		= &bus_uart2_clk.common,
+	[CLK_BUS_UART3]		= &bus_uart3_clk.common,
+	[CLK_BUS_UART4]		= &bus_uart4_clk.common,
+	[CLK_CCI400]		= &cci400_clk.common,
+	[CLK_NAND]		= &nand_clk.common,
+	[CLK_MMC0]		= &mmc0_clk.common,
+	[CLK_MMC0_SAMPLE]	= &mmc0_sample_clk.common,
+	[CLK_MMC0_OUTPUT]	= &mmc0_output_clk.common,
+	[CLK_MMC1]		= &mmc1_clk.common,
+	[CLK_MMC1_SAMPLE]	= &mmc1_sample_clk.common,
+	[CLK_MMC1_OUTPUT]	= &mmc1_output_clk.common,
+	[CLK_MMC2]		= &mmc2_clk.common,
+	[CLK_MMC2_SAMPLE]	= &mmc2_sample_clk.common,
+	[CLK_MMC2_OUTPUT]	= &mmc2_output_clk.common,
+	[CLK_SS]		= &ss_clk.common,
+	[CLK_SPI0]		= &spi0_clk.common,
+	[CLK_SPI1]		= &spi1_clk.common,
+	[CLK_DAUDIO0]		= &daudio0_clk.common,
+	[CLK_DAUDIO1]		= &daudio1_clk.common,
+	[CLK_DAUDIO2]		= &daudio2_clk.common,
+	[CLK_TDM]		= &tdm_clk.common,
+	[CLK_SPDIF]		= &spdif_clk.common,
+	[CLK_USB_PHY0]		= &usb_phy0_clk.common,
+	[CLK_USB_PHY1]		= &usb_phy1_clk.common,
+	[CLK_HSIC]		= &hsic_clk.common,
+	[CLK_OSC12M]		= &osc12m_clk.common,
+	[CLK_OHCI0]		= &ohci0_clk.common,
+	[CLK_DRAM]		= &dram_clk.common,
+	[CLK_DRAM_VE]		= &dram_ve_clk.common,
+	[CLK_DRAM_CSI]		= &dram_csi_clk.common,
+	[CLK_TCON0]		= &tcon0_clk.common,
+	[CLK_TCON1]		= &tcon1_clk.common,
+	[CLK_CSI_MISC]		= &csi_misc_clk.common,
+	[CLK_MIPI_CSI]		= &mipi_csi_clk.common,
+	[CLK_CSI_SCLK]		= &csi_sclk_clk.common,
+	[CLK_CSI_MCLK]		= &csi_mclk_clk.common,
+	[CLK_VE]		= &ve_clk.common,
+	[CLK_AVS]		= &avs_clk.common,
+	[CLK_HDMI]		= &hdmi_clk.common,
+	[CLK_HDMI_DDC]		= &hdmi_ddc_clk.common,
+	[CLK_MBUS]		= &mbus_clk.common,
+	[CLK_MIPI_DSI0]		= &mipi_dsi0_clk.common,
+	[CLK_MIPI_DSI1]		= &mipi_dsi1_clk.common,
+	[CLK_GPU_CORE]		= &gpu_core_clk.common,
+	[CLK_GPU_MEM]		= &gpu_mem_clk.common,
+	[CLK_GPU_HYD]		= &gpu_hyd_clk.common,
+};
+
+static struct ccu_reset_map sun8i_a83t_ccu_resets[] = {
+	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
+	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
+	[RST_USB_HSIC]		=  { 0x0cc, BIT(2) },
+
+	[RST_DRAM]		=  { 0x0f4, BIT(31) },
+	[RST_MBUS]		=  { 0x0fc, BIT(31) },
+
+	[RST_BUS_MIPIDSI]	=  { 0x2c0, BIT(1) },
+	[RST_BUS_CE]		=  { 0x2c0, BIT(5) },
+	[RST_BUS_DMA]		=  { 0x2c0, BIT(6) },
+	[RST_BUS_MMC0]		=  { 0x2c0, BIT(8) },
+	[RST_BUS_MMC1]		=  { 0x2c0, BIT(9) },
+	[RST_BUS_MMC2]		=  { 0x2c0, BIT(10) },
+	[RST_BUS_NAND]		=  { 0x2c0, BIT(13) },
+	[RST_BUS_DRAM]		=  { 0x2c0, BIT(14) },
+	[RST_BUS_EMAC]		=  { 0x2c0, BIT(17) },
+	[RST_BUS_HSTIMER]	=  { 0x2c0, BIT(19) },
+	[RST_BUS_SPI0]		=  { 0x2c0, BIT(20) },
+	[RST_BUS_SPI1]		=  { 0x2c0, BIT(21) },
+	[RST_BUS_USBDRD]	=  { 0x2c0, BIT(24) },
+	[RST_BUS_EHCI0]		=  { 0x2c0, BIT(26) },
+	[RST_BUS_EHCI1]		=  { 0x2c0, BIT(27) },
+	[RST_BUS_OHCI0]		=  { 0x2c0, BIT(29) },
+
+	[RST_BUS_VE]		=  { 0x2c4, BIT(0) },
+	[RST_BUS_TCON0]		=  { 0x2c4, BIT(4) },
+	[RST_BUS_TCON1]		=  { 0x2c4, BIT(5) },
+	[RST_BUS_CSI]		=  { 0x2c4, BIT(8) },
+	[RST_BUS_HDMI0]		=  { 0x2c4, BIT(10) },
+	[RST_BUS_HDMI1]		=  { 0x2c4, BIT(11) },
+	[RST_BUS_DE]		=  { 0x2c4, BIT(12) },
+	[RST_BUS_GPU]		=  { 0x2c4, BIT(20) },
+	[RST_BUS_MSGBOX]	=  { 0x2c4, BIT(21) },
+	[RST_BUS_SPINLOCK]	=  { 0x2c4, BIT(22) },
+
+	[RST_BUS_LVDS]		=  { 0x2c8, BIT(0) },
+
+	[RST_BUS_SPDIF]		=  { 0x2d0, BIT(1) },
+	[RST_BUS_DAUDIO0]	=  { 0x2d0, BIT(12) },
+	[RST_BUS_DAUDIO1]	=  { 0x2d0, BIT(13) },
+	[RST_BUS_DAUDIO2]	=  { 0x2d0, BIT(14) },
+	[RST_BUS_TDM]		=  { 0x2d0, BIT(15) },
+
+	[RST_BUS_I2C0]		=  { 0x2d8, BIT(0) },
+	[RST_BUS_I2C1]		=  { 0x2d8, BIT(1) },
+	[RST_BUS_I2C2]		=  { 0x2d8, BIT(2) },
+	[RST_BUS_UART0]		=  { 0x2d8, BIT(16) },
+	[RST_BUS_UART1]		=  { 0x2d8, BIT(17) },
+	[RST_BUS_UART2]		=  { 0x2d8, BIT(18) },
+	[RST_BUS_UART3]		=  { 0x2d8, BIT(19) },
+	[RST_BUS_UART4]		=  { 0x2d8, BIT(20) },
+};
+
+static const struct sunxi_ccu_desc sun8i_a83t_ccu_desc = {
+	.clks		= sun8i_a83t_ccu_clks,
+	.num_clks	= ARRAY_SIZE(sun8i_a83t_ccu_clks),
+
+	.resets		= sun8i_a83t_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun8i_a83t_ccu_resets),
+};
+
+static void __init sun8i_a83t_ccu_setup(struct device_node *node)
+{
+	sunxi_ccu_probe(node, &sun8i_a83t_ccu_desc);
+}
+CLK_OF_DECLARE(sun8i_a83t_ccu, "allwinner,sun8i-a83t-ccu",
+	       sun8i_a83t_ccu_setup);
diff --git a/include/dt-bindings/clock/sun8i-a83t.h b/include/dt-bindings/clock/sun8i-a83t.h
new file mode 100644
index 0000000..f194e89
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-a83t.h
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
+ * Based on the H3 version from
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
+#ifndef _DT_BINDINGS_CLK_SUN8I_A83T_H_
+#define _DT_BINDINGS_CLK_SUN8I_A83T_H_
+
+#define CLK_PLL_C0CPUX		0
+#define CLK_PLL_C1CPUX		1
+#define CLK_PLL_AUDIO		2
+#define CLK_PLL_VIDEO0		3
+#define CLK_PLL_VE		4
+#define CLK_PLL_DDR		5
+#define CLK_PLL_PERIPH		6
+#define CLK_PLL_GPU		7
+#define CLK_PLL_HSIC		8
+#define CLK_PLL_DE		9
+#define CLK_PLL_VIDEO1		10
+#define CLK_C0CPUX		11
+#define CLK_AXI0		12
+#define CLK_C1CPUX		13
+#define CLK_AXI1		14
+#define CLK_AHB1		15
+#define CLK_APB1		16
+#define CLK_APB2		17
+#define CLK_AHB2		18
+#define CLK_BUS_MIPIDSI		19
+#define CLK_BUS_SS		20
+#define CLK_BUS_DMA		21
+#define CLK_BUS_MMC0		22
+#define CLK_BUS_MMC1		23
+#define CLK_BUS_MMC2		24
+#define CLK_BUS_NAND		25
+#define CLK_BUS_DRAM		26
+#define CLK_BUS_EMAC		27
+#define CLK_BUS_HSTIMER		28
+#define CLK_BUS_SPI0		29
+#define CLK_BUS_SPI1		30
+#define CLK_BUS_USBDRD		31
+#define CLK_BUS_EHCI0		32
+#define CLK_BUS_EHCI1		33
+#define CLK_BUS_OHCI0		34
+#define CLK_BUS_VE		35
+#define CLK_BUS_TCON0		36
+#define CLK_BUS_TCON1		37
+#define CLK_BUS_CSI		38
+#define CLK_BUS_HDMI		39
+#define CLK_BUS_DE		40
+#define CLK_BUS_GPU		41
+#define CLK_BUS_MSGBOX		42
+#define CLK_BUS_SPINLOCK	43
+#define CLK_BUS_SPDIF		44
+#define CLK_BUS_PIO		45
+#define CLK_BUS_DAUDIO0		46
+#define CLK_BUS_DAUDIO1		47
+#define CLK_BUS_DAUDIO2		48
+#define CLK_BUS_TDM		49
+#define CLK_BUS_I2C0		50
+#define CLK_BUS_I2C1		51
+#define CLK_BUS_I2C2		52
+#define CLK_BUS_UART0		53
+#define CLK_BUS_UART1		54
+#define CLK_BUS_UART2		55
+#define CLK_BUS_UART3		56
+#define CLK_BUS_UART4		57
+#define CLK_CCI400		58
+#define CLK_NAND		59
+#define CLK_MMC0		60
+#define CLK_MMC0_SAMPLE		61
+#define CLK_MMC0_OUTPUT		62
+#define CLK_MMC1		63
+#define CLK_MMC1_SAMPLE		64
+#define CLK_MMC1_OUTPUT		65
+#define CLK_MMC2		66
+#define CLK_MMC2_SAMPLE		67
+#define CLK_MMC2_OUTPUT		68
+#define CLK_SS			69
+#define CLK_SPI0		70
+#define CLK_SPI1		71
+#define CLK_DAUDIO0		72
+#define CLK_DAUDIO1		73
+#define CLK_DAUDIO2		74
+#define CLK_TDM			75
+#define CLK_SPDIF		76
+#define CLK_USB_PHY0		77
+#define CLK_USB_PHY1		78
+#define CLK_HSIC		79
+#define CLK_OSC12M		80
+#define CLK_OHCI0		81
+#define CLK_DRAM		82
+#define CLK_DRAM_VE		83
+#define CLK_DRAM_CSI		84
+#define CLK_TCON0		85
+#define CLK_TCON1		86
+#define CLK_CSI_MISC		87
+#define CLK_MIPI_CSI		88
+#define CLK_CSI_SCLK		89
+#define CLK_CSI_MCLK		90
+#define CLK_VE			91
+#define CLK_AVS			92
+#define CLK_HDMI		93
+#define CLK_HDMI_DDC		94
+#define CLK_MBUS		95
+#define CLK_MIPI_DSI0		96
+#define CLK_MIPI_DSI1		97
+#define CLK_GPU_CORE		98
+#define CLK_GPU_MEM		99
+#define CLK_GPU_HYD		100
+
+#endif /* _DT_BINDINGS_CLK_SUN8I_A83T_H_ */
diff --git a/include/dt-bindings/reset/sun8i-a83t.h b/include/dt-bindings/reset/sun8i-a83t.h
new file mode 100644
index 0000000..86facc6
--- /dev/null
+++ b/include/dt-bindings/reset/sun8i-a83t.h
@@ -0,0 +1,96 @@
+/*
+ * Copyright (c) 2016 Jean-Francois Moine <moinejf@free.fr>
+ * Based on the H3 version from
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
+#ifndef _DT_BINDINGS_RST_SUN8I_A83T_H_
+#define _DT_BINDINGS_RST_SUN8I_A83T_H_
+
+#define RST_USB_PHY0		0
+#define RST_USB_PHY1		1
+#define RST_USB_HSIC		2
+
+#define RST_DRAM		3
+#define RST_MBUS		4
+
+#define RST_BUS_MIPIDSI		5
+#define RST_BUS_CE		6
+#define RST_BUS_DMA		7
+#define RST_BUS_MMC0		8
+#define RST_BUS_MMC1		9
+#define RST_BUS_MMC2		10
+#define RST_BUS_NAND		11
+#define RST_BUS_DRAM		12
+#define RST_BUS_EMAC		13
+#define RST_BUS_HSTIMER		14
+#define RST_BUS_SPI0		15
+#define RST_BUS_SPI1		16
+#define RST_BUS_USBDRD		17
+#define RST_BUS_EHCI0		18
+#define RST_BUS_EHCI1		19
+#define RST_BUS_OHCI0		20
+#define RST_BUS_VE		21
+#define RST_BUS_TCON0		22
+#define RST_BUS_TCON1		23
+#define RST_BUS_CSI		24
+#define RST_BUS_HDMI0		25
+#define RST_BUS_HDMI1		26
+#define RST_BUS_DE		27
+#define RST_BUS_GPU		28
+#define RST_BUS_MSGBOX		29
+#define RST_BUS_SPINLOCK	30
+#define RST_BUS_LVDS		31
+#define RST_BUS_SPDIF		32
+#define RST_BUS_DAUDIO0		33
+#define RST_BUS_DAUDIO1		34
+#define RST_BUS_DAUDIO2		35
+#define RST_BUS_TDM		36
+#define RST_BUS_I2C0		37
+#define RST_BUS_I2C1		38
+#define RST_BUS_I2C2		39
+#define RST_BUS_UART0		40
+#define RST_BUS_UART1		41
+#define RST_BUS_UART2		42
+#define RST_BUS_UART3		43
+#define RST_BUS_UART4		44
+
+#endif /* _DT_BINDINGS_RST_SUN8I_A83T_H_ */
-- 
2.8.3
