From: marc.ceeeee@gmail.com (Marc Carino)
Date: Fri, 17 Jan 2014 11:19:27 -0800
Subject: [PATCH v4 8/8] ARM: brcmstb: dts: add a reference DTS for Broadcom
 7445
In-Reply-To: <1389986367-4010-1-git-send-email-marc.ceeeee@gmail.com>
References: <1389986367-4010-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1389986367-4010-9-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a sample DTS which will allow bootup of a board populated
with the BCM7445 chip.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm7445.dts |  111 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm7445.dts

diff --git a/arch/arm/boot/dts/bcm7445.dts b/arch/arm/boot/dts/bcm7445.dts
new file mode 100644
index 0000000..6f2d532
--- /dev/null
+++ b/arch/arm/boot/dts/bcm7445.dts
@@ -0,0 +1,111 @@
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Broadcom STB (bcm7445)";
+	compatible = "brcm,bcm7445", "brcm,brcmstb";
+	interrupt-parent = <&gic>;
+
+	chosen {};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00 0x00000000 0x00 0x40000000>,
+		      <0x00 0x40000000 0x00 0x40000000>,
+		      <0x00 0x80000000 0x00 0x40000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "brcm,brahma-b15";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			compatible = "brcm,brahma-b15";
+			device_type = "cpu";
+			reg = <1>;
+		};
+
+		cpu at 2 {
+			compatible = "brcm,brahma-b15";
+			device_type = "cpu";
+			reg = <2>;
+		};
+
+		cpu at 3 {
+			compatible = "brcm,brahma-b15";
+			device_type = "cpu";
+			reg = <3>;
+		};
+	};
+
+	gic: interrupt-controller at ffd00000 {
+		compatible = "brcm,brahma-b15-gic", "arm,cortex-a15-gic";
+		reg = <0x00 0xffd01000 0x00 0x1000>,
+		      <0x00 0xffd02000 0x00 0x2000>,
+		      <0x00 0xffd04000 0x00 0x2000>,
+		      <0x00 0xffd06000 0x00 0x2000>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0xf08>;
+	};
+
+	serial at f0406b00 {
+		compatible = "ns16550a";
+		reg = <0x00 0xf0406b00 0x00 0x20>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <0 75 0x4>;
+		clock-frequency = <0x4d3f640>;
+	};
+
+	rdb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0 0x00 0xf0000000 0x1000000>;
+
+		sun_top_ctrl: syscon at 404000 {
+			compatible = "brcm,bcm7445-sun-top-ctrl",
+				     "syscon";
+			reg = <0x404000 0x51c>;
+		};
+
+		hif_cpubiuctrl: syscon at 3e2400 {
+			compatible = "brcm,bcm7445-hif-cpubiuctrl",
+				     "syscon";
+			reg = <0x3e2400 0x5b4>;
+		};
+
+		hif_continuation: syscon at 452000 {
+			compatible = "brcm,bcm7445-hif-continuation",
+				     "syscon";
+			reg = <0x452000 0x100>;
+		};
+	};
+
+	smpboot {
+		compatible = "brcm,brcmstb-smpboot";
+		syscon-cpu = <&hif_cpubiuctrl 0x88 0x178>;
+		syscon-cont = <&hif_continuation>;
+	};
+
+	reboot {
+		compatible = "brcm,brcmstb-reboot";
+		syscon = <&sun_top_ctrl 0x304 0x308>;
+	};
+};
-- 
1.7.1
