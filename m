From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Apr 2012 23:57:14 +0800
Subject: [PATCH 2/8] clk: mxs: add clock support for imx23
In-Reply-To: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335023840-1394-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx23 clock support based on common clk framework.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/mxs/Makefile    |    2 +
 drivers/clk/mxs/clk-imx23.c |  195 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/mxs/clk.h       |   20 +++++
 3 files changed, 217 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/mxs/clk-imx23.c

diff --git a/drivers/clk/mxs/Makefile b/drivers/clk/mxs/Makefile
index 067c231..21ec6ca 100644
--- a/drivers/clk/mxs/Makefile
+++ b/drivers/clk/mxs/Makefile
@@ -3,3 +3,5 @@
 #
 
 obj-y += clk-pll.o clk-ref.o clk-div.o clk-frac.o
+
+obj-$(CONFIG_SOC_IMX23) += clk-imx23.o
diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
new file mode 100644
index 0000000..6cce512
--- /dev/null
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -0,0 +1,195 @@
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
+#include <mach/mx23.h>
+#include "clk.h"
+
+#define DIGCTRL			MX23_IO_ADDRESS(MX23_DIGCTL_BASE_ADDR)
+#define CLKCTRL			MX23_IO_ADDRESS(MX23_CLKCTRL_BASE_ADDR)
+#define PLLCTRL0		(CLKCTRL + 0x0000)
+#define CPU			(CLKCTRL + 0x0020)
+#define HBUS			(CLKCTRL + 0x0030)
+#define XBUS			(CLKCTRL + 0x0040)
+#define XTAL			(CLKCTRL + 0x0050)
+#define PIX			(CLKCTRL + 0x0060)
+#define SSP			(CLKCTRL + 0x0070)
+#define GPMI			(CLKCTRL + 0x0080)
+#define SPDIF			(CLKCTRL + 0x0090)
+#define EMI			(CLKCTRL + 0x00a0)
+#define SAIF			(CLKCTRL + 0x00c0)
+#define TV			(CLKCTRL + 0x00d0)
+#define ETM			(CLKCTRL + 0x00e0)
+#define FRAC			(CLKCTRL + 0x00f0)
+#define CLKSEQ			(CLKCTRL + 0x0110)
+
+#define BP_CPU_INTERRUPT_WAIT	12
+#define BP_CLKSEQ_BYPASS_SAIF	0
+#define BP_CLKSEQ_BYPASS_SSP	5
+#define BP_SAIF_DIV_FRAC_EN	16
+#define BP_FRAC_IOFRAC		24
+
+static void __init clk_misc_init(void)
+{
+	u32 val;
+
+	/* Gate off cpu clock in WFI for power saving */
+	__mxs_setl(1 << BP_CPU_INTERRUPT_WAIT, CPU);
+
+	/* Clear BYPASS for SAIF */
+	__mxs_clrl(1 << BP_CLKSEQ_BYPASS_SAIF, CLKSEQ);
+
+	/* SAIF has to use frac div for functional operation */
+	val = readl_relaxed(SAIF);
+	val |= 1 << BP_SAIF_DIV_FRAC_EN;
+	writel_relaxed(val, SAIF);
+
+	/*
+	 * Source ssp clock from ref_io than ref_xtal,
+	 * as ref_xtal only provides 24 MHz as maximum.
+	 */
+	__mxs_clrl(1 << BP_CLKSEQ_BYPASS_SSP, CLKSEQ);
+
+	/*
+	 * 480 MHz seems too high to be ssp clock source directly,
+	 * so set frac to get a 288 MHz ref_io.
+	 */
+	__mxs_clrl(0x3f << BP_FRAC_IOFRAC, FRAC);
+	__mxs_setl(30 << BP_FRAC_IOFRAC, FRAC);
+}
+
+static struct clk_lookup uart_lookups[] __initdata = {
+	{ .dev_id = "duart", },
+	{ .dev_id = "mxs-auart.0", },
+	{ .dev_id = "mxs-auart.1", },
+	{ .dev_id = "8006c000.serial", },
+	{ .dev_id = "8006e000.serial", },
+	{ .dev_id = "80070000.serial", },
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
+static struct clk_lookup ssp_lookups[] __initdata = {
+	{ .dev_id = "mxs-mmc.0", },
+	{ .dev_id = "mxs-mmc.1", },
+	{ .dev_id = "80010000.ssp", },
+	{ .dev_id = "80034000.ssp", },
+};
+
+static struct clk_lookup lcdif_lookups[] __initdata = {
+	{ .dev_id = "imx23-fb", },
+	{ .dev_id = "80030000.lcdif", },
+};
+
+static struct clk_lookup gpmi_lookups[] __initdata = {
+	{ .dev_id = "imx23-gpmi-nand", },
+	{ .dev_id = "8000c000.gpmi", },
+};
+
+static const char *sel_pll[]  __initconst = { "pll", "ref_xtal", };
+static const char *sel_cpu[]  __initconst = { "ref_cpu", "ref_xtal", };
+static const char *sel_pix[]  __initconst = { "ref_pix", "ref_xtal", };
+static const char *sel_io[]   __initconst = { "ref_io", "ref_xtal", };
+static const char *cpu_sels[] __initconst = { "cpu_pll", "cpu_xtal", };
+static const char *emi_sels[] __initconst = { "emi_pll", "emi_xtal", };
+
+static char *clks_init_on[] __initdata = {
+	"cpu", "hbus", "xbus", "emi", "uart",
+};
+
+int __init mx23_clocks_init(void)
+{
+	struct clk *clk;
+	int ret;
+
+	clk_misc_init();
+
+	mxs_clk_fixed("ref_xtal", 24000000);
+
+	mxs_clk_pll("pll", "ref_xtal", PLLCTRL0, 16, 18, 480000000, 0);
+
+	mxs_clk_ref("ref_cpu", "pll", FRAC, 0);
+	mxs_clk_ref("ref_emi", "pll", FRAC, 1);
+	mxs_clk_ref("ref_pix", "pll", FRAC, 2);
+	mxs_clk_ref("ref_io", "pll", FRAC, 3);
+
+	mxs_clk_mux("saif_sel", CLKSEQ, 0, 1, sel_pll, ARRAY_SIZE(sel_pll));
+	mxs_clk_mux("lcdif_sel", CLKSEQ, 1, 1, sel_pix, ARRAY_SIZE(sel_pix));
+	mxs_clk_mux("gpmi_sel", CLKSEQ, 4, 1, sel_io, ARRAY_SIZE(sel_io));
+	mxs_clk_mux("ssp_sel", CLKSEQ, 5, 1, sel_io, ARRAY_SIZE(sel_io));
+	mxs_clk_mux("emi_sel", CLKSEQ, 6, 1, emi_sels, ARRAY_SIZE(emi_sels));
+	clk = mxs_clk_mux("cpu", CLKSEQ, 7, 1, cpu_sels, ARRAY_SIZE(cpu_sels));
+	clk_register_clkdev(clk, NULL, "cpu");
+	mxs_clk_mux("etm_sel", CLKSEQ, 8, 1, sel_cpu, ARRAY_SIZE(sel_cpu));
+
+	mxs_clk_div("cpu_pll", "ref_cpu", CPU, 0, 6, 28);
+	mxs_clk_div("cpu_xtal", "ref_xtal", CPU, 16, 10, 29);
+	clk = mxs_clk_div("hbus", "cpu", HBUS, 0, 5, 29);
+	clk_register_clkdevs(clk, hbus_lookups, ARRAY_SIZE(hbus_lookups));
+	clk = mxs_clk_div("xbus", "ref_xtal", XBUS, 0, 10, 31);
+	clk_register_clkdevs(clk, xbus_lookups, ARRAY_SIZE(xbus_lookups));
+	mxs_clk_div("lcdif_div", "lcdif_sel", PIX, 0, 12, 29);
+	mxs_clk_div("ssp_div", "ssp_sel", SSP, 0, 9, 29);
+	mxs_clk_div("gpmi_div", "gpmi_sel", GPMI, 0, 10, 29);
+	mxs_clk_div("emi_pll", "ref_emi", EMI, 0, 6, 28);
+	mxs_clk_div("emi_xtal", "ref_xtal", EMI, 8, 4, 29);
+	mxs_clk_div("etm_div", "etm_sel", ETM, 0, 6, 29);
+	mxs_clk_frac("saif_div", "saif_sel", SAIF, 0, 16, 29);
+
+	mxs_clk_fixed_factor("clk32k_div", "ref_xtal", 1, 750);
+	mxs_clk_fixed_factor("rtc", "ref_xtal", 1, 768);
+	mxs_clk_fixed_factor("adc", "clk32k", 1, 16);
+	mxs_clk_fixed_factor("spdif_div", "pll", 1, 4);
+
+	clk = mxs_clk_gate("clk32k", "clk32k_div", XTAL, 26);
+	clk_register_clkdev(clk, NULL, "timrot");
+	mxs_clk_gate("dri", "ref_xtal", XTAL, 28);
+	mxs_clk_gate("pwm", "ref_xtal", XTAL, 29);
+	mxs_clk_gate("filt", "ref_xtal", XTAL, 30);
+	clk = mxs_clk_gate("uart", "ref_xtal", XTAL, 31);
+	clk_register_clkdevs(clk, uart_lookups, ARRAY_SIZE(uart_lookups));
+	clk = mxs_clk_gate("ssp", "ssp_div", SSP, 31);
+	clk_register_clkdevs(clk, ssp_lookups, ARRAY_SIZE(ssp_lookups));
+	clk = mxs_clk_gate("gpmi", "gpmi_div", GPMI, 31);
+	clk_register_clkdevs(clk, gpmi_lookups, ARRAY_SIZE(gpmi_lookups));
+	mxs_clk_gate("spdif", "spdif_div", SPDIF, 31);
+	clk = mxs_clk_gate("emi", "emi_sel", EMI, 31);
+	clk_register_clkdev(clk, NULL, "emi");
+	mxs_clk_gate("saif", "saif_div", SAIF, 31);
+	clk = mxs_clk_gate("lcdif", "lcdif_div", PIX, 31);
+	clk_register_clkdevs(clk, lcdif_lookups, ARRAY_SIZE(lcdif_lookups));
+	mxs_clk_gate("etm", "etm_div", ETM, 31);
+	mxs_clk_gate("usb", "pll", DIGCTRL, 2);
+
+	ret = mxs_clk_init_on(clks_init_on, ARRAY_SIZE(clks_init_on));
+	if (ret)
+		return ret;
+
+	mxs_timer_init(NULL, MX23_INT_TIMER0);
+
+	return 0;
+}
diff --git a/drivers/clk/mxs/clk.h b/drivers/clk/mxs/clk.h
index deb5c23..fb5937d 100644
--- a/drivers/clk/mxs/clk.h
+++ b/drivers/clk/mxs/clk.h
@@ -12,6 +12,8 @@
 #ifndef __MXS_CLK_H
 #define __MXS_CLK_H
 
+#include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -72,4 +74,22 @@ static inline int mxs_clk_wait(void __iomem *reg, u8 shift)
 	return 0;
 }
 
+static inline int mxs_clk_init_on(char **clks_init_on, int num)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		clk = clk_get_sys(clks_init_on[i], NULL);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to get clk %s", __func__,
+			       clks_init_on[i]);
+			return PTR_ERR(clk);
+		}
+		clk_prepare_enable(clk);
+	}
+
+	return 0;
+}
+
 #endif /* __MXS_CLK_H */
-- 
1.7.5.4
