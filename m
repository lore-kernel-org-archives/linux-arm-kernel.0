From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 13 May 2014 20:05:16 +0400
Subject: [PATCH v2 3/3] ARM: i.MX1 clk: Add devicetree support
Message-ID: <1399997116-4313-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds devicetree support CCM module for i.MX1 (MC9328MX1) CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/clock/imx1-clock.txt       |  28 +++++
 arch/arm/mach-imx/clk-imx1.c                       | 138 +++++++++++++--------
 include/dt-bindings/clock/imx1-clock.h             |  40 ++++++
 3 files changed, 153 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.txt
 create mode 100644 include/dt-bindings/clock/imx1-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx1-clock.txt b/Documentation/devicetree/bindings/clock/imx1-clock.txt
new file mode 100644
index 0000000..bae9216
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx1-clock.txt
@@ -0,0 +1,28 @@
+* Clock bindings for Freescale i.MX1 CPUs
+
+Required properties:
+- compatible: Should be "fsl,imx1-ccm".
+- reg: Address and length of the register set.
+- interrupts: Should contain CCM interrupt.
+- #clock-cells: Should be <1>.
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx1-clock.h
+for the full list of i.MX1 clock IDs.
+
+Examples:
+	clks: ccm at 0021b000 {
+		#clock-cells = <1>;
+		compatible = "fsl,imx1-ccm";
+		reg = <0x0021b000 0x1000>;
+		interrupts = <59>;
+	};
+
+	pwm: pwm at 00208000 {
+		#pwm-cells = <2>;
+		compatible = "fsl,imx1-pwm";
+		reg = <0x00208000 0x1000>;
+		interrupts = <34>;
+		clocks = <&clks IMX1_CLK_DUMMY>, <&clks IMX1_CLK_PER1>;
+		clock-names = "ipg", "per";
+	};
diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 7f739be..0901490 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -20,7 +20,10 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/of.h>
+#include <dt-bindings/clock/imx1-clock.h>
 
 #include "clk.h"
 #include "common.h"
@@ -43,72 +46,101 @@ static const char *prem_sel_clks[] = { "clk32_premult", "clk16m", };
 static const char *clko_sel_clks[] = { "per1", "hclk", "clk48m", "clk16m",
 				       "prem", "fclk", };
 
-enum imx1_clks {
-	dummy, clk32, clk16m_ext, clk16m, clk32_premult, prem, mpll, mpll_gate,
-	spll, spll_gate, mcu, fclk, hclk, clk48m, per1, per2, per3, clko,
-	uart3_gate, ssi2_gate, brom_gate, dma_gate, csi_gate, mma_gate,
-	usbd_gate, clk_max
-};
-
-static struct clk *clk[clk_max];
+static struct clk *clk[IMX1_CLK_MAX];
+static struct clk_onecell_data clk_data;
 
 int __init mx1_clocks_init(unsigned long fref)
 {
 	int i;
 
-	clk[dummy] = imx_clk_fixed("dummy", 0);
-	clk[clk32] = imx_clk_fixed("clk32", fref);
-	clk[clk16m_ext] = imx_clk_fixed("clk16m_ext", 16000000);
-	clk[clk16m] = imx_clk_gate("clk16m", "clk16m_ext", CCM_CSCR, 17);
-	clk[clk32_premult] = imx_clk_fixed_factor("clk32_premult", "clk32", 512, 1);
-	clk[prem] = imx_clk_mux("prem", CCM_CSCR, 16, 1, prem_sel_clks,
-			ARRAY_SIZE(prem_sel_clks));
-	clk[mpll] = imx_clk_pllv1("mpll", "clk32_premult", CCM_MPCTL0);
-	clk[mpll_gate] = imx_clk_gate("mpll_gate", "mpll", CCM_CSCR, 0);
-	clk[spll] = imx_clk_pllv1("spll", "prem", CCM_SPCTL0);
-	clk[spll_gate] = imx_clk_gate("spll_gate", "spll", CCM_CSCR, 1);
-	clk[mcu] = imx_clk_divider("mcu", "clk32_premult", CCM_CSCR, 15, 1);
-	clk[fclk] = imx_clk_divider("fclk", "mpll_gate", CCM_CSCR, 15, 1);
-	clk[hclk] = imx_clk_divider("hclk", "spll_gate", CCM_CSCR, 10, 4);
-	clk[clk48m] = imx_clk_divider("clk48m", "spll_gate", CCM_CSCR, 26, 3);
-	clk[per1] = imx_clk_divider("per1", "spll_gate", CCM_PCDR, 0, 4);
-	clk[per2] = imx_clk_divider("per2", "spll_gate", CCM_PCDR, 4, 4);
-	clk[per3] = imx_clk_divider("per3", "spll_gate", CCM_PCDR, 16, 7);
-	clk[clko] = imx_clk_mux("clko", CCM_CSCR, 29, 3, clko_sel_clks,
-			ARRAY_SIZE(clko_sel_clks));
-	clk[uart3_gate] = imx_clk_gate("uart3_gate", "hclk", SCM_GCCR, 6);
-	clk[ssi2_gate] = imx_clk_gate("ssi2_gate", "hclk", SCM_GCCR, 5);
-	clk[brom_gate] = imx_clk_gate("brom_gate", "hclk", SCM_GCCR, 4);
-	clk[dma_gate] = imx_clk_gate("dma_gate", "hclk", SCM_GCCR, 3);
-	clk[csi_gate] = imx_clk_gate("csi_gate", "hclk", SCM_GCCR, 2);
-	clk[mma_gate] = imx_clk_gate("mma_gate", "hclk", SCM_GCCR, 1);
-	clk[usbd_gate] = imx_clk_gate("usbd_gate", "clk48m", SCM_GCCR, 0);
+	clk[IMX1_CLK_DUMMY] =
+		imx_clk_fixed("dummy", 0);
+	clk[IMX1_CLK_CLK32] =
+		imx_obtain_fixed_clock("clk32", fref);
+	clk[IMX1_CLK_CLK16M_EXT] =
+		imx_clk_fixed("clk16m_ext", 16000000);
+	clk[IMX1_CLK_CLK16M] =
+		imx_clk_gate("clk16m", "clk16m_ext", CCM_CSCR, 17);
+	clk[IMX1_CLK_CLK32_PREMULT] =
+		imx_clk_fixed_factor("clk32_premult", "clk32", 512, 1);
+	clk[IMX1_CLK_PREM] =
+		imx_clk_mux("prem", CCM_CSCR, 16, 1, prem_sel_clks,
+			    ARRAY_SIZE(prem_sel_clks));
+	clk[IMX1_CLK_MPLL] =
+		imx_clk_pllv1("mpll", "clk32_premult", CCM_MPCTL0);
+	clk[IMX1_CLK_MPLL_GATE] =
+		imx_clk_gate("mpll_gate", "mpll", CCM_CSCR, 0);
+	clk[IMX1_CLK_SPLL] =
+		imx_clk_pllv1("spll", "prem", CCM_SPCTL0);
+	clk[IMX1_CLK_SPLL_GATE] =
+		imx_clk_gate("spll_gate", "spll", CCM_CSCR, 1);
+	clk[IMX1_CLK_MCU] =
+		imx_clk_divider("mcu", "clk32_premult", CCM_CSCR, 15, 1);
+	clk[IMX1_CLK_FCLK] =
+		imx_clk_divider("fclk", "mpll_gate", CCM_CSCR, 15, 1);
+	clk[IMX1_CLK_HCLK] =
+		imx_clk_divider("hclk", "spll_gate", CCM_CSCR, 10, 4);
+	clk[IMX1_CLK_CLK48M] =
+		imx_clk_divider("clk48m", "spll_gate", CCM_CSCR, 26, 3);
+	clk[IMX1_CLK_PER1] =
+		imx_clk_divider("per1", "spll_gate", CCM_PCDR, 0, 4);
+	clk[IMX1_CLK_PER2] =
+		imx_clk_divider("per2", "spll_gate", CCM_PCDR, 4, 4);
+	clk[IMX1_CLK_PER3] =
+		imx_clk_divider("per3", "spll_gate", CCM_PCDR, 16, 7);
+	clk[IMX1_CLK_CLKO] =
+		imx_clk_mux("clko", CCM_CSCR, 29, 3, clko_sel_clks,
+			    ARRAY_SIZE(clko_sel_clks));
+	clk[IMX1_CLK_UART3_GATE] =
+		imx_clk_gate("uart3_gate", "hclk", SCM_GCCR, 6);
+	clk[IMX1_CLK_SSI2_GATE] =
+		imx_clk_gate("ssi2_gate", "hclk", SCM_GCCR, 5);
+	clk[IMX1_CLK_BROM_GATE] =
+		imx_clk_gate("brom_gate", "hclk", SCM_GCCR, 4);
+	clk[IMX1_CLK_DMA_GATE] =
+		imx_clk_gate("dma_gate", "hclk", SCM_GCCR, 3);
+	clk[IMX1_CLK_CSI_GATE] =
+		imx_clk_gate("csi_gate", "hclk", SCM_GCCR, 2);
+	clk[IMX1_CLK_MMA_GATE] =
+		imx_clk_gate("mma_gate", "hclk", SCM_GCCR, 1);
+	clk[IMX1_CLK_USBD_GATE] =
+		imx_clk_gate("usbd_gate", "clk48m", SCM_GCCR, 0);
 
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
 		if (IS_ERR(clk[i]))
 			pr_err("imx1 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
-	clk_register_clkdev(clk[dma_gate], "ahb", "imx1-dma");
-	clk_register_clkdev(clk[hclk], "ipg", "imx1-dma");
-	clk_register_clkdev(clk[per1], "per", "imx-gpt.0");
-	clk_register_clkdev(clk[hclk], "ipg", "imx-gpt.0");
-	clk_register_clkdev(clk[per1], "per", "imx1-uart.0");
-	clk_register_clkdev(clk[hclk], "ipg", "imx1-uart.0");
-	clk_register_clkdev(clk[per1], "per", "imx1-uart.1");
-	clk_register_clkdev(clk[hclk], "ipg", "imx1-uart.1");
-	clk_register_clkdev(clk[per1], "per", "imx1-uart.2");
-	clk_register_clkdev(clk[uart3_gate], "ipg", "imx1-uart.2");
-	clk_register_clkdev(clk[hclk], NULL, "imx1-i2c.0");
-	clk_register_clkdev(clk[per2], "per", "imx1-cspi.0");
-	clk_register_clkdev(clk[dummy], "ipg", "imx1-cspi.0");
-	clk_register_clkdev(clk[per2], "per", "imx1-cspi.1");
-	clk_register_clkdev(clk[dummy], "ipg", "imx1-cspi.1");
-	clk_register_clkdev(clk[per2], "per", "imx1-fb.0");
-	clk_register_clkdev(clk[dummy], "ipg", "imx1-fb.0");
-	clk_register_clkdev(clk[dummy], "ahb", "imx1-fb.0");
+	clk_register_clkdev(clk[IMX1_CLK_DMA_GATE], "ahb", "imx1-dma");
+	clk_register_clkdev(clk[IMX1_CLK_HCLK], "ipg", "imx1-dma");
+	clk_register_clkdev(clk[IMX1_CLK_PER1], "per", "imx-gpt.0");
+	clk_register_clkdev(clk[IMX1_CLK_HCLK], "ipg", "imx-gpt.0");
+	clk_register_clkdev(clk[IMX1_CLK_PER1], "per", "imx1-uart.0");
+	clk_register_clkdev(clk[IMX1_CLK_HCLK], "ipg", "imx1-uart.0");
+	clk_register_clkdev(clk[IMX1_CLK_PER1], "per", "imx1-uart.1");
+	clk_register_clkdev(clk[IMX1_CLK_HCLK], "ipg", "imx1-uart.1");
+	clk_register_clkdev(clk[IMX1_CLK_PER1], "per", "imx1-uart.2");
+	clk_register_clkdev(clk[IMX1_CLK_UART3_GATE], "ipg", "imx1-uart.2");
+	clk_register_clkdev(clk[IMX1_CLK_HCLK], NULL, "imx1-i2c.0");
+	clk_register_clkdev(clk[IMX1_CLK_PER2], "per", "imx1-cspi.0");
+	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ipg", "imx1-cspi.0");
+	clk_register_clkdev(clk[IMX1_CLK_PER2], "per", "imx1-cspi.1");
+	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ipg", "imx1-cspi.1");
+	clk_register_clkdev(clk[IMX1_CLK_PER2], "per", "imx1-fb.0");
+	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ipg", "imx1-fb.0");
+	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ahb", "imx1-fb.0");
 
 	mxc_timer_init(MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR), MX1_TIM1_INT);
 
 	return 0;
 }
+
+static void __init mx1_clocks_init_dt(struct device_node *np)
+{
+	mx1_clocks_init(32768);
+
+	clk_data.clks = clk;
+	clk_data.clk_num = ARRAY_SIZE(clk);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
+CLK_OF_DECLARE(imx1_ccm, "fsl,imx1-ccm", mx1_clocks_init_dt);
diff --git a/include/dt-bindings/clock/imx1-clock.h b/include/dt-bindings/clock/imx1-clock.h
new file mode 100644
index 0000000..607bf01
--- /dev/null
+++ b/include/dt-bindings/clock/imx1-clock.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX1_H
+#define __DT_BINDINGS_CLOCK_IMX1_H
+
+#define IMX1_CLK_DUMMY		0
+#define IMX1_CLK_CLK32		1
+#define IMX1_CLK_CLK16M_EXT	2
+#define IMX1_CLK_CLK16M		3
+#define IMX1_CLK_CLK32_PREMULT	4
+#define IMX1_CLK_PREM		5
+#define IMX1_CLK_MPLL		6
+#define IMX1_CLK_MPLL_GATE	7
+#define IMX1_CLK_SPLL		8
+#define IMX1_CLK_SPLL_GATE	9
+#define IMX1_CLK_MCU		10
+#define IMX1_CLK_FCLK		11
+#define IMX1_CLK_HCLK		12
+#define IMX1_CLK_CLK48M		13
+#define IMX1_CLK_PER1		14
+#define IMX1_CLK_PER2		15
+#define IMX1_CLK_PER3		16
+#define IMX1_CLK_CLKO		17
+#define IMX1_CLK_UART3_GATE	18
+#define IMX1_CLK_SSI2_GATE	19
+#define IMX1_CLK_BROM_GATE	20
+#define IMX1_CLK_DMA_GATE	21
+#define IMX1_CLK_CSI_GATE	22
+#define IMX1_CLK_MMA_GATE	23
+#define IMX1_CLK_USBD_GATE	24
+#define IMX1_CLK_MAX		25
+
+#endif
-- 
1.8.3.2
