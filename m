From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 11 Dec 2017 21:39:12 +0100
Subject: [PATCH 3/3] ARM: dts: bcm283x: Define polarity of per-cpu interrupts
In-Reply-To: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
References: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1513024752-11246-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch define the polarity of the per-cpu interrupts on BCM2836
and BCM2837 in order to avoid the warnings from ARM arch timer code:

    arch_timer: WARNING: Invalid trigger for IRQ19, assuming level low
    arch_timer: WARNING: Please fix your firmware
    arch_timer: cp15 timer(s) running at 19.20MHz (virt).

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2836.dtsi | 14 +++++++-------
 arch/arm/boot/dts/bcm2837.dtsi | 12 ++++++------
 arch/arm/boot/dts/bcm283x.dtsi |  1 +
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
index 61e1580..1dfd764 100644
--- a/arch/arm/boot/dts/bcm2836.dtsi
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -13,24 +13,24 @@
 			compatible = "brcm,bcm2836-l1-intc";
 			reg = <0x40000000 0x100>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 			interrupt-parent = <&local_intc>;
 		};
 
 		arm-pmu {
 			compatible = "arm,cortex-a7-pmu";
 			interrupt-parent = <&local_intc>;
-			interrupts = <9>;
+			interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
 
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&local_intc>;
-		interrupts = <0>, // PHYS_SECURE_PPI
-			     <1>, // PHYS_NONSECURE_PPI
-			     <3>, // VIRT_PPI
-			     <2>; // HYP_PPI
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>, // PHYS_SECURE_PPI
+			     <1 IRQ_TYPE_LEVEL_HIGH>, // PHYS_NONSECURE_PPI
+			     <3 IRQ_TYPE_LEVEL_HIGH>, // VIRT_PPI
+			     <2 IRQ_TYPE_LEVEL_HIGH>; // HYP_PPI
 		always-on;
 	};
 
@@ -76,7 +76,7 @@
 	compatible = "brcm,bcm2836-armctrl-ic";
 	reg = <0x7e00b200 0x200>;
 	interrupt-parent = <&local_intc>;
-	interrupts = <8>;
+	interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &cpu_thermal {
diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index bc1cca5..efa7d33 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -12,7 +12,7 @@
 			compatible = "brcm,bcm2836-l1-intc";
 			reg = <0x40000000 0x100>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 			interrupt-parent = <&local_intc>;
 		};
 	};
@@ -20,10 +20,10 @@
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&local_intc>;
-		interrupts = <0>, // PHYS_SECURE_PPI
-			     <1>, // PHYS_NONSECURE_PPI
-			     <3>, // VIRT_PPI
-			     <2>; // HYP_PPI
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>, // PHYS_SECURE_PPI
+			     <1 IRQ_TYPE_LEVEL_HIGH>, // PHYS_NONSECURE_PPI
+			     <3 IRQ_TYPE_LEVEL_HIGH>, // VIRT_PPI
+			     <2 IRQ_TYPE_LEVEL_HIGH>; // HYP_PPI
 		always-on;
 	};
 
@@ -73,7 +73,7 @@
 	compatible = "brcm,bcm2836-armctrl-ic";
 	reg = <0x7e00b200 0x200>;
 	interrupt-parent = <&local_intc>;
-	interrupts = <8>;
+	interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &cpu_thermal {
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index e08203c..0d43bd4 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -2,6 +2,7 @@
 #include <dt-bindings/clock/bcm2835.h>
 #include <dt-bindings/clock/bcm2835-aux.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 /* firmware-provided startup stubs live here, where the secondary CPUs are
  * spinning.
-- 
2.7.4
