From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  4 Jan 2013 14:17:19 +0000
Subject: [PATCH v3 5/7] arm64: Add dts files for the ARMv8 RTSM model
In-Reply-To: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
References: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1357309041-6192-6-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pawel Moll <Pawel.Moll@arm.com>

Signed-off-by: Pawel Moll <Pawel.Moll@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/boot/dts/Makefile                 |   2 +
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts       | 154 ++++++++++++++++++
 arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi | 234 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/skeleton.dtsi            |  13 ++
 4 files changed, 403 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
 create mode 100644 arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
 create mode 100644 arch/arm64/boot/dts/skeleton.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 801e2d7..6d9a147 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,3 +1,5 @@
+dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
+
 targets += dtbs
 
 dtbs: $(addprefix $(obj)/, $(dtb-y))
diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
new file mode 100644
index 0000000..15df04c
--- /dev/null
+++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
@@ -0,0 +1,154 @@
+/*
+ * ARM Ltd. Fast Models
+ *
+ * Architecture Envelope Model (AEM) ARMv8-A
+ * ARMAEMv8AMPCT
+ *
+ * RTSM_VE_AEMv8A.lisa
+ */
+
+/dts-v1/;
+
+/memreserve/ 0x80000000 0x00010000;
+
+/ {
+	model = "RTSM_VE_AEMv8A";
+	compatible = "arm,rtsm_ve,aemv8a", "arm,vexpress";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	aliases {
+		serial0 = &v2m_serial0;
+		serial1 = &v2m_serial1;
+		serial2 = &v2m_serial2;
+		serial3 = &v2m_serial3;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x80000000>,
+		      <0x00000008 0x80000000 0 0x80000000>;
+	};
+
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0 0x2c001000 0 0x1000>,
+		      <0 0x2c002000 0 0x100>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 14 0xff01>;
+		clock-frequency = <100000000>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <0 60 4>,
+			     <0 61 4>,
+			     <0 62 4>,
+			     <0 63 4>;
+	};
+
+	smb {
+		compatible = "simple-bus";
+
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0x08000000 0x04000000>,
+			 <1 0 0 0x14000000 0x04000000>,
+			 <2 0 0 0x18000000 0x04000000>,
+			 <3 0 0 0x1c000000 0x04000000>,
+			 <4 0 0 0x0c000000 0x04000000>,
+			 <5 0 0 0x10000000 0x04000000>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 63>;
+		interrupt-map = <0 0  0 &gic 0  0 4>,
+				<0 0  1 &gic 0  1 4>,
+				<0 0  2 &gic 0  2 4>,
+				<0 0  3 &gic 0  3 4>,
+				<0 0  4 &gic 0  4 4>,
+				<0 0  5 &gic 0  5 4>,
+				<0 0  6 &gic 0  6 4>,
+				<0 0  7 &gic 0  7 4>,
+				<0 0  8 &gic 0  8 4>,
+				<0 0  9 &gic 0  9 4>,
+				<0 0 10 &gic 0 10 4>,
+				<0 0 11 &gic 0 11 4>,
+				<0 0 12 &gic 0 12 4>,
+				<0 0 13 &gic 0 13 4>,
+				<0 0 14 &gic 0 14 4>,
+				<0 0 15 &gic 0 15 4>,
+				<0 0 16 &gic 0 16 4>,
+				<0 0 17 &gic 0 17 4>,
+				<0 0 18 &gic 0 18 4>,
+				<0 0 19 &gic 0 19 4>,
+				<0 0 20 &gic 0 20 4>,
+				<0 0 21 &gic 0 21 4>,
+				<0 0 22 &gic 0 22 4>,
+				<0 0 23 &gic 0 23 4>,
+				<0 0 24 &gic 0 24 4>,
+				<0 0 25 &gic 0 25 4>,
+				<0 0 26 &gic 0 26 4>,
+				<0 0 27 &gic 0 27 4>,
+				<0 0 28 &gic 0 28 4>,
+				<0 0 29 &gic 0 29 4>,
+				<0 0 30 &gic 0 30 4>,
+				<0 0 31 &gic 0 31 4>,
+				<0 0 32 &gic 0 32 4>,
+				<0 0 33 &gic 0 33 4>,
+				<0 0 34 &gic 0 34 4>,
+				<0 0 35 &gic 0 35 4>,
+				<0 0 36 &gic 0 36 4>,
+				<0 0 37 &gic 0 37 4>,
+				<0 0 38 &gic 0 38 4>,
+				<0 0 39 &gic 0 39 4>,
+				<0 0 40 &gic 0 40 4>,
+				<0 0 41 &gic 0 41 4>,
+				<0 0 42 &gic 0 42 4>;
+
+		/include/ "rtsm_ve-motherboard.dtsi"
+	};
+};
+
diff --git a/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
new file mode 100644
index 0000000..b45e5f3
--- /dev/null
+++ b/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
@@ -0,0 +1,234 @@
+/*
+ * ARM Ltd. Fast Models
+ *
+ * Versatile Express (VE) system model
+ * Motherboard component
+ *
+ * VEMotherBoard.lisa
+ */
+
+	motherboard {
+		arm,v2m-memory-map = "rs1";
+		compatible = "arm,vexpress,v2m-p1", "simple-bus";
+		#address-cells = <2>; /* SMB chipselect number and offset */
+		#size-cells = <1>;
+		#interrupt-cells = <1>;
+		ranges;
+
+		flash at 0,00000000 {
+			compatible = "arm,vexpress-flash", "cfi-flash";
+			reg = <0 0x00000000 0x04000000>,
+			      <4 0x00000000 0x04000000>;
+			bank-width = <4>;
+		};
+
+		vram at 2,00000000 {
+			compatible = "arm,vexpress-vram";
+			reg = <2 0x00000000 0x00800000>;
+		};
+
+		ethernet at 2,02000000 {
+			compatible = "smsc,lan91c111";
+			reg = <2 0x02000000 0x10000>;
+			interrupts = <15>;
+		};
+
+		v2m_clk24mhz: clk24mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "v2m:clk24mhz";
+		};
+
+		v2m_refclk1mhz: refclk1mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1000000>;
+			clock-output-names = "v2m:refclk1mhz";
+		};
+
+		v2m_refclk32khz: refclk32khz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "v2m:refclk32khz";
+		};
+
+		iofpga at 3,00000000 {
+			compatible = "arm,amba-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 3 0 0x200000>;
+
+			v2m_sysreg: sysreg at 010000 {
+				compatible = "arm,vexpress-sysreg";
+				reg = <0x010000 0x1000>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			v2m_sysctl: sysctl at 020000 {
+				compatible = "arm,sp810", "arm,primecell";
+				reg = <0x020000 0x1000>;
+				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&v2m_clk24mhz>;
+				clock-names = "refclk", "timclk", "apb_pclk";
+				#clock-cells = <1>;
+				clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
+			};
+
+			aaci at 040000 {
+				compatible = "arm,pl041", "arm,primecell";
+				reg = <0x040000 0x1000>;
+				interrupts = <11>;
+				clocks = <&v2m_clk24mhz>;
+				clock-names = "apb_pclk";
+			};
+
+			mmci at 050000 {
+				compatible = "arm,pl180", "arm,primecell";
+				reg = <0x050000 0x1000>;
+				interrupts = <9 10>;
+				cd-gpios = <&v2m_sysreg 0 0>;
+				wp-gpios = <&v2m_sysreg 1 0>;
+				max-frequency = <12000000>;
+				vmmc-supply = <&v2m_fixed_3v3>;
+				clocks = <&v2m_clk24mhz>, <&v2m_clk24mhz>;
+				clock-names = "mclk", "apb_pclk";
+			};
+
+			kmi at 060000 {
+				compatible = "arm,pl050", "arm,primecell";
+				reg = <0x060000 0x1000>;
+				interrupts = <12>;
+				clocks = <&v2m_clk24mhz>, <&v2m_clk24mhz>;
+				clock-names = "KMIREFCLK", "apb_pclk";
+			};
+
+			kmi at 070000 {
+				compatible = "arm,pl050", "arm,primecell";
+				reg = <0x070000 0x1000>;
+				interrupts = <13>;
+				clocks = <&v2m_clk24mhz>, <&v2m_clk24mhz>;
+				clock-names = "KMIREFCLK", "apb_pclk";
+			};
+
+			v2m_serial0: uart at 090000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x090000 0x1000>;
+				interrupts = <5>;
+				clocks = <&v2m_clk24mhz>, <&v2m_clk24mhz>;
+				clock-names = "uartclk", "apb_pclk";
+			};
+
+			v2m_serial1: uart at 0a0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0a0000 0x1000>;
+				interrupts = <6>;
+				clocks = <&v2m_clk24mhz>, <&v2m_clk24mhz>;
+				clock-names = "uartclk", "apb_pclk";
+			};
+
+			v2m_serial2: uart at 0b0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0b0000 0x1000>;
+				interrupts = <7>;
+				clocks = <&v2m_clk24mhz>, <&v2m_clk24mhz>;
+				clock-names = "uartclk", "apb_pclk";
+			};
+
+			v2m_serial3: uart at 0c0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x0c0000 0x1000>;
+				interrupts = <8>;
+				clocks = <&v2m_clk24mhz>, <&v2m_clk24mhz>;
+				clock-names = "uartclk", "apb_pclk";
+			};
+
+			wdt at 0f0000 {
+				compatible = "arm,sp805", "arm,primecell";
+				reg = <0x0f0000 0x1000>;
+				interrupts = <0>;
+				clocks = <&v2m_refclk32khz>, <&v2m_clk24mhz>;
+				clock-names = "wdogclk", "apb_pclk";
+			};
+
+			v2m_timer01: timer at 110000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x110000 0x1000>;
+				interrupts = <2>;
+				clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_clk24mhz>;
+				clock-names = "timclken1", "timclken2", "apb_pclk";
+			};
+
+			v2m_timer23: timer at 120000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x120000 0x1000>;
+				interrupts = <3>;
+				clocks = <&v2m_sysctl 2>, <&v2m_sysctl 3>, <&v2m_clk24mhz>;
+				clock-names = "timclken1", "timclken2", "apb_pclk";
+			};
+
+			rtc at 170000 {
+				compatible = "arm,pl031", "arm,primecell";
+				reg = <0x170000 0x1000>;
+				interrupts = <4>;
+				clocks = <&v2m_clk24mhz>;
+				clock-names = "apb_pclk";
+			};
+
+			clcd at 1f0000 {
+				compatible = "arm,pl111", "arm,primecell";
+				reg = <0x1f0000 0x1000>;
+				interrupts = <14>;
+				clocks = <&v2m_oscclk1>, <&v2m_clk24mhz>;
+				clock-names = "clcdclk", "apb_pclk";
+			};
+		};
+
+		v2m_fixed_3v3: fixedregulator at 0 {
+			compatible = "regulator-fixed";
+			regulator-name = "3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		mcc {
+			compatible = "arm,vexpress,config-bus", "simple-bus";
+			arm,vexpress,config-bridge = <&v2m_sysreg>;
+
+			v2m_oscclk1: osc at 1 {
+				/* CLCD clock */
+				compatible = "arm,vexpress-osc";
+				arm,vexpress-sysreg,func = <1 1>;
+				freq-range = <23750000 63500000>;
+				#clock-cells = <0>;
+				clock-output-names = "v2m:oscclk1";
+			};
+
+			reset at 0 {
+				compatible = "arm,vexpress-reset";
+				arm,vexpress-sysreg,func = <5 0>;
+			};
+
+			muxfpga at 0 {
+				compatible = "arm,vexpress-muxfpga";
+				arm,vexpress-sysreg,func = <7 0>;
+			};
+
+			shutdown at 0 {
+				compatible = "arm,vexpress-shutdown";
+				arm,vexpress-sysreg,func = <8 0>;
+			};
+
+			reboot at 0 {
+				compatible = "arm,vexpress-reboot";
+				arm,vexpress-sysreg,func = <9 0>;
+			};
+
+			dvimode at 0 {
+				compatible = "arm,vexpress-dvimode";
+				arm,vexpress-sysreg,func = <11 0>;
+			};
+		};
+	};
diff --git a/arch/arm64/boot/dts/skeleton.dtsi b/arch/arm64/boot/dts/skeleton.dtsi
new file mode 100644
index 0000000..38ead82
--- /dev/null
+++ b/arch/arm64/boot/dts/skeleton.dtsi
@@ -0,0 +1,13 @@
+/*
+ * Skeleton device tree; the bare minimum needed to boot; just include and
+ * add a compatible value.  The bootloader will typically populate the memory
+ * node.
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	chosen { };
+	aliases { };
+	memory { device_type = "memory"; reg = <0 0 0>; };
+};
