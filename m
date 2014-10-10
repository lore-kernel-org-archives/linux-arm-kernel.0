From: B45475@freescale.com (Zhao Qiang)
Date: Fri, 10 Oct 2014 14:49:58 +0800
Subject: [PATCH 3/3] ls1021a-twr/qe: add qe node to ls1-twr
Message-ID: <1412923798-9757-1-git-send-email-B45475@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add qe node to ls1021atwr fdt.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 24 +++++++++++++++
 arch/arm/boot/dts/ls1021a.dtsi    | 64 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a52be7b..415387f 100755
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -164,6 +164,30 @@
 	};
 };
 
+&uqe {
+	tdma: ucc at 2000 {
+		compatible = "fsl,ucc-tdm";
+		rx-clock-name = "clk8";
+		tx-clock-name = "clk9";
+		fsl,rx-sync-clock = "rsync_pin";
+		fsl,tx-sync-clock = "tsync_pin";
+		fsl,tx-timeslot = <0xfffffffe>;
+		fsl,rx-timeslot = <0xfffffffe>;
+		fsl,tdm-framer-type = "e1";
+		fsl,tdm-mode = "normal";
+		fsl,tdm-id = <0>;
+		fsl,siram-entry-id = <0>;
+	};
+
+	serial: ucc at 2200 {
+		device_type = "serial";
+		compatible = "ucc_uart";
+		port-number = <1>;
+		rx-clock-name = "brg2";
+		tx-clock-name = "brg2";
+	};
+};
+
 &pwm6 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 80747dc..3f2ab89 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -314,6 +314,70 @@
 			status = "disabled";
 		};
 
+		uqe: uqe at 2400000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "qe";
+			compatible = "fsl,qe", "simple-bus";
+			ranges = <0x0 0x0 0x2400000 0x40000>;
+			reg = <0x0 0x2400000 0x0 0x480>;
+			brg-frequency = <100000000>;
+			bus-frequency = <200000000>;
+
+			fsl,qe-num-riscs = <1>;
+			fsl,qe-num-snums = <28>;
+
+			qeic: qeic at 80 {
+				compatible = "fsl,qe-ic";
+				reg = <0x80 0x80>;
+				#address-cells = <0>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupts = <0 109 0x04 0 109 0x04>;
+			};
+
+			si1: si at 700 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,qe-si";
+				reg = <0x700 0x80>;
+			};
+
+			siram1: siram at 1000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,qe-siram";
+				reg = <0x1000 0x800>;
+			};
+
+			ucc at 2000 {
+				cell-index = <1>;
+				reg = <0x2000 0x200>;
+				interrupts = <32>;
+				interrupt-parent = <&qeic>;
+			};
+
+			ucc at 2200 {
+				cell-index = <3>;
+				reg = <0x2200 0x200>;
+				interrupts = <34>;
+				interrupt-parent = <&qeic>;
+			};
+
+			muram at 10000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,qe-muram", "fsl,cpm-muram";
+				ranges = <0x0 0x10000 0x6000>;
+
+				data-only at 0 {
+					compatible = "fsl,qe-muram-data",
+					"fsl,cpm-muram-data";
+					reg = <0x0 0x6000>;
+				};
+			};
+		};
+
 		lpuart0: serial at 2950000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2950000 0x0 0x1000>;
-- 
2.1.0.27.g96db324
