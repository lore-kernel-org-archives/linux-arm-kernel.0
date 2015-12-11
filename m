From: b51503@freescale.com (Bai Ping)
Date: Fri, 11 Dec 2015 18:45:20 +0800
Subject: [PATCH 1/3] ARM: dts: imx: Add basic dts support for imx6qp
Message-ID: <1449830722-26607-1-git-send-email-b51503@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6Qual Plus processor is an high performance SOC of i.MX6 family.
It has enhanced graphics performance and increased overall memory bandwidth
compared to i.MX6Q. Most of the design are same as i.MX6Qual/Dual, so code
for i.MX6Qual can be resued by this chip. The revision number is identied as
i.MX6Q Rev2.0, but actually it is a new chip, as we did many change to the
overall architecture.

This patch adds basic dts file for the new i.MX6Qual Plus processor.

Signed-off-by: Bai Ping <b51503@freescale.com>
---
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/imx6q.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi    |   1 +
 arch/arm/boot/dts/imx6qp-sabreauto.dts    |  67 +++++++++++++
 arch/arm/boot/dts/imx6qp-sabresd.dts      |  59 +++++++++++
 arch/arm/boot/dts/imx6qp.dtsi             | 157 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/imx6qdl-clock.h |  16 ++-
 7 files changed, 302 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qp-sabreauto.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-sabresd.dts
 create mode 100644 arch/arm/boot/dts/imx6qp.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0fe130e..ab8efbd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -302,6 +302,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
+	imx6qp-sabresd.dtb \
 	imx6dl-tx6dl-comtft.dtb \
 	imx6dl-tx6u-801x.dtb \
 	imx6dl-tx6u-811x.dtb \
@@ -328,6 +329,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-phytec-pbab01.dtb \
 	imx6q-rex-pro.dtb \
 	imx6q-sabreauto.dtb \
+	imx6qp-sabreauto.dtb \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
 	imx6q-sbc6x.dtb \
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 399103b..c4efd9a 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -21,7 +21,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a6d445c..f65f57b 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -238,6 +238,7 @@
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
+				regulator-ramp-delay = <6250>;
 			};
 
 			sw3a_reg: sw3a {
diff --git a/arch/arm/boot/dts/imx6qp-sabreauto.dts b/arch/arm/boot/dts/imx6qp-sabreauto.dts
new file mode 100644
index 0000000..b24aae6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-sabreauto.dts
@@ -0,0 +1,67 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6q-sabreauto.dts"
+#include "imx6qp.dtsi"
+
+/ {
+	model = "Freescale i.MX6 Quad Plus SABRE Automotive Board";
+	compatible = "fsl,imx6qp-sabreauto", "fsl,imx6qp";
+};
+
+
+&fec {
+	pinctrl-assert-gpios = <&max7322 0 GPIO_ACTIVE_HIGH>;
+};
+
+&i2c2 {
+	max7322: gpio at 68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&iomuxc {
+	imx6qdl-sabreauto {
+		pinctrl_enet: enetgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL1__ENET_MDIO          0x1b0b0
+				MX6QDL_PAD_KEY_COL2__ENET_MDC           0x1b0b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC         0x1b018
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0         0x1b018
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1         0x1b018
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2         0x1b018
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3         0x1b018
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL   0x1b018
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC         0x1b018
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0         0x1b018
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1         0x1b018
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2         0x1b018
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3         0x1b018
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL   0x1b018
+				MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0x4001b0a8
+				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
+			>;
+		};
+	};
+};
+
+&pcie {
+	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&vgen3_reg {
+	regulator-always-on;
+};
diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
new file mode 100644
index 0000000..c3ab2b6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6q-sabresd.dts"
+#include "imx6qp.dtsi"
+
+/ {
+	model = "Freescale i.MX6 Quad Plus SABRE Smart Device Board";
+	compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp";
+};
+
+&cpu0 {
+	arm-supply = <&sw2_reg>;
+};
+
+&iomuxc {
+	imx6qdl-sabresd {
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10071
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+				MX6QDL_PAD_NANDF_D4__SD2_DATA4		0x17059
+				MX6QDL_PAD_NANDF_D5__SD2_DATA5		0x17059
+				MX6QDL_PAD_NANDF_D6__SD2_DATA6		0x17059
+				MX6QDL_PAD_NANDF_D7__SD2_DATA7		0x17059
+			>;
+		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10071
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+				MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x17059
+				MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x17059
+				MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x17059
+				MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
+			>;
+		};
+	};
+};
+
+&pcie {
+	power-on-gpio = <&gpio3 19 0>;
+	reset-gpio = <&gpio7 12 0>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
new file mode 100644
index 0000000..e43751f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -0,0 +1,157 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+/ {
+	aliases {
+		pre0 = &pre1;
+		pre1 = &pre2;
+		pre2 = &pre3;
+		pre3 = &pre4;
+		prg0 = &prg1;
+		prg1 = &prg2;
+	};
+
+	soc {
+		ocram_2: sram at 00940000 {
+			compatible = "mmio-sram";
+			reg = <0x00940000 0x20000>;
+			clocks = <&clks IMX6QDL_CLK_OCRAM>;
+		};
+
+		ocram_3: sram at 00960000 {
+			compatible = "mmio-sram";
+			reg = <0x00960000 0x20000>;
+			clocks = <&clks IMX6QDL_CLK_OCRAM>;
+		};
+
+		pcie: pcie at 0x01000000 {
+			compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
+			reg = <0x01ffc000 0x4000>, <0x01f00000 0x80000>;
+			reg-names = "dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
+				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 123 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 122 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 121 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 120 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6QDL_CLK_PCIE_REF_125M>,
+				 <&clks IMX6QDL_CLK_SATA_REF_100M>,
+				 <&clks IMX6QDL_CLK_LVDS1_GATE>, <&clks IMX6QDL_CLK_PCIE_AXI>;
+			clock-names = "pcie_phy", "ref_100m", "pcie_bus", "pcie";
+			status = "disabled";
+		};
+
+		aips-bus at 02100000 { /* AIPS2 */
+			pre1: pre at 021c8000 {
+				compatible = "fsl,imx6q-pre";
+				reg = <0x021c8000 0x1000>;
+				clocks = <&clks IMX6QDL_CLK_PRE0>;
+				interrupts = <0 90 IRQ_TYPE_EDGE_RISING>;
+				ocram = <&ocram_2>;
+				status = "disabled";
+			};
+
+			pre2: pre at 021c9000 {
+				compatible = "fsl,imx6q-pre";
+				reg = <0x021c9000 0x1000>;
+				clocks = <&clks IMX6QDL_CLK_PRE1>;
+				interrupts = <0 97 IRQ_TYPE_EDGE_RISING>;
+				ocram = <&ocram_2>;
+				status = "disabled";
+			};
+
+			pre3: pre at 021ca000 {
+				compatible = "fsl,imx6q-pre";
+				reg = <0x021ca000 0x1000>;
+				clocks = <&clks IMX6QDL_CLK_PRE2>;
+				interrupts = <0 98 IRQ_TYPE_EDGE_RISING>;
+				ocram = <&ocram_3>;
+				status = "disabled";
+			};
+
+			pre4: pre at 021cb000 {
+				compatible = "fsl,imx6q-pre";
+				reg = <0x021cb000 0x1000>;
+				clocks = <&clks IMX6QDL_CLK_PRE3>;
+				interrupts = <0 99 IRQ_TYPE_EDGE_RISING>;
+				ocram = <&ocram_3>;
+				status = "disabled";
+			};
+
+			prg1: prg at 021cc000 {
+				compatible = "fsl,imx6q-prg";
+				reg = <0x021cc000 0x1000>;
+				clocks = <&clks IMX6QDL_CLK_PRG0_AXI>,
+					 <&clks IMX6QDL_CLK_PRG0_APB>;
+				clock-names = "axi", "apb";
+				gpr = <&gpr>;
+				status = "disabled";
+			};
+
+			prg2: prg at 021cd000 {
+				compatible = "fsl,imx6q-prg";
+				reg = <0x021cd000 0x1000>;
+				clocks = <&clks IMX6QDL_CLK_PRG1_AXI>,
+					 <&clks IMX6QDL_CLK_PRG1_APB>;
+				clock-names = "axi", "apb";
+				gpr = <&gpr>;
+				status = "disabled";
+			};
+		};
+
+		ipu1: ipu at 02400000 {
+			compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
+			clocks = <&clks IMX6QDL_CLK_IPU1>,
+				 <&clks IMX6QDL_CLK_IPU1_DI0>, <&clks IMX6QDL_CLK_IPU1_DI1>,
+				 <&clks IMX6QDL_CLK_IPU1_DI0_SEL>, <&clks IMX6QDL_CLK_IPU1_DI1_SEL>,
+				 <&clks IMX6QDL_CLK_LDB_DI0_PODF>, <&clks IMX6QDL_CLK_LDB_DI1_PODF>,
+				 <&clks IMX6QDL_CLK_PRG0_APB>;
+			clock-names = "bus",
+				      "di0", "di1",
+				      "di0_sel", "di1_sel",
+				      "ldb_di0", "ldb_di1", "prg";
+		};
+
+		ipu2: ipu at 02800000 {
+			compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
+			clocks = <&clks IMX6QDL_CLK_IPU2>,
+				 <&clks IMX6QDL_CLK_IPU2_DI0>, <&clks IMX6QDL_CLK_IPU2_DI1>,
+				 <&clks IMX6QDL_CLK_IPU2_DI0_SEL>, <&clks IMX6QDL_CLK_IPU2_DI1_SEL>,
+				 <&clks IMX6QDL_CLK_LDB_DI0_PODF>, <&clks IMX6QDL_CLK_LDB_DI1_PODF>,
+				 <&clks IMX6QDL_CLK_PRG1_APB>;
+			clock-names = "bus",
+				      "di0", "di1",
+				      "di0_sel", "di1_sel",
+				      "ldb_di0", "ldb_di1", "prg";
+		};
+
+		sata: sata at 02200000 {
+			compatible = "fsl,imx6qp-ahci";
+			reg = <0x02200000 0x4000>;
+			interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6QDL_CLK_SATA>,
+				 <&clks IMX6QDL_CLK_SATA_REF_100M>,
+				 <&clks IMX6QDL_CLK_AHB>;
+			clock-names = "sata", "sata_ref", "ahb";
+			status = "disabled";
+		};
+	};
+};
+
+&ldb {
+	compatible = "fsl,imx6qp-ldb", "fsl,imx6q-ldb", "fsl,imx53-ldb";
+};
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 77985cc..2905033 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -255,6 +255,20 @@
 #define IMX6QDL_CLK_CAAM_ACLK			242
 #define IMX6QDL_CLK_CAAM_IPG			243
 #define IMX6QDL_CLK_SPDIF_GCLK			244
-#define IMX6QDL_CLK_END				245
+#define IMX6QDL_CLK_UART_SEL			245
+#define IMX6QDL_CLK_IPG_PER_SEL			246
+#define IMX6QDL_CLK_ECSPI_SEL			247
+#define IMX6QDL_CLK_CAN_SEL			248
+#define IMX6QDL_CLK_MMDC_CH1_AXI_CG		249
+#define IMX6QDL_CLK_PRE0			250
+#define IMX6QDL_CLK_PRE1			251
+#define IMX6QDL_CLK_PRE2			252
+#define IMX6QDL_CLK_PRE3			253
+#define IMX6QDL_CLK_PRG0_AXI			254
+#define IMX6QDL_CLK_PRG1_AXI			255
+#define IMX6QDL_CLK_PRG0_APB			256
+#define IMX6QDL_CLK_PRG1_APB			257
+#define IMX6QDL_CLK_PRE_AXI			258
+#define IMX6QDL_CLK_END				259
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
1.9.1
