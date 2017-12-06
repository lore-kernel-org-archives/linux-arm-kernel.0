From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  6 Dec 2017 12:05:29 +0000
Subject: [PATCH v2] ARM: dts: r8a7745: Add APMU node and second CPU core
Message-ID: <1512561929-16540-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add DT node for the Advanced Power Management Unit (APMU), add the
second CPU core, and use "renesas,apmu" as "enable-method".

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
Dear All,

I am reposting this patch now that its dependecy ("ARM: shmobile: rcar-gen2:
Make sure CNTVOFF is initialized on CA7/15") is part of v4.15-rc1, similarly
to patch "ARM: dts: r8a7794: Add SMP support".

v2:
- rebased against renesas-devel-20171205-v4.15-rc2

Thanks

 arch/arm/boot/dts/r8a7745.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index de13e15..0fa7861 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -38,6 +38,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -49,6 +50,15 @@
 			next-level-cache = <&L2_CA7>;
 		};
 
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7745_PD_CA7_CPU1>;
+			next-level-cache = <&L2_CA7>;
+		};
+
 		L2_CA7: cache-controller-0 {
 			compatible = "cache";
 			cache-unified;
@@ -65,6 +75,12 @@
 		#size-cells = <2>;
 		ranges;
 
+		apmu at e6151000 {
+			compatible = "renesas,r8a7745-apmu", "renesas,apmu";
+			reg = <0 0xe6151000 0 0x188>;
+			cpus = <&cpu0 &cpu1>;
+		};
+
 		gic: interrupt-controller at f1001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.7.4
