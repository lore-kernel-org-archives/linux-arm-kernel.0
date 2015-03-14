From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 14 Mar 2015 19:49:43 +0800
Subject: [PATCH 08/10] ARM: dts: zx: add an initial dts for zx296702
In-Reply-To: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1426333785-3952-9-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dts file for ZX296702 and board ZX296702-AD1.  More
peripherals will be added later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/zx296702-ad1.dts |  43 +++++++++++++
 arch/arm/boot/dts/zx296702.dtsi    | 127 +++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 arch/arm/boot/dts/zx296702-ad1.dts
 create mode 100644 arch/arm/boot/dts/zx296702.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..55dcfbc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -645,6 +645,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6592-evb.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
+dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 endif
 
 always		:= $(dtb-y)
diff --git a/arch/arm/boot/dts/zx296702-ad1.dts b/arch/arm/boot/dts/zx296702-ad1.dts
new file mode 100644
index 0000000..cac207a
--- /dev/null
+++ b/arch/arm/boot/dts/zx296702-ad1.dts
@@ -0,0 +1,43 @@
+
+/dts-v1/;
+
+#include "zx296702.dtsi"
+
+/ {
+	model = "ZTE ZX296702 AD1 Board";
+	compatible = "zte,zx296702-ad1", "zte,zx296702";
+
+	memory {
+		reg = <0x50000000 0x20000000>;
+	};
+};
+
+&dwmmc0 {
+	num-slots = <1>;
+	supports-highspeed;
+	non-removable;
+	disable-wp;
+	status = "okay";
+
+	slot at 0 {
+		reg = <0>;
+		bus-width = <4>;
+	};
+};
+
+&dwmmc1 {
+	num-slots = <1>;
+	supports-highspeed;
+	non-removable;
+	disable-wp;
+	status = "okay";
+
+	slot at 0 {
+		reg = <0>;
+		bus-width = <8>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/zx296702.dtsi b/arch/arm/boot/dts/zx296702.dtsi
new file mode 100644
index 0000000..2e66345
--- /dev/null
+++ b/arch/arm/boot/dts/zx296702.dtsi
@@ -0,0 +1,127 @@
+
+#include "skeleton.dtsi"
+#include <dt-bindings/clock/zx296702-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		intc: interrupt-controller at 00801000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupt-controller;
+			reg = <0x00801000 0x1000>,
+			      <0x00800100 0x100>;
+		};
+
+		global_timer: timer at 008000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x00800200 0x20>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&intc>;
+			clocks = <&clks ZX296702_A9_PERIPHCLK>;
+		};
+
+		l2cc: cache-controller at 0x00c00000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x00c00000 0x1000>;
+			arm,data-latency = <1 1 1>;
+			arm,tag-latency = <1 1 1>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		lsp1crpm: lsp1crpm at 0x09400000 {
+			compatible = "zte,zx296702-lsp1crpm";
+			reg = <0x09400000 0x1000>;
+		};
+
+		uart0: serial at 0x09405000 {
+			compatible = "zte,zx296702-uart";
+			reg = <0x09405000 0x1000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks ZX296702_UART0_PCLK>;
+			status = "disabled";
+		};
+
+		uart1: serial at 0x09406000 {
+			compatible = "zte,zx296702-uart";
+			reg = <0x09406000 0x1000>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks ZX296702_UART1_WCLK>;
+			status = "disabled";
+		};
+
+		dwmmc0: dwmmc at 0x09408000 {
+			compatible = "snps,dw-mshc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x09408000 0x1000>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			fifo-depth = <32>;
+			clocks = <&clks ZX296702_SDMMC0_PCLK>,
+				 <&clks ZX296702_SDMMC0_WCLK>;
+			clock-names = "biu", "ciu";
+			status = "disabled";
+		};
+
+		clks: topcrm at 0x09800000 {
+			compatible = "zte,zx296702-topcrm";
+			reg = <0x09800000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		lsp0crpm: lsp0crpm at 0x0b000000 {
+			compatible = "zte,zx296702-lsp0crpm";
+			reg = <0x0b000000 0x1000>;
+		};
+
+		dwmmc1: dwmmc at 0x0b003000 {
+			compatible = "snps,dw-mshc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0b003000 0x1000>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			fifo-depth = <32>;
+			clocks = <&clks ZX296702_SDMMC1_PCLK>,
+				 <&clks ZX296702_SDMMC1_WCLK>;
+			clock-names = "biu", "ciu";
+			status = "disabled";
+		};
+
+		aon_sysctrl: aon-sysctrl at 0xa0007000 {
+			compatible = "zte,aon-sysctrl";
+			reg = <0xa0007000 0x1000>;
+		};
+	};
+};
-- 
1.9.1
