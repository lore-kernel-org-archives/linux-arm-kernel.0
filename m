From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 12 Sep 2014 20:56:28 +0530
Subject: [PATCH v4 4/8] clk: samsung: add initial clock support for Exynos7 SoC
In-Reply-To: <1410535592-5782-1-git-send-email-ch.naveen@samsung.com>
References: <1410535592-5782-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1410535592-5782-6-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial clock support for Exynos7 SoC which is required
to bring up platforms based on Exynos7.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 .../devicetree/bindings/clock/exynos7-clock.txt    |   37 ++
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos7.c                  |  417 ++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h            |   39 ++
 4 files changed, 494 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos7-clock.txt
 create mode 100644 drivers/clk/samsung/clk-exynos7.c
 create mode 100644 include/dt-bindings/clock/exynos7-clk.h

diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
new file mode 100644
index 0000000..798eb10
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
@@ -0,0 +1,37 @@
+* Samsung Exynos7 Clock Controller
+
+Exynos7 clock controller has various blocks which are instantiated
+independently from the device-tree. These clock controllers
+generate and supply clocks to various hardware blocks within
+the SoC.
+
+Each clock is assigned an identifier and client nodes can use
+this identifier to specify the clock which they consume. All
+available clocks are defined as preprocessor macros in
+dt-bindings/clock/exynos7-clk.h header and can be used in
+device tree sources.
+
+External clocks:
+
+There are several clocks that are generated outside the SoC. It
+is expected that they are defined using standard clock bindings
+with following clock-output-names:
+
+ - "fin_pll" - PLL input clock from XXTI
+
+Required Properties for Clock Controller:
+
+ - compatible: clock controllers will use one of the following
+	compatible strings to indicate the clock controller
+	functionality.
+
+	- "samsung,exynos7-clock-topc"
+	- "samsung,exynos7-clock-top0"
+	- "samsung,exynos7-clock-peric0"
+	- "samsung,exynos7-clock-peric1"
+	- "samsung,exynos7-clock-peris"
+
+ - reg: physical base address of the controller and the length of
+	memory mapped region.
+
+ - #clock-cells: should be 1.
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 6fb4bc6..5da0ba9 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
 obj-$(CONFIG_S3C2443_COMMON_CLK)+= clk-s3c2443.o
 obj-$(CONFIG_ARCH_S3C64XX)	+= clk-s3c64xx.o
 obj-$(CONFIG_ARCH_S5PV210)	+= clk-s5pv210.o clk-s5pv210-audss.o
+obj-$(CONFIG_ARCH_EXYNOS7)	+= clk-exynos7.o
diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
new file mode 100644
index 0000000..3ea8d0e
--- /dev/null
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -0,0 +1,417 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Author: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+
+#include "clk.h"
+#include <dt-bindings/clock/exynos7-clk.h>
+
+/* Register Offset definitions for CMU_TOPC (0x10570000) */
+#define CC_PLL_LOCK		0x0000
+#define BUS0_PLL_LOCK		0x0004
+#define BUS1_DPLL_LOCK		0x0008
+#define MFC_PLL_LOCK		0x000C
+#define AUD_PLL_LOCK		0x0010
+#define CC_PLL_CON0		0x0100
+#define BUS0_PLL_CON0		0x0110
+#define BUS1_DPLL_CON0		0x0120
+#define MFC_PLL_CON0		0x0130
+#define AUD_PLL_CON0		0x0140
+#define MUX_SEL_TOPC0		0x0200
+#define MUX_SEL_TOPC1		0x0204
+#define MUX_SEL_TOPC3		0x020C
+#define DIV_TOPC1		0x0604
+#define DIV_TOPC3		0x060C
+
+static struct samsung_fixed_factor_clock topc_fixed_factor_clks[] __initdata = {
+	FFACTOR(0, "ffac_topc_bus0_pll_div2", "mout_bus0_pll_ctrl", 1, 2, 0),
+	FFACTOR(0, "ffac_topc_bus0_pll_div4",
+				"ffac_topc_bus0_pll_div2", 1, 2, 0),
+	FFACTOR(0, "ffac_topc_bus1_pll_div2", "mout_bus1_pll_ctrl", 1, 2, 0),
+	FFACTOR(0, "ffac_topc_cc_pll_div2", "mout_cc_pll_ctrl", 1, 2, 0),
+	FFACTOR(0, "ffac_topc_mfc_pll_div2", "mout_mfc_pll_ctrl", 1, 2, 0),
+};
+
+/* List of parent clocks for Muxes in CMU_TOPC */
+PNAME(mout_bus0_pll_ctrl_p)	= { "fin_pll", "fout_bus0_pll" };
+PNAME(mout_bus1_pll_ctrl_p)	= { "fin_pll", "fout_bus1_pll" };
+PNAME(mout_cc_pll_ctrl_p)	= { "fin_pll", "fout_cc_pll" };
+PNAME(mout_mfc_pll_ctrl_p)	= { "fin_pll", "fout_mfc_pll" };
+
+PNAME(mout_topc_group2)		= { "mout_sclk_bus0_pll_cmuc",
+	"mout_sclk_bus1_pll_cmuc", "mout_sclk_cc_pll_cmuc",
+	"mout_sclk_mfc_pll_cmuc" };
+
+PNAME(mout_sclk_bus0_pll_cmuc_p) = { "mout_bus0_pll_ctrl",
+	"ffac_topc_bus0_pll_div2", "ffac_topc_bus0_pll_div4"};
+PNAME(mout_sclk_bus1_pll_cmuc_p) = { "mout_bus1_pll_ctrl",
+	"ffac_topc_bus1_pll_div2"};
+PNAME(mout_sclk_cc_pll_cmuc_p) = { "mout_cci_pll_ctrl",
+	"ffac_topc_cci_pll_div2"};
+PNAME(mout_sclk_mfc_pll_cmuc_p) = { "mout_mfc_pll_ctrl",
+	"ffac_topc_mfc_pll_div2"};
+
+
+PNAME(mout_sclk_bus0_pll_out_p) = {"mout_bus0_pll_ctrl",
+	"ffac_topc_bus0_pll_div2"};
+
+static unsigned long topc_clk_regs[] __initdata = {
+	CC_PLL_LOCK,
+	BUS0_PLL_LOCK,
+	BUS1_DPLL_LOCK,
+	MFC_PLL_LOCK,
+	AUD_PLL_LOCK,
+	CC_PLL_CON0,
+	BUS0_PLL_CON0,
+	BUS1_DPLL_CON0,
+	MFC_PLL_CON0,
+	AUD_PLL_CON0,
+	MUX_SEL_TOPC0,
+	MUX_SEL_TOPC1,
+	MUX_SEL_TOPC3,
+	DIV_TOPC1,
+	DIV_TOPC3,
+};
+
+static struct samsung_mux_clock topc_mux_clks[] __initdata = {
+	MUX(0, "mout_bus0_pll_ctrl", mout_bus0_pll_ctrl_p, MUX_SEL_TOPC0, 0, 1),
+	MUX(0, "mout_bus1_pll_ctrl", mout_bus1_pll_ctrl_p, MUX_SEL_TOPC0, 4, 1),
+	MUX(0, "mout_cc_pll_ctrl", mout_cc_pll_ctrl_p, MUX_SEL_TOPC0, 8, 1),
+	MUX(0, "mout_mfc_pll_ctrl", mout_mfc_pll_ctrl_p, MUX_SEL_TOPC0, 12, 1),
+
+	MUX(0, "mout_sclk_bus0_pll_cmuc",
+			mout_sclk_bus0_pll_cmuc_p, MUX_SEL_TOPC0, 16, 2),
+	MUX(0, "mout_sclk_bus1_pll_cmuc",
+			mout_sclk_bus1_pll_cmuc_p, MUX_SEL_TOPC0, 20, 1),
+	MUX(0, "mout_sclk_cc_pll_cmuc",
+			mout_sclk_cc_pll_cmuc_p, MUX_SEL_TOPC0, 24, 1),
+	MUX(0, "mout_sclk_mfc_pll_cmuc",
+			mout_sclk_mfc_pll_cmuc_p, MUX_SEL_TOPC0, 28, 1),
+
+	MUX(0, "mout_sclk_bus0_pll_out",
+			mout_sclk_bus0_pll_out_p, MUX_SEL_TOPC1, 16, 1),
+
+	MUX(0, "mout_aclk_peris_66", mout_topc_group2, MUX_SEL_TOPC3, 24, 2),
+};
+
+static struct samsung_div_clock topc_div_clks[] __initdata = {
+	DIV(0, "dout_aclk_peris_66", "mout_aclk_peris_66", DIV_TOPC1, 24, 4),
+
+	DIV(0, "dout_sclk_bus0_pll", "mout_sclk_bus0_pll_out", DIV_TOPC3, 0, 3),
+	DIV(0, "dout_sclk_bus1_pll", "mout_bus1_pll_ctrl", DIV_TOPC3, 8, 3),
+	DIV(0, "dout_sclk_cc_pll", "mout_cc_pll_ctrl", DIV_TOPC3, 12, 3),
+	DIV(0, "dout_sclk_mfc_pll", "mout_mfc_pll_ctrl", DIV_TOPC3, 16, 3),
+};
+
+static struct samsung_pll_clock topc_pll_clks[] __initdata = {
+	PLL(pll_1451x, 0, "fout_bus0_pll", "fin_pll",
+		BUS0_PLL_LOCK, BUS0_PLL_CON0, NULL),
+	PLL(pll_1452x, 0, "fout_cc_pll", "fin_pll",
+		CC_PLL_LOCK, CC_PLL_CON0, NULL),
+	PLL(pll_1452x, 0, "fout_bus1_pll", "fin_pll",
+		BUS1_DPLL_LOCK, BUS1_DPLL_CON0, NULL),
+	PLL(pll_1452x, 0, "fout_mfc_pll", "fin_pll",
+		MFC_PLL_LOCK, MFC_PLL_CON0, NULL),
+	PLL(pll_1460x, 0, "fout_aud_pll", "fin_pll",
+		AUD_PLL_LOCK, AUD_PLL_CON0, NULL),
+};
+
+static void __init exynos7_clk_topc_init(struct device_node *np)
+{
+	struct exynos_cmu_info cmu = {0};
+
+	cmu.pll_clks = topc_pll_clks;
+	cmu.nr_pll_clks = ARRAY_SIZE(topc_pll_clks);
+	cmu.mux_clks = topc_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(topc_mux_clks);
+	cmu.div_clks = topc_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(topc_div_clks);
+	cmu.fixed_factor_clks = topc_fixed_factor_clks;
+	cmu.nr_fixed_factor_clks = ARRAY_SIZE(topc_fixed_factor_clks);
+	cmu.clk_regs = topc_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(topc_clk_regs);
+
+	exynos_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos7_clk_topc, "samsung,exynos7-clock-topc",
+		exynos7_clk_topc_init);
+
+/* Register Offset definitions for CMU_TOP0 (0x105D0000) */
+#define MUX_SEL_TOP00			0x0200
+#define MUX_SEL_TOP01			0x0204
+#define MUX_SEL_TOP03			0x020C
+#define MUX_SEL_TOP0_PERIC3		0x023C
+#define DIV_TOP03			0x060C
+#define DIV_TOP0_PERIC3			0x063C
+#define ENABLE_SCLK_TOP0_PERIC3		0x0A3C
+
+/* List of parent clocks for Muxes in CMU_TOP0 */
+PNAME(mout_bus0_pll_p)	= { "fin_pll", "dout_sclk_bus0_pll" };
+PNAME(mout_bus1_pll_p)	= { "fin_pll", "dout_sclk_bus1_pll" };
+PNAME(mout_cc_pll_p)	= { "fin_pll", "dout_sclk_cc_pll" };
+PNAME(mout_mfc_pll_p)	= { "fin_pll", "dout_sclk_mfc_pll" };
+
+PNAME(mout_top0_half_bus0_pll_p) = {"mout_top0_bus0_pll",
+	"ffac_top0_bus0_pll_div2"};
+PNAME(mout_top0_half_bus1_pll_p) = {"mout_top0_bus1_pll",
+	"ffac_top0_bus1_pll_div2"};
+PNAME(mout_top0_half_cc_pll_p) = {"mout_top0_cc_pll",
+	"ffac_top0_cc_pll_div2"};
+PNAME(mout_top0_half_mfc_pll_p) = {"mout_top0_mfc_pll",
+	"ffac_top0_mfc_pll_div2"};
+
+PNAME(mout_top0_group1) = {"mout_top0_half_bus0_pll",
+	"mout_top0_half_bus1_pll", "mout_top0_half_cc_pll",
+	"mout_top0_half_mfc_pll"};
+
+static unsigned long top0_clk_regs[] __initdata = {
+	MUX_SEL_TOP00,
+	MUX_SEL_TOP01,
+	MUX_SEL_TOP03,
+	MUX_SEL_TOP0_PERIC3,
+	DIV_TOP03,
+	DIV_TOP0_PERIC3,
+	ENABLE_SCLK_TOP0_PERIC3,
+};
+
+static struct samsung_mux_clock top0_mux_clks[] __initdata = {
+	MUX(0, "mout_top0_mfc_pll", mout_mfc_pll_p, MUX_SEL_TOP00, 4, 1),
+	MUX(0, "mout_top0_cc_pll", mout_cc_pll_p, MUX_SEL_TOP00, 8, 1),
+	MUX(0, "mout_top0_bus1_pll", mout_bus1_pll_p, MUX_SEL_TOP00, 12, 1),
+	MUX(0, "mout_top0_bus0_pll", mout_bus0_pll_p, MUX_SEL_TOP00, 16, 1),
+
+	MUX(0, "mout_top0_half_mfc_pll",
+			mout_top0_half_mfc_pll_p, MUX_SEL_TOP01, 4, 1),
+	MUX(0, "mout_top0_half_cc_pll",
+			mout_top0_half_cc_pll_p, MUX_SEL_TOP01, 8, 1),
+	MUX(0, "mout_top0_half_bus1_pll",
+			mout_top0_half_bus1_pll_p, MUX_SEL_TOP01, 12, 1),
+	MUX(0, "mout_top0_half_bus0_pll",
+			mout_top0_half_bus0_pll_p, MUX_SEL_TOP01, 16, 1),
+
+	MUX(0, "mout_aclk_peric1_66", mout_top0_group1, MUX_SEL_TOP03, 12, 2),
+	MUX(0, "mout_aclk_peric0_66", mout_top0_group1, MUX_SEL_TOP03, 20, 2),
+
+	MUX(0, "mout_sclk_uart3", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 4, 2),
+	MUX(0, "mout_sclk_uart2", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 8, 2),
+	MUX(0, "mout_sclk_uart1", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 12, 2),
+	MUX(0, "mout_sclk_uart0", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 16, 2),
+};
+
+static struct samsung_div_clock top0_div_clks[] __initdata = {
+	DIV(0, "dout_aclk_peric1_66", "mout_aclk_peric1_66", DIV_TOP03, 12, 6),
+	DIV(0, "dout_aclk_peric0_66", "mout_aclk_peric0_66", DIV_TOP03, 20, 6),
+
+	DIV(0, "dout_sclk_uart3", "mout_sclk_uart3", DIV_TOP0_PERIC3, 4, 4),
+	DIV(0, "dout_sclk_uart2", "mout_sclk_uart2", DIV_TOP0_PERIC3, 8, 4),
+	DIV(0, "dout_sclk_uart1", "mout_sclk_uart1", DIV_TOP0_PERIC3, 12, 4),
+	DIV(0, "dout_sclk_uart0", "mout_sclk_uart0", DIV_TOP0_PERIC3, 16, 4),
+};
+
+static struct samsung_gate_clock top0_gate_clks[] __initdata = {
+	GATE(CLK_SCLK_UART3, "sclk_uart3", "dout_sclk_uart3",
+			ENABLE_SCLK_TOP0_PERIC3, 4, 0, 0),
+	GATE(CLK_SCLK_UART2, "sclk_uart2", "dout_sclk_uart2",
+			ENABLE_SCLK_TOP0_PERIC3, 8, 0, 0),
+	GATE(CLK_SCLK_UART1, "sclk_uart1", "dout_sclk_uart1",
+			ENABLE_SCLK_TOP0_PERIC3, 12, 0, 0),
+	GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_sclk_uart0",
+			ENABLE_SCLK_TOP0_PERIC3, 16, 0, 0),
+};
+
+static struct samsung_fixed_factor_clock top0_fixed_factor_clks[] __initdata = {
+	FFACTOR(0, "ffac_top0_bus0_pll_div2", "mout_top0_bus0_pll", 1, 2, 0),
+	FFACTOR(0, "ffac_top0_bus1_pll_div2", "mout_top0_bus1_pll", 1, 2, 0),
+	FFACTOR(0, "ffac_top0_cc_pll_div2", "mout_top0_cc_pll", 1, 2, 0),
+	FFACTOR(0, "ffac_top0_mfc_pll_div2", "mout_top0_mfc_pll", 1, 2, 0),
+};
+
+static void __init exynos7_clk_top0_init(struct device_node *np)
+{
+	struct exynos_cmu_info cmu = {0};
+
+	cmu.mux_clks = top0_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(top0_mux_clks);
+	cmu.div_clks = top0_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(top0_div_clks);
+	cmu.gate_clks = top0_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(top0_gate_clks);
+	cmu.fixed_factor_clks = top0_fixed_factor_clks;
+	cmu.nr_fixed_factor_clks = ARRAY_SIZE(top0_fixed_factor_clks);
+	cmu.nr_clk_ids = TOP0_NR_CLK;
+	cmu.clk_regs = top0_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(top0_clk_regs);
+
+	exynos_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos7_clk_top0, "samsung,exynos7-clock-top0",
+		exynos7_clk_top0_init);
+
+/* Register Offset definitions for CMU_PERIC0 (0x13610000) */
+#define MUX_SEL_PERIC0			0x0200
+#define ENABLE_PCLK_PERIC0		0x0900
+#define ENABLE_SCLK_PERIC0		0x0A00
+
+/* List of parent clocks for Muxes in CMU_PERIC0 */
+PNAME(mout_aclk_peric0_66_p)	= { "fin_pll", "dout_aclk_peric0_66" };
+PNAME(mout_sclk_uart0_p)	= { "fin_pll", "sclk_uart0" };
+
+static unsigned long peric0_clk_regs[] __initdata = {
+	MUX_SEL_PERIC0,
+	ENABLE_PCLK_PERIC0,
+	ENABLE_SCLK_PERIC0,
+};
+
+static struct samsung_mux_clock peric0_mux_clks[] __initdata = {
+	MUX(0, "mout_aclk_peric0_66_user",
+			mout_aclk_peric0_66_p, MUX_SEL_PERIC0, 0, 1),
+	MUX(0, "mout_sclk_uart0_user", mout_sclk_uart0_p,
+			MUX_SEL_PERIC0, 16, 1),
+};
+
+static struct samsung_gate_clock peric0_gate_clks[] __initdata = {
+	GATE(PCLK_UART0, "pclk_uart0", "mout_aclk_peric0_66_user",
+			ENABLE_PCLK_PERIC0, 16, 0, 0),
+
+	GATE(SCLK_UART0, "sclk_uart0_user", "mout_sclk_uart0_user",
+			ENABLE_SCLK_PERIC0, 16, 0, 0),
+};
+
+static void __init exynos7_clk_peric0_init(struct device_node *np)
+{
+	struct exynos_cmu_info cmu = {0};
+
+	cmu.mux_clks = peric0_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(peric0_mux_clks);
+	cmu.gate_clks = peric0_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(peric0_gate_clks);
+	cmu.nr_clk_ids = PERIC0_NR_CLK;
+	cmu.clk_regs = peric0_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(peric0_clk_regs);
+
+	exynos_cmu_register_one(np, &cmu);
+}
+
+/* Register Offset definitions for CMU_PERIC1 (0x14C80000) */
+#define MUX_SEL_PERIC10			0x0200
+#define MUX_SEL_PERIC11			0x0204
+#define ENABLE_PCLK_PERIC1		0x0900
+#define ENABLE_SCLK_PERIC10		0x0A00
+
+CLK_OF_DECLARE(exynos7_clk_peric0, "samsung,exynos7-clock-peric0",
+		exynos7_clk_peric0_init);
+
+/* List of parent clocks for Muxes in CMU_PERIC1 */
+PNAME(mout_aclk_peric1_66_p)	= { "fin_pll", "dout_aclk_peric1_66" };
+PNAME(mout_sclk_uart1_p)	= { "fin_pll", "sclk_uart1" };
+PNAME(mout_sclk_uart2_p)	= { "fin_pll", "sclk_uart2" };
+PNAME(mout_sclk_uart3_p)	= { "fin_pll", "sclk_uart3" };
+
+static unsigned long peric1_clk_regs[] __initdata = {
+	MUX_SEL_PERIC10,
+	MUX_SEL_PERIC11,
+	ENABLE_PCLK_PERIC1,
+	ENABLE_SCLK_PERIC10,
+};
+
+static struct samsung_mux_clock peric1_mux_clks[] __initdata = {
+	MUX(0, "mout_aclk_peric1_66_user", mout_aclk_peric1_66_p,
+			MUX_SEL_PERIC10, 0, 1),
+
+	MUX(0, "mout_sclk_uart1_user", mout_sclk_uart1_p,
+			MUX_SEL_PERIC11, 20, 1),
+	MUX(0, "mout_sclk_uart2_user", mout_sclk_uart2_p,
+			MUX_SEL_PERIC11, 24, 1),
+	MUX(0, "mout_sclk_uart3_user", mout_sclk_uart3_p,
+			MUX_SEL_PERIC11, 28, 1),
+};
+
+static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
+	GATE(PCLK_UART1, "pclk_uart1", "mout_aclk_peric1_66_user",
+			ENABLE_PCLK_PERIC1, 9, 0, 0),
+	GATE(PCLK_UART2, "pclk_uart2", "mout_aclk_peric1_66_user",
+			ENABLE_PCLK_PERIC1, 10, 0, 0),
+	GATE(PCLK_UART3, "pclk_uart3", "mout_aclk_peric1_66_user",
+			ENABLE_PCLK_PERIC1, 11, 0, 0),
+
+	GATE(SCLK_UART1, "sclk_uart1_user", "mout_sclk_uart1_user",
+			ENABLE_SCLK_PERIC10, 9, 0, 0),
+	GATE(SCLK_UART2, "sclk_uart2_user", "mout_sclk_uart2_user",
+			ENABLE_SCLK_PERIC10, 10, 0, 0),
+	GATE(SCLK_UART3, "sclk_uart3_user", "mout_sclk_uart3_user",
+			ENABLE_SCLK_PERIC10, 11, 0, 0),
+};
+
+static void __init exynos7_clk_peric1_init(struct device_node *np)
+{
+	struct exynos_cmu_info cmu = {0};
+
+	cmu.mux_clks = peric1_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(peric1_mux_clks);
+	cmu.gate_clks = peric1_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(peric1_gate_clks);
+	cmu.nr_clk_ids = PERIC1_NR_CLK;
+	cmu.clk_regs = peric1_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(peric1_clk_regs);
+
+	exynos_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos7_clk_peric1, "samsung,exynos7-clock-peric1",
+		exynos7_clk_peric1_init);
+
+/* Register Offset definitions for CMU_PERIS (0x10040000) */
+#define MUX_SEL_PERIS			0x0200
+#define ENABLE_PCLK_PERIS_SECURE_CHIPID	0x0910
+#define ENABLE_SCLK_PERIS_SECURE_CHIPID	0x0A10
+
+/* List of parent clocks for Muxes in CMU_PERIS */
+PNAME(mout_aclk_peris_66_p) = { "fin_pll", "dout_aclk_peris_66" };
+
+static unsigned long peris_clk_regs[] __initdata = {
+	MUX_SEL_PERIS,
+	ENABLE_PCLK_PERIS_SECURE_CHIPID,
+	ENABLE_SCLK_PERIS_SECURE_CHIPID,
+};
+
+static struct samsung_mux_clock peris_mux_clks[] __initdata = {
+	MUX(0, "mout_aclk_peris_66_user",
+		mout_aclk_peris_66_p, MUX_SEL_PERIS, 0, 1),
+};
+
+static struct samsung_gate_clock peris_gate_clks[] __initdata = {
+	GATE(PCLK_CHIPID, "pclk_chipid", "mout_aclk_peris_66_user",
+		ENABLE_PCLK_PERIS_SECURE_CHIPID, 0, 0, 0),
+	GATE(SCLK_CHIPID, "sclk_chipid", "fin_pll",
+		ENABLE_SCLK_PERIS_SECURE_CHIPID, 0, 0, 0),
+};
+
+static void __init exynos7_clk_peris_init(struct device_node *np)
+{
+	struct exynos_cmu_info cmu = {0};
+
+	cmu.mux_clks = peris_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(peris_mux_clks);
+	cmu.gate_clks = peris_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(peris_gate_clks);
+	cmu.nr_clk_ids = PERIS_NR_CLK;
+	cmu.clk_regs = peris_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(peris_clk_regs);
+
+	exynos_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos7_clk_peris, "samsung,exynos7-clock-peris",
+		exynos7_clk_peris_init);
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
new file mode 100644
index 0000000..88705cc
--- /dev/null
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Author: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _DT_BINDINGS_CLOCK_EXYNOS7_H
+#define _DT_BINDINGS_CLOCK_EXYNOS7_H
+
+/* TOP0 */
+#define CLK_SCLK_UART0			1
+#define CLK_SCLK_UART1			2
+#define CLK_SCLK_UART2			3
+#define CLK_SCLK_UART3			4
+#define TOP0_NR_CLK			5
+
+/* PERIC0 */
+#define PCLK_UART0			1
+#define SCLK_UART0			2
+#define PERIC0_NR_CLK			3
+
+/* PERIC1 */
+#define PCLK_UART1			1
+#define PCLK_UART2			2
+#define PCLK_UART3			3
+#define SCLK_UART1			4
+#define SCLK_UART2			5
+#define SCLK_UART3			6
+#define PERIC1_NR_CLK			7
+
+/* PERIS */
+#define PCLK_CHIPID		        1
+#define SCLK_CHIPID			2
+#define PERIS_NR_CLK			3
+
+#endif /* _DT_BINDINGS_CLOCK_EXYNOS7_H */
-- 
1.7.9.5
