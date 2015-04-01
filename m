From: manabian@gmail.com (Joachim Eastwood)
Date: Wed,  1 Apr 2015 23:20:41 +0200
Subject: [PATCH 4/6] ARM: dts: Add base DT for NXP LPC18xx and LPC4357
In-Reply-To: <1427923243-26296-1-git-send-email-manabian@gmail.com>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
Message-ID: <1427923243-26296-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC18xx/43xx SoCs are very similar devices and should be able to
share a common base (lpc18xx.dtsi). Diffences between the devices are
put in a dtsi which is specific to that device.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 117 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/lpc4357.dtsi |  39 ++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 arch/arm/boot/dts/lpc18xx.dtsi
 create mode 100644 arch/arm/boot/dts/lpc4357.dtsi

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
new file mode 100644
index 000000000000..161e98b442e0
--- /dev/null
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -0,0 +1,117 @@
+/*
+ * Common base for NXP LPC18xx and LPC43xx devices.
+ *
+ * Copyright 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This code is released using a dual license strategy: BSD/GPL
+ * You can choose the licence that better fits your requirements.
+ *
+ * Released under the terms of 3-clause BSD License
+ * Released under the terms of GNU General Public License Version 2.0
+ *
+ */
+
+#include "armv7-m.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-m3";
+			device_type = "cpu";
+			reg = <0x0>;
+		};
+	};
+
+	clocks {
+		xtal: xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <12000000>;
+		};
+
+		/* Temporary hardcode PLL1 until clk drivers are merged */
+		pll1: pll1 {
+			compatible = "fixed-factor-clock";
+			clocks = <&xtal>;
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <12>;
+		};
+	};
+
+	soc {
+		uart0: serial at 40081000 {
+			compatible = "ns16550a";
+			reg = <0x40081000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <24>;
+			clocks = <&pll1>;
+			status = "disabled";
+		};
+
+		uart1: serial at 40082000 {
+			compatible = "ns16550a";
+			reg = <0x40082000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <25>;
+			clocks = <&pll1>;
+			status = "disabled";
+		};
+
+		timer0: timer at 40084000 {
+			compatible = "nxp,lpc3250-timer";
+			reg = <0x40084000 0x1000>;
+			interrupts = <12>;
+			clocks = <&pll1>;
+		};
+
+		timer1: timer at 40085000 {
+			compatible = "nxp,lpc3250-timer";
+			reg = <0x40085000 0x1000>;
+			interrupts = <13>;
+			clocks = <&pll1>;
+		};
+
+		uart2: serial at 400c1000 {
+			compatible = "ns16550a";
+			reg = <0x400c1000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <26>;
+			clocks = <&pll1>;
+			status = "disabled";
+		};
+
+		uart3: serial at 400c2000 {
+			compatible = "ns16550a";
+			reg = <0x400c2000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <27>;
+			clocks = <&pll1>;
+			status = "disabled";
+		};
+
+		timer2: timer at 400c3000 {
+			compatible = "nxp,lpc3250-timer";
+			reg = <0x400c3000 0x1000>;
+			interrupts = <14>;
+			clocks = <&pll1>;
+		};
+
+		timer3: timer at 400c4000 {
+			compatible = "nxp,lpc3250-timer";
+			reg = <0x400c4000 0x1000>;
+			interrupts = <15>;
+			clocks = <&pll1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/lpc4357.dtsi b/arch/arm/boot/dts/lpc4357.dtsi
new file mode 100644
index 000000000000..9a3ec7663419
--- /dev/null
+++ b/arch/arm/boot/dts/lpc4357.dtsi
@@ -0,0 +1,39 @@
+/*
+ * NXP LPC4357 SoC
+ *
+ * Copyright 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This code is released using a dual license strategy: BSD/GPL
+ * You can choose the licence that better fits your requirements.
+ *
+ * Released under the terms of 3-clause BSD License
+ * Released under the terms of GNU General Public License Version 2.0
+ *
+ */
+
+/ {
+	compatible = "nxp,lpc4357";
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,cortex-m4";
+		};
+	};
+
+	soc {
+		sram0: sram at 10000000 {
+			compatible = "mmio-sram";
+			reg = <0x10000000 0x8000>; /* 32 KiB local SRAM */
+		};
+
+		sram1: sram at 10080000 {
+			compatible = "mmio-sram";
+			reg = <0x10080000 0xa000>; /* 32 + 8 KiB local SRAM */
+		};
+
+		sram2: sram at 20000000 {
+			compatible = "mmio-sram";
+			reg = <0x20000000 0x10000>; /* 4 x 16 KiB AHB SRAM */
+		};
+	};
+};
-- 
1.8.0
