From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 28 Apr 2018 03:06:15 +0800
Subject: [PATCH 3/5] arm64: dts: imx: add imx8qxp support
In-Reply-To: <1524855977-15719-1-git-send-email-aisheng.dong@nxp.com>
References: <1524855977-15719-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1524855977-15719-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx8qxp support

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt     |   5 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-imx8-ca35.dtsi  |  66 ++
 arch/arm64/boot/dts/freescale/fsl-imx8qxp-mek.dts | 138 ++++
 arch/arm64/boot/dts/freescale/fsl-imx8qxp.dtsi    | 794 ++++++++++++++++++++++
 include/dt-bindings/power/imx-rsrc.h              | 558 +++++++++++++++
 6 files changed, 1562 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-imx8-ca35.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-imx8qxp-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-imx8qxp.dtsi
 create mode 100644 include/dt-bindings/power/imx-rsrc.h

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index cdb9dd7..e9aea78 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -53,6 +53,11 @@ i.MX6 Quad SABRE Automotive Board
 Required root node properties:
     - compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
 
+i.MX8QXP MEK Board
+Required root node properties:
+    - compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
+
+
 Generic i.MX boards
 -------------------
 
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 86e18ad..2622da7 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
+dtb-$(CONFIG_SOC_IMX8QXP) += fsl-imx8qxp-mek.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-imx8-ca35.dtsi b/arch/arm64/boot/dts/freescale/fsl-imx8-ca35.dtsi
new file mode 100644
index 0000000..3a3569f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-imx8-ca35.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/{
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		/* We have 1 clusters having 4 Cortex-A35 cores */
+		A35_0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&A35_L2>;
+		};
+
+		A35_1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&A35_L2>;
+		};
+
+		A35_2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			next-level-cache = <&A35_L2>;
+		};
+
+		A35_3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			next-level-cache = <&A35_L2>;
+		};
+
+		A35_L2: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7
+			(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-affinity = <&A35_0>, <&A35_1>, <&A35_2>, <&A35_3>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+		cpu_suspend   = <0xc4000001>;
+		cpu_off	      = <0xc4000002>;
+		cpu_on	      = <0xc4000003>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/fsl-imx8qxp-mek.dts
new file mode 100644
index 0000000..920018e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-imx8qxp-mek.dts
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2017~2018 NXP
+ */
+
+/dts-v1/;
+
+#include "fsl-imx8qxp.dtsi"
+
+/ {
+	model = "Freescale i.MX8QXP MEK";
+	compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
+
+	chosen {
+		stdout-path = &dma_lpuart0;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usdhc2_vmmc: usdhc2_vmmc {
+			compatible = "regulator-fixed";
+			regulator-name = "SD1_SPWR";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+	};
+};
+
+&dma_lpuart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart0>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy at 0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			at803x,eee-disabled;
+			at803x,vddio-1p8v;
+			reg = <0>;
+		};
+
+		ethphy1: ethernet-phy at 1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			at803x,eee-disabled;
+			at803x,vddio-1p8v;
+			reg = <1>;
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	non-removable;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			SC_P_ENET0_MDC_CONN_ENET0_MDC			0x06000020
+			SC_P_ENET0_MDIO_CONN_ENET0_MDIO			0x06000020
+			SC_P_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x06000020
+			SC_P_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC	0x06000020
+			SC_P_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0	0x06000020
+			SC_P_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1	0x06000020
+			SC_P_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2	0x06000020
+			SC_P_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3	0x06000020
+			SC_P_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC	0x06000020
+			SC_P_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x06000020
+			SC_P_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0	0x06000020
+			SC_P_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1	0x06000020
+			SC_P_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2	0x06000020
+			SC_P_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3	0x06000020
+		>;
+	};
+	pinctrl_lpuart0: lpuart0grp {
+		fsl,pins = <
+			SC_P_UART0_RX_ADMA_UART0_RX			0x06000020
+			SC_P_UART0_TX_ADMA_UART0_TX			0x06000020
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			SC_P_EMMC0_CLK_CONN_EMMC0_CLK			0x06000041
+			SC_P_EMMC0_CMD_CONN_EMMC0_CMD			0x00000021
+			SC_P_EMMC0_DATA0_CONN_EMMC0_DATA0		0x00000021
+			SC_P_EMMC0_DATA1_CONN_EMMC0_DATA1		0x00000021
+			SC_P_EMMC0_DATA2_CONN_EMMC0_DATA2		0x00000021
+			SC_P_EMMC0_DATA3_CONN_EMMC0_DATA3		0x00000021
+			SC_P_EMMC0_DATA4_CONN_EMMC0_DATA4		0x00000021
+			SC_P_EMMC0_DATA5_CONN_EMMC0_DATA5		0x00000021
+			SC_P_EMMC0_DATA6_CONN_EMMC0_DATA6		0x00000021
+			SC_P_EMMC0_DATA7_CONN_EMMC0_DATA7		0x00000021
+			SC_P_EMMC0_STROBE_CONN_EMMC0_STROBE		0x00000041
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			SC_P_USDHC1_CLK_CONN_USDHC1_CLK			0x06000041
+			SC_P_USDHC1_CMD_CONN_USDHC1_CMD			0x00000021
+			SC_P_USDHC1_DATA0_CONN_USDHC1_DATA0		0x00000021
+			SC_P_USDHC1_DATA1_CONN_USDHC1_DATA1		0x00000021
+			SC_P_USDHC1_DATA2_CONN_USDHC1_DATA2		0x00000021
+			SC_P_USDHC1_DATA3_CONN_USDHC1_DATA3		0x00000021
+			SC_P_USDHC1_VSELECT_CONN_USDHC1_VSELECT		0x00000021
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/fsl-imx8qxp.dtsi
new file mode 100644
index 0000000..d7cc836
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-imx8qxp.dtsi
@@ -0,0 +1,794 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/clock/imx8qxp-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pads-imx8qxp.h>
+#include <dt-bindings/power/imx-rsrc.h>
+
+#include "fsl-imx8-ca35.dtsi"
+
+/ {
+	compatible = "fsl,imx8qxp";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &dma_lpuart0;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x40000000>;
+	};
+
+	gic: interrupt-controller at 51a00000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
+		      <0x0 0x51b00000 0 0xC0000>; /* GICR (RD_base + SGI_base) */
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9
+			(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>, /* Physical Secure */
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>, /* Physical Non-Secure */
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>, /* Virtual */
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>; /* Hypervisor */
+		clock-frequency = <8000000>;
+	};
+
+	scu {
+		compatible = "nxp,imx8qxp-scu", "simple-bus";
+		fsl,mu = <&lsio_mu0>;
+
+		clk: clk {
+			compatible = "fsl,imx8qxp-clk";
+			#clock-cells = <1>;
+		};
+
+		iomuxc: iomuxc {
+			compatible = "fsl,imx8qxp-iomuxc";
+		};
+
+		imx8qx-pm {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pd_lsio: PD_LSIO {
+				compatible = "nxp,imx8qxp-pd";
+				#power-domain-cells = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_lsio_pwm0: lsio_pwm0 at SC_R_PWM_0 {
+					reg = <SC_R_PWM_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_pwm1: lsio_pwm1 at SC_R_PWM_1 {
+					reg = <SC_R_PWM_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_pwm2: lsio_pwm2 at SC_R_PWM_2 {
+					reg = <SC_R_PWM_2>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_pwm3: lsio_pwm3 at SC_R_PWM_3 {
+					reg = <SC_R_PWM_3>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_pwm4: lsio_pwm4 at SC_R_PWM_4 {
+					reg = <SC_R_PWM_4>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_pwm5: lsio_pwm5 at SC_R_PWM_5 {
+					reg = <SC_R_PWM_5>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_pwm6: lsio_pwm6 at SC_R_PWM_6 {
+					reg = <SC_R_PWM_6>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_pwm7: lsio_pwm7 at SC_R_PWM_7 {
+					reg = <SC_R_PWM_7>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_kpp: lsio_kpp at SC_R_KPP {
+					reg = <SC_R_KPP>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpio0: lsio_gpio0 at SC_R_GPIO_0 {
+					reg = <SC_R_GPIO_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpio1: lsio_gpio1 at SC_R_GPIO_1 {
+					reg = <SC_R_GPIO_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpio2: lsio_gpio2 at SC_R_GPIO_2 {
+					reg = <SC_R_GPIO_2>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpio3: lsio_gpio3 at SC_R_GPIO_3 {
+					reg = <SC_R_GPIO_3>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpio4: lsio_gpio4 at SC_R_GPIO_4 {
+					reg = <SC_R_GPIO_4>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpio5: lsio_gpio5 at SC_R_GPIO_5 {
+					reg = <SC_R_GPIO_5>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpio6: lsio_gpio6 at SC_R_GPIO_6 {
+					reg = <SC_R_GPIO_6>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpio7: lsio_gpio7 at SC_R_GPIO_7 {
+					reg = <SC_R_GPIO_7>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpt0: lsio_gpt0 at SC_R_GPT_0 {
+					reg = <SC_R_GPT_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpt1: lsio_gpt1 at SC_R_GPT_1 {
+					reg = <SC_R_GPT_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpt2: lsio_gpt2 at SC_R_GPT_2 {
+					reg = <SC_R_GPT_2>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpt3: lsio_gpt3 at SC_R_GPT_3 {
+					reg = <SC_R_GPT_3>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_gpt4: lsio_gpt4 at SC_R_GPT_4 {
+					reg = <SC_R_GPT_4>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_flexspi0: lsio_fspi0 at SC_R_FSPI_0 {
+					reg = <SC_R_FSPI_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+				pd_lsio_flexspi1: lsio_fspi1 at SC_R_FSPI_1 {
+					reg = <SC_R_FSPI_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_lsio>;
+				};
+			};
+
+			pd_conn: connectivity_power_domain {
+				compatible = "nxp,imx8qxp-pd";
+				#power-domain-cells = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_conn_usbotg0: conn_usb0 at SC_R_USB_0 {
+					reg = <SC_R_USB_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_usbotg0_phy: conn_usb0_phy at SC_R_USB_0_PHY {
+					reg = <SC_R_USB_0_PHY>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_usbotg1: conn_usb1 at SC_R_USB_1 {
+					reg = <SC_R_USB_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_usb2: conn_usb2 at SC_R_USB_2 {
+					reg = <SC_R_USB_2>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_usb2_phy: conn_usb2_phy at SC_R_USB_2_PHY {
+					reg = <SC_R_USB_2_PHY>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_sdhc0: conn_sdhc0 at SC_R_SDHC_0 {
+					reg = <SC_R_SDHC_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_sdhc1: conn_sdhc1 at SC_R_SDHC_1 {
+					reg = <SC_R_SDHC_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_sdhc2: conn_sdhc2 at SC_R_SDHC_2 {
+					reg = <SC_R_SDHC_2>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_enet0: conn_enet0 at SC_R_ENET_0 {
+					reg = <SC_R_ENET_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_enet1: conn_enet1 at SC_R_ENET_1 {
+					reg = <SC_R_ENET_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_nand: conn_nand at SC_R_NAND {
+					reg = <SC_R_NAND>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_mlb0: conn_mlb0 at SC_R_MLB_0 {
+					reg = <SC_R_MLB_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_conn>;
+				};
+				pd_conn_edma_ch0: conn_dma4_ch0 at SC_R_DMA_4_CH0 {
+					reg = <SC_R_DMA_4_CH0>;
+					#power-domain-cells = <0>;
+					power-domains =<&pd_conn>;
+				};
+				pd_conn_edma_ch1: conn_dma4_ch1 at SC_R_DMA_4_CH1 {
+					reg = <SC_R_DMA_4_CH1>;
+					#power-domain-cells = <0>;
+					power-domains =<&pd_conn>;
+				};
+				pd_conn_edma_ch2: conn_dma4_ch2 at SC_R_DMA_4_CH2 {
+					reg = <SC_R_DMA_4_CH2>;
+					#power-domain-cells = <0>;
+					power-domains =<&pd_conn>;
+				};
+				pd_conn_edma_ch3: conn_dma4_ch3 at SC_R_DMA_4_CH3 {
+					reg = <SC_R_DMA_4_CH3>;
+					#power-domain-cells = <0>;
+					power-domains =<&pd_conn>;
+				};
+				pd_conn_edma_ch4: conn_dma4_ch4 at SC_R_DMA_4_CH4 {
+					reg = <SC_R_DMA_4_CH4>;
+					#power-domain-cells = <0>;
+					power-domains =<&pd_conn>;
+				};
+			};
+
+			pd_dma: dma_power_domain {
+				compatible = "nxp,imx8qxp-pd";
+				#power-domain-cells = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_dma_flexcan0: dma_flexcan0 at SC_R_CAN_0 {
+					reg = <SC_R_CAN_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_flexcan1: dma_flexcan1 at SC_R_CAN_1 {
+					reg = <SC_R_CAN_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_flexcan2: dma_flexcan2 at SC_R_CAN_2 {
+					reg = <SC_R_CAN_2>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_ftm0: dma_ftm0 at SC_R_FTM_0 {
+					reg = <SC_R_FTM_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_ftm1: dma_ftm1 at SC_R_FTM_1 {
+					reg = <SC_R_FTM_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_adc0: dma_adc0 at SC_R_ADC_0 {
+					reg = <SC_R_ADC_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpi2c0: dma_lpi2c0 at SC_R_I2C_0 {
+					reg = <SC_R_I2C_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpi2c1: dma_lpi2c1 at SC_R_I2C_1 {
+					reg = <SC_R_I2C_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpi2c2: dma_lpi2c2 at SC_R_I2C_2 {
+					reg = <SC_R_I2C_2>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpi2c3: dma_lpi2c3 at SC_R_I2C_3 {
+					reg = <SC_R_I2C_3>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpuart0: dma_lpuart0 at SC_R_UART_0 {
+					reg = <SC_R_UART_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpuart1: dma_lpuart1 at SC_R_UART_1 {
+					reg = <SC_R_UART_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpuart2: dma_lpuart2 at SC_R_UART_2 {
+					reg = <SC_R_UART_2>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpuart3: dma_lpuart3 at SC_R_UART_3 {
+					reg = <SC_R_UART_3>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpspi0: dma_spi0 at SC_R_SPI_0 {
+					reg = <SC_R_SPI_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpspi1: dma_spi1 at SC_R_SPI_1 {
+					reg = <SC_R_SPI_1>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpspi2: dma_spi2 at SC_R_SPI_2 {
+					reg = <SC_R_SPI_2>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lpspi3: dma_spi3 at SC_R_SPI_3 {
+					reg = <SC_R_SPI_3>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_pwm0: dma_pwm0 at SC_R_LCD_0_PWM_0 {
+					reg = <SC_R_LCD_0_PWM_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+				pd_dma_lcd0: dma_lcd0 at SC_R_LCD_0 {
+					reg = <SC_R_LCD_0>;
+					#power-domain-cells = <0>;
+					power-domains = <&pd_dma>;
+				};
+			};
+
+			pd_gpu: gpu-power-domain {
+				compatible = "nxp,imx8qxp-pd";
+				#power-domain-cells = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_gpu0: gpu0 at SC_R_GPU_0_PID0 {
+					reg = <SC_R_GPU_0_PID0>;
+					#power-domain-cells = <0>;
+					power-domains =<&pd_gpu>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+
+			pd_vpu: vpu-power-domain at SC_R_VPU_PID0 {
+				compatible = "nxp,imx8qxp-pd";
+				reg = <SC_R_VPU_PID0>;
+				#power-domain-cells = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_vpu_core: vpu_core at SC_R_VPUCORE {
+					reg = <SC_R_VPUCORE>;
+					#power-domain-cells = <0>;
+					power-domains =<&pd_vpu>;
+				};
+			};
+
+			pd_hsio: hsio-power-domain {
+				compatible = "nxp,imx8qxp-pd";
+				#power-domain-cells = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_pcie: hsio-pcie-pd at SC_R_PCIE_A {
+					reg = <SC_R_PCIE_A>;
+					#power-domain-cells = <0>;
+					power-domains =<&pd_hsio>;
+				};
+			};
+
+			pd_dc: dc-power-domain {
+				compatible = "nxp,imx8qxp-pd";
+				#power-domain-cells = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_dc0: dc0-power-domain at SC_R_DC_0 {
+					reg = <SC_R_DC_0>;
+					#power-domain-cells = <0>;
+					power-domains =<&pd_dc>;
+				};
+			};
+
+			pd_mipi_dsi: mipi0_dsi_power_domain at SC_R_MIPI_0 {
+				compatible = "nxp,imx8qxp-pd";
+				reg = <SC_R_MIPI_0>;
+				#power-domain-cells = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_mipi_dsi_i2c0: mipi0_dsi_i2c0 at SC_R_MIPI_0_I2C_0 {
+					reg = <SC_R_MIPI_0_I2C_0>;
+					power-domains =<&pd_mipi_dsi>;
+				};
+				pd_mipi_dsi_i2c1: mipi0_dsi_i2c1 at SC_R_MIPI_0_I2C_1 {
+					reg = <SC_R_MIPI_0_I2C_1>;
+					power-domains =<&pd_mipi_dsi>;
+				};
+				pd_mipi_pwm0: mipi0_dsi_pwm0 at SC_R_MIPI_0_PWM_0 {
+					reg = <SC_R_MIPI_0_PWM_0>;
+					power-domains =<&pd_mipi_dsi>;
+				};
+			};
+
+			pd_mipi_csi: mipi_csi0_power_domain at SC_R_CSI_0 {
+				compatible = "nxp,imx8qxp-pd";
+				reg = <SC_R_CSI_0>;
+				#power-domain-cells = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_mipi_csi0_i2c0: mipi_csi0_i2c at SC_R_CSI_0_I2C_0 {
+					reg = <SC_R_CSI_0_I2C_0>;
+					power-domains =<&pd_mipi_csi>;
+				};
+				pd_mipi_csi0_pwm0: mipi_csi0_pwm at SC_R_CSI_0_PWM_0 {
+					reg = <SC_R_CSI_0_PWM_0>;
+					power-domains =<&pd_mipi_csi>;
+				};
+			};
+		};
+	};
+
+	gpu: gpu at 53100000 {
+		compatible = "fsl,imx8qxp-gpu", "fsl,imx8x-gpu";
+		reg = <0x0 0x53100000 0 0x40000>,
+		      <0x0 0x80000000 0x0 0x08000000>,
+		      <0x0 0x0 0x0 0x2000000>;
+		reg-names = "iobase_3d_0", "phys_baseaddr",
+			    "contiguous_mem";
+		interrupts = <0 64 0x4>;
+		interrupt-names = "irq_3d_0";
+		clocks = <&clk IMX8QXP_GPU0_CORE_CLK>,
+			 <&clk IMX8QXP_GPU0_SHADER_CLK>;
+		clock-names = "clk_core_3d_0", "clk_shader_3d_0";
+		assigned-clocks = <&clk IMX8QXP_GPU0_CORE_CLK>,
+				  <&clk IMX8QXP_GPU0_SHADER_CLK>;
+		assigned-clock-rates = <650000000>, <700000000>;
+		status = "disabled";
+	};
+
+	audio_subsys: audio at 59000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0x59000000 0x0 0x1000000>;
+		ranges;
+	};
+
+	dma_subsys: dma at 5a000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0x5a000000 0x0 0x1000000>;
+		ranges;
+
+		dma_lpuart0: serial at 5a060000 {
+			compatible = "fsl,imx7ulp-lpuart";
+			reg = <0x0 0x5a060000 0x0 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&clk IMX8QXP_UART0_CLK>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		dma_i2c0: i2c at 5a800000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x0 0x5a800000 0x0 0x4000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&clk IMX8QXP_I2C0_CLK>;
+			clock-names = "per";
+			assigned-clocks = <&clk IMX8QXP_I2C0_CLK>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd_dma_lpi2c0>;
+			status = "disabled";
+		};
+
+		dma_i2c1: i2c at 5a810000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x0 0x5a810000 0x0 0x4000>;
+			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&clk IMX8QXP_I2C1_CLK>;
+			clock-names = "per";
+			assigned-clocks = <&clk IMX8QXP_I2C1_CLK>;
+			assigned-clock-rates = <24000000>;
+			status = "disabled";
+		};
+
+		dma_i2c2: i2c at 5a820000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x0 0x5a820000 0x0 0x4000>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&clk IMX8QXP_I2C2_CLK>;
+			clock-names = "per";
+			assigned-clocks = <&clk IMX8QXP_I2C2_CLK>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd_dma_lpi2c2>;
+			status = "disabled";
+		};
+
+		dma_i2c3: i2c at 5a830000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x0 0x5a830000 0x0 0x4000>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&clk IMX8QXP_I2C3_CLK>;
+			clock-names = "per";
+			assigned-clocks = <&clk IMX8QXP_I2C3_CLK>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd_dma_lpi2c3>;
+			status = "disabled";
+		};
+	};
+
+	conn_subsys: conn at 5b000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0x5b000000 0x0 0x1000000>;
+		ranges;
+
+		usdhc1: usdhc at 5b010000 {
+			compatible = "fsl,imx7d-usdhc";
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x0 0x5b010000 0x0 0x10000>;
+			clocks = <&clk IMX8QXP_SDHC0_IPG_CLK>,
+				 <&clk IMX8QXP_SDHC0_CLK>,
+				 <&clk IMX8QXP_CLK_DUMMY>;
+			clock-names = "ipg", "per", "ahb";
+			assigned-clocks = <&clk IMX8QXP_SDHC0_DIV>;
+			assigned-clock-rates = <200000000>;
+			power-domains = <&pd_conn_sdhc0>;
+			status = "disabled";
+		};
+
+		usdhc2: usdhc at 5b020000 {
+			compatible = "fsl,imx7d-usdhc";
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x0 0x5b020000 0x0 0x10000>;
+			clocks = <&clk IMX8QXP_SDHC1_IPG_CLK>,
+				 <&clk IMX8QXP_SDHC1_CLK>,
+				 <&clk IMX8QXP_CLK_DUMMY>;
+			clock-names = "ipg", "per", "ahb";
+			assigned-clocks = <&clk IMX8QXP_SDHC1_DIV>;
+			assigned-clock-rates = <200000000>;
+			power-domains = <&pd_conn_sdhc1>;
+			fsl,tuning-start-tap = <20>;
+			fsl,tuning-step= <2>;
+			status = "disabled";
+		};
+
+		usdhc3: usdhc at 5b030000 {
+			compatible = "fsl,imx7d-usdhc";
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x0 0x5b030000 0x0 0x10000>;
+			clocks = <&clk IMX8QXP_SDHC2_IPG_CLK>,
+				 <&clk IMX8QXP_SDHC2_CLK>,
+				 <&clk IMX8QXP_CLK_DUMMY>;
+			clock-names = "ipg", "per", "ahb";
+			assigned-clocks = <&clk IMX8QXP_SDHC2_DIV>;
+			assigned-clock-rates = <200000000>;
+			power-domains = <&pd_conn_sdhc2>;
+			status = "disabled";
+		};
+
+		fec1: ethernet at 5b040000 {
+			compatible = "fsl,imx6sx-fec";
+			reg = <0x0 0x5b040000 0x0 0x10000>;
+			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8QXP_ENET0_IPG_CLK>, <&clk IMX8QXP_ENET0_AHB_CLK>, <&clk IMX8QXP_ENET0_TX_CLK>,
+				<&clk IMX8QXP_ENET0_PTP_CLK>;
+			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
+			assigned-clocks = <&clk IMX8QXP_ENET0_REF_DIV>, <&clk IMX8QXP_ENET0_PTP_CLK>;
+			assigned-clock-rates = <125000000>, <125000000>;
+			fsl,num-tx-queues=<3>;
+			fsl,num-rx-queues=<3>;
+			power-domains = <&pd_conn_enet0>;
+			status = "disabled";
+		};
+
+		fec2: ethernet at 5b050000 {
+			compatible = "fsl,imx8qxp-fec";
+			reg = <0x0 0x5b050000 0x0 0x10000>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8QXP_ENET1_IPG_CLK>, <&clk IMX8QXP_ENET1_AHB_CLK>, <&clk IMX8QXP_ENET1_TX_CLK>,
+				<&clk IMX8QXP_ENET1_PTP_CLK>;
+			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
+			assigned-clocks = <&clk IMX8QXP_ENET1_REF_DIV>, <&clk IMX8QXP_ENET1_PTP_CLK>;
+			assigned-clock-rates = <125000000>, <125000000>;
+			fsl,num-tx-queues=<3>;
+			fsl,num-rx-queues=<3>;
+			power-domains = <&pd_conn_enet1>;
+			status = "disabled";
+		};
+	};
+
+	db_subsys: db at 5c000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0x5c000000 0x0 0x1000000>;
+		ranges;
+
+		ddr_pmu0: ddr_pmu at 5c020000 {
+			compatible = "fsl,imx8-ddr-pmu";
+			reg = <0x0 0x5c020000 0x0 0x10000>;
+		};
+	};
+
+	lsio_subsys: lsio at 5d000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0x5d000000 0x0 0x1000000>;
+		ranges;
+
+		lsio_mu0: mu at 5d1b0000 {
+			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+			reg = <0x0 0x5d1b0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		lsio_gpio0: gpio at 5d080000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x0 0x5d080000 0x0 0x10000>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		lsio_gpio1: gpio at 5d090000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x0 0x5d090000 0x0 0x10000>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		lsio_gpio2: gpio at 5d0a0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x0 0x5d0a0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		lsio_gpio3: gpio at 5d0b0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x0 0x5d0b0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		lsio_gpio4: gpio at 5d0c0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x0 0x5d0c0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		lsio_gpio5: gpio at 5d0d0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x0 0x5d0d0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		lsio_gpio6: gpio at 5d0e0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x0 0x5d0e0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		lsio_gpio7: gpio at 5d0f0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x0 0x5d0f0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	hsio_subsys: hsio at 5f000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0x5f000000 0x0 0x1000000>;
+		ranges;
+	};
+
+};
diff --git a/include/dt-bindings/power/imx-rsrc.h b/include/dt-bindings/power/imx-rsrc.h
new file mode 100644
index 0000000..b4d0980
--- /dev/null
+++ b/include/dt-bindings/power/imx-rsrc.h
@@ -0,0 +1,558 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ */
+
+#ifndef __DT_BINDINGS_RSCRC_IMX_H
+#define __DT_BINDINGS_RSCRC_IMX_H
+
+/*
+ * These defines are used to indicate a resource. Resources include peripherals
+ * and bus masters (but not memory regions). Note items from list should
+ * never be changed or removed (only added to at the end of the list).
+ */
+#define SC_R_A53                        0
+#define SC_R_A53_0                      1
+#define SC_R_A53_1                      2
+#define SC_R_A53_2                      3
+#define SC_R_A53_3                      4
+#define SC_R_A72                        5
+#define SC_R_A72_0                      6
+#define SC_R_A72_1                      7
+#define SC_R_A72_2                      8
+#define SC_R_A72_3                      9
+#define SC_R_CCI                        10
+#define SC_R_DB                         11
+#define SC_R_DRC_0                      12
+#define SC_R_DRC_1                      13
+#define SC_R_GIC_SMMU                   14
+#define SC_R_IRQSTR_M4_0                15
+#define SC_R_IRQSTR_M4_1                16
+#define SC_R_SMMU                       17
+#define SC_R_GIC                        18
+#define SC_R_DC_0_BLIT0                 19
+#define SC_R_DC_0_BLIT1                 20
+#define SC_R_DC_0_BLIT2                 21
+#define SC_R_DC_0_BLIT_OUT              22
+#define SC_R_DC_0_CAPTURE0              23
+#define SC_R_DC_0_CAPTURE1              24
+#define SC_R_DC_0_WARP                  25
+#define SC_R_DC_0_INTEGRAL0             26
+#define SC_R_DC_0_INTEGRAL1             27
+#define SC_R_DC_0_VIDEO0                28
+#define SC_R_DC_0_VIDEO1                29
+#define SC_R_DC_0_FRAC0                 30
+#define SC_R_DC_0_FRAC1                 31
+#define SC_R_DC_0                       32
+#define SC_R_GPU_2_PID0                 33
+#define SC_R_DC_0_PLL_0                 34
+#define SC_R_DC_0_PLL_1                 35
+#define SC_R_DC_1_BLIT0                 36
+#define SC_R_DC_1_BLIT1                 37
+#define SC_R_DC_1_BLIT2                 38
+#define SC_R_DC_1_BLIT_OUT              39
+#define SC_R_DC_1_CAPTURE0              40
+#define SC_R_DC_1_CAPTURE1              41
+#define SC_R_DC_1_WARP                  42
+#define SC_R_DC_1_INTEGRAL0             43
+#define SC_R_DC_1_INTEGRAL1             44
+#define SC_R_DC_1_VIDEO0                45
+#define SC_R_DC_1_VIDEO1                46
+#define SC_R_DC_1_FRAC0                 47
+#define SC_R_DC_1_FRAC1                 48
+#define SC_R_DC_1                       49
+#define SC_R_GPU_3_PID0                 50
+#define SC_R_DC_1_PLL_0                 51
+#define SC_R_DC_1_PLL_1                 52
+#define SC_R_SPI_0                      53
+#define SC_R_SPI_1                      54
+#define SC_R_SPI_2                      55
+#define SC_R_SPI_3                      56
+#define SC_R_UART_0                     57
+#define SC_R_UART_1                     58
+#define SC_R_UART_2                     59
+#define SC_R_UART_3                     60
+#define SC_R_UART_4                     61
+#define SC_R_EMVSIM_0                   62
+#define SC_R_EMVSIM_1                   63
+#define SC_R_DMA_0_CH0                  64
+#define SC_R_DMA_0_CH1                  65
+#define SC_R_DMA_0_CH2                  66
+#define SC_R_DMA_0_CH3                  67
+#define SC_R_DMA_0_CH4                  68
+#define SC_R_DMA_0_CH5                  69
+#define SC_R_DMA_0_CH6                  70
+#define SC_R_DMA_0_CH7                  71
+#define SC_R_DMA_0_CH8                  72
+#define SC_R_DMA_0_CH9                  73
+#define SC_R_DMA_0_CH10                 74
+#define SC_R_DMA_0_CH11                 75
+#define SC_R_DMA_0_CH12                 76
+#define SC_R_DMA_0_CH13                 77
+#define SC_R_DMA_0_CH14                 78
+#define SC_R_DMA_0_CH15                 79
+#define SC_R_DMA_0_CH16                 80
+#define SC_R_DMA_0_CH17                 81
+#define SC_R_DMA_0_CH18                 82
+#define SC_R_DMA_0_CH19                 83
+#define SC_R_DMA_0_CH20                 84
+#define SC_R_DMA_0_CH21                 85
+#define SC_R_DMA_0_CH22                 86
+#define SC_R_DMA_0_CH23                 87
+#define SC_R_DMA_0_CH24                 88
+#define SC_R_DMA_0_CH25                 89
+#define SC_R_DMA_0_CH26                 90
+#define SC_R_DMA_0_CH27                 91
+#define SC_R_DMA_0_CH28                 92
+#define SC_R_DMA_0_CH29                 93
+#define SC_R_DMA_0_CH30                 94
+#define SC_R_DMA_0_CH31                 95
+#define SC_R_I2C_0                      96
+#define SC_R_I2C_1                      97
+#define SC_R_I2C_2                      98
+#define SC_R_I2C_3                      99
+#define SC_R_I2C_4                      100
+#define SC_R_ADC_0                      101
+#define SC_R_ADC_1                      102
+#define SC_R_FTM_0                      103
+#define SC_R_FTM_1                      104
+#define SC_R_CAN_0                      105
+#define SC_R_CAN_1                      106
+#define SC_R_CAN_2                      107
+#define SC_R_DMA_1_CH0                  108
+#define SC_R_DMA_1_CH1                  109
+#define SC_R_DMA_1_CH2                  110
+#define SC_R_DMA_1_CH3                  111
+#define SC_R_DMA_1_CH4                  112
+#define SC_R_DMA_1_CH5                  113
+#define SC_R_DMA_1_CH6                  114
+#define SC_R_DMA_1_CH7                  115
+#define SC_R_DMA_1_CH8                  116
+#define SC_R_DMA_1_CH9                  117
+#define SC_R_DMA_1_CH10                 118
+#define SC_R_DMA_1_CH11                 119
+#define SC_R_DMA_1_CH12                 120
+#define SC_R_DMA_1_CH13                 121
+#define SC_R_DMA_1_CH14                 122
+#define SC_R_DMA_1_CH15                 123
+#define SC_R_DMA_1_CH16                 124
+#define SC_R_DMA_1_CH17                 125
+#define SC_R_DMA_1_CH18                 126
+#define SC_R_DMA_1_CH19                 127
+#define SC_R_DMA_1_CH20                 128
+#define SC_R_DMA_1_CH21                 129
+#define SC_R_DMA_1_CH22                 130
+#define SC_R_DMA_1_CH23                 131
+#define SC_R_DMA_1_CH24                 132
+#define SC_R_DMA_1_CH25                 133
+#define SC_R_DMA_1_CH26                 134
+#define SC_R_DMA_1_CH27                 135
+#define SC_R_DMA_1_CH28                 136
+#define SC_R_DMA_1_CH29                 137
+#define SC_R_DMA_1_CH30                 138
+#define SC_R_DMA_1_CH31                 139
+#define SC_R_UNUSED1                    140
+#define SC_R_UNUSED2                    141
+#define SC_R_UNUSED3                    142
+#define SC_R_UNUSED4                    143
+#define SC_R_GPU_0_PID0                 144
+#define SC_R_GPU_0_PID1                 145
+#define SC_R_GPU_0_PID2                 146
+#define SC_R_GPU_0_PID3                 147
+#define SC_R_GPU_1_PID0                 148
+#define SC_R_GPU_1_PID1                 149
+#define SC_R_GPU_1_PID2                 150
+#define SC_R_GPU_1_PID3                 151
+#define SC_R_PCIE_A                     152
+#define SC_R_SERDES_0                   153
+#define SC_R_MATCH_0                    154
+#define SC_R_MATCH_1                    155
+#define SC_R_MATCH_2                    156
+#define SC_R_MATCH_3                    157
+#define SC_R_MATCH_4                    158
+#define SC_R_MATCH_5                    159
+#define SC_R_MATCH_6                    160
+#define SC_R_MATCH_7                    161
+#define SC_R_MATCH_8                    162
+#define SC_R_MATCH_9                    163
+#define SC_R_MATCH_10                   164
+#define SC_R_MATCH_11                   165
+#define SC_R_MATCH_12                   166
+#define SC_R_MATCH_13                   167
+#define SC_R_MATCH_14                   168
+#define SC_R_PCIE_B                     169
+#define SC_R_SATA_0                     170
+#define SC_R_SERDES_1                   171
+#define SC_R_HSIO_GPIO                  172
+#define SC_R_MATCH_15                   173
+#define SC_R_MATCH_16                   174
+#define SC_R_MATCH_17                   175
+#define SC_R_MATCH_18                   176
+#define SC_R_MATCH_19                   177
+#define SC_R_MATCH_20                   178
+#define SC_R_MATCH_21                   179
+#define SC_R_MATCH_22                   180
+#define SC_R_MATCH_23                   181
+#define SC_R_MATCH_24                   182
+#define SC_R_MATCH_25                   183
+#define SC_R_MATCH_26                   184
+#define SC_R_MATCH_27                   185
+#define SC_R_MATCH_28                   186
+#define SC_R_LCD_0                      187
+#define SC_R_LCD_0_PWM_0                188
+#define SC_R_LCD_0_I2C_0                189
+#define SC_R_LCD_0_I2C_1                190
+#define SC_R_PWM_0                      191
+#define SC_R_PWM_1                      192
+#define SC_R_PWM_2                      193
+#define SC_R_PWM_3                      194
+#define SC_R_PWM_4                      195
+#define SC_R_PWM_5                      196
+#define SC_R_PWM_6                      197
+#define SC_R_PWM_7                      198
+#define SC_R_GPIO_0                     199
+#define SC_R_GPIO_1                     200
+#define SC_R_GPIO_2                     201
+#define SC_R_GPIO_3                     202
+#define SC_R_GPIO_4                     203
+#define SC_R_GPIO_5                     204
+#define SC_R_GPIO_6                     205
+#define SC_R_GPIO_7                     206
+#define SC_R_GPT_0                      207
+#define SC_R_GPT_1                      208
+#define SC_R_GPT_2                      209
+#define SC_R_GPT_3                      210
+#define SC_R_GPT_4                      211
+#define SC_R_KPP                        212
+#define SC_R_MU_0A                      213
+#define SC_R_MU_1A                      214
+#define SC_R_MU_2A                      215
+#define SC_R_MU_3A                      216
+#define SC_R_MU_4A                      217
+#define SC_R_MU_5A                      218
+#define SC_R_MU_6A                      219
+#define SC_R_MU_7A                      220
+#define SC_R_MU_8A                      221
+#define SC_R_MU_9A                      222
+#define SC_R_MU_10A                     223
+#define SC_R_MU_11A                     224
+#define SC_R_MU_12A                     225
+#define SC_R_MU_13A                     226
+#define SC_R_MU_5B                      227
+#define SC_R_MU_6B                      228
+#define SC_R_MU_7B                      229
+#define SC_R_MU_8B                      230
+#define SC_R_MU_9B                      231
+#define SC_R_MU_10B                     232
+#define SC_R_MU_11B                     233
+#define SC_R_MU_12B                     234
+#define SC_R_MU_13B                     235
+#define SC_R_ROM_0                      236
+#define SC_R_FSPI_0                     237
+#define SC_R_FSPI_1                     238
+#define SC_R_IEE                        239
+#define SC_R_IEE_R0                     240
+#define SC_R_IEE_R1                     241
+#define SC_R_IEE_R2                     242
+#define SC_R_IEE_R3                     243
+#define SC_R_IEE_R4                     244
+#define SC_R_IEE_R5                     245
+#define SC_R_IEE_R6                     246
+#define SC_R_IEE_R7                     247
+#define SC_R_SDHC_0                     248
+#define SC_R_SDHC_1                     249
+#define SC_R_SDHC_2                     250
+#define SC_R_ENET_0                     251
+#define SC_R_ENET_1                     252
+#define SC_R_MLB_0                      253
+#define SC_R_DMA_2_CH0                  254
+#define SC_R_DMA_2_CH1                  255
+#define SC_R_DMA_2_CH2                  256
+#define SC_R_DMA_2_CH3                  257
+#define SC_R_DMA_2_CH4                  258
+#define SC_R_USB_0                      259
+#define SC_R_USB_1                      260
+#define SC_R_USB_0_PHY                  261
+#define SC_R_USB_2                      262
+#define SC_R_USB_2_PHY                  263
+#define SC_R_DTCP                       264
+#define SC_R_NAND                       265
+#define SC_R_LVDS_0                     266
+#define SC_R_LVDS_0_PWM_0               267
+#define SC_R_LVDS_0_I2C_0               268
+#define SC_R_LVDS_0_I2C_1               269
+#define SC_R_LVDS_1                     270
+#define SC_R_LVDS_1_PWM_0               271
+#define SC_R_LVDS_1_I2C_0               272
+#define SC_R_LVDS_1_I2C_1               273
+#define SC_R_LVDS_2                     274
+#define SC_R_LVDS_2_PWM_0               275
+#define SC_R_LVDS_2_I2C_0               276
+#define SC_R_LVDS_2_I2C_1               277
+#define SC_R_M4_0_PID0                  278
+#define SC_R_M4_0_PID1                  279
+#define SC_R_M4_0_PID2                  280
+#define SC_R_M4_0_PID3                  281
+#define SC_R_M4_0_PID4                  282
+#define SC_R_M4_0_RGPIO                 283
+#define SC_R_M4_0_SEMA42                284
+#define SC_R_M4_0_TPM                   285
+#define SC_R_M4_0_PIT                   286
+#define SC_R_M4_0_UART                  287
+#define SC_R_M4_0_I2C                   288
+#define SC_R_M4_0_INTMUX                289
+#define SC_R_M4_0_SIM                   290
+#define SC_R_M4_0_WDOG                  291
+#define SC_R_M4_0_MU_0B                 292
+#define SC_R_M4_0_MU_0A0                293
+#define SC_R_M4_0_MU_0A1                294
+#define SC_R_M4_0_MU_0A2                295
+#define SC_R_M4_0_MU_0A3                296
+#define SC_R_M4_0_MU_1A                 297
+#define SC_R_M4_1_PID0                  298
+#define SC_R_M4_1_PID1                  299
+#define SC_R_M4_1_PID2                  300
+#define SC_R_M4_1_PID3                  301
+#define SC_R_M4_1_PID4                  302
+#define SC_R_M4_1_RGPIO                 303
+#define SC_R_M4_1_SEMA42                304
+#define SC_R_M4_1_TPM                   305
+#define SC_R_M4_1_PIT                   306
+#define SC_R_M4_1_UART                  307
+#define SC_R_M4_1_I2C                   308
+#define SC_R_M4_1_INTMUX                309
+#define SC_R_M4_1_SIM                   310
+#define SC_R_M4_1_WDOG                  311
+#define SC_R_M4_1_MU_0B                 312
+#define SC_R_M4_1_MU_0A0                313
+#define SC_R_M4_1_MU_0A1                314
+#define SC_R_M4_1_MU_0A2                315
+#define SC_R_M4_1_MU_0A3                316
+#define SC_R_M4_1_MU_1A                 317
+#define SC_R_SAI_0                      318
+#define SC_R_SAI_1                      319
+#define SC_R_SAI_2                      320
+#define SC_R_IRQSTR_SCU2                321
+#define SC_R_IRQSTR_DSP                 322
+#define SC_R_UNUSED5                    323
+#define SC_R_UNUSED6                    324
+#define SC_R_AUDIO_PLL_0                325
+#define SC_R_PI_0                       326
+#define SC_R_PI_0_PWM_0                 327
+#define SC_R_PI_0_PWM_1                 328
+#define SC_R_PI_0_I2C_0                 329
+#define SC_R_PI_0_PLL                   330
+#define SC_R_PI_1                       331
+#define SC_R_PI_1_PWM_0                 332
+#define SC_R_PI_1_PWM_1                 333
+#define SC_R_PI_1_I2C_0                 334
+#define SC_R_PI_1_PLL                   335
+#define SC_R_SC_PID0                    336
+#define SC_R_SC_PID1                    337
+#define SC_R_SC_PID2                    338
+#define SC_R_SC_PID3                    339
+#define SC_R_SC_PID4                    340
+#define SC_R_SC_SEMA42                  341
+#define SC_R_SC_TPM                     342
+#define SC_R_SC_PIT                     343
+#define SC_R_SC_UART                    344
+#define SC_R_SC_I2C                     345
+#define SC_R_SC_MU_0B                   346
+#define SC_R_SC_MU_0A0                  347
+#define SC_R_SC_MU_0A1                  348
+#define SC_R_SC_MU_0A2                  349
+#define SC_R_SC_MU_0A3                  350
+#define SC_R_SC_MU_1A                   351
+#define SC_R_SYSCNT_RD                  352
+#define SC_R_SYSCNT_CMP                 353
+#define SC_R_DEBUG                      354
+#define SC_R_SYSTEM                     355
+#define SC_R_SNVS                       356
+#define SC_R_OTP                        357
+#define SC_R_VPU_PID0                   358
+#define SC_R_VPU_PID1                   359
+#define SC_R_VPU_PID2                   360
+#define SC_R_VPU_PID3                   361
+#define SC_R_VPU_PID4                   362
+#define SC_R_VPU_PID5                   363
+#define SC_R_VPU_PID6                   364
+#define SC_R_VPU_PID7                   365
+#define SC_R_VPU_UART                   366
+#define SC_R_VPUCORE                    367
+#define SC_R_VPUCORE_0                  368
+#define SC_R_VPUCORE_1                  369
+#define SC_R_VPUCORE_2                  370
+#define SC_R_VPUCORE_3                  371
+#define SC_R_DMA_4_CH0                  372
+#define SC_R_DMA_4_CH1                  373
+#define SC_R_DMA_4_CH2                  374
+#define SC_R_DMA_4_CH3                  375
+#define SC_R_DMA_4_CH4                  376
+#define SC_R_ISI_CH0                    377
+#define SC_R_ISI_CH1                    378
+#define SC_R_ISI_CH2                    379
+#define SC_R_ISI_CH3                    380
+#define SC_R_ISI_CH4                    381
+#define SC_R_ISI_CH5                    382
+#define SC_R_ISI_CH6                    383
+#define SC_R_ISI_CH7                    384
+#define SC_R_MJPEG_DEC_S0               385
+#define SC_R_MJPEG_DEC_S1               386
+#define SC_R_MJPEG_DEC_S2               387
+#define SC_R_MJPEG_DEC_S3               388
+#define SC_R_MJPEG_ENC_S0               389
+#define SC_R_MJPEG_ENC_S1               390
+#define SC_R_MJPEG_ENC_S2               391
+#define SC_R_MJPEG_ENC_S3               392
+#define SC_R_MIPI_0                     393
+#define SC_R_MIPI_0_PWM_0               394
+#define SC_R_MIPI_0_I2C_0               395
+#define SC_R_MIPI_0_I2C_1               396
+#define SC_R_MIPI_1                     397
+#define SC_R_MIPI_1_PWM_0               398
+#define SC_R_MIPI_1_I2C_0               399
+#define SC_R_MIPI_1_I2C_1               400
+#define SC_R_CSI_0                      401
+#define SC_R_CSI_0_PWM_0                402
+#define SC_R_CSI_0_I2C_0                403
+#define SC_R_CSI_1                      404
+#define SC_R_CSI_1_PWM_0                405
+#define SC_R_CSI_1_I2C_0                406
+#define SC_R_HDMI                       407
+#define SC_R_HDMI_I2S                   408
+#define SC_R_HDMI_I2C_0                 409
+#define SC_R_HDMI_PLL_0                 410
+#define SC_R_HDMI_RX                    411
+#define SC_R_HDMI_RX_BYPASS             412
+#define SC_R_HDMI_RX_I2C_0              413
+#define SC_R_ASRC_0                     414
+#define SC_R_ESAI_0                     415
+#define SC_R_SPDIF_0                    416
+#define SC_R_SPDIF_1                    417
+#define SC_R_SAI_3                      418
+#define SC_R_SAI_4                      419
+#define SC_R_SAI_5                      420
+#define SC_R_GPT_5                      421
+#define SC_R_GPT_6                      422
+#define SC_R_GPT_7                      423
+#define SC_R_GPT_8                      424
+#define SC_R_GPT_9                      425
+#define SC_R_GPT_10                     426
+#define SC_R_DMA_2_CH5                  427
+#define SC_R_DMA_2_CH6                  428
+#define SC_R_DMA_2_CH7                  429
+#define SC_R_DMA_2_CH8                  430
+#define SC_R_DMA_2_CH9                  431
+#define SC_R_DMA_2_CH10                 432
+#define SC_R_DMA_2_CH11                 433
+#define SC_R_DMA_2_CH12                 434
+#define SC_R_DMA_2_CH13                 435
+#define SC_R_DMA_2_CH14                 436
+#define SC_R_DMA_2_CH15                 437
+#define SC_R_DMA_2_CH16                 438
+#define SC_R_DMA_2_CH17                 439
+#define SC_R_DMA_2_CH18                 440
+#define SC_R_DMA_2_CH19                 441
+#define SC_R_DMA_2_CH20                 442
+#define SC_R_DMA_2_CH21                 443
+#define SC_R_DMA_2_CH22                 444
+#define SC_R_DMA_2_CH23                 445
+#define SC_R_DMA_2_CH24                 446
+#define SC_R_DMA_2_CH25                 447
+#define SC_R_DMA_2_CH26                 448
+#define SC_R_DMA_2_CH27                 449
+#define SC_R_DMA_2_CH28                 450
+#define SC_R_DMA_2_CH29                 451
+#define SC_R_DMA_2_CH30                 452
+#define SC_R_DMA_2_CH31                 453
+#define SC_R_ASRC_1                     454
+#define SC_R_ESAI_1                     455
+#define SC_R_SAI_6                      456
+#define SC_R_SAI_7                      457
+#define SC_R_AMIX                       458
+#define SC_R_MQS_0                      459
+#define SC_R_DMA_3_CH0                  460
+#define SC_R_DMA_3_CH1                  461
+#define SC_R_DMA_3_CH2                  462
+#define SC_R_DMA_3_CH3                  463
+#define SC_R_DMA_3_CH4                  464
+#define SC_R_DMA_3_CH5                  465
+#define SC_R_DMA_3_CH6                  466
+#define SC_R_DMA_3_CH7                  467
+#define SC_R_DMA_3_CH8                  468
+#define SC_R_DMA_3_CH9                  469
+#define SC_R_DMA_3_CH10                 470
+#define SC_R_DMA_3_CH11                 471
+#define SC_R_DMA_3_CH12                 472
+#define SC_R_DMA_3_CH13                 473
+#define SC_R_DMA_3_CH14                 474
+#define SC_R_DMA_3_CH15                 475
+#define SC_R_DMA_3_CH16                 476
+#define SC_R_DMA_3_CH17                 477
+#define SC_R_DMA_3_CH18                 478
+#define SC_R_DMA_3_CH19                 479
+#define SC_R_DMA_3_CH20                 480
+#define SC_R_DMA_3_CH21                 481
+#define SC_R_DMA_3_CH22                 482
+#define SC_R_DMA_3_CH23                 483
+#define SC_R_DMA_3_CH24                 484
+#define SC_R_DMA_3_CH25                 485
+#define SC_R_DMA_3_CH26                 486
+#define SC_R_DMA_3_CH27                 487
+#define SC_R_DMA_3_CH28                 488
+#define SC_R_DMA_3_CH29                 489
+#define SC_R_DMA_3_CH30                 490
+#define SC_R_DMA_3_CH31                 491
+#define SC_R_AUDIO_PLL_1                492
+#define SC_R_AUDIO_CLK_0                493
+#define SC_R_AUDIO_CLK_1                494
+#define SC_R_MCLK_OUT_0                 495
+#define SC_R_MCLK_OUT_1                 496
+#define SC_R_PMIC_0                     497
+#define SC_R_PMIC_1                     498
+#define SC_R_SECO                       499
+#define SC_R_CAAM_JR1                   500
+#define SC_R_CAAM_JR2                   501
+#define SC_R_CAAM_JR3                   502
+#define SC_R_SECO_MU_2                  503
+#define SC_R_SECO_MU_3                  504
+#define SC_R_SECO_MU_4                  505
+#define SC_R_HDMI_RX_PWM_0              506
+#define SC_R_A35                        507
+#define SC_R_A35_0                      508
+#define SC_R_A35_1                      509
+#define SC_R_A35_2                      510
+#define SC_R_A35_3                      511
+#define SC_R_DSP                        512
+#define SC_R_DSP_RAM                    513
+#define SC_R_CAAM_JR1_OUT               514
+#define SC_R_CAAM_JR2_OUT               515
+#define SC_R_CAAM_JR3_OUT               516
+#define SC_R_VPU_DEC_0                  517
+#define SC_R_VPU_ENC_0                  518
+#define SC_R_CAAM_JR0                   519
+#define SC_R_CAAM_JR0_OUT               520
+#define SC_R_PMIC_2                     521
+#define SC_R_DBLOGIC                    522
+#define SC_R_HDMI_PLL_1                 523
+#define SC_R_BOARD_R0                   524
+#define SC_R_BOARD_R1                   525
+#define SC_R_BOARD_R2                   526
+#define SC_R_BOARD_R3                   527
+#define SC_R_BOARD_R4                   528
+#define SC_R_BOARD_R5                   529
+#define SC_R_BOARD_R6                   530
+#define SC_R_BOARD_R7                   531
+#define SC_R_MJPEG_DEC_MP               532
+#define SC_R_MJPEG_ENC_MP               533
+#define SC_R_VPU_TS_0                   534
+#define SC_R_VPU_MU_0                   535
+#define SC_R_VPU_MU_1                   536
+#define SC_R_VPU_MU_2                   537
+#define SC_R_VPU_MU_3                   538
+#define SC_R_VPU_ENC_1                  539
+#define SC_R_VPU                        540
+#define SC_R_LAST                       541
+
+#endif /* __DT_BINDINGS_RSCRC_IMX_H */
-- 
2.7.4
