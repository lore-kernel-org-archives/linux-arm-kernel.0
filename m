From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Tue, 14 Oct 2014 06:43:23 +0000
Subject: [PATCH v2 1/1] ARM: dts: imx6x: Add enet2 support for imx6sx-sdb
 board
In-Reply-To: <1411893636-2741-1-git-send-email-b38611@freescale.com>
References: <1411893636-2741-1-git-send-email-b38611@freescale.com>
Message-ID: <342372e6e0774ab987d74d758692180e@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn,

How about the patch V2 ?

From: Fugang Duan <b38611@freescale.com> Sent: Sunday, September 28, 2014 4:41 PM
>To: Guo Shawn-R65073
>Cc: linux-arm-kernel at lists.infradead.org; b20596 at solarflare.com; Gong
>Yibin-B38343; Duan Fugang-B38611; shawn.guo at linaro.org;
>kernel at pengutronix.de
>Subject: [PATCH v2 1/1] ARM: dts: imx6x: Add enet2 support for imx6sx-sdb
>board
>
>Add enet2 support for imx6sx-sdb board, and add the "fsl,imx6q-fec"
>compatible for fec2 node to be compatible with the old version.
>
>V2:
>Add two fixed regulator for enet phy power supply.
>
>Signed-off-by: Fugang Duan <B38611@freescale.com>
>---
> arch/arm/boot/dts/imx6sx-sdb.dts |   62
>++++++++++++++++++++++++++++++++++++++
> arch/arm/boot/dts/imx6sx.dtsi    |    2 +-
> 2 files changed, 63 insertions(+), 1 deletions(-)
>
>diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-
>sdb.dts
>index 82d6b34..448489b 100644
>--- a/arch/arm/boot/dts/imx6sx-sdb.dts
>+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
>@@ -105,6 +105,30 @@
> 			gpio = <&gpio3 27 0>;
> 			enable-active-high;
> 		};
>+
>+		reg_peri_3v3: regulator at 5 {
>+			compatible = "regulator-fixed";
>+			reg = <5>;
>+			pinctrl-names = "default";
>+			pinctrl-0 = <&pinctrl_peri_3v3>;
>+			regulator-name = "peri_3v3";
>+			regulator-min-microvolt = <3300000>;
>+			regulator-max-microvolt = <3300000>;
>+			gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
>+			enable-active-high;
>+			regulator-always-on;
>+		};
>+
>+		reg_enet_3v3: regulator at 6 {
>+			compatible = "regulator-fixed";
>+			reg = <6>;
>+			pinctrl-names = "default";
>+			pinctrl-0 = <&pinctrl_enet_3v3>;
>+			regulator-name = "enet_3v3";
>+			regulator-min-microvolt = <3300000>;
>+			regulator-max-microvolt = <3300000>;
>+			gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
>+		};
> 	};
>
> 	sound {
>@@ -133,6 +157,14 @@
> &fec1 {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_enet1>;
>+	phy-supply = <&reg_enet_3v3>;
>+	phy-mode = "rgmii";
>+	status = "okay";
>+};
>+
>+&fec2 {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_enet2>;
> 	phy-mode = "rgmii";
> 	status = "okay";
> };
>@@ -394,6 +426,30 @@
> 				MX6SX_PAD_RGMII1_RD2__ENET1_RX_DATA_2	0x3081
> 				MX6SX_PAD_RGMII1_RD3__ENET1_RX_DATA_3	0x3081
> 				MX6SX_PAD_RGMII1_RX_CTL__ENET1_RX_EN	0x3081
>+				MX6SX_PAD_ENET2_RX_CLK__ENET2_REF_CLK_25M	0x91
>+			>;
>+		};
>+
>+		pinctrl_enet_3v3: enet3v3grp {
>+			fsl,pins = <
>+				MX6SX_PAD_ENET2_COL__GPIO2_IO_6
>	0x80000000
>+			>;
>+		};
>+
>+		pinctrl_enet2: enet2grp {
>+			fsl,pins = <
>+				MX6SX_PAD_RGMII2_TXC__ENET2_RGMII_TXC	0xa0b9
>+				MX6SX_PAD_RGMII2_TD0__ENET2_TX_DATA_0	0xa0b1
>+				MX6SX_PAD_RGMII2_TD1__ENET2_TX_DATA_1	0xa0b1
>+				MX6SX_PAD_RGMII2_TD2__ENET2_TX_DATA_2	0xa0b1
>+				MX6SX_PAD_RGMII2_TD3__ENET2_TX_DATA_3	0xa0b1
>+				MX6SX_PAD_RGMII2_TX_CTL__ENET2_TX_EN	0xa0b1
>+				MX6SX_PAD_RGMII2_RXC__ENET2_RX_CLK	0x3081
>+				MX6SX_PAD_RGMII2_RD0__ENET2_RX_DATA_0	0x3081
>+				MX6SX_PAD_RGMII2_RD1__ENET2_RX_DATA_1	0x3081
>+				MX6SX_PAD_RGMII2_RD2__ENET2_RX_DATA_2	0x3081
>+				MX6SX_PAD_RGMII2_RD3__ENET2_RX_DATA_3	0x3081
>+				MX6SX_PAD_RGMII2_RX_CTL__ENET2_RX_EN	0x3081
> 			>;
> 		};
>
>@@ -452,6 +508,12 @@
> 			>;
> 		};
>
>+		pinctrl_peri_3v3: peri3v3grp {
>+			fsl,pins = <
>+				MX6SX_PAD_QSPI1A_DATA0__GPIO4_IO_16	0x80000000
>+			>;
>+		};
>+
> 		pinctrl_pwm3: pwm3grp-1 {
> 			fsl,pins = <
> 				MX6SX_PAD_SD1_DATA2__PWM3_OUT 0x110b0 diff --git
>a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi index
>888dd76..5a36053 100644
>--- a/arch/arm/boot/dts/imx6sx.dtsi
>+++ b/arch/arm/boot/dts/imx6sx.dtsi
>@@ -875,7 +875,7 @@
> 			};
>
> 			fec2: ethernet at 021b4000 {
>-				compatible = "fsl,imx6sx-fec";
>+				compatible = "fsl,imx6sx-fec", "fsl,imx6q-fec";
> 				reg = <0x021b4000 0x4000>;
> 				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> 					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>--
>1.7.8
