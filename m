From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 15:23:56 +0900
Subject: [PATCH v11 1/8] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC
 support
In-Reply-To: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1444890243-6978-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Initial version of Renesas R-Car H3 support (V10)

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
TODO:
- Split this patch based on ARM-SoC maintainer preference

Changes since v10:
- None

Changes since v9: (Magnus Damm <damm+renesas@opensource.se>)
- Added clock-output-names for the CPG

Changes since v8: (Magnus Damm <damm+renesas@opensource.se>)
- Renamed xtal node name to drop _clk - thanks Geert!
- Kconfig s/platform/platforms/g - thanks Laurent!
- Added select PINCTRL - thanks Geert
- Removed unused Makefile subdir line - thanks Laurent!

Changes since v7: (Magnus Damm <damm+renesas@opensource.se>)
- Folded together the following patches from v7:
   [PATCH 6/25] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
   [PATCH 7/25] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
   [PATCH 8/25] arm64: renesas: r8a7795: Add initial SoC support
- Updated Kconfig bits
   Changed to CONFIG_ARCH_R8A7795 and CONFIG_RENESAS
   CONFIG_ARCH_SHMOBILE is still set to be able to build various drivers
   CONFIG_ARCH_SHMOBILE_MULTI is gone
   select PM_GENERIC_DOMAINS if PM
- Moved "s3d4_clk" to clock patch from geert
- Replaced CPG clock-output-names with clock-indices
- set #power-domain-cells to 0
---
 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +
 arch/arm64/Kconfig.platforms                       | 17 +++++
 arch/arm64/boot/dts/Makefile                       |  1 +
 arch/arm64/boot/dts/renesas/Makefile               |  2 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 89 ++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h          | 38 +++++++++
 6 files changed, 149 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/Makefile
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7795-clock.h

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index c4f19b2e7dd9..8d696a0d62b3 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -27,6 +27,8 @@ SoCs:
     compatible = "renesas,r8a7793"
   - R-Car E2 (R8A77940)
     compatible = "renesas,r8a7794"
+  - R-Car H3 (R8A77950)
+    compatible = "renesas,r8a7795"
 
 
 Boards:
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 23800a19a7bc..04bf6de3b01a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -66,6 +66,23 @@ config ARCH_SEATTLE
 	help
 	  This enables support for AMD Seattle SOC Family
 
+config ARCH_SHMOBILE
+	bool
+
+config ARCH_RENESAS
+	bool "Renesas SoC Platforms"
+	select ARCH_SHMOBILE
+	select PINCTRL
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the ARMv8 based Renesas SoCs.
+
+config ARCH_R8A7795
+	bool "Renesas R-Car H3 SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas R-Car H3 SoC.
+
 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index d9f88330e7b0..54e401119639 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -9,6 +9,7 @@ dts-dirs += hisilicon
 dts-dirs += marvell
 dts-dirs += mediatek
 dts-dirs += qcom
+dts-dirs += renesas
 dts-dirs += rockchip
 dts-dirs += sprd
 dts-dirs += xilinx
diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
new file mode 100644
index 000000000000..fec69f46d65b
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -0,0 +1,2 @@
+always		:= $(dtb-y)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
new file mode 100644
index 000000000000..ff6e0e98664a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -0,0 +1,89 @@
+/*
+ * Device Tree Source for the r8a7795 SoC
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/clock/r8a7795-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "renesas,r8a7795";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 1core only at this point */
+		a57_0: cpu at 0 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x0>;
+			device_type = "cpu";
+		};
+	};
+
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller at 0xf1010000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xf1010000 0 0x1000>,
+			      <0x0 0xf1020000 0 0x2000>;
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 13
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		clock {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#clock-cells = <1>;
+			ranges;
+
+			cpg_clocks: cpg_clocks at e6150000 {
+				compatible = "renesas,r8a7795-cpg-clocks",
+					     "renesas,rcar-gen3-cpg-clocks";
+				reg = <0 0xe6150000 0 0x1000>;
+				clocks = <&extal_clk>;
+				clock-indices = <
+					R8A7795_CLK_MAIN R8A7795_CLK_PLL0
+					R8A7795_CLK_PLL1 R8A7795_CLK_PLL2
+					R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
+				>;
+				clock-output-names = "main", "pll0", "pll1",
+						     "pll2", "pll3", "pll4";
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+};
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
new file mode 100644
index 000000000000..334fa13d1bb4
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R8A7795_H__
+#define __DT_BINDINGS_CLOCK_R8A7795_H__
+
+/* CPG */
+#define R8A7795_CLK_MAIN		0
+#define R8A7795_CLK_PLL0		1
+#define R8A7795_CLK_PLL1		2
+#define R8A7795_CLK_PLL2		3
+#define R8A7795_CLK_PLL3		4
+#define R8A7795_CLK_PLL4		5
+
+/* MSTP0 */
+
+/* MSTP1 */
+
+/* MSTP2 */
+
+/* MSTP3 */
+
+/* MSTP5 */
+
+/* MSTP7 */
+
+/* MSTP8 */
+
+/* MSTP9 */
+
+/* MSTP10 */
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7795_H__ */
-- 
2.1.4
