From: robh@kernel.org (Rob Herring)
Date: Mon, 11 May 2015 17:25:20 -0500
Subject: [PATCH v2 2/2] clk: mmp: add PXA1928 clock support
In-Reply-To: <1431383120-16957-1-git-send-email-robh@kernel.org>
References: <1431383120-16957-1-git-send-email-robh@kernel.org>
Message-ID: <1431383120-16957-2-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial clock support for Marvell PXA1928. The PXA1928 is a mobile
SOC and is similar to other MMP/PXA series of SOCs, so a lot of the
existing infrastructure is reused here.

Currently the PLLs are just fixed clocks, and not all leaf clocks are
implemented.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
- Clean-up includes
- CC Chao Xie

 drivers/clk/mmp/Makefile         |   2 +
 drivers/clk/mmp/clk-of-pxa1928.c | 265 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 267 insertions(+)
 create mode 100644 drivers/clk/mmp/clk-of-pxa1928.c

diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 3caaf7c..9d4bc41 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -12,3 +12,5 @@ obj-$(CONFIG_MACH_MMP2_DT) += clk-of-mmp2.o
 obj-$(CONFIG_CPU_PXA168) += clk-pxa168.o
 obj-$(CONFIG_CPU_PXA910) += clk-pxa910.o
 obj-$(CONFIG_CPU_MMP2) += clk-mmp2.o
+
+obj-y += clk-of-pxa1928.o
diff --git a/drivers/clk/mmp/clk-of-pxa1928.c b/drivers/clk/mmp/clk-of-pxa1928.c
new file mode 100644
index 0000000..433a5ae
--- /dev/null
+++ b/drivers/clk/mmp/clk-of-pxa1928.c
@@ -0,0 +1,265 @@
+/*
+ * pxa1928 clock framework source file
+ *
+ * Copyright (C) 2015 Linaro, Ltd.
+ * Rob Herring <robh@kernel.org>
+ *
+ * Based on drivers/clk/mmp/clk-of-mmp2.c:
+ * Copyright (C) 2012 Marvell
+ * Chao Xie <xiechao.mail@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <dt-bindings/clock/marvell,pxa1928.h>
+
+#include "clk.h"
+#include "reset.h"
+
+#define MPMU_UART_PLL	0x14
+
+struct pxa1928_clk_unit {
+	struct mmp_clk_unit unit;
+	void __iomem *mpmu_base;
+	void __iomem *apmu_base;
+	void __iomem *apbc_base;
+	void __iomem *apbcp_base;
+};
+
+static struct mmp_param_fixed_rate_clk fixed_rate_clks[] = {
+	{0, "clk32", NULL, CLK_IS_ROOT, 32768},
+	{0, "vctcxo", NULL, CLK_IS_ROOT, 26000000},
+	{0, "pll1_624", NULL, CLK_IS_ROOT, 624000000},
+	{0, "pll5p", NULL, CLK_IS_ROOT, 832000000},
+	{0, "pll5", NULL, CLK_IS_ROOT, 1248000000},
+	{0, "usb_pll", NULL, CLK_IS_ROOT, 480000000},
+};
+
+static struct mmp_param_fixed_factor_clk fixed_factor_clks[] = {
+	{0, "pll1_d2", "pll1_624", 1, 2, 0},
+	{0, "pll1_d9", "pll1_624", 1, 9, 0},
+	{0, "pll1_d12", "pll1_624", 1, 12, 0},
+	{0, "pll1_d16", "pll1_624", 1, 16, 0},
+	{0, "pll1_d20", "pll1_624", 1, 20, 0},
+	{0, "pll1_416", "pll1_624", 2, 3, 0},
+	{0, "vctcxo_d2", "vctcxo", 1, 2, 0},
+	{0, "vctcxo_d4", "vctcxo", 1, 4, 0},
+};
+
+static struct mmp_clk_factor_masks uart_factor_masks = {
+	.factor = 2,
+	.num_mask = 0x1fff,
+	.den_mask = 0x1fff,
+	.num_shift = 16,
+	.den_shift = 0,
+};
+
+static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
+	{.num = 832, .den = 234},	/*58.5MHZ */
+	{.num = 1, .den = 1},		/*26MHZ */
+};
+
+static void pxa1928_pll_init(struct pxa1928_clk_unit *pxa_unit)
+{
+	struct clk *clk;
+	struct mmp_clk_unit *unit = &pxa_unit->unit;
+
+	mmp_register_fixed_rate_clks(unit, fixed_rate_clks,
+					ARRAY_SIZE(fixed_rate_clks));
+
+	mmp_register_fixed_factor_clks(unit, fixed_factor_clks,
+					ARRAY_SIZE(fixed_factor_clks));
+
+	clk = mmp_clk_register_factor("uart_pll", "pll1_416",
+				CLK_SET_RATE_PARENT,
+				pxa_unit->mpmu_base + MPMU_UART_PLL,
+				&uart_factor_masks, uart_factor_tbl,
+				ARRAY_SIZE(uart_factor_tbl), NULL);
+}
+
+static DEFINE_SPINLOCK(uart0_lock);
+static DEFINE_SPINLOCK(uart1_lock);
+static DEFINE_SPINLOCK(uart2_lock);
+static DEFINE_SPINLOCK(uart3_lock);
+static const char *uart_parent_names[] = {"uart_pll", "vctcxo"};
+
+static DEFINE_SPINLOCK(ssp0_lock);
+static DEFINE_SPINLOCK(ssp1_lock);
+static const char *ssp_parent_names[] = {"vctcxo_d4", "vctcxo_d2", "vctcxo", "pll1_d12"};
+
+static DEFINE_SPINLOCK(reset_lock);
+
+static struct mmp_param_mux_clk apbc_mux_clks[] = {
+	{0, "uart0_mux", uart_parent_names, ARRAY_SIZE(uart_parent_names), CLK_SET_RATE_PARENT, PXA1928_CLK_UART0 * 4, 4, 3, 0, &uart0_lock},
+	{0, "uart1_mux", uart_parent_names, ARRAY_SIZE(uart_parent_names), CLK_SET_RATE_PARENT, PXA1928_CLK_UART1 * 4, 4, 3, 0, &uart1_lock},
+	{0, "uart2_mux", uart_parent_names, ARRAY_SIZE(uart_parent_names), CLK_SET_RATE_PARENT, PXA1928_CLK_UART2 * 4, 4, 3, 0, &uart2_lock},
+	{0, "uart3_mux", uart_parent_names, ARRAY_SIZE(uart_parent_names), CLK_SET_RATE_PARENT, PXA1928_CLK_UART3 * 4, 4, 3, 0, &uart3_lock},
+	{0, "ssp0_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), CLK_SET_RATE_PARENT, PXA1928_CLK_SSP0 * 4, 4, 3, 0, &ssp0_lock},
+	{0, "ssp1_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), CLK_SET_RATE_PARENT, PXA1928_CLK_SSP1 * 4, 4, 3, 0, &ssp1_lock},
+};
+
+static struct mmp_param_gate_clk apbc_gate_clks[] = {
+	{PXA1928_CLK_TWSI0, "twsi0_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_TWSI0 * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	{PXA1928_CLK_TWSI1, "twsi1_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_TWSI1 * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	{PXA1928_CLK_TWSI2, "twsi2_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_TWSI2 * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	{PXA1928_CLK_TWSI3, "twsi3_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_TWSI3 * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	{PXA1928_CLK_TWSI4, "twsi4_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_TWSI4 * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	{PXA1928_CLK_TWSI5, "twsi5_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_TWSI5 * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	{PXA1928_CLK_GPIO, "gpio_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_GPIO * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	{PXA1928_CLK_KPC, "kpc_clk", "clk32", CLK_SET_RATE_PARENT, PXA1928_CLK_KPC * 4, 0x3, 0x3, 0x0, MMP_CLK_GATE_NEED_DELAY, NULL},
+	{PXA1928_CLK_RTC, "rtc_clk", "clk32", CLK_SET_RATE_PARENT, PXA1928_CLK_RTC * 4, 0x83, 0x83, 0x0, MMP_CLK_GATE_NEED_DELAY, NULL},
+	{PXA1928_CLK_PWM0, "pwm0_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_PWM0 * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	{PXA1928_CLK_PWM1, "pwm1_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_PWM1 * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	{PXA1928_CLK_PWM2, "pwm2_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_PWM2 * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	{PXA1928_CLK_PWM3, "pwm3_clk", "vctcxo", CLK_SET_RATE_PARENT, PXA1928_CLK_PWM3 * 4, 0x3, 0x3, 0x0, 0, &reset_lock},
+	/* The gate clocks has mux parent. */
+	{PXA1928_CLK_UART0, "uart0_clk", "uart0_mux", CLK_SET_RATE_PARENT, PXA1928_CLK_UART0 * 4, 0x3, 0x3, 0x0, 0, &uart0_lock},
+	{PXA1928_CLK_UART1, "uart1_clk", "uart1_mux", CLK_SET_RATE_PARENT, PXA1928_CLK_UART1 * 4, 0x3, 0x3, 0x0, 0, &uart1_lock},
+	{PXA1928_CLK_UART2, "uart2_clk", "uart2_mux", CLK_SET_RATE_PARENT, PXA1928_CLK_UART2 * 4, 0x3, 0x3, 0x0, 0, &uart2_lock},
+	{PXA1928_CLK_UART3, "uart3_clk", "uart3_mux", CLK_SET_RATE_PARENT, PXA1928_CLK_UART3 * 4, 0x3, 0x3, 0x0, 0, &uart3_lock},
+	{PXA1928_CLK_SSP0, "ssp0_clk", "ssp0_mux", CLK_SET_RATE_PARENT, PXA1928_CLK_SSP0 * 4, 0x3, 0x3, 0x0, 0, &ssp0_lock},
+	{PXA1928_CLK_SSP1, "ssp1_clk", "ssp1_mux", CLK_SET_RATE_PARENT, PXA1928_CLK_SSP1 * 4, 0x3, 0x3, 0x0, 0, &ssp1_lock},
+};
+
+static void pxa1928_apb_periph_clk_init(struct pxa1928_clk_unit *pxa_unit)
+{
+	struct mmp_clk_unit *unit = &pxa_unit->unit;
+
+	mmp_register_mux_clks(unit, apbc_mux_clks, pxa_unit->apbc_base,
+				ARRAY_SIZE(apbc_mux_clks));
+
+	mmp_register_gate_clks(unit, apbc_gate_clks, pxa_unit->apbc_base,
+				ARRAY_SIZE(apbc_gate_clks));
+}
+
+static DEFINE_SPINLOCK(sdh0_lock);
+static DEFINE_SPINLOCK(sdh1_lock);
+static DEFINE_SPINLOCK(sdh2_lock);
+static DEFINE_SPINLOCK(sdh3_lock);
+static DEFINE_SPINLOCK(sdh4_lock);
+static const char *sdh_parent_names[] = {"pll1_624", "pll5p", "pll5", "pll1_416"};
+
+static DEFINE_SPINLOCK(usb_lock);
+
+static struct mmp_param_mux_clk apmu_mux_clks[] = {
+	{0, "sdh_mux", sdh_parent_names, ARRAY_SIZE(sdh_parent_names), CLK_SET_RATE_PARENT, PXA1928_CLK_SDH0 * 4, 8, 2, 0, &sdh0_lock},
+};
+
+static struct mmp_param_div_clk apmu_div_clks[] = {
+	{0, "sdh_div", "sdh_mux", 0, PXA1928_CLK_SDH0 * 4, 10, 4, CLK_DIVIDER_ONE_BASED, &sdh0_lock},
+};
+
+static struct mmp_param_gate_clk apmu_gate_clks[] = {
+	{PXA1928_CLK_USB, "usb_clk", "usb_pll", 0, PXA1928_CLK_USB * 4, 0x9, 0x9, 0x0, 0, &usb_lock},
+	{PXA1928_CLK_HSIC, "hsic_clk", "usb_pll", 0, PXA1928_CLK_HSIC * 4, 0x9, 0x9, 0x0, 0, &usb_lock},
+	/* The gate clocks has mux parent. */
+	{PXA1928_CLK_SDH0, "sdh0_clk", "sdh_div", CLK_SET_RATE_PARENT, PXA1928_CLK_SDH0 * 4, 0x1b, 0x1b, 0x0, 0, &sdh0_lock},
+	{PXA1928_CLK_SDH1, "sdh1_clk", "sdh_div", CLK_SET_RATE_PARENT, PXA1928_CLK_SDH1 * 4, 0x1b, 0x1b, 0x0, 0, &sdh1_lock},
+	{PXA1928_CLK_SDH2, "sdh2_clk", "sdh_div", CLK_SET_RATE_PARENT, PXA1928_CLK_SDH2 * 4, 0x1b, 0x1b, 0x0, 0, &sdh2_lock},
+	{PXA1928_CLK_SDH3, "sdh3_clk", "sdh_div", CLK_SET_RATE_PARENT, PXA1928_CLK_SDH3 * 4, 0x1b, 0x1b, 0x0, 0, &sdh3_lock},
+	{PXA1928_CLK_SDH4, "sdh4_clk", "sdh_div", CLK_SET_RATE_PARENT, PXA1928_CLK_SDH4 * 4, 0x1b, 0x1b, 0x0, 0, &sdh4_lock},
+};
+
+static void pxa1928_axi_periph_clk_init(struct pxa1928_clk_unit *pxa_unit)
+{
+	struct mmp_clk_unit *unit = &pxa_unit->unit;
+
+	mmp_register_mux_clks(unit, apmu_mux_clks, pxa_unit->apmu_base,
+				ARRAY_SIZE(apmu_mux_clks));
+
+	mmp_register_div_clks(unit, apmu_div_clks, pxa_unit->apmu_base,
+				ARRAY_SIZE(apmu_div_clks));
+
+	mmp_register_gate_clks(unit, apmu_gate_clks, pxa_unit->apmu_base,
+				ARRAY_SIZE(apmu_gate_clks));
+}
+
+static void pxa1928_clk_reset_init(struct device_node *np,
+				struct pxa1928_clk_unit *pxa_unit)
+{
+	struct mmp_clk_reset_cell *cells;
+	int i, base, nr_resets;
+
+	nr_resets = ARRAY_SIZE(apbc_gate_clks);
+	cells = kcalloc(nr_resets, sizeof(*cells), GFP_KERNEL);
+	if (!cells)
+		return;
+
+	base = 0;
+	for (i = 0; i < nr_resets; i++) {
+		cells[base + i].clk_id = apbc_gate_clks[i].id;
+		cells[base + i].reg =
+			pxa_unit->apbc_base + apbc_gate_clks[i].offset;
+		cells[base + i].flags = 0;
+		cells[base + i].lock = apbc_gate_clks[i].lock;
+		cells[base + i].bits = 0x4;
+	}
+
+	mmp_clk_reset_register(np, cells, nr_resets);
+}
+
+static void __init pxa1928_mpmu_clk_init(struct device_node *np)
+{
+	struct pxa1928_clk_unit *pxa_unit;
+
+	pxa_unit = kzalloc(sizeof(*pxa_unit), GFP_KERNEL);
+	if (!pxa_unit)
+		return;
+
+	pxa_unit->mpmu_base = of_iomap(np, 0);
+	if (!pxa_unit->mpmu_base) {
+		pr_err("failed to map mpmu registers\n");
+		return;
+	}
+
+	pxa1928_pll_init(pxa_unit);
+}
+CLK_OF_DECLARE(pxa1928_mpmu_clk, "marvell,pxa1928-mpmu", pxa1928_mpmu_clk_init);
+
+static void __init pxa1928_apmu_clk_init(struct device_node *np)
+{
+	struct pxa1928_clk_unit *pxa_unit;
+
+	pxa_unit = kzalloc(sizeof(*pxa_unit), GFP_KERNEL);
+	if (!pxa_unit)
+		return;
+
+	pxa_unit->apmu_base = of_iomap(np, 0);
+	if (!pxa_unit->apmu_base) {
+		pr_err("failed to map apmu registers\n");
+		return;
+	}
+
+	mmp_clk_init(np, &pxa_unit->unit, PXA1928_APMU_NR_CLKS);
+
+	pxa1928_axi_periph_clk_init(pxa_unit);
+}
+CLK_OF_DECLARE(pxa1928_apmu_clk, "marvell,pxa1928-apmu", pxa1928_apmu_clk_init);
+
+static void __init pxa1928_apbc_clk_init(struct device_node *np)
+{
+	struct pxa1928_clk_unit *pxa_unit;
+
+	pxa_unit = kzalloc(sizeof(*pxa_unit), GFP_KERNEL);
+	if (!pxa_unit)
+		return;
+
+	pxa_unit->apbc_base = of_iomap(np, 0);
+	if (!pxa_unit->apbc_base) {
+		pr_err("failed to map apbc registers\n");
+		return;
+	}
+
+	mmp_clk_init(np, &pxa_unit->unit, PXA1928_APBC_NR_CLKS);
+
+	pxa1928_apb_periph_clk_init(pxa_unit);
+	pxa1928_clk_reset_init(np, pxa_unit);
+}
+CLK_OF_DECLARE(pxa1928_apbc_clk, "marvell,pxa1928-apbc", pxa1928_apbc_clk_init);
-- 
2.1.0
