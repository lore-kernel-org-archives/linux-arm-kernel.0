From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:15 +0900
Subject: [PATCH 02/24] ARM: shmobile: Sync Marzen DTS with Marzen reference DTS
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <bedd672409d68c98e717ac79f58b0ba155879275.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy the device nodes from Marzen reference into the Marzen device tree
file. This will allow us to use a single DTS file regardless of kernel
configuration. In case of legacy C board code the device nodes may or
may not be used, but in the multiplatform case all the DT device nodes
will be used.

Based on a similar change for the Lager board by Laurent Pinchart.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 94 ++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index a7af2c2..ddf9b9e 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -11,6 +11,8 @@
 
 /dts-v1/;
 #include "r8a7779.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "marzen";
@@ -24,4 +26,96 @@
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
+
+	fixedregulator3v3: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	lan0 at 18000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x18000000 0x100>;
+		pinctrl-0 = <&lan0_pins>;
+		pinctrl-names = "default";
+
+		phy-mode = "mii";
+		interrupt-parent = <&irqpin0>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		smsc,irq-push-pull;
+		reg-io-width = <4>;
+		vddvario-supply = <&fixedregulator3v3>;
+		vdd33a-supply = <&fixedregulator3v3>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led2 {
+			gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		};
+		led3 {
+			gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
+		};
+		led4 {
+			gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&irqpin0 {
+	status = "okay";
+};
+
+&pfc {
+	pinctrl-0 = <&scif2_pins &scif4_pins>;
+	pinctrl-names = "default";
+
+	lan0_pins: lan0 {
+		intc {
+			renesas,groups = "intc_irq1_b";
+			renesas,function = "intc";
+		};
+		lbsc {
+			renesas,groups = "lbsc_ex_cs0";
+			renesas,function = "lbsc";
+		};
+	};
+
+	scif2_pins: serial2 {
+		renesas,groups = "scif2_data_c";
+		renesas,function = "scif2";
+	};
+
+	scif4_pins: serial4 {
+		renesas,groups = "scif4_data";
+		renesas,function = "scif4";
+	};
+
+	sdhi0_pins: sd0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
+		renesas,function = "sdhi0";
+	};
+
+	hspi0_pins: hspi0 {
+		renesas,groups = "hspi0";
+		renesas,function = "hspi0";
+	};
+};
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&fixedregulator3v3>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&hspi0 {
+	pinctrl-0 = <&hspi0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
 };
-- 
2.0.0.rc2
