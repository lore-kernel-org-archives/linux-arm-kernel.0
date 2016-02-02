From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue,  2 Feb 2016 17:25:16 -0600
Subject: [PATCH 2/3] ARM: dts: keystone: Add Initial DT support for TI K2G SoC
 family
In-Reply-To: <1454455517-7360-1-git-send-email-fcooper@ti.com>
References: <1454455517-7360-1-git-send-email-fcooper@ti.com>
Message-ID: <1454455517-7360-3-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vitaly Andrianov <vitalya@ti.com>

K2G is the newest addition of TI's Keystone 2 product family. It is a
single core Cortex A15 and a C66x DSP.

K2G supports standard peripherals such as SPI, UART, MMC and USB 2.0.

Includes two dual-core Programmable Real-time Unit and Industrial
Communication Subsystems (PRU-ICSS).

The technical reference manual for K2G can be found here:
http://www.ti.com/lit/ug/spruhy8/spruhy8.pdf

This device is targeted for a variety of applications which include, but
are not limited to:

Home audio
Professional audio
Industrial Programmable Logic Control

The peripheral nodes that have been included in this patch have been
tested during bring-up. Since all peripherals will not necessarily be
used on all boards, disable all peripherals by default. This allow
the board dts to selectively choose which peripherals it wants to
enable.

This SoC now uses the next generation of power management architecture
with the PM functionality located in a microcontroller embedded in the SOC.

Support for this new PM architecture along with other peripherals will be
added in future patches.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/k2g.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 arch/arm/boot/dts/k2g.dtsi

diff --git a/arch/arm/boot/dts/k2g.dtsi b/arch/arm/boot/dts/k2g.dtsi
new file mode 100644
index 0000000..7ff2796
--- /dev/null
+++ b/arch/arm/boot/dts/k2g.dtsi
@@ -0,0 +1,89 @@
+/*
+ * Device Tree Source for K2G SOC
+ *
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "ti,k2g","ti,keystone";
+	model = "Texas Instruments K2G SoC";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	gic: interrupt-controller at 02561000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0x02561000 0x0 0x1000>,
+		      <0x0 0x02562000 0x0 0x2000>,
+		      <0x0 0x02564000 0x0 0x1000>,
+		      <0x0 0x02566000 0x0 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+				IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts =
+			<GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts = <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "ti,keystone","simple-bus";
+		ranges = <0x0 0x0 0x0 0xc0000000>;
+		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
+
+		uart0: serial at 02530c00 {
+			compatible = "ns16550a";
+			current-speed = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			reg = <0x02530c00 0x100>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_EDGE_RISING>;
+			clock-frequency = <200000000>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.7.0
