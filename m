From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 19 May 2017 15:06:09 +0800
Subject: [PATCH v4 3/6] clk: sunxi-ng: Add driver for A83T CCU
In-Reply-To: <20170519070612.32159-1-wens@csie.org>
References: <20170519070612.32159-1-wens@csie.org>
Message-ID: <20170519070612.32159-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T clock control unit is a hybrid of some new style clock designs
from the A80, and old style layout from the other Allwinner SoCs.

Like the A80, the SoC does not have a low speed 32.768 kHz oscillator.
Unlike the A80, there is no clock input either. The only low speed clock
available is the internal oscillator which runs at around 16 MHz,
divided by 512, yielding a low speed clock around 31.250 kHz.

Also, the MMC2 module clock supports switching to a "new timing" mode.
This mode divides the clock output by half, and disables the CCU based
clock delays. The MMC controller must be configure to the same mode,
and then use its internal clock delays.

This driver does not support runtime switching of the timing modes.
Instead, the new timing mode is enforced at probe time. Consumers can
check which mode is active by trying to get the current phase delay
of the MMC2 phase clocks, which will return -ENOTSUPP if the new
timing mode is active.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/Kconfig               |  11 +
 drivers/clk/sunxi-ng/Makefile              |   1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c      | 922 +++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.h      |  64 ++
 include/dt-bindings/clock/sun8i-a83t-ccu.h | 140 +++++
 include/dt-bindings/reset/sun8i-a83t-ccu.h |  98 +++
 6 files changed, 1236 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.h
 create mode 100644 include/dt-bindings/clock/sun8i-a83t-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-a83t-ccu.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index b5706fc73f3e..a384c695b388 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -116,6 +116,17 @@ config SUN8I_A33_CCU
 	default MACH_SUN8I
 	depends on MACH_SUN8I || COMPILE_TEST
 
+config SUN8I_A83T_CCU
+	bool "Support for the Allwinner A83T CCU"
+	select SUNXI_CCU_DIV
+	select SUNXI_CCU_GATE
+	select SUNXI_CCU_MP
+	select SUNXI_CCU_MUX
+	select SUNXI_CCU_NKMP
+	select SUNXI_CCU_NM
+	select SUNXI_CCU_PHASE
+	default MACH_SUN8I
+
 config SUN8I_H3_CCU
 	bool "Support for the Allwinner H3 CCU"
 	select SUNXI_CCU_DIV
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index be616279450e..0185c6ffadcb 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
 obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
 obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
 obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
+obj-$(CONFIG_SUN8I_A83T_CCU)	+= ccu-sun8i-a83t.o
 obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
 obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
 obj-$(CONFIG_SUN8I_DE2_CCU)	+= ccu-sun8i-de2.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
new file mode 100644
index 000000000000..4a201a7e03b8
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -0,0 +1,922 @@
+/*
+ * Copyright (c) 2017 Chen-Yu Tsai. All rights reserved.
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
+#include <linux/platform_device.h>
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mp.h"
+#include "ccu_mux.h"
+#include "ccu_nkmp.h"
+#include "ccu_nm.h"
+#include "ccu_phase.h"
+
+#include "ccu-sun8i-a83t.h"
+
+#define CCU_SUN8I_A83T_LOCK_REG	0x208
+
+/*
+ * The CPU PLLs are actually NP clocks, with P being /1 or /4. However
+ * P should only be used for output frequencies lower than 228 MHz.
+ * Neither mainline Linux, U-boot, nor the vendor BSPs use these.
+ *
+ * For now we can just model it as a multiplier clock, and force P to /1.
+ */
+#define SUN8I_A83T_PLL_C0CPUX_REG	0x000
+#define SUN8I_A83T_PLL_C1CPUX_REG	0x004
+
+static struct ccu_mult pll_c0cpux_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(0),
+	.mult		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
+	.common		= {
+		.reg		= SUN8I_A83T_PLL_C0CPUX_REG,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-c0cpux", "osc24M",
+					      &ccu_mult_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static struct ccu_mult pll_c1cpux_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(1),
+	.mult		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
+	.common		= {
+		.reg		= SUN8I_A83T_PLL_C1CPUX_REG,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-c1cpux", "osc24M",
+					      &ccu_mult_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+/*
+ * The Audio PLL has d1, d2 dividers in addition to the usual N, M
+ * factors. Since we only need 2 frequencies from this PLL: 22.5792 MHz
+ * and 24.576 MHz, ignore them for now. Enforce the default for them,
+ * which is d1 = 0, d2 = 1.
+ */
+#define SUN8I_A83T_PLL_AUDIO_REG	0x008
+
+static struct ccu_nm pll_audio_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(2),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
+	.m		= _SUNXI_CCU_DIV_OFFSET(0, 6, 0),
+	.common		= {
+		.reg		= SUN8I_A83T_PLL_AUDIO_REG,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-audio", "osc24M",
+					      &ccu_nm_ops, CLK_SET_RATE_UNGATE),
+	},
+};
+
+/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */
+static struct ccu_nkmp pll_video0_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(3),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
+	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(0, 2), /* output divider */
+	.common		= {
+		.reg		= 0x010,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-video0", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static struct ccu_nkmp pll_ve_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(4),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
+	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
+	.common		= {
+		.reg		= 0x018,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-ve", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static struct ccu_nkmp pll_ddr_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(5),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
+	.common		= {
+		.reg		= 0x020,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-ddr", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static struct ccu_nkmp pll_periph_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(6),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
+	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
+	.common		= {
+		.reg		= 0x028,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-periph", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static struct ccu_nkmp pll_gpu_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(7),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
+	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
+	.common		= {
+		.reg		= 0x038,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-gpu", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static struct ccu_nkmp pll_hsic_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(8),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
+	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
+	.common		= {
+		.reg		= 0x044,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-hsic", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static struct ccu_nkmp pll_de_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(9),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
+	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(18, 1), /* output divider */
+	.common		= {
+		.reg		= 0x048,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-de", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static struct ccu_nkmp pll_video1_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(10),
+	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
+	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(0, 2), /* external divider p */
+	.common		= {
+		.reg		= 0x04c,
+		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
+		.features	= CCU_FEATURE_LOCK_REG,
+		.hw.init	= CLK_HW_INIT("pll-video1", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static const char * const c0cpux_parents[] = { "osc24M", "pll-c0cpux" };
+static SUNXI_CCU_MUX(c0cpux_clk, "c0cpux", c0cpux_parents,
+		     0x50, 12, 1, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+static const char * const c1cpux_parents[] = { "osc24M", "pll-c1cpux" };
+static SUNXI_CCU_MUX(c1cpux_clk, "c1cpux", c1cpux_parents,
+		     0x50, 28, 1, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+static SUNXI_CCU_M(axi0_clk, "axi0", "c0cpux", 0x050, 0, 2, 0);
+static SUNXI_CCU_M(axi1_clk, "axi1", "c1cpux", 0x050, 16, 2, 0);
+
+static const char * const ahb1_parents[] = { "osc16M-d512", "osc24M",
+					     "pll-periph",
+					     "pll-periph" };
+static const struct ccu_mux_var_prediv ahb1_predivs[] = {
+	{ .index = 2, .shift = 6, .width = 2 },
+	{ .index = 3, .shift = 6, .width = 2 },
+};
+static struct ccu_div ahb1_clk = {
+	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
+	.mux		= {
+		.shift	= 12,
+		.width	= 2,
+
+		.var_predivs	= ahb1_predivs,
+		.n_var_predivs	= ARRAY_SIZE(ahb1_predivs),
+	},
+	.common		= {
+		.reg		= 0x054,
+		.hw.init	= CLK_HW_INIT_PARENTS("ahb1",
+						      ahb1_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static SUNXI_CCU_M(apb1_clk, "apb1", "ahb1", 0x054, 8, 2, 0);
+
+static const char * const apb2_parents[] = { "osc16M-d512", "osc24M",
+					     "pll-periph", "pll-periph" };
+
+static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", apb2_parents, 0x058,
+			     0, 5,	/* M */
+			     16, 2,	/* P */
+			     24, 2,	/* mux */
+			     0);
+
+static const char * const ahb2_parents[] = { "ahb1", "pll-periph" };
+static const struct ccu_mux_fixed_prediv ahb2_prediv = {
+	.index = 1, .div = 2
+};
+static struct ccu_mux ahb2_clk = {
+	.mux		= {
+		.shift		= 0,
+		.width		= 2,
+		.fixed_predivs	= &ahb2_prediv,
+		.n_predivs	= 1,
+	},
+	.common		= {
+		.reg		= 0x05c,
+		.hw.init	= CLK_HW_INIT_PARENTS("ahb2",
+						      ahb2_parents,
+						      &ccu_mux_ops,
+						      0),
+	},
+};
+
+static SUNXI_CCU_GATE(bus_mipi_dsi_clk,	"bus-mipi-dsi",	"ahb1",
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
+static SUNXI_CCU_GATE(bus_otg_clk,	"bus-otg",	"ahb1",
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
+		      0x064, BIT(4), 0);
+static SUNXI_CCU_GATE(bus_tcon1_clk,	"bus-tcon1",	"ahb1",
+		      0x064, BIT(5), 0);
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
+static SUNXI_CCU_GATE(bus_i2s0_clk,	"bus-i2s0",	"apb1",
+		      0x068, BIT(12), 0);
+static SUNXI_CCU_GATE(bus_i2s1_clk,	"bus-i2s1",	"apb1",
+		      0x068, BIT(13), 0);
+static SUNXI_CCU_GATE(bus_i2s2_clk,	"bus-i2s2",	"apb1",
+		      0x068, BIT(14), 0);
+static SUNXI_CCU_GATE(bus_tdm_clk,	"bus-tdm",	"apb1",
+		      0x068, BIT(15), 0);
+
+static SUNXI_CCU_GATE(bus_i2c0_clk,	"bus-i2c0",	"apb2",
+		      0x06c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_i2c1_clk,	"bus-i2c1",	"apb2",
+		      0x06c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_i2c2_clk,	"bus-i2c2",	"apb2",
+		      0x06c, BIT(0), 0);
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
+static const char * const cci400_parents[] = { "osc24M", "pll-periph",
+					       "pll-hsic" };
+static struct ccu_div cci400_clk = {
+	.div		= _SUNXI_CCU_DIV_FLAGS(0, 2, 0),
+	.mux		= _SUNXI_CCU_MUX(24, 2),
+	.common		= {
+		.reg		= 0x078,
+		.hw.init	= CLK_HW_INIT_PARENTS("cci400",
+						      cci400_parents,
+						      &ccu_div_ops,
+						      CLK_IS_CRITICAL),
+	},
+};
+
+static const char * const mod0_default_parents[] = { "osc24M", "pll-periph" };
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(nand_clk, "nand", mod0_default_parents,
+				  0x080,
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
+static SUNXI_CCU_PHASE(mmc0_sample_clk, "mmc0-sample", "mmc0",
+		       0x088, 20, 3, 0);
+static SUNXI_CCU_PHASE(mmc0_output_clk, "mmc0-output", "mmc0",
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
+static SUNXI_CCU_PHASE(mmc1_sample_clk, "mmc1-sample", "mmc1",
+		       0x08c, 20, 3, 0);
+static SUNXI_CCU_PHASE(mmc1_output_clk, "mmc1-output", "mmc1",
+		       0x08c, 8, 3, 0);
+
+/* TODO Support MMC2 clock's new timing mode. */
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_parents,
+				  0x090,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_PHASE(mmc2_sample_clk, "mmc2-sample", "mmc2",
+		       0x090, 20, 3, 0);
+static SUNXI_CCU_PHASE(mmc2_output_clk, "mmc2-output", "mmc2",
+		       0x090, 8, 3, 0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(ss_clk, "ss", mod0_default_parents,
+				  0x09c,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi0_clk, "spi0", mod0_default_parents,
+				  0x0a0,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 4,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", mod0_default_parents,
+				  0x0a4,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 4,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_M_WITH_GATE(i2s0_clk, "i2s0", "pll-audio",
+			     0x0b0, 0, 4, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_GATE(i2s1_clk, "i2s1", "pll-audio",
+			     0x0b4, 0, 4, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_GATE(i2s2_clk, "i2s2", "pll-audio",
+			     0x0b8, 0, 4, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_GATE(tdm_clk, "tdm", "pll-audio",
+			     0x0bc, 0, 4, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_GATE(spdif_clk, "spdif", "pll-audio",
+			     0x0c0, 0, 4, BIT(31), CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
+		      0x0cc, BIT(8), 0);
+static SUNXI_CCU_GATE(usb_phy1_clk,	"usb-phy1",	"osc24M",
+		      0x0cc, BIT(9), 0);
+static SUNXI_CCU_GATE(usb_hsic_clk,	"usb-hsic",	"pll-hsic",
+		      0x0cc, BIT(10), 0);
+static struct ccu_gate usb_hsic_12m_clk = {
+	.enable	= BIT(11),
+	.common	= {
+		.reg		= 0x0cc,
+		.prediv		= 2,
+		.features	= CCU_FEATURE_ALL_PREDIV,
+		.hw.init	= CLK_HW_INIT("usb-hsic-12m", "osc24M",
+					      &ccu_gate_ops, 0),
+	}
+};
+static SUNXI_CCU_GATE(usb_ohci0_clk,	"usb-ohci0",	"osc24M",
+		      0x0cc, BIT(16), 0);
+
+/* TODO divider has minimum of 2 */
+static SUNXI_CCU_M(dram_clk, "dram", "pll-ddr", 0x0f4, 0, 4, CLK_IS_CRITICAL);
+
+static SUNXI_CCU_GATE(dram_ve_clk,	"dram-ve",	"dram",
+		      0x100, BIT(0), 0);
+static SUNXI_CCU_GATE(dram_csi_clk,	"dram-csi",	"dram",
+		      0x100, BIT(1), 0);
+
+static const char * const tcon0_parents[] = { "pll-video0" };
+static SUNXI_CCU_MUX_WITH_GATE(tcon0_clk, "tcon0", tcon0_parents,
+				 0x118, 24, 3, BIT(31), CLK_SET_RATE_PARENT);
+
+static const char * const tcon1_parents[] = { "pll-video1" };
+static SUNXI_CCU_MUX_WITH_GATE(tcon1_clk, "tcon1", tcon1_parents,
+				 0x11c, 24, 3, BIT(31), CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_GATE(csi_misc_clk, "csi-misc", "osc24M", 0x130, BIT(16), 0);
+
+static SUNXI_CCU_GATE(mipi_csi_clk, "mipi-csi", "osc24M", 0x130, BIT(31), 0);
+
+static const char * const csi_mclk_parents[] = { "pll-de", "osc24M" };
+static const u8 csi_mclk_table[] = { 3, 5 };
+static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(csi_mclk_clk, "csi-mclk",
+				       csi_mclk_parents, csi_mclk_table,
+				       0x134,
+				       0, 5,	/* M */
+				       10, 3,	/* mux */
+				       BIT(15),	/* gate */
+				       0);
+
+static const char * const csi_sclk_parents[] = { "pll-periph", "pll-ve" };
+static const u8 csi_sclk_table[] = { 0, 5 };
+static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(csi_sclk_clk, "csi-sclk",
+				       csi_sclk_parents, csi_sclk_table,
+				       0x134,
+				       16, 4,	/* M */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve", 0x13c,
+			     16, 3, BIT(31), CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_GATE(avs_clk, "avs", "osc24M", 0x144, BIT(31), 0);
+
+static const char * const hdmi_parents[] = { "pll-video1" };
+static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
+				 0x150,
+				 0, 4,	/* M */
+				 24, 2,	/* mux */
+				 BIT(31),	/* gate */
+				 CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_GATE(hdmi_slow_clk, "hdmi-slow", "osc24M", 0x154, BIT(31), 0);
+
+static const char * const mbus_parents[] = { "osc24M", "pll-periph",
+					     "pll-ddr" };
+static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents,
+				 0x15c,
+				 0, 3,	/* M */
+				 24, 2,	/* mux */
+				 BIT(31),	/* gate */
+				 CLK_IS_CRITICAL);
+
+static const char * const mipi_dsi0_parents[] = { "pll-video0" };
+static const u8 mipi_dsi0_table[] = { 8 };
+static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(mipi_dsi0_clk, "mipi-dsi0",
+				       mipi_dsi0_parents, mipi_dsi0_table,
+				       0x168,
+				       0, 4,	/* M */
+				       24, 4,	/* mux */
+				       BIT(31),	/* gate */
+				       CLK_SET_RATE_PARENT);
+
+static const char * const mipi_dsi1_parents[] = { "osc24M", "pll-video0" };
+static const u8 mipi_dsi1_table[] = { 0, 9 };
+static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(mipi_dsi1_clk, "mipi-dsi1",
+				       mipi_dsi1_parents, mipi_dsi1_table,
+				       0x16c,
+				       0, 4,	/* M */
+				       24, 4,	/* mux */
+				       BIT(31),	/* gate */
+				       CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M_WITH_GATE(gpu_core_clk, "gpu-core", "pll-gpu", 0x1a0,
+			     0, 3, BIT(31), CLK_SET_RATE_PARENT);
+
+static const char * const gpu_memory_parents[] = { "pll-gpu", "pll-ddr" };
+static SUNXI_CCU_M_WITH_MUX_GATE(gpu_memory_clk, "gpu-memory",
+				 gpu_memory_parents,
+				 0x1a4,
+				 0, 3,		/* M */
+				 24, 1,		/* mux */
+				 BIT(31),	/* gate */
+				 CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M_WITH_GATE(gpu_hyd_clk, "gpu-hyd", "pll-gpu", 0x1a8,
+			     0, 3, BIT(31), CLK_SET_RATE_PARENT);
+
+static struct ccu_common *sun8i_a83t_ccu_clks[] = {
+	&pll_c0cpux_clk.common,
+	&pll_c1cpux_clk.common,
+	&pll_audio_clk.common,
+	&pll_video0_clk.common,
+	&pll_ve_clk.common,
+	&pll_ddr_clk.common,
+	&pll_periph_clk.common,
+	&pll_gpu_clk.common,
+	&pll_hsic_clk.common,
+	&pll_de_clk.common,
+	&pll_video1_clk.common,
+	&c0cpux_clk.common,
+	&c1cpux_clk.common,
+	&axi0_clk.common,
+	&axi1_clk.common,
+	&ahb1_clk.common,
+	&ahb2_clk.common,
+	&apb1_clk.common,
+	&apb2_clk.common,
+	&bus_mipi_dsi_clk.common,
+	&bus_ss_clk.common,
+	&bus_dma_clk.common,
+	&bus_mmc0_clk.common,
+	&bus_mmc1_clk.common,
+	&bus_mmc2_clk.common,
+	&bus_nand_clk.common,
+	&bus_dram_clk.common,
+	&bus_emac_clk.common,
+	&bus_hstimer_clk.common,
+	&bus_spi0_clk.common,
+	&bus_spi1_clk.common,
+	&bus_otg_clk.common,
+	&bus_ehci0_clk.common,
+	&bus_ehci1_clk.common,
+	&bus_ohci0_clk.common,
+	&bus_ve_clk.common,
+	&bus_tcon0_clk.common,
+	&bus_tcon1_clk.common,
+	&bus_csi_clk.common,
+	&bus_hdmi_clk.common,
+	&bus_de_clk.common,
+	&bus_gpu_clk.common,
+	&bus_msgbox_clk.common,
+	&bus_spinlock_clk.common,
+	&bus_spdif_clk.common,
+	&bus_pio_clk.common,
+	&bus_i2s0_clk.common,
+	&bus_i2s1_clk.common,
+	&bus_i2s2_clk.common,
+	&bus_tdm_clk.common,
+	&bus_i2c0_clk.common,
+	&bus_i2c1_clk.common,
+	&bus_i2c2_clk.common,
+	&bus_uart0_clk.common,
+	&bus_uart1_clk.common,
+	&bus_uart2_clk.common,
+	&bus_uart3_clk.common,
+	&bus_uart4_clk.common,
+	&cci400_clk.common,
+	&nand_clk.common,
+	&mmc0_clk.common,
+	&mmc0_sample_clk.common,
+	&mmc0_output_clk.common,
+	&mmc1_clk.common,
+	&mmc1_sample_clk.common,
+	&mmc1_output_clk.common,
+	&mmc2_clk.common,
+	&mmc2_sample_clk.common,
+	&mmc2_output_clk.common,
+	&ss_clk.common,
+	&spi0_clk.common,
+	&spi1_clk.common,
+	&i2s0_clk.common,
+	&i2s1_clk.common,
+	&i2s2_clk.common,
+	&tdm_clk.common,
+	&spdif_clk.common,
+	&usb_phy0_clk.common,
+	&usb_phy1_clk.common,
+	&usb_hsic_clk.common,
+	&usb_hsic_12m_clk.common,
+	&usb_ohci0_clk.common,
+	&dram_clk.common,
+	&dram_ve_clk.common,
+	&dram_csi_clk.common,
+	&tcon0_clk.common,
+	&tcon1_clk.common,
+	&csi_misc_clk.common,
+	&mipi_csi_clk.common,
+	&csi_mclk_clk.common,
+	&csi_sclk_clk.common,
+	&ve_clk.common,
+	&avs_clk.common,
+	&hdmi_clk.common,
+	&hdmi_slow_clk.common,
+	&mbus_clk.common,
+	&mipi_dsi0_clk.common,
+	&mipi_dsi1_clk.common,
+	&gpu_core_clk.common,
+	&gpu_memory_clk.common,
+	&gpu_hyd_clk.common,
+};
+
+static struct clk_hw_onecell_data sun8i_a83t_hw_clks = {
+	.hws	= {
+		[CLK_PLL_C0CPUX]	= &pll_c0cpux_clk.common.hw,
+		[CLK_PLL_C1CPUX]	= &pll_c1cpux_clk.common.hw,
+		[CLK_PLL_AUDIO]		= &pll_audio_clk.common.hw,
+		[CLK_PLL_VIDEO0]	= &pll_video0_clk.common.hw,
+		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
+		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
+		[CLK_PLL_PERIPH]	= &pll_periph_clk.common.hw,
+		[CLK_PLL_GPU]		= &pll_gpu_clk.common.hw,
+		[CLK_PLL_HSIC]		= &pll_hsic_clk.common.hw,
+		[CLK_PLL_DE]		= &pll_de_clk.common.hw,
+		[CLK_PLL_VIDEO1]	= &pll_video1_clk.common.hw,
+		[CLK_C0CPUX]		= &c0cpux_clk.common.hw,
+		[CLK_C1CPUX]		= &c1cpux_clk.common.hw,
+		[CLK_AXI0]		= &axi0_clk.common.hw,
+		[CLK_AXI1]		= &axi1_clk.common.hw,
+		[CLK_AHB1]		= &ahb1_clk.common.hw,
+		[CLK_AHB2]		= &ahb2_clk.common.hw,
+		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_APB2]		= &apb2_clk.common.hw,
+		[CLK_BUS_MIPI_DSI]	= &bus_mipi_dsi_clk.common.hw,
+		[CLK_BUS_SS]		= &bus_ss_clk.common.hw,
+		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
+		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
+		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
+		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
+		[CLK_BUS_NAND]		= &bus_nand_clk.common.hw,
+		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
+		[CLK_BUS_EMAC]		= &bus_emac_clk.common.hw,
+		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
+		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
+		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
+		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
+		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
+		[CLK_BUS_EHCI1]		= &bus_ehci1_clk.common.hw,
+		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
+		[CLK_BUS_VE]		= &bus_ve_clk.common.hw,
+		[CLK_BUS_TCON0]		= &bus_tcon0_clk.common.hw,
+		[CLK_BUS_TCON1]		= &bus_tcon1_clk.common.hw,
+		[CLK_BUS_CSI]		= &bus_csi_clk.common.hw,
+		[CLK_BUS_HDMI]		= &bus_hdmi_clk.common.hw,
+		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
+		[CLK_BUS_GPU]		= &bus_gpu_clk.common.hw,
+		[CLK_BUS_MSGBOX]	= &bus_msgbox_clk.common.hw,
+		[CLK_BUS_SPINLOCK]	= &bus_spinlock_clk.common.hw,
+		[CLK_BUS_SPDIF]		= &bus_spdif_clk.common.hw,
+		[CLK_BUS_PIO]		= &bus_pio_clk.common.hw,
+		[CLK_BUS_I2S0]		= &bus_i2s0_clk.common.hw,
+		[CLK_BUS_I2S1]		= &bus_i2s1_clk.common.hw,
+		[CLK_BUS_I2S2]		= &bus_i2s2_clk.common.hw,
+		[CLK_BUS_TDM]		= &bus_tdm_clk.common.hw,
+		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
+		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
+		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
+		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
+		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
+		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
+		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
+		[CLK_BUS_UART4]		= &bus_uart4_clk.common.hw,
+		[CLK_CCI400]		= &cci400_clk.common.hw,
+		[CLK_NAND]		= &nand_clk.common.hw,
+		[CLK_MMC0]		= &mmc0_clk.common.hw,
+		[CLK_MMC0_SAMPLE]	= &mmc0_sample_clk.common.hw,
+		[CLK_MMC0_OUTPUT]	= &mmc0_output_clk.common.hw,
+		[CLK_MMC1]		= &mmc1_clk.common.hw,
+		[CLK_MMC1_SAMPLE]	= &mmc1_sample_clk.common.hw,
+		[CLK_MMC1_OUTPUT]	= &mmc1_output_clk.common.hw,
+		[CLK_MMC2]		= &mmc2_clk.common.hw,
+		[CLK_MMC2_SAMPLE]	= &mmc2_sample_clk.common.hw,
+		[CLK_MMC2_OUTPUT]	= &mmc2_output_clk.common.hw,
+		[CLK_SS]		= &ss_clk.common.hw,
+		[CLK_SPI0]		= &spi0_clk.common.hw,
+		[CLK_SPI1]		= &spi1_clk.common.hw,
+		[CLK_I2S0]		= &i2s0_clk.common.hw,
+		[CLK_I2S1]		= &i2s1_clk.common.hw,
+		[CLK_I2S2]		= &i2s2_clk.common.hw,
+		[CLK_TDM]		= &tdm_clk.common.hw,
+		[CLK_SPDIF]		= &spdif_clk.common.hw,
+		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
+		[CLK_USB_PHY1]		= &usb_phy1_clk.common.hw,
+		[CLK_USB_HSIC]		= &usb_hsic_clk.common.hw,
+		[CLK_USB_HSIC_12M]	= &usb_hsic_12m_clk.common.hw,
+		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
+		[CLK_DRAM]		= &dram_clk.common.hw,
+		[CLK_DRAM_VE]		= &dram_ve_clk.common.hw,
+		[CLK_DRAM_CSI]		= &dram_csi_clk.common.hw,
+		[CLK_TCON0]		= &tcon0_clk.common.hw,
+		[CLK_TCON1]		= &tcon1_clk.common.hw,
+		[CLK_CSI_MISC]		= &csi_misc_clk.common.hw,
+		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
+		[CLK_CSI_MCLK]		= &csi_mclk_clk.common.hw,
+		[CLK_CSI_SCLK]		= &csi_sclk_clk.common.hw,
+		[CLK_VE]		= &ve_clk.common.hw,
+		[CLK_AVS]		= &avs_clk.common.hw,
+		[CLK_HDMI]		= &hdmi_clk.common.hw,
+		[CLK_HDMI_SLOW]		= &hdmi_slow_clk.common.hw,
+		[CLK_MBUS]		= &mbus_clk.common.hw,
+		[CLK_MIPI_DSI0]		= &mipi_dsi0_clk.common.hw,
+		[CLK_MIPI_DSI1]		= &mipi_dsi1_clk.common.hw,
+		[CLK_GPU_CORE]		= &gpu_core_clk.common.hw,
+		[CLK_GPU_MEMORY]	= &gpu_memory_clk.common.hw,
+		[CLK_GPU_HYD]		= &gpu_hyd_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun8i_a83t_ccu_resets[] = {
+	[RST_USB_PHY0]		= { 0x0cc, BIT(0) },
+	[RST_USB_PHY1]		= { 0x0cc, BIT(1) },
+	[RST_USB_HSIC]		= { 0x0cc, BIT(2) },
+	[RST_DRAM]		= { 0x0f4, BIT(31) },
+	[RST_MBUS]		= { 0x0fc, BIT(31) },
+	[RST_BUS_MIPI_DSI]	= { 0x2c0, BIT(1) },
+	[RST_BUS_SS]		= { 0x2c0, BIT(5) },
+	[RST_BUS_DMA]		= { 0x2c0, BIT(6) },
+	[RST_BUS_MMC0]		= { 0x2c0, BIT(8) },
+	[RST_BUS_MMC1]		= { 0x2c0, BIT(9) },
+	[RST_BUS_MMC2]		= { 0x2c0, BIT(10) },
+	[RST_BUS_NAND]		= { 0x2c0, BIT(13) },
+	[RST_BUS_DRAM]		= { 0x2c0, BIT(14) },
+	[RST_BUS_EMAC]		= { 0x2c0, BIT(17) },
+	[RST_BUS_HSTIMER]	= { 0x2c0, BIT(19) },
+	[RST_BUS_SPI0]		= { 0x2c0, BIT(20) },
+	[RST_BUS_SPI1]		= { 0x2c0, BIT(21) },
+	[RST_BUS_OTG]		= { 0x2c0, BIT(24) },
+	[RST_BUS_EHCI0]		= { 0x2c0, BIT(26) },
+	[RST_BUS_EHCI1]		= { 0x2c0, BIT(27) },
+	[RST_BUS_OHCI0]		= { 0x2c0, BIT(29) },
+	[RST_BUS_VE]		= { 0x2c4, BIT(0) },
+	[RST_BUS_TCON0]		= { 0x2c4, BIT(4) },
+	[RST_BUS_TCON1]		= { 0x2c4, BIT(5) },
+	[RST_BUS_CSI]		= { 0x2c4, BIT(8) },
+	[RST_BUS_HDMI0]		= { 0x2c4, BIT(10) },
+	[RST_BUS_HDMI1]		= { 0x2c4, BIT(11) },
+	[RST_BUS_DE]		= { 0x2c4, BIT(12) },
+	[RST_BUS_GPU]		= { 0x2c4, BIT(20) },
+	[RST_BUS_MSGBOX]	= { 0x2c4, BIT(21) },
+	[RST_BUS_SPINLOCK]	= { 0x2c4, BIT(22) },
+	[RST_BUS_LVDS]		= { 0x2c8, BIT(0) },
+	[RST_BUS_SPDIF]		= { 0x2d0, BIT(1) },
+	[RST_BUS_I2S0]		= { 0x2d0, BIT(12) },
+	[RST_BUS_I2S1]		= { 0x2d0, BIT(13) },
+	[RST_BUS_I2S2]		= { 0x2d0, BIT(14) },
+	[RST_BUS_TDM]		= { 0x2d0, BIT(15) },
+	[RST_BUS_I2C0]		= { 0x2d8, BIT(0) },
+	[RST_BUS_I2C1]		= { 0x2d8, BIT(1) },
+	[RST_BUS_I2C2]		= { 0x2d8, BIT(2) },
+	[RST_BUS_UART0]		= { 0x2d8, BIT(16) },
+	[RST_BUS_UART1]		= { 0x2d8, BIT(17) },
+	[RST_BUS_UART2]		= { 0x2d8, BIT(18) },
+	[RST_BUS_UART3]		= { 0x2d8, BIT(19) },
+	[RST_BUS_UART4]		= { 0x2d8, BIT(20) },
+};
+
+static const struct sunxi_ccu_desc sun8i_a83t_ccu_desc = {
+	.ccu_clks	= sun8i_a83t_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_a83t_ccu_clks),
+
+	.hw_clks	= &sun8i_a83t_hw_clks,
+
+	.resets		= sun8i_a83t_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun8i_a83t_ccu_resets),
+};
+
+#define SUN8I_A83T_PLL_P_SHIFT	16
+#define SUN8I_A83T_PLL_N_SHIFT	8
+#define SUN8I_A83T_PLL_N_WIDTH	8
+
+static void sun8i_a83t_cpu_pll_fixup(void __iomem *reg)
+{
+	u32 val = readl(reg);
+
+	/* bail out if P divider is not used */
+	if (!(val & BIT(SUN8I_A83T_PLL_P_SHIFT)))
+		return;
+
+	/*
+	 * If P is used, output should be less than 288 MHz. When we
+	 * set P to 1, we should also decrease the multiplier so the
+	 * output doesn't go out of range, but not too much such that
+	 * the multiplier stays above 12, the minimal operation value.
+	 *
+	 * To keep it simple, set the multiplier to 17, the reset value.
+	 */
+	val &= ~GENMASK(SUN8I_A83T_PLL_N_SHIFT + SUN8I_A83T_PLL_N_WIDTH - 1,
+			SUN8I_A83T_PLL_N_SHIFT);
+	val |= 17 << SUN8I_A83T_PLL_N_SHIFT;
+
+	/* And clear P */
+	val &= ~BIT(SUN8I_A83T_PLL_P_SHIFT);
+
+	writel(val, reg);
+}
+
+static int sun8i_a83t_ccu_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *reg;
+	u32 val;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	/* Enforce d1 = 0, d2 = 0 for Audio PLL */
+	val = readl(reg + SUN8I_A83T_PLL_AUDIO_REG);
+	val &= ~(BIT(16) | BIT(18));
+	writel(val, reg + SUN8I_A83T_PLL_AUDIO_REG);
+
+	/* Enforce P = 1 for both CPU cluster PLLs */
+	sun8i_a83t_cpu_pll_fixup(reg + SUN8I_A83T_PLL_C0CPUX_REG);
+	sun8i_a83t_cpu_pll_fixup(reg + SUN8I_A83T_PLL_C1CPUX_REG);
+
+	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun8i_a83t_ccu_desc);
+}
+
+static const struct of_device_id sun8i_a83t_ccu_ids[] = {
+	{ .compatible = "allwinner,sun8i-a83t-ccu" },
+	{ }
+};
+
+static struct platform_driver sun8i_a83t_ccu_driver = {
+	.probe	= sun8i_a83t_ccu_probe,
+	.driver	= {
+		.name	= "sun8i-a83t-ccu",
+		.of_match_table	= sun8i_a83t_ccu_ids,
+	},
+};
+builtin_platform_driver(sun8i_a83t_ccu_driver);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.h b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.h
new file mode 100644
index 000000000000..d67edaf76748
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.h
@@ -0,0 +1,64 @@
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
+#ifndef _CCU_SUN8I_A83T_H_
+#define _CCU_SUN8I_A83T_H_
+
+#include <dt-bindings/clock/sun8i-a83t-ccu.h>
+#include <dt-bindings/reset/sun8i-a83t-ccu.h>
+
+#define CLK_PLL_C0CPUX		0
+#define CLK_PLL_C1CPUX		1
+#define CLK_PLL_AUDIO		2
+#define CLK_PLL_VIDEO0		3
+#define CLK_PLL_VE		4
+#define CLK_PLL_DDR		5
+
+/* pll-periph is exported to the PRCM block */
+
+#define CLK_PLL_GPU		7
+#define CLK_PLL_HSIC		8
+
+/* pll-de is exported for the display engine */
+
+#define CLK_PLL_VIDEO1		10
+
+/* The CPUX clocks are exported */
+
+#define CLK_AXI0		13
+#define CLK_AXI1		14
+#define CLK_AHB1		15
+#define CLK_AHB2		16
+#define CLK_APB1		17
+#define CLK_APB2		18
+
+/* bus gates exported */
+
+#define CLK_CCI400		58
+
+/* module and usb clocks exported */
+
+#define CLK_DRAM		82
+
+/* dram gates and more module clocks exported */
+
+#define CLK_MBUS		95
+
+/* more module clocks exported */
+
+#define CLK_NUMBER		(CLK_GPU_HYD + 1)
+
+#endif /* _CCU_SUN8I_A83T_H_ */
diff --git a/include/dt-bindings/clock/sun8i-a83t-ccu.h b/include/dt-bindings/clock/sun8i-a83t-ccu.h
new file mode 100644
index 000000000000..78af5085f630
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-a83t-ccu.h
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
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
+#ifndef _DT_BINDINGS_CLOCK_SUN8I_A83T_CCU_H_
+#define _DT_BINDINGS_CLOCK_SUN8I_A83T_CCU_H_
+
+#define CLK_PLL_PERIPH		6
+
+#define CLK_PLL_DE		9
+
+#define CLK_C0CPUX		11
+#define CLK_C1CPUX		12
+
+#define CLK_BUS_MIPI_DSI	19
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
+#define CLK_BUS_OTG		31
+#define CLK_BUS_EHCI0		32
+#define CLK_BUS_EHCI1		33
+#define CLK_BUS_OHCI0		34
+
+#define CLK_BUS_VE		35
+#define CLK_BUS_TCON0		36
+#define CLK_BUS_TCON1		37
+#define CLK_BUS_CSI		38
+#define CLK_BUS_HDMI		39
+#define CLK_BUS_DE		40
+#define CLK_BUS_GPU		41
+#define CLK_BUS_MSGBOX		42
+#define CLK_BUS_SPINLOCK	43
+
+#define CLK_BUS_SPDIF		44
+#define CLK_BUS_PIO		45
+#define CLK_BUS_I2S0		46
+#define CLK_BUS_I2S1		47
+#define CLK_BUS_I2S2		48
+#define CLK_BUS_TDM		49
+
+#define CLK_BUS_I2C0		50
+#define CLK_BUS_I2C1		51
+#define CLK_BUS_I2C2		52
+#define CLK_BUS_UART0		53
+#define CLK_BUS_UART1		54
+#define CLK_BUS_UART2		55
+#define CLK_BUS_UART3		56
+#define CLK_BUS_UART4		57
+
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
+#define CLK_I2S0		72
+#define CLK_I2S1		73
+#define CLK_I2S2		74
+#define CLK_TDM			75
+#define CLK_SPDIF		76
+#define CLK_USB_PHY0		77
+#define CLK_USB_PHY1		78
+#define CLK_USB_HSIC		79
+#define CLK_USB_HSIC_12M	80
+#define CLK_USB_OHCI0		81
+
+#define CLK_DRAM_VE		83
+#define CLK_DRAM_CSI		84
+
+#define CLK_TCON0		85
+#define CLK_TCON1		86
+#define CLK_CSI_MISC		87
+#define CLK_MIPI_CSI		88
+#define CLK_CSI_MCLK		89
+#define CLK_CSI_SCLK		90
+#define CLK_VE			91
+#define CLK_AVS			92
+#define CLK_HDMI		93
+#define CLK_HDMI_SLOW		94
+
+#define CLK_MIPI_DSI0		96
+#define CLK_MIPI_DSI1		97
+#define CLK_GPU_CORE		98
+#define CLK_GPU_MEMORY		99
+#define CLK_GPU_HYD		100
+
+#endif /* _DT_BINDINGS_CLOCK_SUN8I_A83T_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun8i-a83t-ccu.h b/include/dt-bindings/reset/sun8i-a83t-ccu.h
new file mode 100644
index 000000000000..784f6e11664e
--- /dev/null
+++ b/include/dt-bindings/reset/sun8i-a83t-ccu.h
@@ -0,0 +1,98 @@
+/*
+ * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
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
+#ifndef _DT_BINDINGS_RESET_SUN8I_A83T_CCU_H_
+#define _DT_BINDINGS_RESET_SUN8I_A83T_CCU_H_
+
+#define RST_USB_PHY0		0
+#define RST_USB_PHY1		1
+#define RST_USB_HSIC		2
+
+#define RST_DRAM		3
+#define RST_MBUS		4
+
+#define RST_BUS_MIPI_DSI	5
+#define RST_BUS_SS		6
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
+#define RST_BUS_OTG		17
+#define RST_BUS_EHCI0		18
+#define RST_BUS_EHCI1		19
+#define RST_BUS_OHCI0		20
+
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
+
+#define RST_BUS_LVDS		31
+
+#define RST_BUS_SPDIF		32
+#define RST_BUS_I2S0		33
+#define RST_BUS_I2S1		34
+#define RST_BUS_I2S2		35
+#define RST_BUS_TDM		36
+
+#define RST_BUS_I2C0		37
+#define RST_BUS_I2C1		38
+#define RST_BUS_I2C2		39
+#define RST_BUS_UART0		40
+#define RST_BUS_UART1		41
+#define RST_BUS_UART2		42
+#define RST_BUS_UART3		43
+#define RST_BUS_UART4		44
+
+#endif /* _DT_BINDINGS_RESET_SUN8I_A83T_CCU_H_ */
-- 
2.11.0
