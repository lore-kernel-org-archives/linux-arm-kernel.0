From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 21:45:34 +0100
Subject: [PATCH 5/6] ARM: nomadik: push ethernet down to board
In-Reply-To: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
References: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1414788335-28334-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoC file defines the location and type of the ethernet
adapter, this should be in the per-board file, as it is by no
means necessary to have an ethernet adapter connected to this
memory space.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 24 ++++++++++++++++--------
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 12 ------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index 33caad8df276..e411ff7769fe 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -4,6 +4,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "ste-nomadik-stn8815.dtsi"
 
 / {
@@ -14,14 +15,6 @@
 		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
 	};
 
-	/* This is where the interrupt is routed on the S8815 board */
-	external-bus at 34000000 {
-		ethernet at 300 {
-			interrupt-parent = <&gpio3>;
-			interrupts = <8 0x1>;
-		};
-	};
-
 	src at 101e0000 {
 		/* These chrystal drivers are not used on this board */
 		disable-sxtalo;
@@ -73,6 +66,21 @@
 		};
 	};
 
+	/* Ethernet */
+	external-bus at 34000000 {
+		compatible = "simple-bus";
+		reg = <0x34000000 0x1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x34000000 0x1000000>;
+		ethernet at 300 {
+			compatible = "smsc,lan91c111";
+			reg = <0x300 0x0fd00>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <8 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
 	/* GPIO I2C connected to the USB portions of the STw4811 only */
 	gpio-i2c {
 		compatible = "i2c-gpio";
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index c638c1ce2fc4..f435ff20aefe 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -673,18 +673,6 @@
 		};
 	};
 
-	external-bus at 34000000 {
-		compatible = "simple-bus";
-		reg = <0x34000000 0x1000000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x34000000 0x1000000>;
-		ethernet at 300 {
-			compatible = "smsc,lan91c111";
-			reg = <0x300 0x0fd00>;
-		};
-	};
-
 	/* I2C0 connected to the STw4811 power management chip */
 	i2c0 {
 		compatible = "st,nomadik-i2c", "arm,primecell";
-- 
1.9.3
