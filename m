From: marc.ceeeee@gmail.com (Marc Carino)
Date: Tue, 14 Jan 2014 15:48:53 -0800
Subject: [PATCH v3 7/7] ARM: brcmstb: dts: add a reference DTS for Broadcom
 7445
In-Reply-To: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
References: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1389743333-16741-8-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a sample DTS which will allow bootup of a board populated
with the BCM7445 chip.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/brcmstb-7445.dts |  104 ++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/brcmstb-7445.dts

diff --git a/arch/arm/boot/dts/brcmstb-7445.dts b/arch/arm/boot/dts/brcmstb-7445.dts
new file mode 100644
index 0000000..cbe73b4
--- /dev/null
+++ b/arch/arm/boot/dts/brcmstb-7445.dts
@@ -0,0 +1,104 @@
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	model = "Broadcom STB (7445)";
+	compatible = "brcm,brcmstb-7445";
+	interrupt-parent = <&gic>;
+
+	chosen {};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x40000000 0x40000000 0x80000000 0x40000000>;
+	};
+
+	cpupll: cpupll at 0 {
+		#clock-cells = <0x0>;
+		compatible = "fixed-clock";
+		clock-frequency = <1500000000>;
+	};
+
+	cpuclk: cpu-clk-div at 0 {
+		#clock-cells = <0x0>;
+		compatible = "brcm,brcmstb-cpu-clk-div";
+		reg = <0xf03e257c 0x4>;
+		clocks = <&cpupll>;
+		div-table = <0x0 0x1 0x11 0x2 0x12 0x4 0x13 0x8 0x14 0x10>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "brcm,brahma15";
+			operating-points = <0x16e360 0x0
+					    0x0b71b0 0x0
+					    0x05b8d8 0x0
+					    0x02dc6c 0x0
+					    0x016e36 0x0>;
+			clocks = <&cpuclk>;
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <1500000000>;
+		};
+
+		cpu at 1 {
+			compatible = "brcm,brahma15";
+			device_type = "cpu";
+			reg = <1>;
+			clock-frequency = <1500000000>;
+		};
+
+		cpu at 2 {
+			compatible = "brcm,brahma15";
+			device_type = "cpu";
+			reg = <2>;
+			clock-frequency = <1500000000>;
+		};
+
+		cpu at 3 {
+			compatible = "brcm,brahma15";
+			device_type = "cpu";
+			reg = <3>;
+			clock-frequency = <1500000000>;
+		};
+	};
+
+	gic: interrupt-controller at ffd00000 {
+		compatible = "brcm,brahma15-gic", "arm,cortex-a15-gic";
+		reg = <0xffd01000 0x1000
+		       0xffd02000 0x2000>;
+		interrupt-controller;
+		#interrupt-cells = <0x3>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 13 0xf08
+			      1 14 0xf08
+			      1 11 0xf08
+			      1 10 0xf08>;
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
+	gen-ctrl {
+		compatible = "brcm,brcmstb-gen-ctrl-v1";
+		reg = <0xf0404304 0x4
+		       0xf0404308 0x4
+		       0xf03e2578 0x4
+		       0xf03e2488 0x10
+		       0xf0452000 0x20>;
+	};
+};
-- 
1.7.1
