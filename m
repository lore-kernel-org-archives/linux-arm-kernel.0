From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 19 Jan 2018 21:11:06 +0800
Subject: [PATCH V3 06/10] dt-bindings: clock: add imx7ulp clock binding doc
In-Reply-To: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
References: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1516367470-24340-7-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

Note IMX7ULP has two clock domains: M4 and A7. This binding doc
is only for A7 clock domain.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v3:
 * no changes
v1->v2: no changes
---
 .../devicetree/bindings/clock/imx7ulp-clock.txt    |  62 ++++++++++++
 include/dt-bindings/clock/imx7ulp-clock.h          | 108 +++++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
new file mode 100644
index 0000000..76ea3c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
@@ -0,0 +1,62 @@
+* Clock bindings for Freescale i.MX7ULP
+
+i.MX7ULP Clock functions are under joint control of the System
+Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
+modules, and Core Mode Controller (CMC)1 blocks
+
+The clocking scheme provides clear separation between M4 domain
+and A7 domain. Except for a few clock sources shared between two
+domains, such as the System Oscillator clock, the Slow IRC (SIRC),
+and and the Fast IRC clock (FIRCLK), clock sources and clock
+management are separated and contained within each domain.
+
+M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
+A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
+
+Note: this binding doc is only for A7 clock domain.
+
+Required properties:
+
+- compatible:	Should be "fsl,imx7ulp-clock".
+- reg : 	Should contain registers location and length for scg1,
+		pcc2 and pcc3.
+- reg-names:	Should contain the according reg names "scg1", "pcc2"
+		and "pcc3".
+- #clock-cells:	Should be <1>.
+- clocks:	Should contain the fixed input clocks.
+- clock-name:   Should contain the following clock names:"rsoc", "sosc",
+		"sirc", "firc", "upll", "mpll".
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.
+See include/dt-bindings/clock/imx7ulp-clock.h
+for the full list of i.MX7ULP clock IDs.
+
+Examples:
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+
+clks: scg1 at 403e0000 {
+	compatible = "fsl,imx7ulp-clock";
+	reg = <0x403e0000 0x10000>
+	      <0x403f0000 0x10000>
+	      <0x40b30000 0x10000>;
+	reg-names = "scg1", "pcc2", "pcc3";
+	clocks = <&rsoc>, <&sosc>, <&sirc>,
+		 <&firc>, <&upll>, <&mpll>;
+	clock-names = "rsoc", "sosc", "sirc",
+		      "firc", "upll", "mpll";
+	#clock-cells = <1>;
+};
+
+usdhc1: usdhc at 40380000 {
+	compatible = "fsl,imx7ulp-usdhc";
+	reg = <0x40380000 0x10000>;
+	interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX7ULP_CLK_NIC1_BUS_DIV>,
+		 <&clks IMX7ULP_CLK_NIC1_DIV>,
+		 <&clks IMX7ULP_CLK_USDHC1>;
+	clock-names ="ipg", "ahb", "per";
+	bus-width = <4>;
+	status = "disabled";
+};
diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindings/clock/imx7ulp-clock.h
new file mode 100644
index 0000000..2556106
--- /dev/null
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX7ULP_H
+#define __DT_BINDINGS_CLOCK_IMX7ULP_H
+
+#define IMX7ULP_CLK_DUMMY		0
+#define IMX7ULP_CLK_ROSC		1
+#define IMX7ULP_CLK_SOSC		2
+#define IMX7ULP_CLK_FIRC		3
+
+/* SCG1 */
+#define IMX7ULP_CLK_SPLL_PRE_SEL	4
+#define IMX7ULP_CLK_SPLL_PRE_DIV	5
+#define IMX7ULP_CLK_SPLL		6
+#define IMX7ULP_CLK_SPLL_POST_DIV1	7
+#define IMX7ULP_CLK_SPLL_POST_DIV2	8
+#define IMX7ULP_CLK_SPLL_PFD0		9
+#define IMX7ULP_CLK_SPLL_PFD1		10
+#define IMX7ULP_CLK_SPLL_PFD2		11
+#define IMX7ULP_CLK_SPLL_PFD3		12
+#define IMX7ULP_CLK_SPLL_PFD_SEL	13
+#define IMX7ULP_CLK_SPLL_SEL		14
+#define IMX7ULP_CLK_APLL_PRE_SEL	15
+#define IMX7ULP_CLK_APLL_PRE_DIV	16
+#define IMX7ULP_CLK_APLL		17
+#define IMX7ULP_CLK_APLL_POST_DIV1	18
+#define IMX7ULP_CLK_APLL_POST_DIV2	19
+#define IMX7ULP_CLK_APLL_PFD0		20
+#define IMX7ULP_CLK_APLL_PFD1		21
+#define IMX7ULP_CLK_APLL_PFD2		22
+#define IMX7ULP_CLK_APLL_PFD3		23
+#define IMX7ULP_CLK_APLL_PFD_SEL	24
+#define IMX7ULP_CLK_APLL_SEL		25
+#define IMX7ULP_CLK_UPLL		26
+#define IMX7ULP_CLK_SYS_SEL		27
+#define IMX7ULP_CLK_CORE_DIV		28
+#define IMX7ULP_CLK_BUS_DIV		29
+#define IMX7ULP_CLK_PLAT_DIV		30
+#define IMX7ULP_CLK_DDR_SEL		31
+#define IMX7ULP_CLK_DDR_DIV		32
+#define IMX7ULP_CLK_NIC_SEL		33
+#define IMX7ULP_CLK_NIC0_DIV		34
+#define IMX7ULP_CLK_GPU_DIV		35
+#define IMX7ULP_CLK_NIC1_DIV		36
+#define IMX7ULP_CLK_NIC1_BUS_DIV	37
+#define IMX7ULP_CLK_NIC1_EXT_DIV	38
+
+/* PCG2 */
+#define IMX7ULP_CLK_DMA1		39
+#define IMX7ULP_CLK_RGPIO2P1		40
+#define IMX7ULP_CLK_FLEXBUS		41
+#define IMX7ULP_CLK_SEMA42_1		42
+#define IMX7ULP_CLK_DMA_MUX1		43
+#define IMX7ULP_CLK_SNVS		44
+#define IMX7ULP_CLK_CAAM		45
+#define IMX7ULP_CLK_LPTPM4		46
+#define IMX7ULP_CLK_LPTPM5		47
+#define IMX7ULP_CLK_LPIT1		48
+#define IMX7ULP_CLK_LPSPI2		49
+#define IMX7ULP_CLK_LPSPI3		50
+#define IMX7ULP_CLK_LPI2C4		51
+#define IMX7ULP_CLK_LPI2C5		52
+#define IMX7ULP_CLK_LPUART4		53
+#define IMX7ULP_CLK_LPUART5		54
+#define IMX7ULP_CLK_FLEXIO1		55
+#define IMX7ULP_CLK_USB0		56
+#define IMX7ULP_CLK_USB1		57
+#define IMX7ULP_CLK_USB_PHY		58
+#define IMX7ULP_CLK_USB_PL301		59
+#define IMX7ULP_CLK_USDHC0		60
+#define IMX7ULP_CLK_USDHC1		61
+#define IMX7ULP_CLK_WDG1		62
+#define IMX7ULP_CLK_WDG2		63
+
+/* PCG3 */
+#define IMX7ULP_CLK_LPTPM6		64
+#define IMX7ULP_CLK_LPTPM7		65
+#define IMX7ULP_CLK_LPI2C6		66
+#define IMX7ULP_CLK_LPI2C7		67
+#define IMX7ULP_CLK_LPUART6		68
+#define IMX7ULP_CLK_LPUART7		69
+#define IMX7ULP_CLK_VIU			70
+#define IMX7ULP_CLK_DSI			71
+#define IMX7ULP_CLK_LCDIF		72
+#define IMX7ULP_CLK_MMDC		73
+#define IMX7ULP_CLK_PCTLC		74
+#define IMX7ULP_CLK_PCTLD		75
+#define IMX7ULP_CLK_PCTLE		76
+#define IMX7ULP_CLK_PCTLF		77
+#define IMX7ULP_CLK_GPU3D		78
+#define IMX7ULP_CLK_GPU2D		79
+#define IMX7ULP_CLK_MIPI_PLL		80
+#define IMX7ULP_CLK_SIRC		81
+#define IMX7ULP_CLK_SOSC_BUS_CLK	82
+#define IMX7ULP_CLK_FIRC_BUS_CLK	83
+#define IMX7ULP_CLK_SPLL_BUS_CLK	84
+
+#define IMX7ULP_CLK_END			85
+
+#endif /* __DT_BINDINGS_CLOCK_IMX7ULP_H */
-- 
2.7.4
