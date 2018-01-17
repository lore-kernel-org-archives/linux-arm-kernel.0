From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 17 Jan 2018 19:32:43 +0100
Subject: [PATCH 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180117183244.28303-1-l.stach@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
Message-ID: <20180117183244.28303-3-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the evaluation kit board for the i.MX8M. The current level of
support yields a working console and is able to boot userspace from
SD card or Network.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/nxp/Makefile       |   3 +
 arch/arm64/boot/dts/nxp/imx8mq-evk.dts | 287 +++++++++++++++++++++++++++++++++
 2 files changed, 290 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nxp/Makefile
 create mode 100644 arch/arm64/boot/dts/nxp/imx8mq-evk.dts

diff --git a/arch/arm64/boot/dts/nxp/Makefile b/arch/arm64/boot/dts/nxp/Makefile
new file mode 100644
index 000000000000..1aebb1f16708
--- /dev/null
+++ b/arch/arm64/boot/dts/nxp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_SOC_IMX8MQ) += imx8m-evk.dtb
diff --git a/arch/arm64/boot/dts/nxp/imx8mq-evk.dts b/arch/arm64/boot/dts/nxp/imx8mq-evk.dts
new file mode 100644
index 000000000000..ff77fdbcbfe3
--- /dev/null
+++ b/arch/arm64/boot/dts/nxp/imx8mq-evk.dts
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+
+#include "imx8mq.dtsi"
+
+/ {
+	model = "NXP i.MX8MQ EVK";
+	compatible = "nxp,imx8mq-evk", "nxp,imx8mq";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000 0 0xc0000000>;
+	};
+
+	reg_usdhc2_vmmc: usdhc2_vmmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2>;
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pfuze100 at 8 {
+		compatible = "fsl,pfuze100";
+		reg = <0x8>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <825000>;
+				regulator-max-microvolt = <1100000>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <825000>;
+				regulator-max-microvolt = <1100000>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3ab {
+				regulator-min-microvolt = <825000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <975000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1675000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1625000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <3075000>;
+				regulator-max-microvolt = <3625000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	vqmmc-supply = <&sw4_reg>;
+	bus-width = <8>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
+			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23
+			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
+			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
+			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
+			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
+			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
+			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
+			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
+			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
+			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
+			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
+			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
+			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
+		>;
+	};
+
+	pinctrl_reg_usdhc2: regusdhc2grpgpio {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
+			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+		};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+};
-- 
2.11.0
