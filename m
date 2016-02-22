From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Feb 2016 15:02:01 +0100
Subject: [PATCH 3/3 v2] ARM: realview: support all the RealView EB board
 variants
Message-ID: <1456149721-19276-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM RealView Evaluation Baseboards are basically these:

- The original ARMv5 EB board with an ARM926EJ-S, ARM1136 or
  ARM1176 core tile here described in arm-realview-eb.dts
  no matter which of these core tiles is being used. This
  can be emulated by QEMU "realview-eb" machine, which by
  default will have the ARM926EJ-S core tile.

- The same board with one of three MPCore Core tiles:
  ARM11MPCore, not to be confused with the similar ARM
  PB11MPCore ARM11MPCore test system. This exist in
  two revisions:
  - Revision A modeled in arm-realview-eb-11mp.dts
  - Revision B modeled arm-realview-eb-11mp-revb.dts
    Revision B can be emulated by the QEMU
    "realview-eb-mpcore" machine, but to match the hardware
    also the argument -smp cpus=4 must be passed so that
    it has four CPU cores, like the hardware.

  There is also evidently from the code in the kernel a
  Cortex-A9 core tile for the EB, and this is modeled in
  arm-realview-eb-a9mp.dts based on the kernel boardfile.
  I have not found a user guide for this EB core tile on
  the ARM website and it seems uncommon. It is however
  included for completeness.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Switch to one compatible string for the eb11mp GIC variant.
- Switch the syscon compatible strings around for 11MP RevB
  vs RevC a.k.a. "plain EB".
- Switch to "arm,pl390" for the "ordinary" GIC rather than gic-400
---
 arch/arm/boot/dts/Makefile                      |   6 +-
 arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts |  93 +++++
 arch/arm/boot/dts/arm-realview-eb-11mp.dts      |  74 ++++
 arch/arm/boot/dts/arm-realview-eb-a9mp.dts      |  70 ++++
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi       | 225 ++++++++++++
 arch/arm/boot/dts/arm-realview-eb.dts           | 166 +++++++++
 arch/arm/boot/dts/arm-realview-eb.dtsi          | 453 ++++++++++++++++++++++++
 7 files changed, 1086 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-a9mp.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-mp.dtsi
 create mode 100644 arch/arm/boot/dts/arm-realview-eb.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 76baaa51080c..39deb1741465 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -533,7 +533,11 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974-sony-xperia-honami.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
-	arm-realview-pb11mp.dtb
+	arm-realview-pb11mp.dtb \
+	arm-realview-eb.dtb \
+	arm-realview-eb-11mp.dtb \
+	arm-realview-eb-11mp-revb.dtb \
+	arm-realview-eb-a9mp.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3036-evb.dtb \
 	rk3036-kylin.dtb \
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts b/arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts
new file mode 100644
index 000000000000..3a1d72e261aa
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts
@@ -0,0 +1,93 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "arm-realview-eb-11mp.dts"
+
+/ {
+	model = "ARM RealView EB ARM11MPCore Revision B";
+};
+
+/*
+ * The revision B has a distinctly different layout of the syscon, so
+ * append a specific compatible-string.
+ */
+&syscon {
+	compatible = "arm,realview-eb11mp-revb-syscon", "arm,realview-eb-syscon", "syscon", "simple-mfd";
+};
+
+&intc {
+	reg = <0x10101000 0x1000>,
+	      <0x10100100 0x100>;
+};
+
+&L2 {
+	reg = <0x10102000 0x1000>;
+};
+
+&scu {
+	reg = <0x10100000 0x100>;
+};
+
+&twd_timer {
+	reg = <0x10100600 0x20>;
+};
+
+&twd_wdog {
+	reg = <0x10100620 0x20>;
+};
+
+/*
+ * On revision B, we cannot reach the secondary interrupt
+ * controller, as a result, some peripherals that are dependent
+ * on their IRQ cannot be reached, so disable them.
+ */
+&intc_second {
+	status = "disabled";
+};
+
+&gpio0 {
+	status = "disabled";
+};
+
+&gpio1 {
+	status = "disabled";
+};
+
+&gpio2 {
+	status = "disabled";
+};
+
+&serial2 {
+	status = "disabled";
+};
+
+&serial3 {
+	status = "disabled";
+};
+
+&ssp {
+	status = "disabled";
+};
+
+&wdog {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp.dts b/arch/arm/boot/dts/arm-realview-eb-11mp.dts
new file mode 100644
index 000000000000..f2a2ffede0b0
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-11mp.dts
@@ -0,0 +1,74 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "arm-realview-eb-mp.dtsi"
+
+/ {
+	model = "ARM RealView EB ARM11MPCore";
+	arm,hbi = <0x146>;
+
+	/*
+	 * This is the ARM11 MPCore tile (HBI-0146) used with the RealView EB.
+	 * Reference: ARM DUI 0318F
+	 *
+	 * To run this machine with QEMU, specify the following:
+	 * qemu-system-arm -M realview-eb-mpcore -smp cpus=4
+	 */
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "arm,realview-smp";
+
+		MP11_0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,arm11mpcore";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		MP11_1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,arm11mpcore";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+		MP11_2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,arm11mpcore";
+			reg = <2>;
+			next-level-cache = <&L2>;
+		};
+
+		MP11_3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,arm11mpcore";
+			reg = <3>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
+
+&pmu {
+	interrupt-affinity = <&MP11_0>, <&MP11_1>, <&MP11_2>, <&MP11_3>;
+};
diff --git a/arch/arm/boot/dts/arm-realview-eb-a9mp.dts b/arch/arm/boot/dts/arm-realview-eb-a9mp.dts
new file mode 100644
index 000000000000..967684b3636c
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-a9mp.dts
@@ -0,0 +1,70 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "arm-realview-eb-mp.dtsi"
+
+/ {
+	model = "ARM RealView EB Cortex A9 MPCore";
+
+	/*
+	 * This is the Cortex A9 MPCore tile used with the
+	 * RealView EB.
+	 */
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "arm,realview-smp";
+
+		A9_0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		A9_1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+		A9_2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <2>;
+			next-level-cache = <&L2>;
+		};
+
+		A9_3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <3>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
+
+&pmu {
+	interrupt-affinity = <&A9_0>, <&A9_1>, <&A9_2>, <&A9_3>;
+};
diff --git a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
new file mode 100644
index 000000000000..7b8d90b7aeea
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
@@ -0,0 +1,225 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "arm-realview-eb.dtsi"
+
+/*
+ * This is the common include file for all MPCore variants of the
+ * Evaluation Baseboard, i.e. ARM11MPCore, ARM11MPCore Revision B
+ * and Cortex-A9 MPCore.
+ */
+/ {
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,realview-eb-soc", "simple-bus";
+		regmap = <&syscon>;
+		ranges;
+
+		/* Primary interrupt controller in the test chip */
+		intc: interrupt-controller at 1f000100 {
+			compatible = "arm,eb11mp-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x1f001000 0x1000>,
+			      <0x1f000100 0x100>;
+		};
+
+		/* Secondary interrupt controller on the FPGA */
+		intc_second: interrupt-controller at 10040000 {
+			compatible = "arm,pl390";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x10041000 0x1000>,
+			      <0x10040000 0x100>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		L2: l2-cache {
+			compatible = "arm,l220-cache";
+			reg = <0x1f002000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 30 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 31 IRQ_TYPE_LEVEL_HIGH>;
+			cache-unified;
+			cache-level = <2>;
+			/*
+			 * Override default cache size, sets and
+			 * associativity as these may be erroneously set
+			 * up by boot loader(s), probably for safety
+			 * since th outer sync operation can cause the
+			 * cache to hang unless disabled.
+			 */
+			cache-size = <1048576>; // 1MB
+			cache-sets = <4096>;
+			cache-line-size = <32>;
+			arm,shared-override;
+			arm,parity-enable;
+			arm,outer-sync-disable;
+		};
+
+		scu: scu at 1f000000 {
+			compatible = "arm,arm11mp-scu";
+			reg = <0x1f000000 0x100>;
+		};
+
+		twd_timer: timer at 1f000600 {
+			compatible = "arm,arm11mp-twd-timer";
+			reg = <0x1f000600 0x20>;
+			interrupt-parent = <&intc>;
+			interrupts = <1 13 0xf04>;
+		};
+
+		twd_wdog: watchdog at 1f000620 {
+			compatible = "arm,arm11mp-twd-wdt";
+			reg = <0x1f000620 0x20>;
+			interrupt-parent = <&intc>;
+			interrupts = <1 14 0xf04>;
+		};
+
+		/* PMU with one IRQ line per core */
+		pmu: pmu at 0 {
+			compatible = "arm,arm11mpcore-pmu";
+			interrupt-parent = <&intc>;
+			interrupts = <0 17 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 19 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 20 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+};
+
+/*
+ * This adapts all the peripherals to the interrupt routing
+ * to the GIC on the core tile.
+ */
+
+&ethernet {
+	interrupt-parent = <&intc>;
+	interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&usb {
+	interrupt-parent = <&intc>;
+	interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&aaci {
+	interrupt-parent = <&intc>;
+	interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&mmc {
+	interrupt-parent = <&intc>;
+	interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>,
+			<0 15 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&kmi0 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&kmi1 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&charlcd {
+	interrupt-parent = <&intc>;
+	interrupts = <0  IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&serial0 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&serial1 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&timer01 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&timer23 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&rtc {
+	interrupt-parent = <&intc>;
+	interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+/*
+ * On revision A, these peripherals does not have their IRQ lines
+ * routed to the core tile, but they can be reached on the secondary
+ * GIC.
+ */
+&gpio0 {
+	interrupt-parent = <&intc_second>;
+	interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&gpio1 {
+	interrupt-parent = <&intc_second>;
+	interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&gpio2 {
+	interrupt-parent = <&intc_second>;
+	interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&serial2 {
+	interrupt-parent = <&intc_second>;
+	interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
+	status = "okay";
+};
+
+&serial3 {
+	interrupt-parent = <&intc_second>;
+	interrupts = <0 15 IRQ_TYPE_LEVEL_HIGH>;
+	status = "okay";
+};
+
+&ssp {
+	interrupt-parent = <&intc_second>;
+	interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+	status = "okay";
+};
+
+&wdog {
+	interrupt-parent = <&intc_second>;
+	interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/arm-realview-eb.dts b/arch/arm/boot/dts/arm-realview-eb.dts
new file mode 100644
index 000000000000..59cc032598b9
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb.dts
@@ -0,0 +1,166 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "arm-realview-eb.dtsi"
+
+/ {
+	model = "ARM RealView EB";
+	compatible = "arm,realview-eb";
+	arm,hbi = <0x140>;
+
+	/*
+	 * This is the core tile with the CPU and GIC etc for the
+	 * ARM926EJ-S, ARM1136, ARM1176 that does not have L2 cache
+	 * or PMU.
+	 *
+	 * To run this machine with QEMU, specify the following:
+	 * qemu-system-arm -M realview-eb
+	 * Unless specified, QEMU will emulate an ARM926EJ-S core tile.
+	 * Switches -cpu arm1136 or -cpu arm1176 emulates the other
+	 * core tiles.
+	 */
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,realview-eb-soc", "simple-bus";
+		regmap = <&syscon>;
+		ranges;
+
+		intc: interrupt-controller at 10040000 {
+			compatible = "arm,pl390";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x10041000 0x1000>,
+			      <0x10040000 0x100>;
+		};
+	};
+};
+
+/*
+ * This adapts all the peripherals to the interrupt routing
+ * to the GIC on the core tile.
+ */
+
+&ethernet {
+	interrupt-parent = <&intc>;
+	interrupts = <0 28 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&usb {
+	interrupt-parent = <&intc>;
+	interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&aaci {
+	interrupt-parent = <&intc>;
+	interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&mmc {
+	interrupt-parent = <&intc>;
+	interrupts = <0 17 IRQ_TYPE_LEVEL_HIGH>,
+			<0 18 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&kmi0 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&kmi1 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&charlcd {
+	interrupt-parent = <&intc>;
+	interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&serial0 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 12 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&serial1 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&serial2 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&serial3 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 15 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&ssp {
+	interrupt-parent = <&intc>;
+	interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&wdog {
+	interrupt-parent = <&intc>;
+	interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&timer01 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&timer23 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&gpio0 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&gpio1 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&gpio2 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&rtc {
+	interrupt-parent = <&intc>;
+	interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&clcd {
+	interrupt-parent = <&intc>;
+	interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/arch/arm/boot/dts/arm-realview-eb.dtsi b/arch/arm/boot/dts/arm-realview-eb.dtsi
new file mode 100644
index 000000000000..1c6a040218e3
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb.dtsi
@@ -0,0 +1,453 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "arm,realview-eb";
+
+	chosen { };
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+		i2c0 = &i2c;
+	};
+
+	memory {
+		/* 128 MiB memory @ 0x0 */
+		reg = <0x00000000 0x08000000>;
+	};
+
+	/* The voltage to the MMC card is hardwired at 3.3V */
+	vmmc: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+        };
+
+	veth: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "veth";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+
+	xtal24mhz: xtal24mhz at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+
+	timclk: timclk at 1M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <24>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	mclk: mclk at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	kmiclk: kmiclk at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	sspclk: sspclk at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	uartclk: uartclk at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	wdogclk: wdogclk at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	/* FIXME: this actually hangs off the PLL clocks */
+	pclk: pclk at 0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	flash0 at 40000000 {
+		/* 2 * 32MiB NOR Flash memory */
+		compatible = "arm,versatile-flash", "cfi-flash";
+		reg = <0x40000000 0x04000000>;
+		bank-width = <4>;
+	};
+
+	flash1 at 44000000 {
+		/* 2 * 32MiB NOR Flash memory */
+		compatible = "arm,versatile-flash", "cfi-flash";
+		reg = <0x44000000 0x04000000>;
+		bank-width = <4>;
+	};
+
+	/* SMSC 9118 ethernet with PHY and EEPROM */
+	ethernet: ethernet at 4e000000 {
+		compatible = "smsc,lan9118", "smsc,lan9115";
+		reg = <0x4e000000 0x10000>;
+		phy-mode = "mii";
+		reg-io-width = <4>;
+		smsc,irq-active-high;
+		smsc,irq-push-pull;
+		vdd33a-supply = <&veth>;
+		vddvario-supply = <&veth>;
+	};
+
+	usb: usb at 4f000000 {
+		compatible = "nxp,usb-isp1761";
+		reg = <0x4f000000 0x20000>;
+		port1-otg;
+	};
+
+	/* These peripherals are inside the FPGA */
+	fpga {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		syscon: syscon at 10000000 {
+			compatible = "arm,realview-eb-syscon", "syscon", "simple-mfd";
+			reg = <0x10000000 0x1000>;
+
+			led at 08.0 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x01>;
+				label = "versatile:0";
+				linux,default-trigger = "heartbeat";
+				default-state = "on";
+			};
+			led at 08.1 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x02>;
+				label = "versatile:1";
+				linux,default-trigger = "mmc0";
+				default-state = "off";
+			};
+			led at 08.2 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x04>;
+				label = "versatile:2";
+				linux,default-trigger = "cpu0";
+				default-state = "off";
+			};
+			led at 08.3 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x08>;
+				label = "versatile:3";
+				default-state = "off";
+			};
+			led at 08.4 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x10>;
+				label = "versatile:4";
+				default-state = "off";
+			};
+			led at 08.5 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x20>;
+				label = "versatile:5";
+				default-state = "off";
+			};
+			led at 08.6 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x40>;
+				label = "versatile:6";
+				default-state = "off";
+			};
+			led at 08.7 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x80>;
+				label = "versatile:7";
+				default-state = "off";
+			};
+			oscclk0: osc0 at 0c {
+				compatible = "arm,syscon-icst307";
+				#clock-cells = <0>;
+				lock-offset = <0x20>;
+				vco-offset = <0x0C>;
+				clocks = <&xtal24mhz>;
+			};
+			oscclk1: osc1 at 10 {
+				compatible = "arm,syscon-icst307";
+				#clock-cells = <0>;
+				lock-offset = <0x20>;
+				vco-offset = <0x10>;
+				clocks = <&xtal24mhz>;
+			};
+			oscclk2: osc2 at 14 {
+				compatible = "arm,syscon-icst307";
+				#clock-cells = <0>;
+				lock-offset = <0x20>;
+				vco-offset = <0x14>;
+				clocks = <&xtal24mhz>;
+			};
+			oscclk3: osc3 at 18 {
+				compatible = "arm,syscon-icst307";
+				#clock-cells = <0>;
+				lock-offset = <0x20>;
+				vco-offset = <0x18>;
+				clocks = <&xtal24mhz>;
+			};
+			oscclk4: osc4 at 1c {
+				compatible = "arm,syscon-icst307";
+				#clock-cells = <0>;
+				lock-offset = <0x20>;
+				vco-offset = <0x1c>;
+				clocks = <&xtal24mhz>;
+			};
+		};
+
+		i2c: i2c at 10002000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "arm,versatile-i2c";
+			reg = <0x10002000 0x1000>;
+
+			rtc at 68 {
+				compatible = "dallas,ds1338";
+				reg = <0x68>;
+			};
+		};
+
+		aaci: aaci at 10004000 {
+			compatible = "arm,pl041", "arm,primecell";
+			reg = <0x10004000 0x1000>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		mmc: mmcsd at 10005000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			reg = <0x10005000 0x1000>;
+
+			/* Due to frequent FIFO overruns, use just 500 kHz */
+			max-frequency = <500000>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			clocks = <&mclk>, <&pclk>;
+			clock-names = "mclk", "apb_pclk";
+			vmmc-supply = <&vmmc>;
+			cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+			wp-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		kmi0: kmi at 10006000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x10006000 0x1000>;
+			clocks = <&kmiclk>, <&pclk>;
+			clock-names = "KMIREFCLK", "apb_pclk";
+		};
+
+		kmi1: kmi at 10007000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x10007000 0x1000>;
+			clocks = <&kmiclk>, <&pclk>;
+			clock-names = "KMIREFCLK", "apb_pclk";
+		};
+
+		charlcd: fpga_charlcd: charlcd at 10008000 {
+			compatible = "arm,versatile-lcd";
+			reg = <0x10008000 0x1000>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		serial0: serial at 10009000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x10009000 0x1000>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		serial1: serial at 1000a000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1000a000 0x1000>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		serial2: serial at 1000b000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1000b000 0x1000>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		serial3: serial at 1000c000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1000c000 0x1000>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		ssp: ssp at 1000d000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x1000d000 0x1000>;
+			clocks = <&sspclk>, <&pclk>;
+			clock-names = "SSPCLK", "apb_pclk";
+		};
+
+		wdog: watchdog at 10010000 {
+			compatible = "arm,sp805", "arm,primecell";
+			reg = <0x10010000 0x1000>;
+			clocks = <&wdogclk>, <&pclk>;
+			clock-names = "wdogclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		timer01: timer at 10011000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10011000 0x1000>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+		};
+
+		timer23: timer at 10012000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10012000 0x1000>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+		};
+
+		gpio0: gpio at 10013000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x10013000 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio1: gpio at 10014000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x10014000 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio2: gpio at 10015000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x10015000 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		rtc: rtc at 10017000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x10017000 0x1000>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		clcd: clcd at 10020000 {
+			compatible = "arm,pl111", "arm,primecell";
+			reg = <0x10020000 0x1000>;
+			interrupt-names = "combined";
+			clocks = <&oscclk0>, <&pclk>;
+			clock-names = "clcdclk", "apb_pclk";
+
+			port {
+				clcd_pads: endpoint {
+					remote-endpoint = <&clcd_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+				};
+			};
+
+			panel {
+				compatible = "panel-dpi";
+
+				port {
+					clcd_panel: endpoint {
+						remote-endpoint = <&clcd_pads>;
+					};
+				};
+
+				/* Standard 640x480 VGA timings */
+				panel-timing {
+					clock-frequency = <25175000>;
+					hactive = <640>;
+					hback-porch = <48>;
+					hfront-porch = <16>;
+					hsync-len = <96>;
+					vactive = <480>;
+					vback-porch = <33>;
+					vfront-porch = <10>;
+					vsync-len = <2>;
+				};
+			};
+		};
+	};
+};
-- 
2.4.3
