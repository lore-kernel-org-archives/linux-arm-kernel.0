From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 07 Oct 2015 02:05:41 +0300
Subject: [PATCH] ARM: shmobile: porter: add SDHI0/2 DT support
Message-ID: <2228837.DO5U5OvRSi@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Porter board dependent part of the SDHI0/2 device nodes along with
the  necessary  voltage regulators (note that the Vcc regulators are dummy --
they are required but don't actually exist on the board). Also, GPIOs have to
be used for the CD and WP signals due to the SDHI driver constraints...

This patch is analogous to the commit 1299df03d719 (ARM: shmobile: henninger:
add SDHI0/2 DT support) as there  are no differences between those boards in
this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20151006-v4.3-rc4' tag of Simon
Horman's 'renesas.git' repo.

 arch/arm/boot/dts/r8a7791-porter.dts |   76 +++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "r8a7791.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Porter";
@@ -33,6 +34,50 @@
 		device_type = "memory";
 		reg = <2 0x00000000 0 0x40000000>;
 	};
+
+	vcc_sdhi0: regulator at 0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vccq_sdhi0: regulator at 1 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio2 12 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+
+	vcc_sdhi2: regulator at 2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI2 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vccq_sdhi2: regulator at 3 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI2 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
 };
 
 &extal_clk {
@@ -54,6 +99,16 @@
 		renesas,groups = "intc_irq0";
 		renesas,function = "intc";
 	};
+
+	sdhi0_pins: sd0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
+		renesas,function = "sdhi0";
+	};
+
+	sdhi2_pins: sd2 {
+		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,function = "sdhi2";
+	};
 };
 
 &scif0 {
@@ -78,3 +133,24 @@
 		micrel,led-mode = <1>;
 	};
 };
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&sdhi2 {
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi2>;
+	vqmmc-supply = <&vccq_sdhi2>;
+	cd-gpios = <&gpio6 22 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
