From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 23 Jul 2014 19:29:11 +0200
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: add always on pcie regulator
Message-ID: <1406136551-8015-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Everything in the PCI specification assumes devices to be
enumerable on startup. This is only possible if they have
power available.

A future improvement may allow this regulator to be switched
off for D3hot and D3cold power states, but there is a lot
of work to do the pcie host controller side for this to work.
To keep things simple always enable the regulator for now.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: - rename to MPCIE_3V3
    - add proper pinctrl
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 40ea36534643..f35c06102969 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -54,6 +54,19 @@
 			gpio = <&gpio4 10 0>;
 			enable-active-high;
 		};
+
+		reg_pcie: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_pcie_reg>;
+			regulator-name = "MPCIE_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 19 0>;
+			regulator-always-on;
+			enable-active-high;
+		};
 	};
 
 	gpio-keys {
@@ -399,6 +412,12 @@
 			>;
 		};
 
+		pinctrl_pcie_reg: pciereggrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x1b0b0
+			>;
+		};
+
 		pinctrl_pwm1: pwm1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_DAT3__PWM1_OUT		0x1b0b1
-- 
2.0.1
