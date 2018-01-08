From: s.riedmueller@phytec.de (Stefan Riedmueller)
Date: Mon, 8 Jan 2018 15:29:13 +0100
Subject: [PATCH v4 1/6] ARM: dts: imx6: Add initial support for phyCORE-i.MX 6
 SOM
In-Reply-To: <1515421758-4240-1-git-send-email-s.riedmueller@phytec.de>
References: <1515421758-4240-1-git-send-email-s.riedmueller@phytec.de>
Message-ID: <1515421758-4240-2-git-send-email-s.riedmueller@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic support for PHYTEC phyCORE-i.MX 6 SOM with i.MX
6Quad/Dual or i.MX 6DualLight/Solo.

Signed-off-by: Christian Hemp <c.hemp@phytec.de>
Signed-off-by: Stefan Christ <s.christ@phytec.de>
Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi | 279 ++++++++++++++++++++++
 1 file changed, 279 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
new file mode 100644
index 0000000..6486df3
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 PHYTEC Messtechnik GmbH
+ * Author: Christian Hemp <c.hemp@phytec.de>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		rtc1 = &da9062_rtc;
+		rtc2 = &snvs_rtc;
+	};
+
+	/*
+	 * Set the minimum memory size here and
+	 * let the bootloader set the real size.
+	 */
+	memory at 10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x8000000>;
+	};
+
+	gpio_leds_som: somleds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpioleds_som>;
+
+		som-led-green {
+			label = "phycore:green";
+			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	m25p80: flash at 0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		status = "disabled";
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-handle = <&ethphy>;
+	phy-mode = "rgmii";
+	phy-supply = <&vdd_eth_io>;
+	phy-reset-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+	status = "disabled";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy at 3 {
+			reg = <3>;
+			txc-skew-ps = <1680>;
+			rxc-skew-ps = <1860>;
+		};
+	};
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "disabled";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+	};
+
+	pmic at 58 {
+		compatible = "dlg,da9062";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		reg = <0x58>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		da9062_rtc: rtc {
+			compatible = "dlg,da9062-rtc";
+		};
+
+		watchdog {
+			compatible = "dlg,da9062-watchdog";
+		};
+
+		regulators {
+			vdd_arm: buck1 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <730000>;
+				regulator-max-microvolt = <1380000>;
+				regulator-always-on;
+			};
+
+			vdd_soc: buck2 {
+				regulator-name = "vdd_soc";
+				regulator-min-microvolt = <730000>;
+				regulator-max-microvolt = <1380000>;
+				regulator-always-on;
+			};
+
+			vdd_ddr3_1p5: buck3 {
+				regulator-name = "vdd_ddr3";
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+			};
+
+			vdd_eth_1p2: buck4 {
+				regulator-name = "vdd_eth";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+			};
+
+			vdd_snvs: ldo1 {
+				regulator-name = "vdd_snvs";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+			};
+
+			vdd_high: ldo2 {
+				regulator-name = "vdd_high";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+			};
+
+			vdd_eth_io: ldo3 {
+				regulator-name = "vdd_eth_io";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+			};
+
+			vdd_emmc_1p8: ldo4 {
+				regulator-name = "vdd_emmc";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+		};
+	};
+};
+
+&reg_arm {
+	vin-supply = <&vdd_arm>;
+};
+
+&reg_pu {
+	vin-supply = <&vdd_soc>;
+};
+
+&reg_soc {
+	vin-supply = <&vdd_soc>;
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <8>;
+	non-removable;
+	vmmc-supply = <&vdd_emmc_1p8>;
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b0
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
+			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14		0x1b0b0
+		>;
+	};
+
+	pinctrl_gpioleds_som: gpioledssomgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b0
+		>;
+	};
+
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+			MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
+			MX6QDL_PAD_NANDF_CS2__NAND_CE2_B	0xb0b1
+			MX6QDL_PAD_NANDF_CS3__NAND_CE3_B	0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+			MX6QDL_PAD_SD4_DAT0__NAND_DQS		0x00b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		0x100b1
+			MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
+			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		0x100b1
+			MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x1b0b0
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
+		>;
+	};
+
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x17059
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x10059
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x17059
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x17059
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x17059
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17059
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x17059
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17059
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17059
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
+		>;
+	};
+};
-- 
2.7.4
