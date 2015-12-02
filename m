From: carlo@caione.org (Carlo Caione)
Date: Wed,  2 Dec 2015 18:22:33 +0100
Subject: [PATCH v2 7/7] ARM: DTS: Amlogic: Add SMP related nodes for Meson8b
In-Reply-To: <1449076953-5058-1-git-send-email-carlo@caione.org>
References: <1449076953-5058-1-git-send-email-carlo@caione.org>
Message-ID: <1449076953-5058-8-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add nodes for: SCU, PMU and SRAM. Set also the enable-method for SMP
bringup.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 51b32ed..27e1b2f 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -51,9 +51,20 @@
 / {
 	interrupt-parent = <&gic>;
 
+	scu at c4300000 {
+		compatible = "arm,cortex-a5-scu";
+		reg = <0xc4300000 0x100>;
+	};
+
+	pmu at c81000e4 {
+		compatible = "amlogic,meson8b-pmu", "syscon";
+		reg = <0xc81000e0 0x18>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "amlogic,meson8b-smp";
 
 		cpu at 200 {
 			device_type = "cpu";
@@ -88,6 +99,19 @@
 		};
 	};
 
+	sram: sram at d9000000 {
+		compatible = "mmio-sram";
+		reg = <0xd9000000 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xd9000000 0x20000>;
+
+		smp-sram at 1ff80 {
+			compatible = "amlogic,meson8b-smp-sram";
+			reg = <0x1ff80 0x8>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.5.0
