From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:16:00 +0200
Subject: [PATCH 40/41] ARM: dts: r8a7793: Add APMU node and second CPU core
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <65b133cd79cfde9f4e0157deb0e0f88f92811ad3.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add DT nodes for the Advanced Power Management Unit (APMU) and the
second CPU core.  Use the enable-method to point out that the APMU
should be used for SMP support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 9b55c1c6ee31..8d02aacf2892 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -35,6 +35,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -56,6 +57,14 @@
 			next-level-cache = <&L2_CA15>;
 		};
 
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1500000000>;
+			power-domains = <&sysc R8A7793_PD_CA15_CPU1>;
+		};
+
 		L2_CA15: cache-controller at 0 {
 			compatible = "cache";
 			reg = <0>;
@@ -65,6 +74,12 @@
 		};
 	};
 
+	apmu at e6152000 {
+		compatible = "renesas,r8a7793-apmu", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x188>;
+		cpus = <&cpu0 &cpu1>;
+	};
+
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
 			polling-delay-passive	= <0>;
-- 
2.7.0.rc3.207.g0ac5344
