From: vw@iommu.org (Wan Zongshun)
Date: Sun, 10 Jul 2016 15:42:20 +0800
Subject: [PATCH v2 08/10] ARM: dts: nuc900: Add nuc970 dts files
Message-ID: <1468136542-2656-1-git-send-email-vw@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add dts support for nuc970 platform.

Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
---
 arch/arm/boot/dts/Makefile       |  1 +
 arch/arm/boot/dts/nuc970-evb.dts | 34 ++++++++++++++++
 arch/arm/boot/dts/nuc970.dtsi    | 88 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 arch/arm/boot/dts/nuc970-evb.dts
 create mode 100644 arch/arm/boot/dts/nuc970.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 414b427..557477d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -892,6 +892,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += aspeed-bmc-opp-palmetto.dtb \
 	aspeed-ast2500-evb.dtb
+dtb-$(CONFIG_SOC_NUC970) += nuc970-evb.dtb
 endif
 
 dtstree		:= $(srctree)/$(src)
diff --git a/arch/arm/boot/dts/nuc970-evb.dts b/arch/arm/boot/dts/nuc970-evb.dts
new file mode 100644
index 0000000..ae3fe90
--- /dev/null
+++ b/arch/arm/boot/dts/nuc970-evb.dts
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "nuc970.dtsi"
+
+/ {
+	model = "Nuvoton NUC970 Development Board";
+	compatible = "nuvoton,nuc970";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	memory {
+		reg = <0x00000000 0x04000000>;
+	};
+
+	soc {
+		apb at b8000000 {
+			uart0: serial at b8000000 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/nuc970.dtsi b/arch/arm/boot/dts/nuc970.dtsi
new file mode 100644
index 0000000..d476abd
--- /dev/null
+++ b/arch/arm/boot/dts/nuc970.dtsi
@@ -0,0 +1,88 @@
+/*
+ * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/clock/nuc970-clock.h>
+
+/ {
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&aic>;
+		ranges;
+
+		ahb at b0000000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			gcr: syscon at b0000000 {
+				compatible = "syscon", "nuvoton,nuc970-gcr";
+				reg = <0xb0000000 0x200>;
+			};
+
+			soc {
+				compatible = "nuvoton,nuc900-soc";
+				syscon = <&gcr>;
+			};
+
+			reset {
+				compatible = "nuvoton,nuc900-reset";
+				syscon = <&gcr>;
+			};
+
+			clks: clk at b0000200 {
+				compatible = "nuvoton,nuc970-clk";
+				reg = <0xb0000200 0x200>;
+				#clock-cells = <1>;
+			};
+
+		};
+
+		apb at b8000000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			aic: interrupt-controller at b8002000 {
+				compatible = "nuvoton,nuc900-aic";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0xb8002000 0x1000>;
+			};
+
+
+			tmr at 0xb8001000 {
+				compatible = "nuvoton,nuc970-tmr";
+				reg = <0xb8001000 0x1000>;
+				interrupts = <16>;
+				clocks = <&clks TIMER0_GATE>,
+					 <&clks TIMER1_GATE>;
+				clock-names = "timer0", "timer1";
+
+			};
+
+			uart0: serial at b8000000 {
+				compatible = "nuvoton,nuc970-uart";
+				reg = <0xb8000000 0x1000>;
+				interrupts = <36>;
+				clocks = <&clks UART0_GATE>,
+					 <&clks UART0_ECLK_GATE>;
+				clock-names = "uart0", "uart0_eclk";
+				clock-frequency = <12000000>;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
2.7.4
