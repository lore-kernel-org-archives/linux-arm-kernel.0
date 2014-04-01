From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  1 Apr 2014 16:03:49 +0800
Subject: [PATCH v1 7/8] ARM: dts: add hip04-d01 dts file
In-Reply-To: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
References: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1396339430-21084-8-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hip04.dtsi & hip04-d01.dts file to support HiP04 SoC platform.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/Makefile      |   1 +
 arch/arm/boot/dts/hip04-d01.dts |  74 +++++++++++++
 arch/arm/boot/dts/hip04.dtsi    | 240 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 315 insertions(+)
 create mode 100644 arch/arm/boot/dts/hip04-d01.dts
 create mode 100644 arch/arm/boot/dts/hip04.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8f68a0a..e02ad21 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -80,6 +80,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 dtb-$(CONFIG_ARCH_HI3xxx) += hi3620-hi4511.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 	ecx-2000.dtb
+dtb-$(CONFIG_ARCH_HIP04) += hip04-d01.dtb
 dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
 	integratorcp.dtb
 dtb-$(CONFIG_ARCH_KEYSTONE) += k2hk-evm.dtb \
diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hip04-d01.dts
new file mode 100644
index 0000000..a10dcf3
--- /dev/null
+++ b/arch/arm/boot/dts/hip04-d01.dts
@@ -0,0 +1,74 @@
+/*
+ *  Copyright (C) 2013-2014 Linaro Ltd.
+ *  Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "hip04.dtsi"
+
+/ {
+	/* memory bus is 64-bit */
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "Hisilicon D01 Development Board";
+	compatible = "hisilicon,hip04-d01";
+
+	memory at 0 {
+		device_type = "memory";
+		/*
+		 * Bootloader loads kernel image into 0x1000_0000 region,
+		 * so disables the region between [0000_0000 - 1000_0000]
+		 * temporarily.
+		 * Because the PHYS_TO_VIRT_OFFSET is calculated based on
+		 * the original region that kenrel is loaded.
+		 * This workaround will be removed only after UEFI updated.
+		 */
+		reg = <0x00000000 0x10000000 0xc0000000>;
+	};
+
+	memory at 00000004c0000000 {
+		device_type = "memory";
+		reg = <0x00000004 0xc0000000 0x40000000>;
+	};
+
+	memory at 0000000500000000 {
+		device_type = "memory";
+		reg = <0x00000005 0x00000000 0x80000000>;
+	};
+
+	memory at 0000000580000000 {
+		device_type = "memory";
+		reg = <0x00000005 0x80000000 0x80000000>;
+	};
+
+	memory at 0000000600000000 {
+		device_type = "memory";
+		reg = <0x00000006 0x00000000 0x80000000>;
+	};
+
+	memory at 0000000680000000 {
+		device_type = "memory";
+		reg = <0x00000006 0x80000000 0x80000000>;
+	};
+
+	memory at 0000000700000000 {
+		device_type = "memory";
+		reg = <0x00000007 0x00000000 0x80000000>;
+	};
+
+	memory at 0000000780000000 {
+		device_type = "memory";
+		reg = <0x00000007 0x80000000 0x80000000>;
+	};
+
+	soc {
+		uart0: uart at 4007000 {
+			status = "ok";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
new file mode 100644
index 0000000..eb5e5a2
--- /dev/null
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -0,0 +1,240 @@
+/*
+ * Hisilicon Ltd. HiP01 SoC
+ *
+ * Copyright (C) 2013-2014 Hisilicon Ltd.
+ * Copyright (C) 2013-2014 Linaro Ltd.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+
+#include <dt-bindings/clock/hip04-clock.h>
+
+/ {
+	/* memory bus is 64-bit */
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+				core2 {
+					cpu = <&CPU2>;
+				};
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+			cluster1 {
+				core0 {
+					cpu = <&CPU4>;
+				};
+				core1 {
+					cpu = <&CPU5>;
+				};
+				core2 {
+					cpu = <&CPU6>;
+				};
+				core3 {
+					cpu = <&CPU7>;
+				};
+			};
+			cluster2 {
+				core0 {
+					cpu = <&CPU8>;
+				};
+				core1 {
+					cpu = <&CPU9>;
+				};
+				core2 {
+					cpu = <&CPU10>;
+				};
+				core3 {
+					cpu = <&CPU11>;
+				};
+			};
+			cluster3 {
+				core0 {
+					cpu = <&CPU12>;
+				};
+				core1 {
+					cpu = <&CPU13>;
+				};
+				core2 {
+					cpu = <&CPU14>;
+				};
+				core3 {
+					cpu = <&CPU15>;
+				};
+			};
+		};
+		CPU0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+		};
+		CPU1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+		};
+		CPU2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+		};
+		CPU3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+		};
+		CPU4: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x100>;
+			clock-frequency = <1350000000>;
+		};
+		CPU5: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x101>;
+			clock-frequency = <1350000000>;
+		};
+		CPU6: cpu at 102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x102>;
+			clock-frequency = <1350000000>;
+		};
+		CPU7: cpu at 103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x103>;
+			clock-frequency = <1350000000>;
+		};
+		CPU8: cpu at 200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x200>;
+			clock-frequency = <1350000000>;
+		};
+		CPU9: cpu at 201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x201>;
+			clock-frequency = <1350000000>;
+		};
+		CPU10: cpu at 202 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x202>;
+			clock-frequency = <1350000000>;
+		};
+		CPU11: cpu at 203 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x203>;
+			clock-frequency = <1350000000>;
+		};
+		CPU12: cpu at 300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x300>;
+			clock-frequency = <1350000000>;
+		};
+		CPU13: cpu at 301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x301>;
+			clock-frequency = <1350000000>;
+		};
+		CPU14: cpu at 302 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x302>;
+			clock-frequency = <1350000000>;
+		};
+		CPU15: cpu at 303 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x303>;
+			clock-frequency = <1350000000>;
+		};
+	};
+
+	soc {
+		/* It's a 32-bit SoC. */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus", "simple-bus";
+		device_type = "soc";
+		interrupt-parent = <&gic>;
+		ranges = <0 0 0xe0000000 0x10000000>;
+
+		gic: interrupt-controller at c01000 {
+			compatible = "hisilicon,hip04-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+
+			/* gic dist base, gic cpu base */
+			reg = <0xc01000 0x1000>, <0xc02000 0x1000>;
+		};
+
+		mcpm: mcpm {
+			compatible = "hisilicon,hip04-mcpm";
+			reg = <0x100 0x1000>, <0x3e00000 0x00100000>,
+			      <0x302a000 0x1000>;
+		};
+
+		clock: clock {
+			compatible = "hisilicon,hip04-clock";
+			/* FIXME: the base of clock controller */
+			reg = <0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		dual_timer0: dual_timer at 3000000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x3000000 0x1000>;
+			interrupts = <0 224 4>;
+			clocks = <&clock HIP04_CLK_50M>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		timer {
+			compatible = "arm,armv7-timer";
+			interrupts = <1 13 0xf08>,
+				     <1 14 0xf08>,
+				     <1 11 0xf08>,
+				     <1 10 0xf08>;
+		};
+
+		uart0: uart at 4007000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x4007000 0x1000>;
+			interrupts = <0 381 4>;
+			clocks = <&clock HIP04_CLK_168M>;
+			clock-names = "uartclk";
+			reg-shift = <2>;
+			status = "disabled";
+		};
+	};
+};
-- 
1.8.3.2
