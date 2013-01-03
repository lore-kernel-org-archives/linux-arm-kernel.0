From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 Jan 2013 22:55:20 -0700
Subject: [PATCH 5/6] ARM: bcm2835: add I2C controllers to DT
In-Reply-To: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
References: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1357192521-13025-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM2835 has 3 identical I2C controllers. Instantiate them all in the
SoC .dtsi file, and enable the relevant two in the Raspberry Pi board
.dts file.

Note that on the Raspberry Pi Model B revision 1, I2C0 is connected to
the general-purpose expansion header, and I2C1 is connected to the camera
connector. Revision 2 of the board swaps these assignments:-(

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/boot/dts/bcm2835-rpi-b.dts |   10 ++++++++++
 arch/arm/boot/dts/bcm2835.dtsi      |   22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 0544ef8..aafda17 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -25,6 +25,16 @@
 	};
 };
 
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
 &sdhci {
 	status = "okay";
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 1d7e4f5..c69a591 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -64,6 +64,22 @@
 			#interrupt-cells = <2>;
 		};
 
+		i2c0: i2c at 20205000 {
+			compatible = "brcm,bcm2835-i2c";
+			reg = <0x7e205000 0x1000>;
+			interrupts = <2 21>;
+			clocks = <&clk_i2c>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 20804000 {
+			compatible = "brcm,bcm2835-i2c";
+			reg = <0x7e804000 0x1000>;
+			interrupts = <2 21>;
+			clocks = <&clk_i2c>;
+			status = "disabled";
+		};
+
 		sdhci: sdhci {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
@@ -73,6 +89,12 @@
 		};
 	};
 
+	clk_i2c: clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <150000000>;
+	};
+
 	clk_mmc: clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
1.7.10.4
