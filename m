From: joel@jms.id.au (Joel Stanley)
Date: Thu, 14 Apr 2016 19:17:47 +0930
Subject: [PATCH 7/9] arm/dts: Add aspeed device trees
In-Reply-To: <1460627269-21721-1-git-send-email-joel@jms.id.au>
References: <1460627269-21721-1-git-send-email-joel@jms.id.au>
Message-ID: <1460627269-21721-8-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common device tree, and a board specific dts for the Palmetto
OpenPower developemnt machine which was used for testing.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/Makefile                    |   3 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |  21 ++++
 arch/arm/boot/dts/ast2400.dtsi                | 152 ++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
 create mode 100644 arch/arm/boot/dts/ast2400.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 95c1923ce6fa..0600a7f58e8a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -839,6 +839,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
+dtb-$(CONFIG_ARCH_ASPEED) += aspeed-bmc-opp-palmetto.dtb \
+	aspeed-bmc-opp-barreleye.dtb \
+	aspeed-bmc-opp-firestone.dtb
 endif
 
 dtstree		:= $(srctree)/$(src)
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
new file mode 100644
index 000000000000..5caa7a1b55d2
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -0,0 +1,21 @@
+/dts-v1/;
+
+#include "ast2400.dtsi"
+
+/ {
+	model = "Palmetto BMC";
+	compatible = "tyan,palmetto-bmc", "aspeed,ast2400";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,38400";
+	};
+
+	memory {
+		reg = < 0x40000000 0x10000000 >;
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/ast2400.dtsi b/arch/arm/boot/dts/ast2400.dtsi
new file mode 100644
index 000000000000..6d22ad837fe4
--- /dev/null
+++ b/arch/arm/boot/dts/ast2400.dtsi
@@ -0,0 +1,152 @@
+#include "skeleton.dtsi"
+
+/ {
+	model = "Aspeed BMC";
+	compatible = "aspeed,ast2400";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&vic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,arm926ej-s";
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
+	clocks {
+		clk_clkin: clk_clkin {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <48000000>;
+		};
+
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
+			valid-sources = <0xffffffff 0x0007ffff>;
+			reg = <0x1e6c0080 0x80>;
+		};
+
+		apb {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clk_hpll: clk_hpll at 1e6e2070 {
+				#clock-cells = <0>;
+				compatible = "aspeed,ast2400-hpll-clock";
+				reg = <0x1e6e2070 0x4>;
+				clocks = <&clk_clkin>;
+			};
+
+			clk_apb: clk_apb at 1e6e2008 {
+				#clock-cells = <0>;
+				compatible = "aspeed,ast2400-apb-clock";
+				reg = <0x1e6e2008 0x4>;
+				clocks = <&clk_hpll>;
+			};
+
+			sram at 1e720000 {
+				compatible = "mmio-sram";
+				reg = <0x1e720000 0x8000>;	// 32K
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
