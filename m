From: jun.nie@linaro.org (Jun Nie)
Date: Fri, 29 May 2015 10:39:37 +0800
Subject: [PATCH v5 3/4] ARM: dts: zx: add an initial zx296702 dts and doc
In-Reply-To: <1432867178-5913-1-git-send-email-jun.nie@linaro.org>
References: <1432867178-5913-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1432867178-5913-2-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dts file and document for ZX296702 and board ZX296702-AD1.
More peripherals will be added later.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 Documentation/devicetree/bindings/arm/zte.txt      |  15 +++
 .../devicetree/bindings/clock/zx296702-clk.txt     |  35 ++++++
 Documentation/devicetree/bindings/serial/pl011.txt |   2 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/zx296702-ad1.dts                 |  48 +++++++
 arch/arm/boot/dts/zx296702.dtsi                    | 139 +++++++++++++++++++++
 7 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/zte.txt
 create mode 100644 Documentation/devicetree/bindings/clock/zx296702-clk.txt
 create mode 100644 arch/arm/boot/dts/zx296702-ad1.dts
 create mode 100644 arch/arm/boot/dts/zx296702.dtsi

diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
new file mode 100644
index 0000000..3ff5c9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte.txt
@@ -0,0 +1,15 @@
+ZTE platforms device tree bindings
+---------------------------------------
+
+-  ZX296702 board:
+    Required root node properties:
+      - compatible = "zte,zx296702-ad1", "zte,zx296702"
+
+System management required properties:
+      - compatible = "zte,sysctrl"
+
+Low power management required properties:
+      - compatible = "zte,zx296702-pcu"
+
+Bus matrix required properties:
+      - compatible = "zte,zx-bus-matrix"
diff --git a/Documentation/devicetree/bindings/clock/zx296702-clk.txt b/Documentation/devicetree/bindings/clock/zx296702-clk.txt
new file mode 100644
index 0000000..750442b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/zx296702-clk.txt
@@ -0,0 +1,35 @@
+Device Tree Clock bindings for ZTE zx296702
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of the following:
+	"zte,zx296702-topcrm-clk":
+		zx296702 top clock selection, divider and gating
+
+	"zte,zx296702-lsp0crpm-clk" and
+	"zte,zx296702-lsp1crpm-clk":
+		zx296702 device level clock selection and gating
+
+- reg: Address and length of the register set
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell. See include/dt-bindings/clock/zx296702-clock.h
+for the full list of zx296702 clock IDs.
+
+
+topclk: topcrm at 0x09800000 {
+        compatible = "zte,zx296702-topcrm-clk";
+        reg = <0x09800000 0x1000>;
+        #clock-cells = <1>;
+};
+
+uart0: serial at 0x09405000 {
+        compatible = "zte,zx296702-uart";
+        reg = <0x09405000 0x1000>;
+        interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&lsp1clk ZX296702_UART0_PCLK>;
+        status = "disabled";
+};
diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
index ba3ecb8..cbae3d9 100644
--- a/Documentation/devicetree/bindings/serial/pl011.txt
+++ b/Documentation/devicetree/bindings/serial/pl011.txt
@@ -1,7 +1,7 @@
 * ARM AMBA Primecell PL011 serial UART
 
 Required properties:
-- compatible: must be "arm,primecell", "arm,pl011"
+- compatible: must be "arm,primecell", "arm,pl011", "zte,zx296702-uart"
 - reg: exactly one register range with length 0x1000
 - interrupts: exactly one interrupt specifier
 
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8033919..717ffd5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -211,3 +211,4 @@ xillybus	Xillybus Ltd.
 xlnx	Xilinx
 zyxel	ZyXEL Communications Corp.
 zarlink	Zarlink Semiconductor
+zte	ZTE Corp.
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 86217db..4814c6b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -660,6 +660,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6592-evb.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
+dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 endif
 
 always		:= $(dtb-y)
diff --git a/arch/arm/boot/dts/zx296702-ad1.dts b/arch/arm/boot/dts/zx296702-ad1.dts
new file mode 100644
index 0000000..081f980
--- /dev/null
+++ b/arch/arm/boot/dts/zx296702-ad1.dts
@@ -0,0 +1,48 @@
+
+/dts-v1/;
+
+#include "zx296702.dtsi"
+
+/ {
+	model = "ZTE ZX296702 AD1 Board";
+	compatible = "zte,zx296702-ad1", "zte,zx296702";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	memory {
+		reg = <0x50000000 0x20000000>;
+	};
+};
+
+&mmc0 {
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
+&mmc1 {
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
index 0000000..d45c8fc
--- /dev/null
+++ b/arch/arm/boot/dts/zx296702.dtsi
@@ -0,0 +1,139 @@
+
+#include "skeleton.dtsi"
+#include <dt-bindings/clock/zx296702-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "zte,zx296702-smp";
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			next-level-cache = <&l2cc>;
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			next-level-cache = <&l2cc>;
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
+		matrix: bus-matrix at 400000 {
+			compatible = "zte,zx-bus-matrix";
+			reg = <0x00400000 0x1000>;
+		};
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
+			clocks = <&topclk ZX296702_A9_PERIPHCLK>;
+		};
+
+		l2cc: l2-cache-controller at 0x00c00000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x00c00000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+			arm,data-latency = <1 1 1>;
+			arm,tag-latency = <1 1 1>;
+			arm,double-linefill = <1>;
+			arm,double-linefill-incr = <0>;
+		};
+
+		pcu: pcu at 0xa0008000 {
+			compatible = "zte,zx296702-pcu";
+			reg = <0xa0008000 0x1000>;
+		};
+
+		topclk: topclk at 0x09800000 {
+			compatible = "zte,zx296702-topcrm-clk";
+			reg = <0x09800000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		lsp1clk: lsp1clk at 0x09400000 {
+			compatible = "zte,zx296702-lsp1crpm-clk";
+			reg = <0x09400000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		lsp0clk: lsp0clk at 0x0b000000 {
+			compatible = "zte,zx296702-lsp0crpm-clk";
+			reg = <0x0b000000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		uart0: serial at 0x09405000 {
+			compatible = "zte,zx296702-uart";
+			reg = <0x09405000 0x1000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&lsp1clk ZX296702_UART0_WCLK>;
+			status = "disabled";
+		};
+
+		uart1: serial at 0x09406000 {
+			compatible = "zte,zx296702-uart";
+			reg = <0x09406000 0x1000>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&lsp1clk ZX296702_UART1_WCLK>;
+			status = "disabled";
+		};
+
+		mmc0: mmc at 0x09408000 {
+			compatible = "snps,dw-mshc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x09408000 0x1000>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			fifo-depth = <32>;
+			clocks = <&lsp1clk ZX296702_SDMMC0_PCLK>,
+				 <&lsp1clk ZX296702_SDMMC0_WCLK>;
+			clock-names = "biu", "ciu";
+			status = "disabled";
+		};
+
+		mmc1: mmc at 0x0b003000 {
+			compatible = "snps,dw-mshc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0b003000 0x1000>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			fifo-depth = <32>;
+			clocks = <&lsp0clk ZX296702_SDMMC1_PCLK>,
+				 <&lsp0clk ZX296702_SDMMC1_WCLK>;
+			clock-names = "biu", "ciu";
+			status = "disabled";
+		};
+
+		sysctrl: sysctrl at 0xa0007000 {
+			compatible = "zte,sysctrl", "syscon";
+			reg = <0xa0007000 0x1000>;
+		};
+	};
+};
-- 
1.9.1
