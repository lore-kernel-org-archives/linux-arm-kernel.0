From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:39:19 +0900
Subject: [PATCH 1/3] ARM: shmobile: ape6evm-reference: add MMCIF and SDHI DT
 nodes
In-Reply-To: <cover.1380530263.git.horms+renesas@verge.net.au>
References: <cover.1380530263.git.horms+renesas@verge.net.au>
Message-ID: <dbffb5a1525dc88f1c871c48574634f14845b43d.1380530263.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This patch adds MMCIF0, SDHI0 and SDHI1 DT nodes and a fixed voltage
reglator for them to the ape6evm-reference platform.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 72 +++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index f444624..2b49b05 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 /include/ "r8a73a4.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "APE6EVM";
@@ -24,6 +25,34 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
+	vcc_mmc0: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "MMC0 Vcc";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	vcc_sdhi0: regulator at 1 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pfc 76 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/* Common 3.3V rail, used by several devices on APE6EVM */
+	ape6evm_fixed_3v3: regulator at 2 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	lbsc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -62,4 +91,47 @@
 		renesas,groups = "scifa0_data";
 		renesas,function = "scifa0";
 	};
+
+	mmc0_pins: mmcif {
+		renesas,groups = "mmc0_data8", "mmc0_ctrl";
+		renesas,function = "mmc0";
+	};
+
+	sdhi0_pins: sdhi0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
+		renesas,function = "sdhi0";
+	};
+
+	sdhi1_pins: sdhi1 {
+		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
+		renesas,function = "sdhi1";
+	};
+};
+
+&mmcif0 {
+	vmmc-supply = <&vcc_mmc0>;
+	bus-width = <8>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	status = "okay";
+};
+
+&sdhi0 {
+	vmmc-supply = <&vcc_sdhi0>;
+	bus-width = <4>;
+	toshiba,mmc-wrprotect-disable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhi0_pins>;
+	status = "okay";
+};
+
+&sdhi1 {
+	vmmc-supply = <&ape6evm_fixed_3v3>;
+	bus-width = <4>;
+	broken-cd;
+	toshiba,mmc-wrprotect-disable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhi1_pins>;
+	status = "okay";
 };
-- 
1.8.4
