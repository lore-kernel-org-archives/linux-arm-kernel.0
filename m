From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue,  8 Jul 2014 16:42:24 +0200
Subject: [PATCH 1/2] ARM: Kirkwood: allow to use netxbig DTSI for d2net_v2 DTS
In-Reply-To: <1404830545-15581-1-git-send-email-simon.guinot@sequanux.org>
References: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
 <1404830545-15581-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1404830545-15581-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The d2 Network v2 board (d2net_v2) shares a lot of hardware
characteristics with the 2Big and 5Big Network v2 boards. This patch
prepares the kirkwood-netxbig.dtsi file in order to allow to include it
from the d2net_v2 DTS file. The DT nodes only relevant for the 2Big and
5Big Network v2 boards are moved into their respective DTS files.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 arch/arm/boot/dts/kirkwood-net2big.dts  | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-net5big.dts  | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-netxbig.dtsi | 26 --------------------------
 3 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/kirkwood-net2big.dts
index a98deccee59f..53dc37a3b687 100644
--- a/arch/arm/boot/dts/kirkwood-net2big.dts
+++ b/arch/arm/boot/dts/kirkwood-net2big.dts
@@ -28,3 +28,33 @@
 		reg = <0x00000000 0x10000000>;
 	};
 };
+
+&regulators {
+	regulator at 2 {
+		compatible = "regulator-fixed";
+		reg = <2>;
+		regulator-name = "hdd1power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+	};
+
+	clocks {
+	       g762_clk: g762-oscillator {
+			 compatible = "fixed-clock";
+			 #clock-cells = <0>;
+			 clock-frequency = <32768>;
+	       };
+	};
+};
+
+&i2c0 {
+	g762 at 3e {
+		compatible = "gmt,g762";
+		reg = <0x3e>;
+		clocks = <&g762_clk>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-net5big.dts b/arch/arm/boot/dts/kirkwood-net5big.dts
index d2887ed493f2..36155b749d9f 100644
--- a/arch/arm/boot/dts/kirkwood-net5big.dts
+++ b/arch/arm/boot/dts/kirkwood-net5big.dts
@@ -31,6 +31,18 @@
 };
 
 &regulators {
+	regulator at 2 {
+		compatible = "regulator-fixed";
+		reg = <2>;
+		regulator-name = "hdd1power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+	};
+
 	regulator at 3 {
 		compatible = "regulator-fixed";
 		reg = <3>;
@@ -66,6 +78,14 @@
 		regulator-boot-on;
 		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 	};
+
+	clocks {
+	       g762_clk: g762-oscillator {
+			 compatible = "fixed-clock";
+			 #clock-cells = <0>;
+			 clock-frequency = <32768>;
+	       };
+	};
 };
 
 &mdio {
@@ -81,3 +101,11 @@
 	};
 };
 
+
+&i2c0 {
+	g762 at 3e {
+		compatible = "gmt,g762";
+		reg = <0x3e>;
+		clocks = <&g762_clk>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-netxbig.dtsi b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
index fd75720547e3..b0cfb7cd30b9 100644
--- a/arch/arm/boot/dts/kirkwood-netxbig.dtsi
+++ b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
@@ -104,26 +104,6 @@
 			regulator-boot-on;
 			gpio = <&gpio0 16 GPIO_ACTIVE_HIGH>;
 		};
-
-		regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "hdd1power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
-		};
-
-		clocks {
-		       g762_clk: g762-oscillator {
-				 compatible = "fixed-clock";
-				 #clock-cells = <0>;
-				 clock-frequency = <32768>;
-		       };
-		};
 	};
 };
 
@@ -171,10 +151,4 @@
 		pagesize = <16>;
 		reg = <0x50>;
 	};
-
-	g762 at 3e {
-		compatible = "gmt,g762";
-		reg = <0x3e>;
-		clocks = <&g762_clk>;
-	};
 };
-- 
2.0.0.rc2
