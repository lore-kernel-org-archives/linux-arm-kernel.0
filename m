From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Aug 2014 12:24:57 -0700
Subject: [PATCH v3 3/5] ARM: BCM63XX: add BCM63138 minimal Device Tree
In-Reply-To: <1408389899-1022-1-git-send-email-f.fainelli@gmail.com>
References: <1408389899-1022-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1408389899-1022-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a very minimalistic BCM63138 Device Tree include file which
describes the BCM63138 SoC with only the basic set of required
peripherals:

- Cortex A9 CPUs
- ARM GIC
- ARM SCU
- PL310 Level-2 cache controller
- ARM TWD & Global timers
- ARM TWD watchdog
- legacy MIPS bus (UBUS)
- BCM6345-style UARTs (disabled by default)

Since the PL310 L2 cache controller does not come out of reset with
correct default values, we need to override the 'cache-sets' and
'cache-size' properties to get its geometry right.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
- renamed UART nodes from uart to serial to follow ePAPR
- added Arnd's Acked-by tag

Changes in v2:
- removed buses 'reg' properties since they are unused
- align buses 'ranges' properties on a nicer boundary
- moved mpcore peripherals one level higher in the axi bus
- added uart nodes since we have a driver for it (bcm63xx_uart)

 arch/arm/boot/dts/bcm63138.dtsi | 134 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm63138.dtsi

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
new file mode 100644
index 000000000000..f3bb2dd6269e
--- /dev/null
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -0,0 +1,134 @@
+/*
+ * Broadcom BCM63138 DSL SoCs Device Tree
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
+	aliases {
+		uart0 = &serial0;
+		uart1 = &serial1;
+	};
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
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <1>;
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
+
+		periph_clk: periph_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+			clock-output-names = "periph";
+		};
+	};
+
+	/* ARM bus */
+	axi at 80000000 {
+		compatible = "simple-bus";
+		ranges = <0 0x80000000 0x784000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		L2: cache-controller at 1d000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x1d000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+			cache-sets = <16>;
+			cache-size = <0x80000>;
+			interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		scu: scu at 1e000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0x1e000 0x100>;
+		};
+
+		gic: interrupt-controller at 1e100 {
+			compatible = "arm,cortex-a9-gic";
+			reg = <0x1f000 0x1000
+				0x1e100 0x100>;
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+		};
+
+		global_timer: timer at 1e200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x1e200 0x20>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		local_timer: local-timer at 1e600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x1e600 0x20>;
+			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		twd_watchdog: watchdog at 1e620 {
+			compatible = "arm,cortex-a9-twd-wdt";
+			reg = <0x1e620 0x20>;
+			interupts = <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	/* Legacy UBUS base */
+	ubus at fffe8000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xfffe8000 0x8100>;
+
+		serial0: serial at 600 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x600 0x1b>;
+			interrupts = <GIC_SPI 32 0>;
+			clocks = <&periph_clk>;
+			clock-names = "periph";
+			status = "disabled";
+		};
+
+		serial1: serial at 620 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x620 0x1b>;
+			interrupts = <GIC_SPI 33 0>;
+			clocks = <&periph_clk>;
+			clock-names = "periph";
+			status = "disabled";
+		};
+	};
+};
-- 
1.9.1
