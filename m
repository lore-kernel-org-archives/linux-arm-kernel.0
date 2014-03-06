From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 6 Mar 2014 09:45:57 -0800
Subject: [PATCH 4/6] ARM: BCM63XX: add BCM63138 minimal Device Tree
In-Reply-To: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
References: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1394127959-3159-5-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a very minimalistic BCM63138 Device Tree include file which
describes the BCM63138 SoC with only the basic set of required
peripherals:

- Cortex A9 CPU
- ARM GIC
- PL310 Level-2 cache controller
- ARM TWD & Global timers
- ARM TWD watchdog
- legacy MIPS bus (UBUS)

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm63138.dtsi | 109 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm63138.dtsi

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
new file mode 100644
index 000000000000..190d6e53a85a
--- /dev/null
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -0,0 +1,109 @@
+/*
+ * Broadcom BCM63138 DSL SoCs Device Tree
+ *
+ * Copyright (C) 2014 Broadcom Corporation
+ *
+ * Licensed under the GNU/GPL. See COPYING for details
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "brcm,bcm63138";
+	model = "Broadcom BCM63138 DSL SoC";
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		arm_timer_clk: arm_timer_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <500000000>;
+		};
+	};
+
+	/* ARM bus */
+	axi at 80000000 {
+		compatible = "simple-bus";
+		ranges = <0 0x80000000 0x783003>;
+		reg = <0x80000000 0x783003>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		L2: cache-controller at 1d000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x1d000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+			interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		mpcore at 1e000 {
+			compatible = "simple-bus";
+			reg = <0x1e000 0x20000>;
+			ranges = <0 0x1e000 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			scu: scu at 0 {
+				compatible = "arm,cortex-a9-scu";
+				reg = <0x0 0x100>;
+			};
+
+			gic: interrupt-controller at 100 {
+				compatible = "arm,cortex-a9-gic";
+				reg = <0x1000 0x1000
+					0x100 0x100>;
+				#interrupt-cells = <3>;
+				#address-cells = <0>;
+				interrupt-controller;
+			};
+
+			global_timer: timer at 200 {
+				compatible = "arm,cortex-a9-global-timer";
+				reg = <0x200 0x20>;
+				interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&arm_timer_clk>;
+			};
+
+			local_timer: local-timer at 600 {
+				compatible = "arm,cortex-a9-twd-timer";
+				reg = <0x600 0x20>;
+				interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&arm_timer_clk>;
+			};
+
+			twd_watchdog: watchdog at 620 {
+				compatible = "arm,cortex-a9-twd-wdt";
+				reg = <0x620 0x20>;
+				interupts = <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+	};
+
+	/* Legacy UBUS base */
+	ubus at fffe8000 {
+		compatible = "simple-bus";
+		reg = <0xfffe8000 0x8053>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xfffe8000 0x8053>;
+	};
+};
-- 
1.8.3.2
