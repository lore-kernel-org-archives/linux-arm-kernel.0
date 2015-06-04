From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  4 Jun 2015 20:53:41 +0200
Subject: [PATCH/RFC 15/15] ARM: shmobile: r8a7794 dtsi: Add SYSC PM domains
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1433444021-22167-16-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up the Cortex-A7 CPU cores and the Cortex-A7 L2 cache/SCU to their
respective PM domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 0ea502a43d553e25..3d844edaf433ac05 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -28,6 +28,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			power-domains = <&pd_ca7_cpu0>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -45,6 +46,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			power-domains = <&pd_ca7_cpu1>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -60,6 +62,7 @@
 
 	L2_CA7: cache-controller at 1 {
 		compatible = "cache";
+		power-domains = <&pd_ca7_scu>;
 
 		cache-unified;
 		cache-level = <2>;
@@ -787,6 +790,43 @@
 		};
 	};
 
+	sysc: system-controller at e6180000 {
+		compatible = "renesas,sysc-r8a7794", "renesas,sysc-rcar";
+		reg = <0 0xe6180000 0 0x0200>;
+
+		pm-domains {
+			#address-cells = <2>;
+			#size-cells = <0>;
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
+					reg = <6 0x1c0>;
+					#power-domain-cells = <0>;
+				};
+			};
+
+			pd_sh: sh at 16 {
+				reg = <16 0x80>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sgx: sgx at 20 {
+				reg = <20 0xc0>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
 	ipmmu_sy0: mmu at e6280000 {
 		compatible = "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
-- 
1.9.1
