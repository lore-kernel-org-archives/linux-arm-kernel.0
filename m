From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Mar 2016 12:45:42 +0700
Subject: [PATCH v2] ARM: realview: DT support for the PBA8 and PBX-A9
Message-ID: <1457588742-12674-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a devicetree for the ARM RealView PBA8 platform,
also known as HBI-0178, "RealView Platform Baseboard for
Cortex-A8" and PBX-A9 "RealView Platform Baseboard
Explore for Cortex-A9"

Tested in QEMU with -M realview-pb-a8, as well as with
-M realview-pbx-a9 -smp cpus=2

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Realized that the PBA8 and the PBX-A9 is very similar so
  merged these machines into one patch sharing a common PBX
  .dtsi file and enabled PBX-A9 as well.
- Fixed the assignment of the SD/MMC card detect to route
  to gpio instance 2.
- Drop QEMU sob story from commit message.
---
 arch/arm/boot/dts/Makefile                |   4 +-
 arch/arm/boot/dts/arm-realview-pba8.dts   | 178 ++++++++++
 arch/arm/boot/dts/arm-realview-pbx-a9.dts | 229 +++++++++++++
 arch/arm/boot/dts/arm-realview-pbx.dtsi   | 542 ++++++++++++++++++++++++++++++
 4 files changed, 952 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/arm-realview-pba8.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-pbx-a9.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-pbx.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 39deb1741465..74261429e679 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -537,7 +537,9 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-eb.dtb \
 	arm-realview-eb-11mp.dtb \
 	arm-realview-eb-11mp-revb.dtb \
-	arm-realview-eb-a9mp.dtb
+	arm-realview-eb-a9mp.dtb \
+	arm-realview-pba8.dtb \
+	arm-realview-pbx-a9.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3036-evb.dtb \
 	rk3036-kylin.dtb \
diff --git a/arch/arm/boot/dts/arm-realview-pba8.dts b/arch/arm/boot/dts/arm-realview-pba8.dts
new file mode 100644
index 000000000000..d3238c252b59
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-pba8.dts
@@ -0,0 +1,178 @@
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
+#include "arm-realview-pbx.dtsi"
+
+/ {
+	model = "ARM RealView Platform Baseboard for Cortex-A8";
+	compatible = "arm,realview-pba8";
+	arm,hbi = <0x178>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "arm,realview-smp";
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a8";
+			reg = <0>;
+		};
+	};
+
+	pmu: pmu at 0 {
+		compatible = "arm,cortex-a8-pmu";
+		interrupt-parent = <&intc>;
+		interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>;
+	};
+
+	/* Primary GIC PL390 interrupt controller in the test chip */
+	intc: interrupt-controller at 1e000000 {
+		compatible = "arm,pl390";
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		interrupt-controller;
+		reg = <0x1e001000 0x1000>,
+		      <0x1e000000 0x100>;
+	};
+};
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
+&soc {
+	compatible = "arm,realview-pba8-soc", "simple-bus";
+};
+
+&syscon {
+	compatible = "arm,realview-pba8-syscon", "syscon", "simple-mfd";
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
+&wdog0 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&wdog1 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
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
+&timer45 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&timer67 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
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
+		     <0 18 IRQ_TYPE_LEVEL_HIGH>;
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
+&clcd {
+	interrupt-parent = <&intc>;
+	interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/arch/arm/boot/dts/arm-realview-pbx-a9.dts b/arch/arm/boot/dts/arm-realview-pbx-a9.dts
new file mode 100644
index 000000000000..db808f92dd79
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-pbx-a9.dts
@@ -0,0 +1,229 @@
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
+#include "arm-realview-pbx.dtsi"
+
+/ {
+	/*
+	 * This is the RealView Platform Baseboard Explore for Cortex-A9
+	 * (HBI0182 + HBI0183) as described in ARM DUI 0440B
+	 */
+	model = "ARM RealView Platform Baseboard Explore for Cortex-A9";
+	arm,hbi = <0x182>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "arm,realview-smp";
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+			};
+		};
+		CPU0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+		CPU1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x1>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	L2: l2-cache {
+		compatible = "arm,pl310-cache";
+		reg = <0x1f002000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+		/*
+		 * Override default cache size, sets and
+		 * associativity as these may be erroneously set
+		 * up by boot loader(s).
+		 */
+		cache-size = <1048576>; // 1MB
+		cache-sets = <4096>;
+		cache-line-size = <32>;
+		arm,parity-disable;
+		arm,tag-latency = <1>;
+		arm,data-latency = <1 1>;
+		arm,dirty-latency = <1>;
+	};
+
+	scu: scu at 1f000000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x1f000000 0x100>;
+	};
+
+	twd_timer: timer at 1f000600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x1f000600 0x20>;
+		interrupt-parent = <&intc>;
+		interrupts = <1 13 0xf04>;
+	};
+
+	twd_wdog: watchdog at 1f000620 {
+		compatible = "arm,cortex-a9-twd-wdt";
+		reg = <0x1f000620 0x20>;
+		interrupt-parent = <&intc>;
+		interrupts = <1 14 0xf04>;
+	};
+
+	pmu: pmu at 0 {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-parent = <&intc>;
+		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 45 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&CPU0>, <&CPU1>;
+	};
+
+	/* Primary GIC PL390 interrupt controller in the test chip */
+	intc: interrupt-controller at 1f000000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		interrupt-controller;
+		reg = <0x1f001000 0x1000>,
+		      <0x1f000100 0x100>;
+	};
+};
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
+&wdog0 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&wdog1 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
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
+&timer45 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&timer67 {
+	interrupt-parent = <&intc>;
+	interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
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
+		     <0 18 IRQ_TYPE_LEVEL_HIGH>;
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
+&clcd {
+	interrupt-parent = <&intc>;
+	interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/arch/arm/boot/dts/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm-realview-pbx.dtsi
new file mode 100644
index 000000000000..aeb49c4bd773
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-pbx.dtsi
@@ -0,0 +1,542 @@
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
+	compatible = "arm,realview-pbx";
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
+	refclk32khz: refclk32khz {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
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
+	soc: soc at 0 {
+		compatible = "arm,realview-pbx-soc", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		regmap = <&syscon>;
+		ranges;
+
+		syscon: syscon at 10000000 {
+			compatible = "arm,realview-pbx-syscon", "syscon", "simple-mfd";
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
+		sp810_syscon0: sysctl at 10001000 {
+			compatible = "arm,sp810", "arm,primecell";
+			reg = <0x10001000 0x1000>;
+			clocks = <&refclk32khz>, <&timclk>, <&xtal24mhz>;
+			clock-names = "refclk", "timclk", "apb_pclk";
+			#clock-cells = <1>;
+			clock-output-names = "timerclk0",
+					     "timerclk1",
+					     "timerclk2",
+					     "timerclk3";
+			assigned-clocks = <&sp810_syscon0 0>,
+					  <&sp810_syscon0 1>,
+					  <&sp810_syscon0 2>,
+					  <&sp810_syscon0 3>;
+			assigned-clock-parents = <&timclk>,
+					       <&timclk>,
+					       <&timclk>,
+					       <&timclk>;
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
+		ssp: ssp at 1000d000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x1000d000 0x1000>;
+			clocks = <&sspclk>, <&pclk>;
+			clock-names = "SSPCLK", "apb_pclk";
+		};
+
+		wdog0: watchdog at 1000f000 {
+			compatible = "arm,sp805", "arm,primecell";
+			reg = <0x1000f000 0x1000>;
+			clocks = <&wdogclk>, <&pclk>;
+			clock-names = "wdogclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		wdog1: watchdog at 10010000 {
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
+			clocks = <&sp810_syscon0 0>,
+			         <&sp810_syscon0 1>,
+				 <&pclk>;
+			clock-names = "timerclk0",
+				    "timerclk1",
+				    "apb_pclk";
+		};
+
+		timer23: timer at 10012000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10012000 0x1000>;
+			clocks = <&sp810_syscon0 2>,
+			         <&sp810_syscon0 3>,
+				 <&pclk>;
+			clock-names = "timerclk2",
+				    "timerclk3",
+				    "apb_pclk";
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
+		/* DVI serial bus control is at 10016000 */
+
+		rtc: rtc at 10017000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x10017000 0x1000>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		timer45: timer at 10018000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10018000 0x1000>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timerclk4", "timerclk5", "apb_pclk";
+		};
+
+		timer67: timer at 10019000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10019000 0x1000>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timerclk6", "timerclk7", "apb_pclk";
+		};
+
+		sp810_syscon1: sysctl at 1001a000 {
+			compatible = "arm,sp810", "arm,primecell";
+			reg = <0x1001a000 0x1000>;
+			clocks = <&refclk32khz>, <&timclk>, <&xtal24mhz>;
+			clock-names = "refclk", "timclk", "apb_pclk";
+			#clock-cells = <1>;
+			clock-output-names = "timerclk4",
+					     "timerclk5",
+					     "timerclk6",
+					     "timerclk7";
+			assigned-clocks = <&sp810_syscon1 0>,
+					  <&sp810_syscon1 1>,
+					  <&sp810_syscon1 2>,
+					  <&sp810_syscon1 3>;
+			assigned-clock-parents = <&timclk>,
+					       <&timclk>,
+					       <&timclk>,
+					       <&timclk>;
+		};
+	};
+
+
+	/* These peripherals are inside the FPGA */
+	fpga {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
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
+			cd-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+			wp-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
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
+		serial3: serial at 1000c000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1000c000 0x1000>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+	};
+
+	/* These peripherals are inside the NEC ISSP */
+	issp {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		clcd: clcd at 10020000 {
+			compatible = "arm,pl111", "arm,primecell";
+			reg = <0x10020000 0x1000>;
+			interrupt-names = "combined";
+			clocks = <&oscclk4>, <&pclk>;
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
+
-- 
2.4.3
