From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 15 Feb 2016 22:16:56 +0100
Subject: [PATCH/RFC v2 07/11] ARM: dts: r8a7790: Add SYSC PM domains
In-Reply-To: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1455571020-18968-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up the Cortex-A15 and Cortex-A7 CPU cores and L2 caches/SCUs to
their respective PM domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7790.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e40aa6585831c520..3e5a97c70480cbbc 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -52,6 +52,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7790_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			power-domains = <&pd_ca15_cpu0>;
 			next-level-cache = <&L2_CA15>;
 
 			/* kHz - uV - OPPs unknown yet */
@@ -68,6 +69,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+			power-domains = <&pd_ca15_cpu1>;
 			next-level-cache = <&L2_CA15>;
 		};
 
@@ -76,6 +78,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+			power-domains = <&pd_ca15_cpu2>;
 			next-level-cache = <&L2_CA15>;
 		};
 
@@ -84,6 +87,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+			power-domains = <&pd_ca15_cpu3>;
 			next-level-cache = <&L2_CA15>;
 		};
 
@@ -92,6 +96,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+			power-domains = <&pd_ca7_cpu0>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -100,6 +105,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+			power-domains = <&pd_ca7_cpu1>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -108,6 +114,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+			power-domains = <&pd_ca7_cpu2>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -116,18 +123,21 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+			power-domains = <&pd_ca7_cpu3>;
 			next-level-cache = <&L2_CA7>;
 		};
 	};
 
 	L2_CA15: cache-controller at 0 {
 		compatible = "cache";
+		power-domains = <&pd_ca15_scu>;
 		cache-unified;
 		cache-level = <2>;
 	};
 
 	L2_CA7: cache-controller at 1 {
 		compatible = "cache";
+		power-domains = <&pd_ca7_scu>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -1441,6 +1451,85 @@
 		};
 	};
 
+	sysc: system-controller at e6180000 {
+		compatible = "renesas,r8a7790-sysc", "renesas,rcar-gen2-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+
+		pm-domains {
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			pd_ca15_scu: scu at 12 {
+				reg = <12 0x180>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_ca15_cpu0: cpu at 0 {
+					reg = <0 0x40>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca15_cpu1: cpu at 1 {
+					reg = <1 0x41>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca15_cpu2: cpu at 2 {
+					reg = <2 0x42>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca15_cpu3: cpu at 3 {
+					reg = <3 0x43>;
+					#power-domain-cells = <0>;
+				};
+			};
+
+			pd_ca7_scu: scu at 21 {
+				reg = <21 0x100>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_ca7_cpu0: cpu at 5 {
+					reg = <5 0x1c0>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca7_cpu1: cpu at 6 {
+					reg = <6 0x1c1>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca7_cpu2: cpu at 7 {
+					reg = <7 0x1c2>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca7_cpu3: cpu at 8 {
+					reg = <8 0x1c3>;
+					#power-domain-cells = <0>;
+				};
+			};
+
+			pd_sh: sh at 16 {
+				reg = <16 0x80>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_rgx: rgx at 20 {
+				reg = <20 0xc0>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_imp: imp at 24 {
+				reg = <24 0x140>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
 	qspi: spi at e6b10000 {
 		compatible = "renesas,qspi-r8a7790", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-- 
1.9.1
