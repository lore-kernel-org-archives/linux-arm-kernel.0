From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 18 Mar 2014 15:32:45 +0100
Subject: [PATCH v4 1/3] ARM: dts: berlin2q: add the Marvell Armada 1500 pro
In-Reply-To: <1395153167-21029-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1395153167-21029-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1395153167-21029-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds initial support for the Marvell Armada 1500 pro (BG2Q) SoC (Berlin family).
The SoC has nodes for cpu, l2 cache controller, interrupt controllers, local
timer, apb timers and uarts for now.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 224 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)
 create mode 100644 arch/arm/boot/dts/berlin2q.dtsi

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
new file mode 100644
index 000000000000..aa90c273fdf2
--- /dev/null
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -0,0 +1,224 @@
+/*
+ * Copyright (C) 2014 Antoine T?nart <antoine.tenart@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#include "skeleton.dtsi"
+
+/ {
+	model = "Marvell Armada 1500 pro (BG2-Q) SoC";
+	compatible = "marvell,berlin2q", "marvell,berlin";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			next-level-cache = <&l2>;
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			next-level-cache = <&l2>;
+			reg = <1>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			next-level-cache = <&l2>;
+			reg = <2>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			next-level-cache = <&l2>;
+			reg = <3>;
+		};
+	};
+
+	smclk: sysmgr-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	cfgclk: config-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	cpuclk: cpu-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1200000000>;
+	};
+
+	twdclk: twdclk {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&cpuclk>;
+		clock-mult = <1>;
+		clock-div = <3>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		ranges = <0 0xf7000000 0x1000000>;
+		interrupt-parent = <&gic>;
+
+		l2: l2-cache-controller at ac0000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xac0000 0x1000>;
+			cache-level = <2>;
+		};
+
+		local-timer at ad0600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xad0600 0x20>;
+			clocks = <&twdclk>;
+			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gic: interrupt-controller at ad1000 {
+			compatible = "arm,cortex-a9-gic";
+			reg = <0xad1000 0x1000>, <0xad0100 0x100>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		apb at e80000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0 0xe80000 0x10000>;
+			interrupt-parent = <&aic>;
+
+			timer0: timer at 2c00 {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x2c00 0x14>;
+				clocks = <&cfgclk>;
+				clock-names = "timer";
+				interrupts = <8>;
+			};
+
+			timer1: timer at 2c14 {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x2c14 0x14>;
+				clocks = <&cfgclk>;
+				clock-names = "timer";
+				status = "disabled";
+			};
+
+			timer2: timer at 2c28 {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x2c28 0x14>;
+				clocks = <&cfgclk>;
+				clock-names = "timer";
+				status = "disabled";
+			};
+
+			timer3: timer at 2c3c {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x2c3c 0x14>;
+				clocks = <&cfgclk>;
+				clock-names = "timer";
+				status = "disabled";
+			};
+
+			timer4: timer at 2c50 {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x2c50 0x14>;
+				clocks = <&cfgclk>;
+				clock-names = "timer";
+				status = "disabled";
+			};
+
+			timer5: timer at 2c64 {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x2c64 0x14>;
+				clocks = <&cfgclk>;
+				clock-names = "timer";
+				status = "disabled";
+			};
+
+			timer6: timer at 2c78 {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x2c78 0x14>;
+				clocks = <&cfgclk>;
+				clock-names = "timer";
+				status = "disabled";
+			};
+
+			timer7: timer at 2c8c {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x2c8c 0x14>;
+				clocks = <&cfgclk>;
+				clock-names = "timer";
+				status = "disabled";
+			};
+
+			aic: interrupt-controller at 3800 {
+				compatible = "snps,dw-apb-ictl";
+				reg = <0x3800 0x30>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		apb at fc0000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0 0xfc0000 0x10000>;
+			interrupt-parent = <&sic>;
+
+			uart0: uart at 9000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x9000 0x100>;
+				interrupt-parent = <&sic>;
+				interrupts = <8>;
+				clock-frequency = <25000000>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+
+			uart1: uart at a000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0xa000 0x100>;
+				interrupt-parent = <&sic>;
+				interrupts = <9>;
+				clock-frequency = <25000000>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+
+			sic: interrupt-controller at e000 {
+				compatible = "snps,dw-apb-ictl";
+				reg = <0xe000 0x30>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+	};
+};
-- 
1.8.3.2
