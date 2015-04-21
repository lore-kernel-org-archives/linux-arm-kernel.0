From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 11:09:50 -0700
Subject: [PATCH 3/9] ARM: Make a copy of the 2835 dts for the 2836.
In-Reply-To: <1429639796-2169-1-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
Message-ID: <1429639796-2169-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not hooked up to anything yet, but it means that our later
2836-specific changes will be more obvious.  The bcm2836-rpi-2-b.dts
actually comes from bcm2835-rpi-2-b-plus, which apparently is the
closest.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts | 30 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2836-rpi.dtsi    | 51 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2836.dtsi        | 31 +++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2836-rpi-2-b.dts
 create mode 100644 arch/arm/boot/dts/bcm2836-rpi.dtsi
 create mode 100644 arch/arm/boot/dts/bcm2836.dtsi

diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
new file mode 100644
index 0000000..668442b
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -0,0 +1,30 @@
+/dts-v1/;
+#include "bcm2835-rpi.dtsi"
+
+/ {
+	compatible = "raspberrypi,model-b-plus", "brcm,bcm2835";
+	model = "Raspberry Pi Model B+";
+
+	leds {
+		act {
+			gpios = <&gpio 47 0>;
+		};
+
+		pwr {
+			label = "PWR";
+			gpios = <&gpio 35 0>;
+			default-state = "keep";
+			linux,default-trigger = "default-on";
+		};
+	};
+};
+
+&gpio {
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
+
+	/* I2S interface */
+	i2s_alt0: i2s_alt0 {
+		brcm,pins = <18 19 20 21>;
+		brcm,function = <BCM2835_FSEL_ALT0>;
+	};
+};
diff --git a/arch/arm/boot/dts/bcm2836-rpi.dtsi b/arch/arm/boot/dts/bcm2836-rpi.dtsi
new file mode 100644
index 0000000..46780bb
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2836-rpi.dtsi
@@ -0,0 +1,51 @@
+#include "bcm2835.dtsi"
+
+/ {
+	memory {
+		reg = <0 0x10000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		act {
+			label = "ACT";
+			default-state = "keep";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&gpio {
+	pinctrl-names = "default";
+
+	gpioout: gpioout {
+		brcm,pins = <6>;
+		brcm,function = <BCM2835_FSEL_GPIO_OUT>;
+	};
+
+	alt0: alt0 {
+		brcm,pins = <0 1 2 3 4 5 7 8 9 10 11 14 15 40 45>;
+		brcm,function = <BCM2835_FSEL_ALT0>;
+	};
+
+	alt3: alt3 {
+		brcm,pins = <48 49 50 51 52 53>;
+		brcm,function = <BCM2835_FSEL_ALT3>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&sdhci {
+	status = "okay";
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
new file mode 100644
index 0000000..bdf9993
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -0,0 +1,31 @@
+#include <dt-bindings/pinctrl/bcm2835.h>
+#include "skeleton.dtsi"
+#include "bcm283x-common.dtsi"
+
+/ {
+	compatible = "brcm,bcm2835";
+	model = "BCM2835";
+	interrupt-parent = <&intc>;
+
+	chosen {
+		bootargs = "earlyprintk console=ttyAMA0";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x7e000000 0x20000000 0x02000000>;
+
+		timer at 7e003000 {
+			compatible = "brcm,bcm2835-system-timer";
+			reg = <0x7e003000 0x1000>;
+			interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
+			clock-frequency = <1000000>;
+		};
+
+		arm-pmu {
+			compatible = "arm,arm1176-pmu";
+		};
+	};
+};
-- 
2.1.4
