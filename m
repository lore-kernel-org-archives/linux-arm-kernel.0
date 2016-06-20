From: tixy@linaro.org (Jon Medhurst)
Date: Mon, 20 Jun 2016 13:13:16 +0100
Subject: [PATCH 2/2] arm64: dts: Add device-tree for ARM's AEMv8A-AEMv8A FVP
 Base model
In-Reply-To: <1466424796-13769-1-git-send-email-tixy@linaro.org>
References: <1466424796-13769-1-git-send-email-tixy@linaro.org>
Message-ID: <1466424796-13769-2-git-send-email-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed Virtual Platform (FVP) Base models are simulations of systems
that resemble Versatile Express or Juno hardware.

This adds a device-tree for the model variant that has two clusters of
Architecture Envelope Model (AEM) v8-A CPUs. The peripheral devices that
are common to all variants of Base models have been placed in a separate
file (fvp-base.dtsi) to facilitate creating device-trees for other
models.

It is desirable to use simulations for code testing purposes and so it
is beneficial to include nodes for things that are timing and power
consumption related, even when these don't otherwise have relevance or
accuracy. Where these have been included here (e.g. idle-states) entries
have been copied from real hardware platforms such as Juno.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 arch/arm64/boot/dts/arm/Makefile                   |   1 +
 arch/arm64/boot/dts/arm/fvp-base-aemv8a-aemv8a.dts | 221 +++++++++++++++++
 arch/arm64/boot/dts/arm/fvp-base.dtsi              | 267 +++++++++++++++++++++
 3 files changed, 489 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
index 75cc2aa..7531001 100644
--- a/arch/arm64/boot/dts/arm/Makefile
+++ b/arch/arm64/boot/dts/arm/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb foundation-v8-gicv3.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += fvp-base-aemv8a-aemv8a.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb juno-r2.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
diff --git a/arch/arm64/boot/dts/arm/fvp-base-aemv8a-aemv8a.dts b/arch/arm64/boot/dts/arm/fvp-base-aemv8a-aemv8a.dts
new file mode 100644
index 0000000..2acfd26
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/fvp-base-aemv8a-aemv8a.dts
@@ -0,0 +1,221 @@
+/*
+ * ARM Ltd. Fixed Virtual Platform (FVP) Base model with dual cluster
+ * Architecture Envelope Model (AEM) v8-A CPUs
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "arm,fvp-base,aemv8a-aemv8a", "arm,fvp-base", "arm,vexpress";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	aliases {
+		serial0 = &bp_serial0;
+		serial1 = &bp_serial1;
+		serial2 = &bp_serial2;
+		serial3 = &bp_serial3;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0_0>;
+				};
+				core1 {
+					cpu = <&CPU0_1>;
+				};
+				core2 {
+					cpu = <&CPU0_2>;
+				};
+				core3 {
+					cpu = <&CPU0_3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU1_0>;
+				};
+				core1 {
+					cpu = <&CPU1_1>;
+				};
+				core2 {
+					cpu = <&CPU1_2>;
+				};
+				core3 {
+					cpu = <&CPU1_3>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "arm,psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
+				entry-latency-us = <300>;
+				exit-latency-us = <1200>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1010000>;
+				local-timer-stop;
+				entry-latency-us = <300>;
+				exit-latency-us = <1200>;
+				min-residency-us = <2500>;
+			};
+		};
+
+		CPU0_0: cpu at 0 {
+			compatible = "arm,armv8";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&CLUSTER0_L2>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		CPU0_1: cpu at 1 {
+			compatible = "arm,armv8";
+			reg = <0x0 0x1>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&CLUSTER0_L2>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		CPU0_2: cpu at 2 {
+			compatible = "arm,armv8";
+			reg = <0x0 0x2>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&CLUSTER0_L2>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		CPU0_3: cpu at 3 {
+			compatible = "arm,armv8";
+			reg = <0x0 0x3>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&CLUSTER0_L2>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		CPU1_0: cpu at 100 {
+			compatible = "arm,armv8";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&CLUSTER1_L2>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		CPU1_1: cpu at 101 {
+			compatible = "arm,armv8";
+			reg = <0x0 0x101>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&CLUSTER1_L2>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		CPU1_2: cpu at 102 {
+			compatible = "arm,armv8";
+			reg = <0x0 0x102>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&CLUSTER1_L2>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		CPU1_3: cpu at 103 {
+			compatible = "arm,armv8";
+			reg = <0x0 0x103>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&CLUSTER1_L2>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		CLUSTER0_L2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		CLUSTER1_L2: l2-cache1 {
+			compatible = "cache";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <100000000>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&CPU0_0>,
+				     <&CPU0_1>,
+				     <&CPU0_2>,
+				     <&CPU0_3>,
+				     <&CPU1_0>,
+				     <&CPU1_1>,
+				     <&CPU1_2>,
+				     <&CPU1_3>;
+	};
+
+	gic: interrupt-controller at 2f000000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		reg =	<0x0 0x2f000000 0x0 0x10000>,
+			<0x0 0x2f100000 0x0 0x100000>,
+			<0x0 0x2c000000 0x0 0x2000>,
+			<0x0 0x2c010000 0x0 0x2000>,
+			<0x0 0x2c02f000 0x0 0x2000>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		its: its at 2f020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			#msi-cells = <1>;
+			reg = <0x0 0x2f020000 0x0 0x20000>;
+		};
+	};
+
+	#include "fvp-base.dtsi"
+};
diff --git a/arch/arm64/boot/dts/arm/fvp-base.dtsi b/arch/arm64/boot/dts/arm/fvp-base.dtsi
new file mode 100644
index 0000000..ea3f170
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/fvp-base.dtsi
@@ -0,0 +1,267 @@
+	bp_clock35mhz: clock35mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <35000000>;
+		clock-output-names = "bp:clock35mhz";
+	};
+
+	bp_clock24mhz: clock24mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "bp:clock24mhz";
+	};
+
+	flash at 8000000 {
+		compatible = "arm,vexpress-flash", "cfi-flash";
+		reg = <0x0 0x08000000 0x0 0x04000000>,
+		      <0x0 0x0C000000 0x0 0x04000000>;
+		bank-width = <4>;
+	};
+
+	bp_video_ram: vram at 18000000 {
+		compatible = "arm,vexpress-vram";
+		reg = <0x0 0x18000000 0x0 0x00800000>;
+	};
+
+	ethernet at 1a000000 {
+		compatible = "smsc,lan91c111";
+		reg = <0x0 0x1a000000 0x0 0x10000>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	bp_sysreg: sysreg at 1c010000 {
+		compatible = "arm,vexpress-sysreg";
+		reg = <0x0 0x1c010000 0x0 0x1000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	mcc {
+		compatible = "arm,vexpress,config-bus";
+		arm,vexpress,config-bridge = <&bp_sysreg>;
+
+		bp_oscclk1: oscclk1 {
+			compatible = "arm,vexpress-osc";
+			arm,vexpress-sysreg,func = <1 1>;
+			freq-range = <23750000 63500000>;
+			#clock-cells = <0>;
+			clock-output-names = "bp:oscclk1";
+		};
+
+		muxfpga {
+			compatible = "arm,vexpress-muxfpga";
+			arm,vexpress-sysreg,func = <7 0>;
+		};
+
+		shutdown {
+			compatible = "arm,vexpress-shutdown";
+			arm,vexpress-sysreg,func = <8 0>;
+		};
+
+		reboot {
+			compatible = "arm,vexpress-reboot";
+			arm,vexpress-sysreg,func = <9 0>;
+		};
+	};
+
+	sysctl_refclk: sysctl-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000>;
+		clock-output-names = "sysctl:refclk";
+	};
+
+	sysctl_timclk: sysctl-timclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "sysctl:timclk";
+	};
+
+	bp_sysctl: sysctl at 1c020000 {
+		compatible = "arm,sp810", "arm,primecell";
+		reg = <0x0 0x1c020000 0x0 0x1000>;
+		clocks = <&sysctl_refclk>, <&sysctl_timclk>, <&bp_clock35mhz>;
+		clock-names = "refclk", "timclk", "apb_pclk";
+		#clock-cells = <1>;
+		clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
+		assigned-clocks = <&bp_sysctl 0>, <&bp_sysctl 1>, <&bp_sysctl 3>, <&bp_sysctl 3>;
+		assigned-clock-parents = <&sysctl_timclk>, <&sysctl_timclk>, <&sysctl_timclk>, <&sysctl_timclk>;
+	};
+
+	aaci at 1c040000 {
+		compatible = "arm,pl041", "arm,primecell";
+		reg = <0x0 0x1c040000 0x0 0x1000>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_clock24mhz>;
+		clock-names = "apb_pclk";
+	};
+
+	bp_fixed_3v3: bp-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	mmci at 1c050000 {
+		compatible = "arm,pl180", "arm,primecell";
+		reg = <0x0 0x1c050000 0x0 0x1000>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		cd-gpios = <&bp_sysreg 0 0>;
+		wp-gpios = <&bp_sysreg 1 0>;
+		max-frequency = <12000000>;
+		vmmc-supply = <&bp_fixed_3v3>;
+		clocks = <&bp_clock24mhz>, <&bp_clock24mhz>;
+		clock-names = "mclk", "apb_pclk";
+	};
+
+	kmi at 1c060000 {
+		compatible = "arm,pl050", "arm,primecell";
+		reg = <0x0 0x1c060000 0x0 0x1000>;
+		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_clock24mhz>, <&bp_clock24mhz>;
+		clock-names = "KMIREFCLK", "apb_pclk";
+	};
+
+	kmi at 1c070000 {
+		compatible = "arm,pl050", "arm,primecell";
+		reg = <0x0 0x1c070000 0x0 0x1000>;
+		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_clock24mhz>, <&bp_clock24mhz>;
+		clock-names = "KMIREFCLK", "apb_pclk";
+	};
+
+	bp_serial0: uart at 1c090000 {
+		compatible = "arm,pl011", "arm,primecell";
+		reg = <0x0 0x1c090000 0x0 0x1000>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_clock24mhz>, <&bp_clock24mhz>;
+		clock-names = "uartclk", "apb_pclk";
+	};
+
+	bp_serial1: uart at 1c0a0000 {
+		compatible = "arm,pl011", "arm,primecell";
+		reg = <0x0 0x1c0a0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_clock24mhz>, <&bp_clock24mhz>;
+		clock-names = "uartclk", "apb_pclk";
+	};
+
+	bp_serial2: uart at 1c0b0000 {
+		compatible = "arm,pl011", "arm,primecell";
+		reg = <0x0 0x1c0b0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_clock24mhz>, <&bp_clock24mhz>;
+		clock-names = "uartclk", "apb_pclk";
+	};
+
+	bp_serial3: uart at 1c0c0000 {
+		compatible = "arm,pl011", "arm,primecell";
+		reg = <0x0 0x1c0c0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_clock24mhz>, <&bp_clock24mhz>;
+		clock-names = "uartclk", "apb_pclk";
+	};
+
+	wdt at 1c0f0000 {
+		compatible = "arm,sp805", "arm,primecell";
+		reg = <0x0 0x1c0f0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_clock24mhz>, <&bp_clock24mhz>;
+		clock-names = "wdogclk", "apb_pclk";
+	};
+
+	bp_timer01: timer at 1c110000 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0x0 0x1c110000 0x0 0x1000>;
+		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_sysctl 0>, <&bp_sysctl 1>, <&bp_clock35mhz>;
+		clock-names = "timclken1", "timclken2", "apb_pclk";
+	};
+
+	bp_timer23: timer at 1c120000 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0x0 0x1c120000 0x0 0x1000>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_sysctl 2>, <&bp_sysctl 3>, <&bp_clock35mhz>;
+		clock-names = "timclken1", "timclken2", "apb_pclk";
+	};
+
+	virtio_block at 1c0130000 {
+		compatible = "virtio,mmio";
+		reg = <0x0 0x1c130000 0x0 0x200>;
+		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	rtc at 1c170000 {
+		compatible = "arm,pl031", "arm,primecell";
+		reg = <0x0 0x1c170000 0x0 0x1000>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_clock24mhz>;
+		clock-names = "apb_pclk";
+	};
+
+	clcd at 1c1f0000 {
+		compatible = "arm,pl111", "arm,primecell";
+		reg = <0x0 0x1c1f0000 0x0 0x1000>;
+		interrupt-names = "combined";
+		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_oscclk1>, <&bp_clock24mhz>;
+		clock-names = "clcdclk", "apb_pclk";
+		arm,pl11x,framebuffer = <0x18000000 0x00180000>;
+		memory-region = <&bp_video_ram>;
+		max-memory-bandwidth = <130000000>; /* 16bpp @ 63.5MHz */
+
+		port {
+			bp_clcd_pads: endpoint {
+				remote-endpoint = <&bp_clcd_panel>;
+				arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+			};
+		};
+
+		panel {
+			compatible = "panel-dpi";
+
+			port {
+				bp_clcd_panel: endpoint {
+					remote-endpoint = <&bp_clcd_pads>;
+				};
+			};
+
+			panel-timing {
+				clock-frequency = <63500127>;
+				hactive = <1024>;
+				hback-porch = <152>;
+				hfront-porch = <48>;
+				hsync-len = <104>;
+				vactive = <768>;
+				vback-porch = <23>;
+				vfront-porch = <3>;
+				vsync-len = <4>;
+			};
+		};
+	};
+
+	timer at 2a810000 {
+		compatible = "arm,armv7-timer-mem";
+		reg = <0x0 0x2a810000 0x0 0x1000>;
+		clock-frequency = <50000000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		frame at 2a830000 {
+			frame-number = <1>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x0 0x2a830000 0x0 0x1000>;
+		};
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x80000000>,
+		      <0x00000008 0x80000000 0 0x80000000>;
+	};
-- 
2.1.4
