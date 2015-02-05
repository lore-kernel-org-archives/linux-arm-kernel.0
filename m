From: bintian.wang@huawei.com (Bintian Wang)
Date: Thu, 5 Feb 2015 17:24:37 +0800
Subject: [PATCH 3/3] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <1423128277-10297-4-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dtsi file to support Hisilicon Hi6220 SoC with
support of Octal core CPUs in two clusters and each cluster
has quard Cortex-A53.

We now use the "spin-table" method for SMP, and it will be
changed to PSCI later.

Also add dts file to support HiKey development board which
based on Hi6220 SoC and document the devicetree bindings.

These dts files will be changed later and more nodes will be
added to describe other devices.

Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
Reviewed-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Reviewed-by: Yiping Xu <xuyiping@hisilicon.com>
---
 .../bindings/arm/hisilicon/hisilicon.txt           |   33 ++++
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/hisilicon/Makefile             |    5 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   31 +++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  204 ++++++++++++++++++++
 5 files changed, 274 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index f717c7b..5eb6b41 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -9,6 +9,9 @@ HiP04 D01 Board
 Required root node properties:
 	- compatible = "hisilicon,hip04-d01";
 
+HiKey Board
+Required root node properties:
+	- compatible = "hisilicon,hi6220-hikey";
 
 Hisilicon system controller
 
@@ -62,6 +65,36 @@ Example:
 	};
 
 -----------------------------------------------------------------------
+Hisilicon Power Always ON domain controller
+
+Required properties:
+- compatible : "hisilicon,aoctrl"
+- reg : Register address and size
+
+Some clock registers are defined in power always on system controller,
+especially in Hi6220 SoC which is used for mobile platform.
+
+-----------------------------------------------------------------------
+Hisilicon Media domain controller
+
+Required properties:
+- compatible : "hisilicon,mediactrl"
+- reg : Register address and size
+
+Some clock registers of media module are defined in media system
+controller, especially in Hi6220 SoC which is used for mobile platform.
+
+-----------------------------------------------------------------------
+Hisilicon Power Management domain controller
+
+Required properties:
+- compatible : "hisilicon,pmctrl"
+- reg : Register address and size
+
+Some clock registers and PMU registers are defined in power management
+controller, especially in Hin6220 SoC which is used for mobile platform.
+
+-----------------------------------------------------------------------
 Fabric:
 
 Required Properties:
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index c62b0f4..bffd6b7 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -2,5 +2,6 @@ dts-dirs += amd
 dts-dirs += apm
 dts-dirs += arm
 dts-dirs += cavium
+dts-dirs += hisilicon
 
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
new file mode 100644
index 0000000..fa81a6e
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
new file mode 100644
index 0000000..a94da84
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -0,0 +1,31 @@
+/*
+ * dts file for Hisilicon HiKey Development Board
+ *
+ * Copyright (C) 2015, Hisilicon Ltd.
+ *
+ */
+
+/dts-v1/;
+
+/memreserve/ 0x0740f000 0x1000;
+
+#include "hi6220.dtsi"
+
+/ {
+	model = "HiKey Development Board";
+	compatible = "hisilicon,hi6220-hikey";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen { };
+
+	memory at 7400000 {
+		device_type = "memory";
+		reg = <0x0 0x07400000 0x0 0x38c00000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
new file mode 100644
index 0000000..53ba9cf
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -0,0 +1,204 @@
+/*
+ * dts file for Hisilicon Hi6220 SoC
+ *
+ * Copyright (C) 2015, Hisilicon Ltd.
+ */
+
+#include <dt-bindings/clock/hi6220-clock.h>
+
+/ {
+	cpu-map {
+		cluster0 {
+			core0 {
+				cpu = <&cpu0>;
+			};
+			core1 {
+				cpu = <&cpu1>;
+			};
+			core2 {
+				cpu = <&cpu2>;
+			};
+			core3 {
+				cpu = <&cpu3>;
+			};
+		};
+		cluster1 {
+			core0 {
+				cpu = <&cpu4>;
+			};
+			core1 {
+				cpu = <&cpu5>;
+			};
+			core2 {
+				cpu = <&cpu6>;
+			};
+			core3 {
+				cpu = <&cpu7>;
+			};
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 000 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x740fff8>;
+			clock-latency = <0>;
+		};
+		cpu1: cpu at 001 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x740fff8>;
+			clock-latency = <0>;
+		};
+		cpu2: cpu at 002 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x740fff8>;
+			clock-latency = <0>;
+		};
+		cpu3: cpu at 003 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x740fff8>;
+			clock-latency = <0>;
+		};
+		cpu4: cpu at 100 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x740fff8>;
+			clock-latency = <0>;
+		};
+		cpu5: cpu at 101 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x740fff8>;
+			clock-latency = <0>;
+		};
+		cpu6: cpu at 102 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x102>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x740fff8>;
+			clock-latency = <0>;
+		};
+		cpu7: cpu at 103 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x103>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x740fff8>;
+			clock-latency = <0>;
+		};
+	};
+
+	gic: interrupt-controller at f6800000 {
+		compatible = "arm,gic-400", "arm,cortex-a15-gic";
+		reg = <0x0 0xf6801000 0x0 0x1000>, /* GICD */
+		      <0x0 0xf6802000 0x0 0x2000>, /* GICC */
+		      <0x0 0xf6804000 0x0 0x2000>, /* GICH */
+		      <0x0 0xf6806000 0x0 0x2000>; /* GICV */
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+	};
+
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <1 13 0xff08>,
+			     <1 14 0xff08>,
+			     <1 11 0xff08>,
+			     <1 10 0xff08>;
+		clock-frequency = <1200000>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		interrupt-parent = <&gic>;
+		ranges;
+
+		ao_ctrl: ao_ctrl {
+			compatible = "hisilicon,aoctrl", "syscon";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0xf7800000 0x0 0x2000>;
+			ranges = <0 0x0 0xf7800000 0x2000>;
+
+			clock_ao: clock0 at 0 {
+				compatible = "hisilicon,hi6220-clock-ao";
+				reg = <0 0x1000>;
+				#clock-cells = <1>;
+			};
+		};
+
+		sys_ctrl: sys_ctrl {
+			compatible = "hisilicon,sysctrl", "syscon";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0xf7030000 0x0 0x2000>;
+			ranges = <0 0x0 0xf7030000 0x2000>;
+
+			clock_sys: clock1 at 0 {
+				compatible = "hisilicon,hi6220-clock-sys";
+				reg = <0 0x1000>;
+				#clock-cells = <1>;
+			};
+		};
+
+		media_ctrl: media_ctrl {
+			compatible = "hisilicon,mediactrl", "syscon";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0xf4410000 0x0 0x1000>;
+			ranges = <0 0x0 0xf4410000 0x1000>;
+
+			clock_media: clock2 at 0 {
+				compatible = "hisilicon,hi6220-clock-media";
+				reg = <0 0x1000>;
+				#clock-cells = <1>;
+			};
+		};
+
+		pm_ctrl: pm_ctrl {
+			compatible = "hisilicon,pmctrl", "syscon";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0xf7032000 0x0 0x1000>;
+			ranges = <0 0x0 0xf7032000 0x1000>;
+
+			clock_power: clock3 at 0 {
+				compatible = "hisilicon,hi6220-clock-power";
+				reg = <0 0x1000>;
+				#clock-cells = <1>;
+			};
+		};
+
+		uart0: uart at f8015000 {	/* console */
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xf8015000 0x0 0x1000>;
+			interrupts = <0 36 4>;
+			clocks = <&clock_ao HI6220_UART0_PCLK>, <&clock_ao HI6220_UART0_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+	};
+};
-- 
1.7.9.5
