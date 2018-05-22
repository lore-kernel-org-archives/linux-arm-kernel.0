From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 22 May 2018 15:29:25 +0200
Subject: [PATCH/RFC] ARM: dts: r8a7791: Move enable-method to CPU nodes
Message-ID: <1526995765-29693-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/arm/cpus.txt, the
"enable-method" property should be a property of the individual CPU
nodes, not of the parent "cpus" node.  However, on R-Car M2-W (and on
several other arm32 SoCs), the property is tied to the "cpus" node
instead.

Secondary CPU bringup and CPU hot (un)plug work regardless, as
arm_dt_init_cpu_maps() falls back to looking in the "cpus" node.

The cpuidle code does not have such a fallback, so it does not detect
the enable-method.  Note that cpuidle does not support the
"renesas,apmu" enable-method yet, so for now this does not make any
difference.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Arm64 and powerpc do not have such a fallback, but SH has, like arm32.

This is marked RFC, as the alternative is to update the DT bindings to
keep the status quo.
---
 arch/arm/boot/dts/r8a7791.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d568bd22d6cbd855..b214cb8f52e47109 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -71,7 +71,6 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		enable-method = "renesas,apmu";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -83,6 +82,7 @@
 			clock-latency = <300000>; /* 300 us */
 			power-domains = <&sysc R8A7791_PD_CA15_CPU0>;
 			next-level-cache = <&L2_CA15>;
+			enable-method = "renesas,apmu";
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1500000 1000000>,
@@ -101,6 +101,7 @@
 			clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
 			power-domains = <&sysc R8A7791_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
+			enable-method = "renesas,apmu";
 		};
 
 		L2_CA15: cache-controller-0 {
-- 
2.7.4
