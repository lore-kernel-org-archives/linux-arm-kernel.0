From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 17 Dec 2013 19:42:27 +0000
Subject: [PATCH 1/2] ARM: imx: initial SolidRun HummingBoard support
In-Reply-To: <20131217194130.GA4360@n2100.arm.linux.org.uk>
References: <20131217194130.GA4360@n2100.arm.linux.org.uk>
Message-ID: <E1Vt0XD-0007Bq-OM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the SolidRun HummingBoard.  This commit adds support for
the following interfaces on this board:

- Consumer Ir receiver
- S/PDIF output
- Both USB interfaces
- Gigabit Ethernet using AR8035
- UART port

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/imx6dl-hummingboard.dts      |   90 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi |   58 +++++++++++++++
 arch/arm/boot/dts/imx6qdl-microsom.dtsi        |   80 +++++++++++++++++++++
 arch/arm/mach-imx/mach-imx6q.c                 |   35 +++++++++
 5 files changed, 264 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-microsom.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d57c1a65b24f..875af333c6dc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -136,6 +136,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
 	imx53-smd.dtb \
+	imx6dl-hummingboard.dtb \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabresd.dtb \
 	imx6dl-wandboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/imx6dl-hummingboard.dts
new file mode 100644
index 000000000000..6184b0366926
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-hummingboard.dts
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2013 Russell King
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License version 2.
+ */
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-microsom.dtsi"
+#include "imx6qdl-microsom-ar8035.dtsi"
+
+/ {
+	model = "SolidRun HummingBoard DL/Solo";
+	compatible = "solidrun,hummingboard", "fsl,imx6dl";
+
+	ir_recv: ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio1 2 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard_gpio1_2>;
+	};
+
+	codec: spdif-transmitter {
+		compatible = "linux,spdif-dit";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard_spdif>;
+	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		/* IMX6 doesn't implement this yet */
+		spdif-controller = <&spdif>;
+		spdif-out;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+
+	/*
+	 * Not fitted on Carrier-1 board... yet
+	status = "okay";
+
+	rtc: pcf8523 at 68 {
+		compatible = "nxp,pcf8523";
+		reg = <0x68>;
+	};
+	 */
+};
+
+&iomuxc {
+	hummingboard {
+		pinctrl_hummingboard_gpio1_2: hummingboard-gpio1_2 {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x80000000
+			>;
+		};
+
+		pinctrl_hummingboard_spdif: hummingboard-spdif {
+			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0>;
+		};
+
+		pinctrl_hummingboard_usdhc2: hummingboard-usdhc2 {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
+				MX6QDL_PAD_GPIO_4__SD2_CD_B    0x1f071
+			>;
+		};
+	};
+};
+
+&spdif {
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard_usdhc2>;
+	vmmc-supply = <&reg_3p3v>;
+	fsl,cd-controller;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
new file mode 100644
index 000000000000..c1be487dfc62
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
@@ -0,0 +1,58 @@
+/*
+ * Copyright 2013 Russell King
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License version 2.
+ *
+ * This describes the hookup for an AR8035 to the IMX6 on the Cubox-i
+ * MicroSOM.
+ *
+ * FIXME: we need to configure PLL_ENET to produce 25MHz, but there
+ * doesn't seem to be a way to do that yet from DT.  (Writing 0x2000
+ * to 0x020c80e0 phys will do this.)
+ */
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
+	phy-mode = "rgmii";
+	phy-reset-duration = <2>;
+	phy-reset-gpios = <&gpio4 15 0>;
+	status = "okay";
+};
+
+&iomuxc {
+	enet {
+		pinctrl_microsom_enet_ar8035: microsom-enet-ar8035 {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+				/* AR8035 reset */
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x130b0
+				/* AR8035 interrupt */
+				MX6QDL_PAD_DI0_PIN2__GPIO4_IO18		0x80000000
+				/* GPIO16 -> AR8035 25MHz */
+				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0xc0000000
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x80000000
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
+				/* AR8035 CLK_25M --> ENET_REF_CLK (V22) */
+				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x0a0b1
+				/* AR8035 pin strapping: IO voltage: pull up */
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
+				/* AR8035 pin strapping: PHYADDR#0: pull down */
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x130b0
+				/* AR8035 pin strapping: PHYADDR#1: pull down */
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x130b0
+				/* AR8035 pin strapping: MODE#1: pull up */
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
+				/* AR8035 pin strapping: MODE#3: pull up */
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
+				/* AR8035 pin strapping: MODE#0: pull down */
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x130b0
+			>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qdl-microsom.dtsi b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
new file mode 100644
index 000000000000..8aa31a842236
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
@@ -0,0 +1,80 @@
+/*
+ * Copyright 2013 Russell King
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License version 2.
+ */
+/ {
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_usb_h1_vbus: usb_h1_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio1 0 0>;
+			enable-active-high;
+		};
+
+		reg_usb_otg_vbus: usb_otg_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 22 0>;
+			enable-active-high;
+		};
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_microsom_flexcan1>;
+	status = "okay";
+};
+
+&iomuxc {
+	microsom {
+		pinctrl_microsom_flexcan1: microsom-flexcan1 {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX 0x80000000
+				MX6QDL_PAD_SD3_CMD__FLEXCAN1_TX 0x80000000
+			>;
+		};
+
+		pinctrl_microsom_usbotg: microsom-usbotg {
+			/*
+			 * Similar to pinctrl_usbotg_2, but we want it
+			 * pulled down for a fixed host connection.
+			 */
+			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_microsom_usbotg>;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index d0cfb225ec9a..cb6fa3d61243 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -103,6 +103,39 @@ static int ar8031_phy_fixup(struct phy_device *dev)
 
 #define PHY_ID_AR8031	0x004dd074
 
+static int ar8035_phy_fixup(struct phy_device *dev)
+{
+	u16 val;
+
+	/* Ar803x phy SmartEEE feature cause link status generates glitch,
+	 * which cause ethernet link down/up issue, so disable SmartEEE
+	 */
+	phy_write(dev, 0xd, 0x3);
+	phy_write(dev, 0xe, 0x805d);
+	phy_write(dev, 0xd, 0x4003);
+
+	val = phy_read(dev, 0xe);
+	phy_write(dev, 0xe, val & ~(1 << 8));
+
+	/*
+	 * Enable 125MHz clock from CLK_25M on the AR8031.  This
+	 * is fed in to the IMX6 on the ENET_REF_CLK (V22) pad.
+	 * Also, introduce a tx clock delay.
+	 *
+	 * This is the same as is the AR8031 fixup.
+	 */
+	ar8031_phy_fixup(dev);
+
+	/*check phy power*/
+	val = phy_read(dev, 0x0);
+	if (val & BMCR_PDOWN)
+		phy_write(dev, 0x0, val & ~BMCR_PDOWN);
+
+	return 0;
+}
+
+#define PHY_ID_AR8035 0x004dd072
+
 static void __init imx6q_enet_phy_init(void)
 {
 	if (IS_BUILTIN(CONFIG_PHYLIB)) {
@@ -112,6 +145,8 @@ static void __init imx6q_enet_phy_init(void)
 				ksz9031rn_phy_fixup);
 		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffff,
 				ar8031_phy_fixup);
+		phy_register_fixup_for_uid(PHY_ID_AR8035, 0xffffffef,
+				ar8035_phy_fixup);
 	}
 }
 
-- 
1.7.4.4
