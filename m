From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:34 +0100
Subject: [PATCH 15/16] arm: dts: enable the usb device on the mt7623n rfb
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-16-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All versions of the mt7623n RFB have an USB port so enable the device.
There is a gpio that gets used to power up the port supply. Add support
for this gpio using the fixed-regulator driver.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/boot/dts/mt7623.dtsi      |    1 +
 arch/arm/boot/dts/mt7623n-rfb.dtsi |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index b256ff51..388ba7f 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mt2701-clk.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt7623-pinfunc.h>
 #include <dt-bindings/power/mt2701-power.h>
diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index df9e564..777334a 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -28,6 +28,15 @@
 		serial1 = &uart1;
 		serial2 = &uart2;
 	};
+
+	usb_p1_vbus: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 135 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &uart0 {
@@ -41,3 +50,12 @@
 &uart2 {
 	status = "okay";
 };
+
+&usb1 {
+	vbus-supply = <&usb_p1_vbus>;
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
-- 
1.7.10.4
