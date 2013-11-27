From: marc.ceeeee@gmail.com (Marc Carino)
Date: Tue, 26 Nov 2013 16:22:28 -0800
Subject: [PATCH v2 6/6] ARM: brcmstb: dts: add a reference DTS for Broadcom
 7445
In-Reply-To: <1385511748-27869-1-git-send-email-marc.ceeeee@gmail.com>
References: <1385511748-27869-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1385511748-27869-7-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a sample DTS which will allow bootup of a board populated
with the BCM7445 chip.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/brcmstb-7445.dts |  115 ++++++++++++++++++++++++++++++++++++
 1 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/brcmstb-7445.dts

diff --git a/arch/arm/boot/dts/brcmstb-7445.dts b/arch/arm/boot/dts/brcmstb-7445.dts
new file mode 100644
index 0000000..a8b74c5
--- /dev/null
+++ b/arch/arm/boot/dts/brcmstb-7445.dts
@@ -0,0 +1,115 @@
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	model = "Broadcom STB (7445)";
+	compatible = "brcm,brcmstb";
+	interrupt-parent = <&gic>;
+
+	chosen {
+		bootargs = "earlyprintk console=ttyS0,115200";
+	};
+
+	memory {
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x40000000 0x40000000 0x80000000 0x40000000>;
+	};
+
+	cpupll: cpupll at 0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0x0>;
+		clock-frequency = <1500000000>;
+	};
+
+	cpuclk: cpu-clk-div at 0 {
+		compatible = "brcm,brcmstb-cpu-clk-div";
+		reg = <0xf03e257c 0x4>;
+		#clock-cells = <0x0>;
+		clocks = <&cpupll>;
+		div-table = <0x0 0x1 0x11 0x2 0x12 0x4 0x13 0x8 0x14 0x10>;
+	};
+
+	cpus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		cpu at 0 {
+			operating-points = <0x16e360 0x0
+								0xb71b0 0x0
+								0x5b8d8 0x0
+								0x2dc6c 0x0
+								0x16e36 0x0>;
+			clocks = <&cpuclk>;
+			device_type = "cpu";
+			compatible = "brcm,brahma15";
+			reg = <0x0>;
+			clock-frequency = <1500000000>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "brcm,brahma15";
+			reg = <0x1>;
+			clock-frequency = <1500000000>;
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "brcm,brahma15";
+			reg = <0x2>;
+			clock-frequency = <1500000000>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "brcm,brahma15";
+			reg = <0x3>;
+			clock-frequency = <1500000000>;
+		};
+	};
+
+	gic: interrupt-controller at ffd00000 {
+		compatible = "brcm,brahma15-gic", "arm,cortex-a15-gic";
+		interrupt-controller;
+		#interrupt-cells = <0x3>;
+		reg = <0xffd01000 0x1000 0xffd02000 0x2000>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <0x1 0xd 0xf08 0x1 0xe 0xf08 0x1 0xb 0xf08 0x1 0xa 0xf08>;
+	};
+
+	serial at f0406b00 {
+		compatible = "ns16550a";
+		reg = <0xf0406b00 0x20>;
+		reg-shift = <0x2>;
+		reg-io-width = <0x4>;
+		interrupts = <0x0 0x4b 0x4>;
+		clock-frequency = <0x4d3f640>;
+	};
+
+	sun-top-ctrl at f0404000 {
+		compatible = "brcm,brcmstb-sun-top-ctrl";
+		reg = <0xf0404000 0x51c>;
+		reset-source-enable-reg = <0x304>;
+		sw-master-reset-reg = <0x308>;
+	};
+
+	cpu-biu-ctrl at f03e2400 {
+		compatible = "brcm,brcmstb-cpu-biu-ctrl";
+		reg = <0xf03e2400 0x5b4>;
+		cpu-reset-config-reg = <0x178>;
+		cpu0-pwr-zone-ctrl-reg = <0x88>;
+	};
+
+	hif-continuation at f0452000 {
+		compatible = "brcm,brcmstb-hif-continuation";
+		reg = <0xf0452000 0x100>;
+		stb-boot-hi-addr0-reg = <0x0>;
+	};
+};
-- 
1.7.1
