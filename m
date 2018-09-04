From: edgar.righi@lsitec.org.br (Edgar Bernardi Righi)
Date: Tue, 4 Sep 2018 12:38:24 -0300
Subject: [PATCH v2 02/03] arm: dts: actions: Enable clock controller for
 Actions Semi S500 SoC
Message-ID: <CADHB5bAYs4QjhYVj--Vd5vVP0h5o8161St_=Yj2HfhFAR4U3eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable clock controller for Actions Semi S500 SoC on owl-s500 device tree.
Set UART clock reference from CMU for Actions Semi S500 SoC.
Tested on a Lemaker Guitar board.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>


diff --git a/arch/arm/boot/dts/owl-s500-cubieboard6.dts
b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
index 7c96c59b610d..4a91a29d2f29 100644
--- a/arch/arm/boot/dts/owl-s500-cubieboard6.dts
+++ b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
@@ -3,6 +3,7 @@
  * Cubietech CubieBoard6
  *
  * Copyright (c) 2017 Andreas F?rber
+ * Copyright (c) 2018 Edgar Bernardi Righi
  */

 /dts-v1/;
@@ -25,12 +26,6 @@
         device_type = "memory";
         reg = <0x0 0x80000000>;
     };
-
-    uart3_clk: uart3-clk {
-        compatible = "fixed-clock";
-        clock-frequency = <921600>;
-        #clock-cells = <0>;
-    };
 };

 &timer {
@@ -39,5 +34,4 @@

 &uart3 {
     status = "okay";
-    clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
index e610d49395d2..1a980ca6a426 100644
--- a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
+++ b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2016-2017 Andreas F?rber
+ * Copyright (c) 2018-2018 Edgar Bernardi Righi
  */

 /dts-v1/;
@@ -18,15 +19,8 @@
     chosen {
         stdout-path = "serial3:115200n8";
     };
-
-    uart3_clk: uart3-clk {
-        compatible = "fixed-clock";
-        clock-frequency = <921600>;
-        #clock-cells = <0>;
-    };
 };

 &uart3 {
     status = "okay";
-    clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-sparky.dts
b/arch/arm/boot/dts/owl-s500-sparky.dts
index c665ce8b88b4..65555afee584 100644
--- a/arch/arm/boot/dts/owl-s500-sparky.dts
+++ b/arch/arm/boot/dts/owl-s500-sparky.dts
@@ -3,6 +3,7 @@
  * Allo.com Sparky
  *
  * Copyright (c) 2017 Andreas F?rber
+ * Copyright (c) 2018-2018 Edgar Bernardi Righi
  */

 /dts-v1/;
@@ -25,12 +26,6 @@
         device_type = "memory";
         reg = <0x0 0x40000000>; /* 1 or 2 GiB */
     };
-
-    uart3_clk: uart3-clk {
-        compatible = "fixed-clock";
-        clock-frequency = <921600>;
-        #clock-cells = <0>;
-    };
 };

 &timer {
@@ -39,5 +34,4 @@

 &uart3 {
     status = "okay";
-    clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 5ceb6cc4451d..bf506038e22b 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -3,10 +3,12 @@
  * Actions Semi S500 SoC
  *
  * Copyright (c) 2016-2017 Andreas F?rber
+ * Copyright (c) 2018-2018 Edgar Bernardi Righi
  */

 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
+#include <dt-bindings/clock/actions,s500-cmu.h>

 / {
     compatible = "actions,s500";
@@ -69,6 +71,12 @@
         clock-frequency = <24000000>;
         #clock-cells = <0>;
     };
+
+    losc: losc {
+        compatible = "fixed-clock";
+        clock-frequency = <32678>;
+        #clock-cells = <0>;
+    };

     soc {
         compatible = "simple-bus";
@@ -124,6 +132,7 @@
             compatible = "actions,s500-uart", "actions,owl-uart";
             reg = <0xb0120000 0x2000>;
             interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu CLK_UART0>;
             status = "disabled";
         };

@@ -131,6 +140,7 @@
             compatible = "actions,s500-uart", "actions,owl-uart";
             reg = <0xb0122000 0x2000>;
             interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu CLK_UART1>;
             status = "disabled";
         };

@@ -138,6 +148,7 @@
             compatible = "actions,s500-uart", "actions,owl-uart";
             reg = <0xb0124000 0x2000>;
             interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu CLK_UART2>;
             status = "disabled";
         };

@@ -145,6 +156,7 @@
             compatible = "actions,s500-uart", "actions,owl-uart";
             reg = <0xb0126000 0x2000>;
             interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu CLK_UART3>;
             status = "disabled";
         };

@@ -152,6 +164,7 @@
             compatible = "actions,s500-uart", "actions,owl-uart";
             reg = <0xb0128000 0x2000>;
             interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu CLK_UART4>;
             status = "disabled";
         };

@@ -159,6 +172,7 @@
             compatible = "actions,s500-uart", "actions,owl-uart";
             reg = <0xb012a000 0x2000>;
             interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu CLK_UART5>;
             status = "disabled";
         };

@@ -166,8 +180,18 @@
             compatible = "actions,s500-uart", "actions,owl-uart";
             reg = <0xb012c000 0x2000>;
             interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu CLK_UART6>;
             status = "disabled";
         };
+
+        cmu: clock-controller at b0160000 {
+            compatible = "actions,s500-cmu";
+            reg = <0xb0160000 0x8000>;
+            clocks = <&hosc>, <&losc>;
+            clock-indices = <CLK_UART0>, <CLK_UART1>, <CLK_UART2>,
+                            <CLK_UART3>, <CLK_UART4>, <CLK_UART5>, <CLK_UART6>;
+            #clock-cells = <1>;
+        };

         timer: timer at b0168000 {
             compatible = "actions,s500-timer";
