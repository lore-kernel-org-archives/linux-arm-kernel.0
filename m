From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon, 15 May 2017 21:59:23 +0800
Subject: [PATCH 9/9] clk: imx: add imx7ulp clk driver
In-Reply-To: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1494856763-6543-10-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

The clocking scheme provides clear separation between M4 domain
and A7 domain. Except for a few clock sources shared between two
domains, such as the System Oscillator clock, the Slow IRC (SIRC),
and and the Fast IRC clock (FIRCLK), clock sources and clock
management are separated and contained within each domain.

M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.

This driver only adds clock support in A7 domain.

Note that most clocks required to be operated when gated, e.g. pll,
pfd, pcc. And more special cases that scs/ddr/nic mux selecting
different clock source requires that clock to be enabled first,
then we need set CLK_OPS_PARENT_ENABLE flag for them properly.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/Makefile      |   1 +
 drivers/clk/imx/clk-imx7ulp.c | 171 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index bf001ce..6f013e0 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -27,4 +27,5 @@ obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
+obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
new file mode 100644
index 0000000..de229ba
--- /dev/null
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -0,0 +1,171 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include "clk.h"
+
+static const char * const pll_pre_sels[]	= { "sosc", "firc", };
+static const char * const spll_pfd_sels[]	= { "spll_pfd0", "spll_pfd1", "spll_pfd2", "spll_pfd3", };
+static const char * const spll_sels[]		= { "spll", "spll_pfd_sel", };
+static const char * const apll_pfd_sels[]	= { "apll_pfd0", "apll_pfd1", "apll_pfd2", "apll_pfd3", };
+static const char * const apll_sels[]		= { "apll", "apll_pfd_sel", };
+static const char * const scs_sels[]		= { "dummy", "sosc", "sirc", "firc", "dummy", "apll_sel", "spll_sel", "upll", };
+static const char * const ddr_sels[]		= { "apll_pfd_sel", "upll", };
+static const char * const nic_sels[]		= { "firc", "ddr_clk", };
+static const char * const periph_plat_sels[]	= { "dummy", "nic1_bus_clk", "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
+static const char * const periph_bus_sels[]	= { "dummy", "sosc_bus_clk", "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk", };
+
+static struct clk *clks[IMX7ULP_CLK_END];
+static struct clk_onecell_data clk_data;
+
+static void __init imx7ulp_clocks_init(struct device_node *scg_node)
+{
+	struct device_node *np;
+	void __iomem *base;
+
+	clks[IMX7ULP_CLK_DUMMY]		= imx_clk_fixed("dummy", 0);
+
+	clks[IMX7ULP_CLK_ROSC]		= of_clk_get_by_name(scg_node, "rosc");
+	clks[IMX7ULP_CLK_SOSC]		= of_clk_get_by_name(scg_node, "sosc");
+	clks[IMX7ULP_CLK_SIRC]		= of_clk_get_by_name(scg_node, "sirc");
+	clks[IMX7ULP_CLK_FIRC]		= of_clk_get_by_name(scg_node, "firc");
+	clks[IMX7ULP_CLK_MIPI_PLL]	= of_clk_get_by_name(scg_node, "mpll");
+	clks[IMX7ULP_CLK_UPLL]		= of_clk_get_by_name(scg_node, "upll");
+
+	np = scg_node;
+	base = of_io_request_and_map(np, 0, "scg1");
+	WARN_ON(!base);
+
+	/* NOTE: xPLL config can't be changed when xPLL is enabled */
+	clks[IMX7ULP_CLK_APLL_PRE_SEL]	= imx_clk_mux_flags("apll_pre_sel", base + 0x508, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_PRE_SEL]	= imx_clk_mux_flags("spll_pre_sel", base + 0x608, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
+
+	/*							name		parent_name	reg		shift	width	flags */
+	clks[IMX7ULP_CLK_APLL_PRE_DIV]	= imx_clk_divider_flags("apll_pre_div", "apll_pre_sel", base + 0x508,	8,	3,	CLK_SET_RATE_GATE);
+	clks[IMX7ULP_CLK_SPLL_PRE_DIV]	= imx_clk_divider_flags("spll_pre_div", "spll_pre_sel", base + 0x608,	8,	3,	CLK_SET_RATE_GATE);
+
+	/*						name	 parent_name	 base */
+	clks[IMX7ULP_CLK_APLL]		= imx_clk_pllv4("apll",  "apll_pre_div", base + 0x500);
+	clks[IMX7ULP_CLK_SPLL]		= imx_clk_pllv4("spll",  "spll_pre_div", base + 0x600);
+
+	/* APLL PFDs */
+	clks[IMX7ULP_CLK_APLL_PFD0]	= imx_clk_pfdv2("apll_pfd0", "apll", base + 0x50C, 0);
+	clks[IMX7ULP_CLK_APLL_PFD1]	= imx_clk_pfdv2("apll_pfd1", "apll", base + 0x50C, 1);
+	clks[IMX7ULP_CLK_APLL_PFD2]	= imx_clk_pfdv2("apll_pfd2", "apll", base + 0x50C, 2);
+	clks[IMX7ULP_CLK_APLL_PFD3]	= imx_clk_pfdv2("apll_pfd3", "apll", base + 0x50C, 3);
+
+	/* SPLL PFDs */
+	clks[IMX7ULP_CLK_SPLL_PFD0]	= imx_clk_pfdv2("spll_pfd0", "spll", base + 0x60C, 0);
+	clks[IMX7ULP_CLK_SPLL_PFD1]	= imx_clk_pfdv2("spll_pfd1", "spll", base + 0x60C, 1);
+	clks[IMX7ULP_CLK_SPLL_PFD2]	= imx_clk_pfdv2("spll_pfd2", "spll", base + 0x60C, 2);
+	clks[IMX7ULP_CLK_SPLL_PFD3]	= imx_clk_pfdv2("spll_pfd3", "spll", base + 0x60C, 3);
+
+	/* PLL Mux */
+	clks[IMX7ULP_CLK_APLL_PFD_SEL]	= imx_clk_mux_flags("apll_pfd_sel", base + 0x508, 14, 2, apll_pfd_sels, ARRAY_SIZE(apll_pfd_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_PFD_SEL]	= imx_clk_mux_flags("spll_pfd_sel", base + 0x608, 14, 2, spll_pfd_sels, ARRAY_SIZE(spll_pfd_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_APLL_SEL]	= imx_clk_mux_flags("apll_sel", base + 0x508, 1, 1, apll_sels, ARRAY_SIZE(apll_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_SEL]	= imx_clk_mux_flags("spll_sel", base + 0x608, 1, 1, spll_sels, ARRAY_SIZE(spll_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+
+	clks[IMX7ULP_CLK_SPLL_BUS_CLK]	= clk_register_divider(NULL, "spll_bus_clk", "spll_sel", CLK_SET_RATE_GATE, base + 0x604, 8, 3, CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	/* scs/ddr/nic select different clock source requires that clock to be enabled first */
+	clks[IMX7ULP_CLK_SYS_SEL]	= imx_clk_mux2("scs_sel", base + 0x14, 24, 4, scs_sels, ARRAY_SIZE(scs_sels));
+	clks[IMX7ULP_CLK_NIC_SEL]	= imx_clk_mux2("nic_sel", base + 0x40, 28, 1, nic_sels, ARRAY_SIZE(nic_sels));
+	clks[IMX7ULP_CLK_DDR_SEL]	= imx_clk_mux_flags("ddr_sel", base + 0x30, 24, 1, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+
+	clks[IMX7ULP_CLK_CORE_DIV]	= imx_clk_divider_flags("divcore",	"scs_sel",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+	clks[IMX7ULP_CLK_DDR_DIV]	= clk_register_divider(NULL, "ddr_clk", "ddr_sel", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
+							       CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	clks[IMX7ULP_CLK_NIC0_DIV]	= imx_clk_divider_flags("nic0_clk",	"nic_sel",  base + 0x40, 24, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX7ULP_CLK_NIC1_DIV]	= imx_clk_divider_flags("nic1_clk",	"nic0_clk", base + 0x40, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX7ULP_CLK_NIC1_BUS_DIV]	= imx_clk_divider_flags("nic1_bus_clk",	"nic1_clk", base + 0x40, 4,  4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+	clks[IMX7ULP_CLK_GPU_DIV] 	= imx_clk_divider("gpu_clk", "nic0_clk", base + 0x40, 20, 4);
+
+	clks[IMX7ULP_CLK_SOSC_BUS_CLK]	= clk_register_divider(NULL, "sosc_bus_clk", "sosc", 0, base + 0x104, 8, 3,
+							       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+	clks[IMX7ULP_CLK_FIRC_BUS_CLK]	= clk_register_divider(NULL, "firc_bus_clk", "firc", 0, base + 0x304, 8, 3,
+							       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	/* PCC2 */
+	base = of_io_request_and_map(np, 1, "pcc2");
+	WARN_ON(!base);
+
+	clks[IMX7ULP_CLK_DMA1]		= imx_clk_gate("dma1", "nic1_clk", base + 0x20, 30);
+	clks[IMX7ULP_CLK_RGPIO2P1]	= imx_clk_gate("rgpio2p1", "nic1_bus_clk", base + 0x3c, 30);
+	clks[IMX7ULP_CLK_DMA_MUX1]	= imx_clk_gate("dma_mux1", "nic1_bus_clk", base + 0x84, 30);
+	clks[IMX7ULP_CLK_SNVS]		= imx_clk_gate("snvs", "nic1_bus_clk", base + 0x8c, 30);
+	clks[IMX7ULP_CLK_CAAM]		= imx_clk_gate("caam", "nic1_clk", base + 0x90, 30);
+	clks[IMX7ULP_CLK_LPTPM4]	= imx_clk_composite("lptpm4",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPTPM5]	= imx_clk_composite("lptmp5",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPIT1]		= imx_clk_composite("lpit1",   periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9C);
+	clks[IMX7ULP_CLK_LPSPI2]	= imx_clk_composite("lpspi2",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xA4);
+	clks[IMX7ULP_CLK_LPSPI3]	= imx_clk_composite("lpspi3",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xA8);
+	clks[IMX7ULP_CLK_LPI2C4]	= imx_clk_composite("lpi2c4",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xAC);
+	clks[IMX7ULP_CLK_LPI2C5]	= imx_clk_composite("lpi2c5",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xB0);
+	clks[IMX7ULP_CLK_LPUART4]	= imx_clk_composite("lpuart4", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xB4);
+	clks[IMX7ULP_CLK_LPUART5]	= imx_clk_composite("lpuart5", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xB8);
+	clks[IMX7ULP_CLK_FLEXIO1]	= imx_clk_composite("flexio1", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xC4);
+	clks[IMX7ULP_CLK_USB0]		= imx_clk_composite("usb0",    periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xCC);
+	clks[IMX7ULP_CLK_USB1]		= imx_clk_composite("usb1",    periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xD0);
+	clks[IMX7ULP_CLK_USB_PHY]	= imx_clk_gate("usb_phy", "nic1_bus_clk", base + 0xD4, 30);
+	clks[IMX7ULP_CLK_USDHC0]	= imx_clk_composite("usdhc0",  periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xDC);
+	clks[IMX7ULP_CLK_USDHC1]	= imx_clk_composite("usdhc1",  periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xE0);
+	clks[IMX7ULP_CLK_WDG1]		= imx_clk_composite("wdg1",    periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xF4);
+	clks[IMX7ULP_CLK_WDG2]		= imx_clk_composite("sdg2",    periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0x10C);
+
+	/* PCC3 */
+	base = of_io_request_and_map(np, 2, "pcc3");
+	WARN_ON(!base);
+
+	clks[IMX7ULP_CLK_LPTPM6]	= imx_clk_composite("lptpm6",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x84);
+	clks[IMX7ULP_CLK_LPTPM7]	= imx_clk_composite("lptpm7",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x88);
+	clks[IMX7ULP_CLK_LPI2C6]	= imx_clk_composite("lpi2c6",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x90);
+	clks[IMX7ULP_CLK_LPI2C7]	= imx_clk_composite("lpi2c7",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPUART6]	= imx_clk_composite("lpuart6", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPUART7]	= imx_clk_composite("lpuart7", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9C);
+	clks[IMX7ULP_CLK_DSI]		= imx_clk_composite("dsi",     periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xA4);
+	clks[IMX7ULP_CLK_LCDIF]		= imx_clk_composite("lcdif",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xA8);
+
+	clks[IMX7ULP_CLK_MMDC]		= clk_register_gate(NULL, "mmdc", "nic1_clk", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+							    base + 0xAC, 30, 0, &imx_ccm_lock);
+
+	clks[IMX7ULP_CLK_VIU]		= imx_clk_gate("viu",	"nic1_clk",	base + 0xA0, 30);
+	clks[IMX7ULP_CLK_PCTLC]		= imx_clk_gate("pctlc", "nic1_bus_clk", base + 0xB8, 30);
+	clks[IMX7ULP_CLK_PCTLD]		= imx_clk_gate("pctld", "nic1_bus_clk", base + 0xBC, 30);
+	clks[IMX7ULP_CLK_PCTLE]		= imx_clk_gate("pctle", "nic1_bus_clk", base + 0xc0, 30);
+	clks[IMX7ULP_CLK_PCTLF]		= imx_clk_gate("pctlf", "nic1_bus_clk", base + 0xc4, 30);
+
+	clks[IMX7ULP_CLK_GPU3D]		= imx_clk_composite("gpu3d",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
+	clks[IMX7ULP_CLK_GPU2D]		= imx_clk_composite("gpu2d",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
+
+	imx_check_clocks(clks, ARRAY_SIZE(clks));
+
+	clk_data.clks = clks;
+	clk_data.clk_num = ARRAY_SIZE(clks);
+	of_clk_add_provider(scg_node, of_clk_src_onecell_get, &clk_data);
+
+	pr_info("i.MX7ULP clock tree init done.\n");
+}
+
+CLK_OF_DECLARE(imx7ulp, "fsl,imx7ulp-clock", imx7ulp_clocks_init);
-- 
2.7.4
