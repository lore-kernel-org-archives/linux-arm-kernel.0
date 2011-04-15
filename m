From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Apr 2011 21:08:14 +0200
Subject: [PATCH 09/10] ARM i.MX51/53: reimplement clock support
In-Reply-To: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1302894495-6879-10-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reimplement i.MX51/53 clock support. This is tested with a babbage
board and a loco board up to the point that UARTs, FEC and USB work.
There are surely bugs left in the code, but I found several in the
old code while reimplementing it, so who cares...
The implementation is mostly based on the datasheet and not the old
code.

The old code is left in the tree and removed in the next patch.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig               |    6 +
 arch/arm/mach-mx5/Makefile              |    2 +-
 arch/arm/mach-mx5/clock-imx51-imx53.c   |  420 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/clkdev.h |    2 +
 arch/arm/plat-mxc/include/mach/clock.h  |    3 +
 5 files changed, 432 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mx5/clock-imx51-imx53.c

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 159340d..c39cf42 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -26,12 +26,18 @@ config	SOC_IMX51
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_HAS_CPUFREQ
 	select ARCH_MX51
+	select USE_COMMON_STRUCT_CLK
+	select USE_COMMON_CLK_DIVIDER
+	select USE_COMMON_CLK_MUX
 
 config	SOC_IMX53
 	bool
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MX53
+	select USE_COMMON_STRUCT_CLK
+	select USE_COMMON_CLK_DIVIDER
+        select USE_COMMON_CLK_MUX
 
 comment "MX5 platforms:"
 
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 0b9338c..164d300 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Object file lists.
-obj-y   := cpu.o mm.o clock-mx51-mx53.o devices.o ehci.o system.o
+obj-y   := cpu.o mm.o clock-imx51-imx53.o devices.o ehci.o system.o
 obj-$(CONFIG_SOC_IMX50) += mm-mx50.o
 
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
diff --git a/arch/arm/mach-mx5/clock-imx51-imx53.c b/arch/arm/mach-mx5/clock-imx51-imx53.c
new file mode 100644
index 0000000..27b6c63
--- /dev/null
+++ b/arch/arm/mach-mx5/clock-imx51-imx53.c
@@ -0,0 +1,420 @@
+/*
+ * Copyright 2010 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/clkdev.h>
+
+#include <asm/div64.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/clock.h>
+
+#include "crm_regs.h"
+
+static DEFINE_CLK_FIXED(ckil, 0);
+static DEFINE_CLK_FIXED(osc, 0);
+static DEFINE_CLK_FIXED(ckih1, 0);
+static DEFINE_CLK_FIXED(ckih2, 0);
+
+static DEFINE_CLK_PLLV2(pll1_sw, &osc.clk, MX51_DPLL1_BASE);
+static DEFINE_CLK_PLLV2(pll2_sw, &osc.clk, MX51_DPLL2_BASE);
+static DEFINE_CLK_PLLV2(pll3_sw, &osc.clk, MX51_DPLL3_BASE);
+static DEFINE_CLK_PLLV2(pll4_sw, &osc.clk, MX53_DPLL4_BASE);
+
+static DEFINE_CLK_FIXED(dummy, 0);
+
+/* Low-power Audio Playback Mode clock */
+static struct clk *lp_apm_sel[] = {
+	&osc.clk,
+	NULL,
+};
+static DEFINE_CLK_MUX(lp_apm, MXC_CCM_CCSR, 9, 1, lp_apm_sel);
+
+/* This is used multiple times */
+static struct clk *standard_pll_sel_clks[] = {
+	&pll1_sw.clk,
+	&pll2_sw.clk,
+	&pll3_sw.clk,
+	&lp_apm.clk,
+};
+
+static struct clk *periph_apm_sel[] = {
+	&pll1_sw.clk,
+	&pll3_sw.clk,
+	&lp_apm.clk,
+	NULL,
+};
+static DEFINE_CLK_MUX(periph_apm, MXC_CCM_CBCMR, 12, 2, periph_apm_sel);
+
+static struct clk *main_bus_sel[] = {
+	&pll2_sw.clk,
+	&periph_apm.clk,
+};
+static DEFINE_CLK_MUX(main_bus, MXC_CCM_CBCDR, 25, 1, main_bus_sel);
+
+static DEFINE_CLK_DIVIDER(ahb_root, &main_bus.clk, MXC_CCM_CBCDR, 10, 3);
+static DEFINE_CLK_DIVIDER(ipg, &ahb_root.clk, MXC_CCM_CBCDR, 8, 2);
+
+static DEFINE_CLK_MUX(uart_sel, MXC_CCM_CSCMR1, 24, 2, standard_pll_sel_clks);
+static DEFINE_CLK_DIVIDER(uart_pred, &uart_sel.clk, MXC_CCM_CSCDR1, 3, 3);
+static DEFINE_CLK_DIVIDER(uart_root, &uart_pred.clk, MXC_CCM_CSCDR1, 0, 3);
+
+static DEFINE_CLK_MUX(esdhc1_sel, MXC_CCM_CSCMR1, 20, 2, standard_pll_sel_clks);
+static DEFINE_CLK_DIVIDER(esdhc1_pred, &esdhc1_sel.clk, MXC_CCM_CSCDR1, 16, 3);
+static DEFINE_CLK_DIVIDER(esdhc1_podf, &esdhc1_pred.clk, MXC_CCM_CSCDR1, 11, 3);
+
+/* This is routed to esdhc3 in the i.MX53 datasheet */
+static DEFINE_CLK_MUX(esdhc2_sel, MXC_CCM_CSCMR1, 16, 2, standard_pll_sel_clks);
+static DEFINE_CLK_DIVIDER(esdhc2_pred, &esdhc2_sel.clk, MXC_CCM_CSCDR1, 22, 3);
+static DEFINE_CLK_DIVIDER(esdhc2_podf, &esdhc2_pred.clk, MXC_CCM_CSCDR1, 19, 3);
+
+static struct clk *esdhc3_sel_clks[] = {
+	&esdhc1_podf.clk,
+	&esdhc2_podf.clk,
+};
+static DEFINE_CLK_MUX(esdhc3_sel, MXC_CCM_CSCMR1, 19, 1, esdhc3_sel_clks);
+
+static struct clk *esdhc4_sel_clks[] = {
+	&esdhc1_podf.clk,
+	&esdhc2_podf.clk,
+};
+static DEFINE_CLK_MUX(esdhc4_sel, MXC_CCM_CSCMR1, 18, 1, esdhc4_sel_clks);
+
+static struct clk *emi_slow_sel_clks[] = {
+	&main_bus.clk,
+	&ahb_root.clk,
+};
+static DEFINE_CLK_MUX(emi_sel, MXC_CCM_CBCDR, 26, 1, emi_slow_sel_clks);
+static DEFINE_CLK_DIVIDER(emi_slow_podf, &emi_sel.clk, MXC_CCM_CBCDR, 22, 3);
+static DEFINE_CLK_DIVIDER(nfc_podf, &emi_slow_podf.clk, MXC_CCM_CBCDR, 13, 3);
+
+static DEFINE_CLK_MUX(ecspi_sel, MXC_CCM_CSCMR1, 4, 2, standard_pll_sel_clks);
+static DEFINE_CLK_DIVIDER(ecspi_pred, &ecspi_sel.clk, MXC_CCM_CSCDR2, 25, 3);
+static DEFINE_CLK_DIVIDER(ecspi_podf, &ecspi_pred.clk, MXC_CCM_CSCDR2, 19, 6);
+
+static DEFINE_CLK_MUX(usboh3_sel, MXC_CCM_CSCMR1, 22, 2, standard_pll_sel_clks);
+static DEFINE_CLK_DIVIDER(usboh3_pred, &usboh3_sel.clk, MXC_CCM_CSCDR1, 8, 3);
+static DEFINE_CLK_DIVIDER(usboh3_podf, &usboh3_pred.clk, MXC_CCM_CSCDR1, 6, 2);
+
+static DEFINE_CLK_DIVIDER(usb_phy_pred, &pll3_sw.clk, MXC_CCM_CDCDR, 3, 3);
+static DEFINE_CLK_DIVIDER(usb_phy_podf, &usb_phy_pred.clk, MXC_CCM_CDCDR, 0, 3);
+static struct clk *usb_phy_sel_clks[] = {
+	&osc.clk,
+	&usb_phy_podf.clk,
+};
+static DEFINE_CLK_MUX(usb_phy_sel, MXC_CCM_CSCMR1, 26, 1, usb_phy_sel_clks);
+
+static DEFINE_CLK_DIVIDER(cpu_podf, &pll1_sw.clk, MXC_CCM_CACRR, 0, 3);
+
+static struct clk *ipu_di0_sel_clks[] = {
+	&pll3_sw.clk,
+	&osc.clk,
+	&ckih1.clk,
+	NULL, /* &tve_di.clk */
+	NULL, /* ipp di0 (iomux) */
+	NULL, /* ldp di0 */
+};
+static DEFINE_CLK_MUX(ipu_di0_sel, MXC_CCM_CSCMR2, 26, 3, ipu_di0_sel_clks);
+
+static struct clk *ipu_di1_sel_clks[] = {
+	&pll3_sw.clk,
+	&osc.clk,
+	&ckih1.clk,
+	NULL, /* &tve_di.clk */
+	NULL, /* ipp di1 (iomux) */
+	NULL, /* ldp di1 */
+};
+static DEFINE_CLK_MUX(ipu_di1_sel, MXC_CCM_CSCMR2, 29, 3, ipu_di1_sel_clks);
+
+static struct clk *tve_ext_sel_clks[] = {
+	&osc.clk,
+	&ckih1.clk,
+};
+static DEFINE_CLK_MUX(tve_ext_sel, MXC_CCM_CSCMR1, 6, 1, tve_ext_sel_clks);
+
+static DEFINE_CLK_DIVIDER(tve_pred, &pll3_sw.clk, MXC_CCM_CDCDR, 28, 3);
+
+static struct clk *tve_sel_clks[] = {
+	&tve_pred.clk,
+	&tve_ext_sel.clk,
+};
+static DEFINE_CLK_MUX(tve_sel, MXC_CCM_CSCMR1, 7, 1, tve_sel_clks);
+
+static DEFINE_CLK_GATE_2(iim_gate, &ipg.clk, MXC_CCM_CCGR0, 30);
+
+static DEFINE_CLK_GATE_2(uart1_ipg_gate, &ipg.clk, MXC_CCM_CCGR1, 6);
+static DEFINE_CLK_GATE_2(uart1_per_gate, &uart_root.clk, MXC_CCM_CCGR1, 8);
+static DEFINE_CLK_GATE_2(uart2_ipg_gate, &ipg.clk, MXC_CCM_CCGR1, 10);
+static DEFINE_CLK_GATE_2(uart2_per_gate, &uart_root.clk, MXC_CCM_CCGR1, 12);
+static DEFINE_CLK_GATE_2(uart3_ipg_gate, &ipg.clk, MXC_CCM_CCGR1, 14);
+static DEFINE_CLK_GATE_2(uart3_per_gate, &uart_root.clk, MXC_CCM_CCGR1, 16);
+static DEFINE_CLK_GATE_2(i2c1_gate, &ipg.clk, MXC_CCM_CCGR1, 18);
+static DEFINE_CLK_GATE_2(i2c2_gate, &ipg.clk, MXC_CCM_CCGR1, 20);
+static DEFINE_CLK_GATE_2(hsi2c_gate, &ipg.clk, MXC_CCM_CCGR1, 22);
+
+static DEFINE_CLK_GATE_2(mx51_usb_phy_gate, &usb_phy_sel.clk, MXC_CCM_CCGR2, 0);
+static DEFINE_CLK_GATE_2(gpt_ipg_gate, &ipg.clk, MXC_CCM_CCGR2, 20);
+static DEFINE_CLK_GATE_2(pwm1_ipg_gate, &ipg.clk, MXC_CCM_CCGR2, 10);
+static DEFINE_CLK_GATE_2(pwm1_hf_gate, &ipg.clk, MXC_CCM_CCGR2, 12);
+static DEFINE_CLK_GATE_2(pwm2_ipg_gate, &ipg.clk, MXC_CCM_CCGR2, 14);
+static DEFINE_CLK_GATE_2(pwm2_hf_gate, &ipg.clk, MXC_CCM_CCGR2, 16);
+static DEFINE_CLK_GATE_2(gpt_gate, &ipg.clk, MXC_CCM_CCGR2, 18);
+static DEFINE_CLK_GATE_2(fec_gate, &ipg.clk, MXC_CCM_CCGR2, 24);
+static DEFINE_CLK_GATE_2(usboh3_ahb_gate, &ipg.clk, MXC_CCM_CCGR2, 26);
+static DEFINE_CLK_GATE_2(usboh3_gate, &usboh3_podf.clk, MXC_CCM_CCGR2, 28);
+static DEFINE_CLK_GATE_2(tve_gate, &tve_sel.clk, MXC_CCM_CCGR2, 30);
+
+static DEFINE_CLK_GATE_2(esdhc1_ipg_gate, &ipg.clk, MXC_CCM_CCGR3, 0);
+static DEFINE_CLK_GATE_2(esdhc1_per_gate, &esdhc1_podf.clk, MXC_CCM_CCGR3, 2);
+static DEFINE_CLK_GATE_2(esdhc2_ipg_gate, &ipg.clk, MXC_CCM_CCGR3, 4);
+static DEFINE_CLK_GATE_2(esdhc2_per_gate, &esdhc2_podf.clk, MXC_CCM_CCGR3, 6);
+static DEFINE_CLK_GATE_2(esdhc3_ipg_gate, &ipg.clk, MXC_CCM_CCGR3, 8);
+static DEFINE_CLK_GATE_2(esdhc3_per_gate, &esdhc3_sel.clk, MXC_CCM_CCGR3, 10);
+static DEFINE_CLK_GATE_2(esdhc4_ipg_gate, &ipg.clk, MXC_CCM_CCGR3, 12);
+static DEFINE_CLK_GATE_2(esdhc4_per_gate, &esdhc4_sel.clk, MXC_CCM_CCGR3, 14);
+static DEFINE_CLK_GATE_2(ssi1_ipg_gate, &ipg.clk, MXC_CCM_CCGR3, 16);
+static DEFINE_CLK_GATE_2(ssi2_ipg_gate, &ipg.clk, MXC_CCM_CCGR3, 18);
+static DEFINE_CLK_GATE_2(ssi3_ipg_gate, &ipg.clk, MXC_CCM_CCGR3, 20);
+
+static DEFINE_CLK_GATE_2(mx51_mipi_hsc1_gate, &ipg.clk, MXC_CCM_CCGR4, 6);
+static DEFINE_CLK_GATE_2(mx51_mipi_hsc2_gate, &ipg.clk, MXC_CCM_CCGR4, 8);
+static DEFINE_CLK_GATE_2(mx51_mipi_esc_gate, &ipg.clk, MXC_CCM_CCGR4, 10);
+static DEFINE_CLK_GATE_2(mx51_mipi_hsp_gate, &ipg.clk, MXC_CCM_CCGR4, 12);
+
+static DEFINE_CLK_GATE_2(mx53_usb_phy1_gate, &usb_phy_sel.clk, MXC_CCM_CCGR4, 10);
+static DEFINE_CLK_GATE_2(mx53_usb_phy2_gate, &usb_phy_sel.clk, MXC_CCM_CCGR4, 12);
+static DEFINE_CLK_GATE_2(ecspi1_ipg_gate, &ipg.clk, MXC_CCM_CCGR4, 18);
+static DEFINE_CLK_GATE_2(ecspi1_per_gate, &ecspi_podf.clk, MXC_CCM_CCGR4, 20);
+static DEFINE_CLK_GATE_2(ecspi2_ipg_gate, &ipg.clk, MXC_CCM_CCGR4, 22);
+static DEFINE_CLK_GATE_2(ecspi2_per_gate, &ecspi_podf.clk, MXC_CCM_CCGR4, 24);
+static DEFINE_CLK_GATE_2(cspi_ipg_gate, &ipg.clk, MXC_CCM_CCGR4, 26);
+static DEFINE_CLK_GATE_2(sdma_gate, &ipg.clk, MXC_CCM_CCGR4, 30);
+
+static DEFINE_CLK_GATE_2(ipu_gate, &ahb_root.clk, MXC_CCM_CCGR5, 10);
+static DEFINE_CLK_GATE_2(emi_fast_gate, &dummy.clk, MXC_CCM_CCGR5, 16);
+static DEFINE_CLK_GATE_2(emi_slow_gate, &emi_slow_podf.clk, MXC_CCM_CCGR5, 16);
+static DEFINE_CLK_GATE_2(nfc_gate, &nfc_podf.clk, MXC_CCM_CCGR5, 20);
+
+static DEFINE_CLK_GATE_2(ipu_di0_gate, &ipu_di0_sel.clk, MXC_CCM_CCGR6, 10);
+static DEFINE_CLK_GATE_2(ipu_di1_gate, &ipu_di1_sel.clk, MXC_CCM_CCGR6, 12);
+
+static struct clk *uart1_group[] = {
+	&uart1_per_gate.clk,
+	&uart1_ipg_gate.clk
+};
+static DEFINE_CLK_GROUP(uart1, uart1_group);
+
+static struct clk *uart2_group[] = {
+	&uart2_per_gate.clk,
+	&uart2_ipg_gate.clk
+};
+static DEFINE_CLK_GROUP(uart2, uart2_group);
+
+static struct clk *uart3_group[] = {
+	&uart3_per_gate.clk,
+	&uart3_ipg_gate.clk
+};
+static DEFINE_CLK_GROUP(uart3, uart3_group);
+
+static struct clk *gpt_group[] = {
+	&gpt_gate.clk,
+	&gpt_ipg_gate.clk,
+};
+static DEFINE_CLK_GROUP(gpt, gpt_group);
+
+static struct clk *esdhc1_group[] = {
+	&esdhc1_per_gate.clk,
+	&esdhc1_ipg_gate.clk,
+};
+static DEFINE_CLK_GROUP(esdhc1, esdhc1_group);
+
+static struct clk *esdhc2_group[] = {
+	&esdhc2_per_gate.clk,
+	&esdhc2_ipg_gate.clk,
+};
+static DEFINE_CLK_GROUP(esdhc2, esdhc2_group);
+
+static struct clk *esdhc3_group[] = {
+	&esdhc3_per_gate.clk,
+	&esdhc3_ipg_gate.clk,
+};
+static DEFINE_CLK_GROUP(esdhc3, esdhc3_group);
+
+static struct clk *esdhc4_group[] = {
+	&esdhc4_per_gate.clk,
+	&esdhc4_ipg_gate.clk,
+};
+static DEFINE_CLK_GROUP(esdhc4, esdhc4_group);
+
+static struct clk *ecspi1_group[] = {
+	&ecspi1_per_gate.clk,
+	&ecspi1_ipg_gate.clk,
+};
+static DEFINE_CLK_GROUP(ecspi1, ecspi1_group);
+
+static struct clk *ecspi2_group[] = {
+	&ecspi2_per_gate.clk,
+	&ecspi2_ipg_gate.clk,
+};
+static DEFINE_CLK_GROUP(ecspi2, ecspi2_group);
+
+static struct clk *cspi_group[] = {
+	&ecspi1_per_gate.clk,
+	&cspi_ipg_gate.clk,
+};
+static DEFINE_CLK_GROUP(cspi, cspi_group);
+
+static struct clk *mx51_mipi_group[] = {
+	&mx51_mipi_hsp_gate.clk,
+	&mx51_mipi_hsc1_gate.clk,
+	&mx51_mipi_hsc2_gate.clk,
+	&mx51_mipi_esc_gate.clk,
+};
+static DEFINE_CLK_GROUP(mx51_mipi, mx51_mipi_group);
+
+static struct clk *ipu_group_clks[] = {
+	&ipu_gate.clk,
+	&emi_fast_gate.clk,
+};
+static DEFINE_CLK_GROUP(ipu, ipu_group_clks);
+
+#define _REGISTER_CLOCK(d, n, c) \
+       { \
+		.dev_id = d, \
+		.con_id = n, \
+		.clk = c,   \
+       },
+
+static struct clk_lookup mx5_lookups[] = {
+	_REGISTER_CLOCK("imx-uart.0", NULL, &uart1.clk)
+	_REGISTER_CLOCK("imx-uart.1", NULL, &uart2.clk)
+	_REGISTER_CLOCK("imx-uart.2", NULL, &uart3.clk)
+	_REGISTER_CLOCK("fec.0", NULL, &fec_gate.clk)
+	_REGISTER_CLOCK("mxc_pwm.0", "pwm", &pwm1_ipg_gate.clk)
+	_REGISTER_CLOCK("mxc_pwm.1", "pwm", &pwm2_ipg_gate.clk)
+	_REGISTER_CLOCK("imx-i2c.0", NULL, &i2c1_gate.clk)
+	_REGISTER_CLOCK("imx-i2c.1", NULL, &i2c2_gate.clk)
+	_REGISTER_CLOCK("mxc-ehci.0", "usb", &usboh3_gate.clk)
+	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", &usboh3_ahb_gate.clk)
+	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy1", &mx53_usb_phy1_gate.clk)
+	_REGISTER_CLOCK("mxc-ehci.1", "usb", &usboh3_gate.clk)
+	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", &usboh3_ahb_gate.clk)
+	_REGISTER_CLOCK("mxc-ehci.2", "usb", &usboh3_gate.clk)
+	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", &usboh3_ahb_gate.clk)
+	_REGISTER_CLOCK("fsl-usb2-udc", "usb", &usboh3_gate.clk)
+	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", &usboh3_ahb_gate.clk)
+	_REGISTER_CLOCK("mxc_nand", NULL, &nfc_gate.clk)
+	_REGISTER_CLOCK("imx-ssi.0", NULL, &ssi1_ipg_gate.clk)
+	_REGISTER_CLOCK("imx-ssi.1", NULL, &ssi1_ipg_gate.clk)
+	_REGISTER_CLOCK("imx-ssi.2", NULL, &ssi1_ipg_gate.clk)
+	_REGISTER_CLOCK("imx-sdma", NULL, &sdma_gate.clk)
+	_REGISTER_CLOCK("imx51-ecspi.0", NULL, &ecspi1.clk)
+	_REGISTER_CLOCK("imx51-ecspi.1", NULL, &ecspi2.clk)
+	_REGISTER_CLOCK("imx51-cspi.0", NULL, &cspi.clk)
+	_REGISTER_CLOCK(NULL, "cpu", &cpu_podf.clk)
+	_REGISTER_CLOCK(NULL, "iim", &iim_gate.clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, &esdhc1.clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, &esdhc2.clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, &esdhc3.clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, &esdhc4.clk)
+	_REGISTER_CLOCK("imx-ipuv3", NULL, &ipu.clk)
+	_REGISTER_CLOCK("imx-ipuv3", "di0", &ipu_di0_gate.clk)
+	_REGISTER_CLOCK("imx-ipuv3", "di1", &ipu_di1_gate.clk)
+	_REGISTER_CLOCK("imx2-wdt.0", NULL, &dummy.clk)
+	_REGISTER_CLOCK("imx2-wdt.1", NULL, &dummy.clk)
+	_REGISTER_CLOCK("imx-keypad", NULL, &dummy.clk)
+};
+
+static struct clk_lookup mx51_lookups[] = {
+	_REGISTER_CLOCK("imx-i2c.2", NULL, &hsi2c_gate.clk)
+	_REGISTER_CLOCK(NULL, "mipi_hsp", &mx51_mipi.clk)
+};
+
+static void clkdev_add_array(struct clk_lookup *lookup, int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		clkdev_add(&lookup[i]);
+}
+
+static void mx5_clocks_common_init(unsigned long rate_ckil, unsigned long rate_osc,
+			unsigned long rate_ckih1, unsigned long rate_ckih2)
+{
+	ckil.rate = rate_ckil;
+	osc.rate = rate_osc;
+	ckih1.rate = rate_ckih1;
+	ckih2.rate = rate_ckih2;
+
+	clkdev_add_array(mx5_lookups, ARRAY_SIZE(mx5_lookups));
+
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(&esdhc1_sel.clk, &pll2_sw.clk);
+	clk_set_parent(&esdhc2_sel.clk, &pll2_sw.clk);
+}
+
+int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
+			unsigned long rate_ckih1, unsigned long rate_ckih2)
+{
+	/* Clock tree has i.MX51 layout. i.MX53 needs some fixups */
+	pll1_sw.base = MX53_DPLL1_BASE;
+	pll2_sw.base = MX53_DPLL2_BASE;
+	pll3_sw.base = MX53_DPLL3_BASE;
+	esdhc3_per_gate.parent = &esdhc2_podf.clk;
+	esdhc2_per_gate.parent = &esdhc3_sel.clk;
+	tve_gate.parent = &tve_pred.clk;
+	tve_pred.parent = &tve_ext_sel.clk;
+	tve_ext_sel_clks[0] = &pll4_sw.clk;
+	tve_ext_sel_clks[1] = &ckih1.clk;
+
+	mx5_clocks_common_init(rate_ckil, rate_osc, rate_ckih1, rate_ckih2);
+
+	/* set SDHC root clock to 200MHZ*/
+	clk_set_rate(&esdhc1_podf.clk, 200000000);
+	clk_set_rate(&esdhc2_podf.clk, 200000000);
+
+	/* System timer */
+	mxc_timer_init(&gpt.clk, MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR),
+		MX53_INT_GPT);
+
+	clk_prepare(&iim_gate.clk);
+	clk_enable(&iim_gate.clk);
+	mx53_revision();
+	clk_disable(&iim_gate.clk);
+
+	return 0;
+}
+
+int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
+			unsigned long rate_ckih1, unsigned long rate_ckih2)
+{
+	mx5_clocks_common_init(rate_ckil, rate_osc, rate_ckih1, rate_ckih2);
+	clkdev_add_array(mx51_lookups, ARRAY_SIZE(mx51_lookups));
+
+	/* set SDHC root clock to 166.25MHZ*/
+	clk_set_rate(&esdhc1_podf.clk, 166250000);
+	clk_set_rate(&esdhc2_podf.clk, 166250000);
+
+	/* System timer */
+	mxc_timer_init(&gpt.clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
+		MX51_MXC_INT_GPT);
+
+	clk_prepare(&iim_gate.clk);
+	clk_enable(&iim_gate.clk);
+	mx51_revision();
+	clk_disable(&iim_gate.clk);
+	mx51_display_revision();
+
+	return 0;
+}
diff --git a/arch/arm/plat-mxc/include/mach/clkdev.h b/arch/arm/plat-mxc/include/mach/clkdev.h
index 04b37a8..ad1e227 100644
--- a/arch/arm/plat-mxc/include/mach/clkdev.h
+++ b/arch/arm/plat-mxc/include/mach/clkdev.h
@@ -1,7 +1,9 @@
 #ifndef __ASM_MACH_CLKDEV_H
 #define __ASM_MACH_CLKDEV_H
 
+#ifndef CONFIG_USE_COMMON_STRUCT_CLK
 #define __clk_get(clk) ({ 1; })
 #define __clk_put(clk) do { } while (0)
+#endif
 
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/clock.h b/arch/arm/plat-mxc/include/mach/clock.h
index 4943ab0..cc11577 100644
--- a/arch/arm/plat-mxc/include/mach/clock.h
+++ b/arch/arm/plat-mxc/include/mach/clock.h
@@ -25,6 +25,8 @@
 
 struct module;
 
+#ifdef CONFIG_USE_COMMON_STRUCT_CLK
+#else
 struct clk {
 	int id;
 	/* Source clock this clk depends on */
@@ -56,6 +58,7 @@ struct clk {
 	/* Function ptr to set the parent clock of the clock. */
 	int (*set_parent) (struct clk *, struct clk *);
 };
+#endif
 
 unsigned long mxc_decode_pll(unsigned int pll, u32 f_ref);
 
-- 
1.7.4.1
