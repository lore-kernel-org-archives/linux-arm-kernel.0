From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Apr 2012 23:57:15 +0800
Subject: [PATCH 3/8] clk: mxs: add clock support for imx28
In-Reply-To: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335023840-1394-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx28 clock support based on common clk framework.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/mxs/Makefile    |    1 +
 drivers/clk/mxs/clk-imx28.c |  318 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 319 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/mxs/clk-imx28.c

diff --git a/drivers/clk/mxs/Makefile b/drivers/clk/mxs/Makefile
index 21ec6ca..3554916 100644
--- a/drivers/clk/mxs/Makefile
+++ b/drivers/clk/mxs/Makefile
@@ -5,3 +5,4 @@
 obj-y += clk-pll.o clk-ref.o clk-div.o clk-frac.o
 
 obj-$(CONFIG_SOC_IMX23) += clk-imx23.o
+obj-$(CONFIG_SOC_IMX28) += clk-imx28.o
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
new file mode 100644
index 0000000..0837f1d
--- /dev/null
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -0,0 +1,318 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <mach/common.h>
+#include <mach/mx28.h>
+#include "clk.h"
+
+#define CLKCTRL			MX28_IO_ADDRESS(MX28_CLKCTRL_BASE_ADDR)
+#define PLL0CTRL0		(CLKCTRL + 0x0000)
+#define PLL1CTRL0		(CLKCTRL + 0x0020)
+#define PLL2CTRL0		(CLKCTRL + 0x0040)
+#define CPU			(CLKCTRL + 0x0050)
+#define HBUS			(CLKCTRL + 0x0060)
+#define XBUS			(CLKCTRL + 0x0070)
+#define XTAL			(CLKCTRL + 0x0080)
+#define SSP0			(CLKCTRL + 0x0090)
+#define SSP1			(CLKCTRL + 0x00a0)
+#define SSP2			(CLKCTRL + 0x00b0)
+#define SSP3			(CLKCTRL + 0x00c0)
+#define GPMI			(CLKCTRL + 0x00d0)
+#define SPDIF			(CLKCTRL + 0x00e0)
+#define EMI			(CLKCTRL + 0x00f0)
+#define SAIF0			(CLKCTRL + 0x0100)
+#define SAIF1			(CLKCTRL + 0x0110)
+#define LCDIF			(CLKCTRL + 0x0120)
+#define ETM			(CLKCTRL + 0x0130)
+#define ENET			(CLKCTRL + 0x0140)
+#define FLEXCAN			(CLKCTRL + 0x0160)
+#define FRAC0			(CLKCTRL + 0x01b0)
+#define FRAC1			(CLKCTRL + 0x01c0)
+#define CLKSEQ			(CLKCTRL + 0x01d0)
+
+#define BP_CPU_INTERRUPT_WAIT	12
+#define BP_SAIF_DIV_FRAC_EN	16
+#define BP_ENET_DIV_TIME	21
+#define BP_ENET_SLEEP		31
+#define BP_CLKSEQ_BYPASS_SAIF0	0
+#define BP_CLKSEQ_BYPASS_SSP0	3
+#define BP_FRAC0_IO1FRAC	16
+#define BP_FRAC0_IO0FRAC	24
+
+#define DIGCTRL			MX28_IO_ADDRESS(MX28_DIGCTL_BASE_ADDR)
+#define BP_SAIF_CLKMUX		10
+
+/*
+ * HW_SAIF_CLKMUX_SEL:
+ *  DIRECT(0x0): SAIF0 clock pins selected for SAIF0 input clocks, and SAIF1
+ *		clock pins selected for SAIF1 input clocks.
+ *  CROSSINPUT(0x1): SAIF1 clock inputs selected for SAIF0 input clocks, and
+ *		SAIF0 clock inputs selected for SAIF1 input clocks.
+ *  EXTMSTR0(0x2): SAIF0 clock pin selected for both SAIF0 and SAIF1 input
+ *		clocks.
+ *  EXTMSTR1(0x3): SAIF1 clock pin selected for both SAIF0 and SAIF1 input
+ *		clocks.
+ */
+int mxs_saif_clkmux_select(unsigned int clkmux)
+{
+	if (clkmux > 0x3)
+		return -EINVAL;
+
+	__mxs_clrl(0x3 << BP_SAIF_CLKMUX, DIGCTRL);
+	__mxs_setl(clkmux << BP_SAIF_CLKMUX, DIGCTRL);
+
+	return 0;
+}
+
+static void __init clk_misc_init(void)
+{
+	u32 val;
+
+	/* Gate off cpu clock in WFI for power saving */
+	__mxs_setl(1 << BP_CPU_INTERRUPT_WAIT, CPU);
+
+	/* 0 is a bad default value for a divider */
+	__mxs_setl(1 << BP_ENET_DIV_TIME, ENET);
+
+	/* Clear BYPASS for SAIF */
+	__mxs_clrl(0x3 << BP_CLKSEQ_BYPASS_SAIF0, CLKSEQ);
+
+	/* SAIF has to use frac div for functional operation */
+	val = readl_relaxed(SAIF0);
+	val |= 1 << BP_SAIF_DIV_FRAC_EN;
+	writel_relaxed(val, SAIF0);
+
+	val = readl_relaxed(SAIF1);
+	val |= 1 << BP_SAIF_DIV_FRAC_EN;
+	writel_relaxed(val, SAIF1);
+
+	/* Extra fec clock setting */
+	val = readl_relaxed(ENET);
+	val &= ~(1 << BP_ENET_SLEEP);
+	writel_relaxed(val, ENET);
+
+	/*
+	 * Source ssp clock from ref_io than ref_xtal,
+	 * as ref_xtal only provides 24 MHz as maximum.
+	 */
+	__mxs_clrl(0xf << BP_CLKSEQ_BYPASS_SSP0, CLKSEQ);
+}
+
+static struct clk_lookup uart_lookups[] __initdata = {
+	{ .dev_id = "duart", },
+	{ .dev_id = "mxs-auart.0", },
+	{ .dev_id = "mxs-auart.1", },
+	{ .dev_id = "mxs-auart.2", },
+	{ .dev_id = "mxs-auart.3", },
+	{ .dev_id = "mxs-auart.4", },
+	{ .dev_id = "8006a000.serial", },
+	{ .dev_id = "8006c000.serial", },
+	{ .dev_id = "8006e000.serial", },
+	{ .dev_id = "80070000.serial", },
+	{ .dev_id = "80072000.serial", },
+	{ .dev_id = "80074000.serial", },
+	{ .dev_id = "uart", },
+};
+
+static struct clk_lookup hbus_lookups[] __initdata = {
+	{ .dev_id = "mxs-dma-apbh", },
+	{ .dev_id = "80004000.dma-apbh", },
+	{ .dev_id = "hbus", },
+};
+
+static struct clk_lookup xbus_lookups[] __initdata = {
+	{ .dev_id = "duart", .con_id = "apb_pclk"},
+	{ .dev_id = "mxs-dma-apbx", },
+	{ .dev_id = "80024000.dma-apbx", },
+	{ .dev_id = "xbus", },
+};
+
+static struct clk_lookup ssp0_lookups[] __initdata = {
+	{ .dev_id = "mxs-mmc.0", },
+	{ .dev_id = "80010000.ssp", },
+};
+
+static struct clk_lookup ssp1_lookups[] __initdata = {
+	{ .dev_id = "mxs-mmc.1", },
+	{ .dev_id = "80012000.ssp", },
+};
+
+static struct clk_lookup ssp2_lookups[] __initdata = {
+	{ .dev_id = "mxs-mmc.2", },
+	{ .dev_id = "80014000.ssp", },
+};
+
+static struct clk_lookup ssp3_lookups[] __initdata = {
+	{ .dev_id = "mxs-mmc.3", },
+	{ .dev_id = "80016000.ssp", },
+};
+
+static struct clk_lookup lcdif_lookups[] __initdata = {
+	{ .dev_id = "imx28-fb", },
+	{ .dev_id = "80030000.lcdif", },
+};
+
+static struct clk_lookup gpmi_lookups[] __initdata = {
+	{ .dev_id = "imx28-gpmi-nand", },
+	{ .dev_id = "8000c000.gpmi", },
+};
+
+static struct clk_lookup fec_lookups[] __initdata = {
+	{ .dev_id = "imx28-fec.0", },
+	{ .dev_id = "imx28-fec.1", },
+	{ .dev_id = "800f0000.ethernet", },
+	{ .dev_id = "800f4000.ethernet", },
+};
+
+static struct clk_lookup can0_lookups[] __initdata = {
+	{ .dev_id = "flexcan.0", },
+	{ .dev_id = "80032000.can", },
+};
+
+static struct clk_lookup can1_lookups[] __initdata = {
+	{ .dev_id = "flexcan.1", },
+	{ .dev_id = "80034000.can", },
+};
+
+static struct clk_lookup saif0_lookups[] __initdata = {
+	{ .dev_id = "mxs-saif.0", },
+	{ .dev_id = "80042000.saif", },
+};
+
+static struct clk_lookup saif1_lookups[] __initdata = {
+	{ .dev_id = "mxs-saif.1", },
+	{ .dev_id = "80046000.saif", },
+};
+
+static const char *sel_cpu[]  __initconst = { "ref_cpu", "ref_xtal", };
+static const char *sel_io0[]  __initconst = { "ref_io0", "ref_xtal", };
+static const char *sel_io1[]  __initconst = { "ref_io1", "ref_xtal", };
+static const char *sel_pix[]  __initconst = { "ref_pix", "ref_xtal", };
+static const char *sel_gpmi[] __initconst = { "ref_gpmi", "ref_xtal", };
+static const char *sel_pll0[] __initconst = { "pll0", "ref_xtal", };
+static const char *cpu_sels[] __initconst = { "cpu_pll", "cpu_xtal", };
+static const char *emi_sels[] __initconst = { "emi_pll", "emi_xtal", };
+static const char *ptp_sels[] __initconst = { "ref_xtal", "pll0", };
+
+static char *clks_init_on[] __initdata = {
+	"cpu", "hbus", "xbus", "emi", "uart",
+};
+
+int __init mx28_clocks_init(void)
+{
+	struct clk *clk;
+	int ret;
+
+	clk_misc_init();
+
+	mxs_clk_fixed("ref_xtal", 24000000);
+
+	mxs_clk_pll("pll0", "ref_xtal", PLL0CTRL0, 17, 18, 480000000, 0);
+	mxs_clk_pll("pll1", "ref_xtal", PLL1CTRL0, 17, 18, 480000000, 0);
+	mxs_clk_pll("pll2", "ref_xtal", PLL2CTRL0, 23, 31, 50000000,
+		    PLL_SET_GATE_DISABLE);
+
+	mxs_clk_ref("ref_cpu", "pll0", FRAC0, 0);
+	mxs_clk_ref("ref_emi", "pll0", FRAC0, 1);
+	mxs_clk_ref("ref_io0", "pll0", FRAC0, 2);
+	mxs_clk_ref("ref_io1", "pll0", FRAC0, 3);
+	mxs_clk_ref("ref_pix", "pll0", FRAC1, 0);
+	mxs_clk_ref("ref_hsadc", "pll0", FRAC1, 1);
+	mxs_clk_ref("ref_gpmi", "pll0", FRAC1, 2);
+
+	mxs_clk_mux("saif0_sel", CLKSEQ, 0, 1, sel_pll0, ARRAY_SIZE(sel_pll0));
+	mxs_clk_mux("saif1_sel", CLKSEQ, 1, 1, sel_pll0, ARRAY_SIZE(sel_pll0));
+	mxs_clk_mux("gpmi_sel", CLKSEQ, 2, 1, sel_gpmi, ARRAY_SIZE(sel_gpmi));
+	mxs_clk_mux("ssp0_sel", CLKSEQ, 3, 1, sel_io0, ARRAY_SIZE(sel_io0));
+	mxs_clk_mux("ssp1_sel", CLKSEQ, 4, 1, sel_io0, ARRAY_SIZE(sel_io0));
+	mxs_clk_mux("ssp2_sel", CLKSEQ, 5, 1, sel_io1, ARRAY_SIZE(sel_io1));
+	mxs_clk_mux("ssp3_sel", CLKSEQ, 6, 1, sel_io1, ARRAY_SIZE(sel_io1));
+	mxs_clk_mux("emi_sel", CLKSEQ, 7, 1, emi_sels, ARRAY_SIZE(emi_sels));
+	mxs_clk_mux("etm_sel", CLKSEQ, 8, 1, sel_cpu, ARRAY_SIZE(sel_cpu));
+	mxs_clk_mux("lcdif_sel", CLKSEQ, 14, 1, sel_pix, ARRAY_SIZE(sel_pix));
+	clk = mxs_clk_mux("cpu", CLKSEQ, 18, 1, cpu_sels, ARRAY_SIZE(cpu_sels));
+	clk_register_clkdev(clk, NULL, "cpu");
+	mxs_clk_mux("ptp_sel", ENET, 19, 1, ptp_sels, ARRAY_SIZE(ptp_sels));
+
+	mxs_clk_div("cpu_pll", "ref_cpu", CPU, 0, 6, 28);
+	mxs_clk_div("cpu_xtal", "ref_xtal", CPU, 16, 10, 29);
+	clk = mxs_clk_div("hbus", "cpu", HBUS, 0, 5, 31);
+	clk_register_clkdevs(clk, hbus_lookups, ARRAY_SIZE(hbus_lookups));
+	clk = mxs_clk_div("xbus", "ref_xtal", XBUS, 0, 10, 31);
+	clk_register_clkdevs(clk, xbus_lookups, ARRAY_SIZE(xbus_lookups));
+	mxs_clk_div("ssp0_div", "ssp0_sel", SSP0, 0, 9, 29);
+	mxs_clk_div("ssp1_div", "ssp1_sel", SSP1, 0, 9, 29);
+	mxs_clk_div("ssp2_div", "ssp2_sel", SSP2, 0, 9, 29);
+	mxs_clk_div("ssp3_div", "ssp3_sel", SSP3, 0, 9, 29);
+	mxs_clk_div("gpmi_div", "gpmi_sel", GPMI, 0, 10, 29);
+	mxs_clk_div("emi_pll", "ref_emi", EMI, 0, 6, 28);
+	mxs_clk_div("emi_xtal", "ref_xtal", EMI, 8, 4, 29);
+	mxs_clk_div("lcdif_div", "lcdif_sel", LCDIF, 0, 13, 29);
+	mxs_clk_div("etm_div", "etm_sel", ETM, 0, 7, 29);
+	mxs_clk_div("ptp", "ptp_sel", ENET, 21, 6, 27);
+
+	mxs_clk_frac("saif0_div", "saif0_sel", SAIF0, 0, 16, 29);
+	mxs_clk_frac("saif1_div", "saif1_sel", SAIF1, 0, 16, 29);
+
+	mxs_clk_fixed_factor("clk32k_div", "ref_xtal", 1, 750);
+	mxs_clk_fixed_factor("rtc", "ref_xtal", 1, 768);
+	mxs_clk_fixed_factor("lradc", "clk32k", 1, 16);
+	mxs_clk_fixed_factor("spdif_div", "pll0", 1, 4);
+
+	clk = mxs_clk_gate("clk32k", "clk32k_div", XTAL, 26);
+	clk_register_clkdev(clk, NULL, "timrot");
+	mxs_clk_gate("pwm", "ref_xtal", XTAL, 29);
+	clk = mxs_clk_gate("uart", "ref_xtal", XTAL, 31);
+	clk_register_clkdevs(clk, uart_lookups, ARRAY_SIZE(uart_lookups));
+	clk = mxs_clk_gate("ssp0", "ssp0_div", SSP0, 31);
+	clk_register_clkdevs(clk, ssp0_lookups, ARRAY_SIZE(ssp0_lookups));
+	clk = mxs_clk_gate("ssp1", "ssp1_div", SSP1, 31);
+	clk_register_clkdevs(clk, ssp1_lookups, ARRAY_SIZE(ssp1_lookups));
+	clk = mxs_clk_gate("ssp2", "ssp2_div", SSP2, 31);
+	clk_register_clkdevs(clk, ssp2_lookups, ARRAY_SIZE(ssp2_lookups));
+	clk = mxs_clk_gate("ssp3", "ssp3_div", SSP3, 31);
+	clk_register_clkdevs(clk, ssp3_lookups, ARRAY_SIZE(ssp3_lookups));
+	clk = mxs_clk_gate("gpmi", "gpmi_div", GPMI, 31);
+	clk_register_clkdevs(clk, gpmi_lookups, ARRAY_SIZE(gpmi_lookups));
+	mxs_clk_gate("spdif", "spdif_div", SPDIF, 31);
+	clk = mxs_clk_gate("emi", "emi_sel", EMI, 31);
+	clk_register_clkdev(clk, NULL, "emi");
+	clk = mxs_clk_gate("saif0", "saif0_div", SAIF0, 31);
+	clk_register_clkdevs(clk, saif0_lookups, ARRAY_SIZE(saif0_lookups));
+	clk = mxs_clk_gate("saif1", "saif1_div", SAIF1, 31);
+	clk_register_clkdevs(clk, saif1_lookups, ARRAY_SIZE(saif1_lookups));
+	clk = mxs_clk_gate("lcdif", "lcdif_div", LCDIF, 31);
+	clk_register_clkdevs(clk, lcdif_lookups, ARRAY_SIZE(lcdif_lookups));
+	mxs_clk_gate("etm", "etm_div", ETM, 31);
+	clk = mxs_clk_gate("fec", "hbus", ENET, 30);
+	clk_register_clkdevs(clk, fec_lookups, ARRAY_SIZE(fec_lookups));
+	clk = mxs_clk_gate("can0", "ref_xtal", FLEXCAN, 30);
+	clk_register_clkdevs(clk, can0_lookups, ARRAY_SIZE(can0_lookups));
+	clk = mxs_clk_gate("can1", "ref_xtal", FLEXCAN, 28);
+	clk_register_clkdevs(clk, can1_lookups, ARRAY_SIZE(can1_lookups));
+	mxs_clk_gate("usb0", "pll0", DIGCTRL, 2);
+	mxs_clk_gate("usb1", "pll1", DIGCTRL, 16);
+
+	clk = clk_register_gate(NULL, "enet_out", "pll2", 0, ENET, 18, 0, NULL);
+	clk_register_clkdev(clk, NULL, "enet_out");
+
+	ret = mxs_clk_init_on(clks_init_on, ARRAY_SIZE(clks_init_on));
+	if (ret)
+		return ret;
+
+	mxs_timer_init(NULL, MX28_INT_TIMER0);
+
+	return 0;
+}
-- 
1.7.5.4
