From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:34:12 +0900
Subject: [PATCH 1/7] ARM: shmobile: porter: add SDHI0/2 DT support
In-Reply-To: <cover.1444868963.git.horms+renesas@verge.net.au>
References: <cover.1444868963.git.horms+renesas@verge.net.au>
Message-ID: <b941a5cbe10201afa937fba90d68d7af6093d3d4.1444868963.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Porter board dependent part of the SDHI0/2 device nodes along
with the  necessary  voltage regulators (note that the Vcc regulators are
dummy -- they are required but don't actually exist on the board). Also,
GPIOs have to be used for the CD and WP signals due to the SDHI driver
constraints...

This patch is analogous to the commit 1299df03d719 ("ARM: shmobile:
henninger: add SDHI0/2 DT support") as there  are no differences between
those boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index ca59ff861923..5bc4d23c1edb 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
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
-- 
2.1.4
