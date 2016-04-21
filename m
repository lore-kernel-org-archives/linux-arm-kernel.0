From: joel@jms.id.au (Joel Stanley)
Date: Thu, 21 Apr 2016 17:34:07 +0930
Subject: [PATCH v2 09/11] arm/dst: Add Aspeed ast2500 device tree
In-Reply-To: <1461225849-28074-1-git-send-email-joel@jms.id.au>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
Message-ID: <1461225849-28074-10-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a common device tree for all fifth generation Aspeed systems,
and a board specific device tree for the ast2500 evaluation board.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/Makefile               |   3 +-
 arch/arm/boot/dts/aspeed-ast2500-evb.dts |  21 +++++
 arch/arm/boot/dts/aspeed-g5.dtsi         | 156 +++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/aspeed-ast2500-evb.dts
 create mode 100644 arch/arm/boot/dts/aspeed-g5.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index dee3a92cbd3c..98251828883f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -839,7 +839,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
-dtb-$(CONFIG_ARCH_ASPEED) += aspeed-bmc-opp-palmetto.dtb
+dtb-$(CONFIG_ARCH_ASPEED) += aspeed-bmc-opp-palmetto.dtb \
+	aspeed-ast2500-evb.dtb
 endif
 
 dtstree		:= $(srctree)/$(src)
diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
new file mode 100644
index 000000000000..24f2b60ed2fd
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -0,0 +1,21 @@
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+
+/ {
+	model = "AST2500 EVB";
+	compatible = "aspeed,ast2500";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200";
+	};
+
+	memory {
+		reg = < 0x80000000 0x10000000 >;
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
new file mode 100644
index 000000000000..05a5f5bf458e
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -0,0 +1,156 @@
+#include "skeleton.dtsi"
+
+/ {
+	model = "Aspeed BMC";
+	compatible = "aspeed,ast2500";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&vic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,arm1176jzf-s";
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		serial5 = &uart6;
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vic: interrupt-controller at 1e6c0080 {
+			compatible = "aspeed,ast2400-vic";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			valid-sources = <0xfefff7ff 0x0807ffff>;
+			reg = <0x1e6c0080 0x80>;
+		};
+
+		apb {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clk_clkin: clk_clkin at 1e6e2070 {
+				#clock-cells = <0>;
+				compatible = "aspeed,g5-clkin-clock";
+				reg = <0x1e6e2070 0x04>;
+			};
+
+			clk_hpll: clk_hpll at 1e6e2024 {
+				#clock-cells = <0>;
+				compatible = "aspeed,g5-hpll-clock";
+				reg = <0x1e6e2024 0x4>;
+				clocks = <&clk_clkin>;
+			};
+
+			clk_ahb: clk_ahb at 1e6e2070 {
+				#clock-cells = <0>;
+				compatible = "aspeed,g5-ahb-clock";
+				reg = <0x1e6e2070 0x4>;
+				clocks = <&clk_hpll>;
+			};
+
+			clk_apb: clk_apb at 1e6e2008 {
+				#clock-cells = <0>;
+				compatible = "aspeed,g5-apb-clock";
+				reg = <0x1e6e2008 0x4>;
+				clocks = <&clk_hpll>;
+			};
+
+			sram at 1e720000 {
+				compatible = "mmio-sram";
+				reg = <0x1e720000 0x9000>;	// 36K
+			};
+
+			timer: timer at 1e782000 {
+				compatible = "aspeed,ast2400-timer";
+				reg = <0x1e782000 0x90>;
+				// The moxart_timer driver registers only one
+				// interrupt and assumes it's for timer 1
+				//interrupts = <16 17 18 35 36 37 38 39>;
+				interrupts = <16>;
+				clocks = <&clk_apb>;
+			};
+
+			uart1: serial at 1e783000 {
+				compatible = "ns16550a";
+				reg = <0x1e783000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <9>;
+				clock-frequency = <1843200>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
+			uart2: serial at 1e78d000 {
+				compatible = "ns16550a";
+				reg = <0x1e78d000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <32>;
+				clock-frequency = <1843200>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
+			uart3: serial at 1e78e000 {
+				compatible = "ns16550a";
+				reg = <0x1e78e000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <33>;
+				clock-frequency = <1843200>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
+			uart4: serial at 1e78f000 {
+				compatible = "ns16550a";
+				reg = <0x1e78f000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <34>;
+				clock-frequency = <1843200>;
+				current-speed = <115200>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
+			uart5: serial at 1e784000 {
+				compatible = "ns16550a";
+				reg = <0x1e784000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <10>;
+				clock-frequency = <1843200>;
+				current-speed = <38400>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
+			uart6: serial at 1e787000 {
+				compatible = "ns16550a";
+				reg = <0x1e787000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <10>;
+				clock-frequency = <1843200>;
+				current-speed = <38400>;
+				no-loopback-test;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
2.7.4
