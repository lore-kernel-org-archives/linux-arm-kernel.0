From: anurupvasu@gmail.com (Anurup M)
Date: Sun, 19 Feb 2017 13:51:30 -0500
Subject: [PATCH v4 11/11] dts: arm64: hip07: Add Hisilicon SoC PMU support
Message-ID: <1487530290-42774-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Add nodes for hip07 L3 cache to support uncore events.
2. Add nodes for hip07 support uncore events.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Anurup M <anurup.m@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 94 ++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 12f4b8e..c00512a 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1008,6 +1008,25 @@
 			#interrupt-cells = <2>;
 			num-pins = <1>;
 		};
+
+		mbigen_fabric_b: faric_intc_b {
+			msi-parent = <&p0_its_peri_b 0x120D0>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <27>;
+		 };
+	};
+
+	p0_mbigen_peri_a: interrupt-controller at 40080000 {
+		compatible = "hisilicon,mbigen-v2";
+		reg = <0x0 0x40080000 0x0 0x10000>;
+
+		mbigen_fabric_a: faric_intc_a {
+			msi-parent = <&p0_its_peri_a 0x120D0>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <27>;
+		 };
 	};
 
 	p0_mbigen_pcie_a: interrupt-controller at a0080000 {
@@ -1085,71 +1104,79 @@
 	};
 
 	djtag0: djtag at 60010000 {
-		compatible = "hisilicon,hisi-djtag-v2";
+		compatible = "hisilicon,hip07-cpu-djtag-v2";
 		reg = <0x0 0x60010000 0x0 0x10000>;
-		scl-id = <0x02>;
+		hisilicon,scl-id = <0x03>;
 
-		/* L3 cache bank 0 for socket0 CPU die scl#2 */
+		/* L3 cache bank 0 for socket0 CPU die scl#3 */
 		pmul3c0 {
-			compatible = "hisilicon,hisi-pmu-l3c-v1";
-			module-id = <0x04 0x02>;
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x01 0x01>;
 		};
 
-		/* L3 cache bank 1 for socket0 CPU die scl#2 */
+		/* L3 cache bank 1 for socket0 CPU die scl#3 */
 		pmul3c1 {
-			compatible = "hisilicon,hisi-pmu-l3c-v1";
-			module-id = <0x04 0x04>;
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x02 0x01>;
 		};
 
-		/* L3 cache bank 2 for socket0 CPU die scl#2 */
+		/* L3 cache bank 2 for socket0 CPU die scl#3 */
 		pmul3c2 {
-			compatible = "hisilicon,hisi-pmu-l3c-v1";
-			module-id = <0x04 0x01>;
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x03 0x01>;
 		};
 
-		/* L3 cache bank 3 for socket0 CPU die scl#2 */
+		/* L3 cache bank 3 for socket0 CPU die scl#3 */
 		pmul3c3 {
-			compatible = "hisilicon,hisi-pmu-l3c-v1";
-			module-id = <0x04 0x08>;
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x04 0x01>;
 		};
 
 		/*
 		 * Miscellaneous node for socket0
-		 * CPU die scl#2
+		 * CPU die scl#3
 		 */
 		pmumn0 {
-			compatible = "hisilicon,hisi-pmu-mn-v1";
-			module-id = <0x0b>;
+			compatible = "hisilicon,hip07-pmu-mn-v2";
+			hisilicon,module-id = <0x21>;
+			interrupt-parent = <&mbigen_fabric_b>;
+			interrupts = <832 1>, <833 1>, <834 1>, <835 1>,
+					<836 1>, <837 1>, <838 1>, <839 1>,
+					<840 1>, <841 1>, <842 1>, <843 1>,
+					<844 1>, <845 1>, <846 1>, <847 1>,
+					<848 1>, <849 1>, <850 1>, <851 1>,
+					<852 1>, <853 1>, <854 1>, <855 1>,
+					<856 1>, <857 1>, <858 1>;
 		};
 	};
 
 	djtag1: djtag at 40010000 {
-		compatible = "hisilicon,hip07-cpu-djtag-v2";
+		compatible = "hisilicon,hip07-djtag-v2";
 		reg = <0x0 0x40010000 0x0 0x10000>;
-		scl-id = <0x01>;
+		hisilicon,scl-id = <0x01>;
 
 		/* L3 cache bank 0 for socket0 CPU die scl#1 */
 		pmul3c0 {
-			compatible = "hisilicon,hisi-pmu-l3c-v1";
-			module-id = <0x04 0x02>;
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x01 0x01>;
 		};
 
 		/* L3 cache bank 1 for socket0 CPU die scl#1 */
 		pmul3c1 {
-			compatible = "hisilicon,hisi-pmu-l3c-v1";
-			module-id = <0x04 0x04>;
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x02 0x01>;
 		};
 
 		/* L3 cache bank 2 for socket0 CPU die scl#1 */
 		pmul3c2 {
-			compatible = "hisilicon,hisi-pmu-l3c-v1";
-			module-id = <0x04 0x01>;
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x03 0x01>;
 		};
 
 		/* L3 cache bank 3 for socket0 CPU die scl#1 */
 		pmul3c3 {
-			compatible = "hisilicon,hisi-pmu-l3c-v1";
-			module-id = <0x04 0x08>;
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x04 0x01>;
 		};
 
 		/*
@@ -1157,9 +1184,16 @@
 		 * CPU die scl#1
 		 */
 		pmumn1 {
-			compatible = "hisilicon,hisi-pmu-mn-v1";
-			module-id = <0x0b>;
+			compatible = "hisilicon,hip07-pmu-mn-v2";
+			hisilicon,module-id = <0x21>;
+			interrupt-parent = <&mbigen_fabric_a>;
+			interrupts = <832 1>, <833 1>, <834 1>, <835 1>,
+					<836 1>, <837 1>, <838 1>, <839 1>,
+					<840 1>, <841 1>, <842 1>, <843 1>,
+					<844 1>, <845 1>, <846 1>, <847 1>,
+					<848 1>, <849 1>, <850 1>, <851 1>,
+					<852 1>, <853 1>, <854 1>, <855 1>,
+					<856 1>, <857 1>, <858 1>;
 		};
 	};
-
 };
-- 
2.1.4
