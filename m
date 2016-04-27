From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Apr 2016 14:20:29 +1000
Subject: [PATCH 02/10] ARM: dts: r8a7790: Add SYSC PM Domains
In-Reply-To: <cover.1461730638.git.horms+renesas@verge.net.au>
References: <cover.1461730638.git.horms+renesas@verge.net.au>
Message-ID: <4c8eb3c8896d842d3fb4802dc6e5f39733596733.1461730638.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller.
Hook up the Cortex-A15 and Cortex-A7 CPU cores and L2 caches/SCUs to
their respective PM Domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 776a2aed81d2..36c91d921771 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/clock/r8a7790-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a7790-sysc.h>
 
 / {
 	compatible = "renesas,r8a7790";
@@ -52,6 +53,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7790_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			power-domains = <&sysc R8A7790_PD_CA15_CPU0>;
 			next-level-cache = <&L2_CA15>;
 
 			/* kHz - uV - OPPs unknown yet */
@@ -68,6 +70,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+			power-domains = <&sysc R8A7790_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
 		};
 
@@ -76,6 +79,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+			power-domains = <&sysc R8A7790_PD_CA15_CPU2>;
 			next-level-cache = <&L2_CA15>;
 		};
 
@@ -84,6 +88,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+			power-domains = <&sysc R8A7790_PD_CA15_CPU3>;
 			next-level-cache = <&L2_CA15>;
 		};
 
@@ -92,6 +97,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+			power-domains = <&sysc R8A7790_PD_CA7_CPU0>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -100,6 +106,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+			power-domains = <&sysc R8A7790_PD_CA7_CPU1>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -108,6 +115,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+			power-domains = <&sysc R8A7790_PD_CA7_CPU2>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -116,6 +124,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+			power-domains = <&sysc R8A7790_PD_CA7_CPU3>;
 			next-level-cache = <&L2_CA7>;
 		};
 	};
@@ -141,12 +150,14 @@
 
 	L2_CA15: cache-controller at 0 {
 		compatible = "cache";
+		power-domains = <&sysc R8A7790_PD_CA15_SCU>;
 		cache-unified;
 		cache-level = <2>;
 	};
 
 	L2_CA7: cache-controller at 1 {
 		compatible = "cache";
+		power-domains = <&sysc R8A7790_PD_CA7_SCU>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -1450,6 +1461,12 @@
 		};
 	};
 
+	sysc: system-controller at e6180000 {
+		compatible = "renesas,r8a7790-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		#power-domain-cells = <1>;
+	};
+
 	qspi: spi at e6b10000 {
 		compatible = "renesas,qspi-r8a7790", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-- 
2.7.0.rc3.207.g0ac5344
