From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:05:13 +0200
Subject: [PATCH 5/9] ARM: dts: Renesas R9A06G032 base device tree file
In-Reply-To: <cover.1532086734.git.horms+renesas@verge.net.au>
References: <cover.1532086734.git.horms+renesas@verge.net.au>
Message-ID: <7476f5964a37fcf1de9b0e65e459c21c1fc52572.1532086734.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michel Pollet <michel.pollet@bp.renesas.com>

This adds the Renesas R9A06G032 bare bone support.

This currently only handles the SYSCTRL block note,
generic parts (gic, architected timer) and a UART.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: updated MAINTAINERS file
[simon: do not use r9a06g032-sysctrl.h as it is not in the renesas tree yet]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS                      |   1 +
 arch/arm/boot/dts/r9a06g032.dtsi | 113 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/r9a06g032.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..4c85ac04872d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1969,6 +1969,7 @@ S:	Supported
 F:	arch/arm/boot/dts/emev2*
 F:	arch/arm/boot/dts/r7s*
 F:	arch/arm/boot/dts/r8a*
+F:	arch/arm/boot/dts/r9a*
 F:	arch/arm/boot/dts/sh*
 F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
new file mode 100644
index 000000000000..339d0958011e
--- /dev/null
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base Device Tree Source for the Renesas RZ/N1D (R9A06G032)
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "renesas,r9a06g032";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+			clocks = <&sysctrl 84>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			clocks = <&sysctrl 84>;
+		};
+	};
+
+	ext_jtag_clk: extjtagclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	ext_mclk: extmclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <40000000>;
+	};
+
+	ext_rgmii_ref: extrgmiiref {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	ext_rtc_clk: extrtcclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupt-parent = <&gic>;
+		ranges;
+
+		sysctrl: system-controller at 4000c000 {
+			compatible = "renesas,r9a06g032-sysctrl";
+			reg = <0x4000c000 0x1000>;
+			status = "okay";
+			#clock-cells = <1>;
+
+			clocks = <&ext_mclk>, <&ext_rtc_clk>,
+					<&ext_jtag_clk>, <&ext_rgmii_ref>;
+			clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
+		};
+
+		uart0: serial at 40060000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x40060000 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&sysctrl 146>;
+			clock-names = "baudclk";
+			status = "disabled";
+		};
+
+		gic: gic at 44101000 {
+			compatible = "arm,cortex-a7-gic", "arm,gic-400";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x44101000 0x1000>, /* Distributer */
+			      <0x44102000 0x2000>, /* CPU interface */
+			      <0x44104000 0x2000>, /* Virt interface control */
+			      <0x44106000 0x2000>; /* Virt CPU interface */
+			interrupts =
+				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+	};
+
+	timer {
+		compatible = "arm,cortex-a7-timer",
+			     "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		arm,cpu-registers-not-fw-configured;
+		always-on;
+		interrupts =
+			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
-- 
2.11.0
