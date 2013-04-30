From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 30 Apr 2013 19:24:35 +0200
Subject: [PATCH] ARM: dove: add si5351 clock driver to CuBox DT
Message-ID: <1367342675-15312-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree node for si5351 clock generator
and the corresponding oscillator connected to it. It also limits
i2c frequency to 100kHz as there are bus locks reported on higher
frequencies.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove-cubox.dts |   51 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 7e3065a..5cae2ab 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -44,11 +44,60 @@
 			gpio = <&gpio0 1 0>;
 		};
 	};
+
+	clocks {
+		/* 25MHz reference crystal */
+		ref25: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
+	};
 };
 
 &uart0 { status = "okay"; };
 &sata0 { status = "okay"; };
-&i2c0 { status = "okay"; };
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	si5351: clock-generator {
+		compatible = "silabs,si5351a-msop";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#clock-cells = <1>;
+
+		/* connect xtal input to 25MHz reference */
+		clocks = <&ref25>;
+
+		/* connect xtal input as source of pll0 and pll1 */
+		silabs,pll-source = <0 0>, <1 0>;
+
+		clkout0 {
+			reg = <0>;
+			silabs,drive-strength = <8>;
+			silabs,multisynth-source = <0>;
+			silabs,clock-source = <0>;
+			silabs,pll-master;
+		};
+
+		clkout1 {
+			reg = <1>;
+			silabs,drive-strength = <8>;
+			silabs,multisynth-source = <1>;
+			silabs,clock-source = <0>;
+			silabs,pll-master;
+		};
+
+		clkout2 {
+			reg = <2>;
+			silabs,multisynth-source = <1>;
+			silabs,clock-source = <0>;
+		};
+	};
+};
 
 &sdio0 {
 	status = "okay";
-- 
1.7.2.5
