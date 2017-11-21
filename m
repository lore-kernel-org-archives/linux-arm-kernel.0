From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Nov 2017 20:50:00 -0200
Subject: [PATCH 3/3] ARM: dts: imx6sx-sdb: Add PCIe support
In-Reply-To: <1511304601-1149-1-git-send-email-festevam@gmail.com>
References: <1511304601-1149-1-git-send-email-festevam@gmail.com>
Message-ID: <1511304601-1149-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Add support for PCIe support.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index d76b458..d57a41c 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -118,6 +118,17 @@
 		gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 	};
 
+	reg_pcie_gpio: regulator-pcie-gpio {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcie_reg>;
+		regulator-name = "MPCIE_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	sound {
 		compatible = "fsl,imx6sx-sdb-wm8962", "fsl,imx-audio-wm8962";
 		model = "wm8962-audio";
@@ -199,6 +210,14 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie_gpio>;
+	status = "okay";
+};
+
 &lcdif1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
@@ -440,6 +459,18 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_COL__GPIO2_IO_0 0x10b0
+			>;
+		};
+
+		pinctrl_pcie_reg: pciereggrp {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_CRS__GPIO2_IO_1	0x10b0
+			>;
+		};
+
 		pinctrl_peri_3v3: peri3v3grp {
 			fsl,pins = <
 				MX6SX_PAD_QSPI1A_DATA0__GPIO4_IO_16	0x80000000
-- 
2.7.4
