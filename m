From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 16 Oct 2015 14:37:01 -0700 (PDT)
Subject: [PATCH v2] ARM: shmobile: silk: add SDHI1 DT support
In-Reply-To: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
Message-ID: <2544073.SzFGJq3XZ1@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the SILK board dependent part of the SDHI1 (connected to micro-SD
slot) device nodes along with the necessary voltage regulators.

Based on the original patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20151015-v4.3-rc5' tag of Simon Horman's
'renesas.git' repo.

Changes in version 3:
- removed the "disable-wp" property;
- added empty line before the regulator nodes;
- reformatted the changelog;
- refreshed the patch.

Changes in version 2:
- removed non-working SDHI0 stuff, renamed the patch;
- replaced SDHI1's "wp-gpios" property with "disable-wp".

 arch/arm/boot/dts/r8a7794-silk.dts |   40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -12,6 +12,7 @@
 
 /dts-v1/;
 #include "r8a7794.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "SILK";
@@ -39,6 +40,30 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	vcc_sdhi1: regulator at 3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio4 26 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi1: regulator at 4 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
 };
 
 &extal_clk {
@@ -71,6 +96,11 @@
 		renesas,function = "mmc";
 	};
 
+	sdhi1_pins: sd1 {
+		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
+		renesas,function = "sdhi1";
+	};
+
 	qspi_pins: spi0 {
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
@@ -147,6 +177,16 @@
 	status = "okay";
 };
 
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi1>;
+	vqmmc-supply = <&vccq_sdhi1>;
+	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &qspi {
 	pinctrl-0 = <&qspi_pins>;
 	pinctrl-names = "default";
