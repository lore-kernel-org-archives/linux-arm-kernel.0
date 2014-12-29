From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:55 +0900
Subject: [PATCH 24/30] ARM: shmobile: ape6evm: synchronize dts with reference
 platform
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <326baa8029706ba6fbba9dd40f2310f718bfab4b.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

This moves everything to the legacy dts that is missing there in
preparation for the switch to multiplatform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 92 ++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index baca8f8..c98cd14 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -10,14 +10,19 @@
 
 /dts-v1/;
 #include "r8a73a4.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "APE6EVM";
 	compatible = "renesas,ape6evm", "renesas,r8a73a4";
 
+	aliases {
+		serial0 = &scifa0;
+	};
+
 	chosen {
 		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
+		stdout-path = &scifa0;
 	};
 
 	memory at 40000000 {
@@ -30,7 +35,27 @@
 		reg = <2 0x00000000 0 0x40000000>;
 	};
 
-	ape6evm_fixed_3v3: fixedregulator at 0 {
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
 		compatible = "regulator-fixed";
 		regulator-name = "3V3";
 		regulator-min-microvolt = <3300000>;
@@ -39,8 +64,10 @@
 	};
 
 	lbsc {
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		ranges = <0 0 0 0x20000000>;
 
 		ethernet at 8000000 {
 			compatible = "smsc,lan9220", "smsc,lan9115";
@@ -79,3 +106,64 @@
 	>;
 	voltage-tolerance = <1>; /* 1% */
 };
+
+&cmt1 {
+	status = "okay";
+};
+
+&pfc {
+	scifa0_pins: serial0 {
+		renesas,groups = "scifa0_data";
+		renesas,function = "scifa0";
+	};
+
+	mmc0_pins: mmc {
+		renesas,groups = "mmc0_data8", "mmc0_ctrl";
+		renesas,function = "mmc0";
+	};
+
+	sdhi0_pins: sd0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
+		renesas,function = "sdhi0";
+	};
+
+	sdhi1_pins: sd1 {
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
+&scifa0 {
+	pinctrl-0 = <&scifa0_pins>;
+	pinctrl-names = "default";
+
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
+};
-- 
2.1.3
