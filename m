From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:30 +0100
Subject: [PATCH 10/11] ARM: vexpress: Add config bus components and clocks to
 DTs
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-11-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description of all functions provided by Versatile Express
motherboard and daughterboards configuration controllers and
clock dependencies between devices.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi     |  136 ++++++++++++++++++++-
 arch/arm/boot/dts/vexpress-v2m.dtsi         |  136 ++++++++++++++++++++-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |  103 ++++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  |  169 +++++++++++++++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts     |   71 +++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts      |  121 +++++++++++++++++++
 6 files changed, 732 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index d8a827b..9cc2a56 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -72,14 +72,20 @@
 			#size-cells = <1>;
 			ranges = <0 3 0 0x200000>;
 
-			sysreg at 010000 {
+			v2m_sysreg: sysreg at 010000 {
 				compatible = "arm,vexpress-sysreg";
 				reg = <0x010000 0x1000>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			sysctl at 020000 {
+			v2m_sysctl: sysctl at 020000 {
 				compatible = "arm,sp810", "arm,primecell";
 				reg = <0x020000 0x1000>;
+				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&v2m_osc_clk0>;
+				clock-names = "refclk", "timclk", "apb_pclk";
+				#clock-cells = <1>;
+				clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
 			};
 
 			/* PCI-E I2C bus */
@@ -100,66 +106,92 @@
 				compatible = "arm,pl041", "arm,primecell";
 				reg = <0x040000 0x1000>;
 				interrupts = <11>;
+				clocks = <&v2m_osc_clk0>;
+				clock-names = "apb_pclk";
 			};
 
 			mmci at 050000 {
 				compatible = "arm,pl180", "arm,primecell";
 				reg = <0x050000 0x1000>;
 				interrupts = <9 10>;
+				cd-gpios = <&v2m_sysreg 0 0>;
+				wp-gpios = <&v2m_sysreg 1 0>;
+				max-frequency = <12000000>;
+				vmmc-supply = <&v2m_fixed_3v3>;
+				clocks = <&v2m_clk_24mhz>, <&v2m_osc_clk0>;
+				clock-names = "mclk", "apb_pclk";
 			};
 
 			kmi at 060000 {
 				compatible = "arm,pl050", "arm,primecell";
 				reg = <0x060000 0x1000>;
 				interrupts = <12>;
+				clocks = <&v2m_clk_24mhz>, <&v2m_osc_clk0>;
+				clock-names = "KMIREFCLK", "apb_pclk";
 			};
 
 			kmi at 070000 {
 				compatible = "arm,pl050", "arm,primecell";
 				reg = <0x070000 0x1000>;
 				interrupts = <13>;
+				clocks = <&v2m_clk_24mhz>, <&v2m_osc_clk0>;
+				clock-names = "KMIREFCLK", "apb_pclk";
 			};
 
 			v2m_serial0: uart at 090000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x090000 0x1000>;
 				interrupts = <5>;
+				clocks = <&v2m_osc_clk2>, <&v2m_osc_clk0>;
+				clock-names = "uartclk", "apb_pclk";
 			};
 
 			v2m_serial1: uart at 0a0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0a0000 0x1000>;
 				interrupts = <6>;
+				clocks = <&v2m_osc_clk2>, <&v2m_osc_clk0>;
+				clock-names = "uartclk", "apb_pclk";
 			};
 
 			v2m_serial2: uart at 0b0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0b0000 0x1000>;
 				interrupts = <7>;
+				clocks = <&v2m_osc_clk2>, <&v2m_osc_clk0>;
+				clock-names = "uartclk", "apb_pclk";
 			};
 
 			v2m_serial3: uart at 0c0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0c0000 0x1000>;
 				interrupts = <8>;
+				clocks = <&v2m_osc_clk2>, <&v2m_osc_clk0>;
+				clock-names = "uartclk", "apb_pclk";
 			};
 
 			wdt at 0f0000 {
 				compatible = "arm,sp805", "arm,primecell";
 				reg = <0x0f0000 0x1000>;
 				interrupts = <0>;
+				clocks = <&v2m_refclk32khz>, <&v2m_osc_clk0>;
+				clock-names = "wdogclk", "apb_pclk";
 			};
 
 			v2m_timer01: timer at 110000 {
 				compatible = "arm,sp804", "arm,primecell";
 				reg = <0x110000 0x1000>;
 				interrupts = <2>;
+				clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_osc_clk0>;
+				clock-names = "timclken1", "timclken2", "apb_pclk";
 			};
 
 			v2m_timer23: timer at 120000 {
 				compatible = "arm,sp804", "arm,primecell";
 				reg = <0x120000 0x1000>;
 				interrupts = <3>;
+				clocks = <&v2m_sysctl 2>, <&v2m_sysctl 3>, <&v2m_osc_clk0>;
+				clock-names = "timclken1", "timclken2", "apb_pclk";
 			};
 
 			/* DVI I2C bus */
@@ -185,6 +217,8 @@
 				compatible = "arm,pl031", "arm,primecell";
 				reg = <0x170000 0x1000>;
 				interrupts = <4>;
+				clocks = <&v2m_osc_clk0>;
+				clock-names = "apb_pclk";
 			};
 
 			compact-flash at 1a0000 {
@@ -198,6 +232,9 @@
 				compatible = "arm,pl111", "arm,primecell";
 				reg = <0x1f0000 0x1000>;
 				interrupts = <14>;
+				arm,vexpress,site = <0>;
+				clocks = <&v2m_osc_clk1>, <&v2m_osc_clk0>;
+				clock-names = "clcdclk", "apb_pclk";
 			};
 		};
 
@@ -208,5 +245,100 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
+
+		v2m_clk_24mhz: clk_24mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "v2m:clk_24mhz";
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
+		mcc {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#interrupt-cells = <0>;
+			arm,vexpress,site = <0>; /* Motherboard */
+
+			v2m_osc_clk0: osc at 0 {
+				/* MCC static memory clock */
+				compatible = "arm,vexpress-config,osc";
+				reg = <0>;
+				freq-range = <25000000 60000000>;
+				#clock-cells = <0>;
+				clock-output-names = "v2m:osc_clk0";
+			};
+
+			v2m_osc_clk1: osc at 1 {
+				/* CLCD clock */
+				compatible = "arm,vexpress-config,osc";
+				reg = <1>;
+				freq-range = <23750000 63500000>;
+				#clock-cells = <0>;
+				clock-output-names = "v2m:osc_clk1";
+			};
+
+			v2m_osc_clk2: osc at 2 {
+				/* IO FPGA peripheral clock */
+				compatible = "arm,vexpress-config,osc";
+				reg = <2>;
+				freq-range = <24000000 24000000>;
+				#clock-cells = <0>;
+				clock-output-names = "v2m:osc_clk2";
+			};
+
+			volt at 0 {
+				/* Logic level voltage */
+				compatible = "arm,vexpress-config,volt";
+				reg = <0>;
+				regulator-name = "VIO";
+				regulator-always-on;
+			};
+
+			temp at 0 {
+				/* MCC internal operating temperature */
+				compatible = "arm,vexpress-config,temp";
+				reg = <0>;
+				label = "MCC";
+			};
+
+			reset at 0 {
+				compatible = "arm,vexpress-config,reset";
+				reg = <0>;
+			};
+
+			muxfpga at 0 {
+				compatible = "arm,vexpress-config,muxfpga";
+				reg = <0>;
+			};
+
+			shutdown at 0 {
+				compatible = "arm,vexpress-config,shutdown";
+				reg = <0>;
+			};
+
+			reboot at 0 {
+				compatible = "arm,vexpress-config,reboot";
+				reg = <0>;
+			};
+
+			dvimode at 0 {
+				compatible = "arm,vexpress-config,dvimode";
+				reg = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index dba53fd..03133a8 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -71,14 +71,20 @@
 			#size-cells = <1>;
 			ranges = <0 7 0 0x20000>;
 
-			sysreg at 00000 {
+			v2m_sysreg: sysreg at 00000 {
 				compatible = "arm,vexpress-sysreg";
 				reg = <0x00000 0x1000>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			sysctl at 01000 {
+			v2m_sysctl: sysctl at 01000 {
 				compatible = "arm,sp810", "arm,primecell";
 				reg = <0x01000 0x1000>;
+				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&v2m_osc_clk0>;
+				clock-names = "refclk", "timclk", "apb_pclk";
+				#clock-cells = <1>;
+				clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
 			};
 
 			/* PCI-E I2C bus */
@@ -99,66 +105,92 @@
 				compatible = "arm,pl041", "arm,primecell";
 				reg = <0x04000 0x1000>;
 				interrupts = <11>;
+				clocks = <&v2m_osc_clk0>;
+				clock-names = "apb_pclk";
 			};
 
 			mmci at 05000 {
 				compatible = "arm,pl180", "arm,primecell";
 				reg = <0x05000 0x1000>;
 				interrupts = <9 10>;
+				cd-gpios = <&v2m_sysreg 0 0>;
+				wp-gpios = <&v2m_sysreg 1 0>;
+				max-frequency = <12000000>;
+				vmmc-supply = <&v2m_fixed_3v3>;
+				clocks = <&v2m_clk_24mhz>, <&v2m_osc_clk0>;
+				clock-names = "mclk", "apb_pclk";
 			};
 
 			kmi at 06000 {
 				compatible = "arm,pl050", "arm,primecell";
 				reg = <0x06000 0x1000>;
 				interrupts = <12>;
+				clocks = <&v2m_clk_24mhz>, <&v2m_osc_clk0>;
+				clock-names = "KMIREFCLK", "apb_pclk";
 			};
 
 			kmi at 07000 {
 				compatible = "arm,pl050", "arm,primecell";
 				reg = <0x07000 0x1000>;
 				interrupts = <13>;
+				clocks = <&v2m_clk_24mhz>, <&v2m_osc_clk0>;
+				clock-names = "KMIREFCLK", "apb_pclk";
 			};
 
 			v2m_serial0: uart at 09000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x09000 0x1000>;
 				interrupts = <5>;
+				clocks = <&v2m_osc_clk2>, <&v2m_osc_clk0>;
+				clock-names = "uartclk", "apb_pclk";
 			};
 
 			v2m_serial1: uart at 0a000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0a000 0x1000>;
 				interrupts = <6>;
+				clocks = <&v2m_osc_clk2>, <&v2m_osc_clk0>;
+				clock-names = "uartclk", "apb_pclk";
 			};
 
 			v2m_serial2: uart at 0b000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0b000 0x1000>;
 				interrupts = <7>;
+				clocks = <&v2m_osc_clk2>, <&v2m_osc_clk0>;
+				clock-names = "uartclk", "apb_pclk";
 			};
 
 			v2m_serial3: uart at 0c000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0c000 0x1000>;
 				interrupts = <8>;
+				clocks = <&v2m_osc_clk2>, <&v2m_osc_clk0>;
+				clock-names = "uartclk", "apb_pclk";
 			};
 
 			wdt at 0f000 {
 				compatible = "arm,sp805", "arm,primecell";
 				reg = <0x0f000 0x1000>;
 				interrupts = <0>;
+				clocks = <&v2m_refclk32khz>, <&v2m_osc_clk0>;
+				clock-names = "wdogclk", "apb_pclk";
 			};
 
 			v2m_timer01: timer at 11000 {
 				compatible = "arm,sp804", "arm,primecell";
 				reg = <0x11000 0x1000>;
 				interrupts = <2>;
+				clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_osc_clk0>;
+				clock-names = "timclken1", "timclken2", "apb_pclk";
 			};
 
 			v2m_timer23: timer at 12000 {
 				compatible = "arm,sp804", "arm,primecell";
 				reg = <0x12000 0x1000>;
 				interrupts = <3>;
+				clocks = <&v2m_sysctl 2>, <&v2m_sysctl 3>, <&v2m_osc_clk0>;
+				clock-names = "timclken1", "timclken2", "apb_pclk";
 			};
 
 			/* DVI I2C bus */
@@ -184,6 +216,8 @@
 				compatible = "arm,pl031", "arm,primecell";
 				reg = <0x17000 0x1000>;
 				interrupts = <4>;
+				clocks = <&v2m_osc_clk0>;
+				clock-names = "apb_pclk";
 			};
 
 			compact-flash at 1a000 {
@@ -197,6 +231,9 @@
 				compatible = "arm,pl111", "arm,primecell";
 				reg = <0x1f000 0x1000>;
 				interrupts = <14>;
+				arm,vexpress,site = <0>;
+				clocks = <&v2m_osc_clk1>, <&v2m_osc_clk0>;
+				clock-names = "clcdclk", "apb_pclk";
 			};
 		};
 
@@ -207,5 +244,100 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
+
+		v2m_clk_24mhz: clk_24mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "v2m:clk_24mhz";
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
+		mcc {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#interrupt-cells = <0>;
+			arm,vexpress,site = <0>; /* Motherboard */
+
+			v2m_osc_clk0: osc at 0 {
+				/* MCC static memory clock */
+				compatible = "arm,vexpress-config,osc";
+				reg = <0>;
+				freq-range = <25000000 60000000>;
+				#clock-cells = <0>;
+				clock-output-names = "v2m:osc_clk0";
+			};
+
+			v2m_osc_clk1: osc at 1 {
+				/* CLCD clock */
+				compatible = "arm,vexpress-config,osc";
+				reg = <1>;
+				freq-range = <23750000 63500000>;
+				#clock-cells = <0>;
+				clock-output-names = "v2m:osc_clk1";
+			};
+
+			v2m_osc_clk2: osc at 2 {
+				/* IO FPGA peripheral clock */
+				compatible = "arm,vexpress-config,osc";
+				reg = <2>;
+				freq-range = <24000000 24000000>;
+				#clock-cells = <0>;
+				clock-output-names = "v2m:osc_clk2";
+			};
+
+			volt at 0 {
+				/* Logic level voltage */
+				compatible = "arm,vexpress-config,volt";
+				reg = <0>;
+				regulator-name = "VIO";
+				regulator-always-on;
+			};
+
+			temp at 0 {
+				/* MCC internal operating temperature */
+				compatible = "arm,vexpress-config,temp";
+				reg = <0>;
+				label = "MCC";
+			};
+
+			reset at 0 {
+				compatible = "arm,vexpress-config,reset";
+				reg = <0>;
+			};
+
+			muxfpga at 0 {
+				compatible = "arm,vexpress-config,muxfpga";
+				reg = <0>;
+			};
+
+			shutdown at 0 {
+				compatible = "arm,vexpress-config,shutdown";
+				reg = <0>;
+			};
+
+			reboot at 0 {
+				compatible = "arm,vexpress-config,reboot";
+				reg = <0>;
+			};
+
+			dvimode at 0 {
+				compatible = "arm,vexpress-config,dvimode";
+				reg = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index d12b34c..9297dd6 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -54,6 +54,9 @@
 		compatible = "arm,hdlcd";
 		reg = <0 0x2b000000 0 0x1000>;
 		interrupts = <0 85 4>;
+		arm,vexpress,site = <0xff>;
+		clocks = <&oscclk5>;
+		clock-names = "pxlclk";
 	};
 
 	memory-controller at 2b0a0000 {
@@ -65,6 +68,7 @@
 		compatible = "arm,sp805", "arm,primecell";
 		reg = <0 0x2b060000 0 0x1000>;
 		interrupts = <98>;
+		status = "disabled";
 	};
 
 	gic: interrupt-controller at 2c001000 {
@@ -163,6 +167,105 @@
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
 	};
+
+	dcc at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <0>;
+		arm,vexpress,site = <0xff>; /* Master site */
+
+		osc at 0 {
+			/* CPU PLL reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <0>;
+			freq-range = <50000000 60000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk0";
+		};
+
+		osc at 4 {
+			/* Multiplexed AXI master clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <4>;
+			freq-range = <20000000 40000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk4";
+		};
+
+		oscclk5: osc at 5 {
+			/* HDLCD PLL reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <5>;
+			freq-range = <23750000 165000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk5";
+		};
+
+		osc at 6 {
+			/* SMB clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <6>;
+			freq-range = <20000000 50000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk6";
+		};
+
+		osc at 7 {
+			/* SYS PLL reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <7>;
+			freq-range = <20000000 60000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk7";
+		};
+
+		osc at 8 {
+			/* DDR2 PLL reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <8>;
+			freq-range = <40000000 40000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk8";
+		};
+
+		volt at 0 {
+			/* CPU core voltage */
+			compatible = "arm,vexpress-config,volt";
+			reg = <0>;
+			regulator-name = "Cores";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-always-on;
+		};
+
+		amp at 0 {
+			/* Total current for the two cores */
+			compatible = "arm,vexpress-config,amp";
+			reg = <0>;
+			label = "Cores";
+		};
+
+		temp at 0 {
+			/* DCC internal temperature */
+			compatible = "arm,vexpress-config,temp";
+			reg = <0>;
+			label = "DCC";
+		};
+
+		power at 0 {
+			/* Total power */
+			compatible = "arm,vexpress-config,power";
+			reg = <0>;
+			label = "Cores";
+		};
+
+		energy at 0 {
+			/* Total energy */
+			compatible = "arm,vexpress-config,energy";
+			reg = <0>;
+			label = "Cores";
+		};
+	};
 };
 
 /include/ "vexpress-v2m-rs1.dtsi"
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 4890a81..a451478 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -74,12 +74,17 @@
 		compatible = "arm,sp805", "arm,primecell";
 		reg = <0 0x2a490000 0 0x1000>;
 		interrupts = <98>;
+		clocks = <&oscclk6a>, <&oscclk6a>;
+		clock-names = "wdogclk", "apb_pclk";
 	};
 
 	hdlcd at 2b000000 {
 		compatible = "arm,hdlcd";
 		reg = <0 0x2b000000 0 0x1000>;
 		interrupts = <0 85 4>;
+		arm,vexpress,site = <0xff>;
+		clocks = <&oscclk5>;
+		clock-names = "pxlclk";
 	};
 
 	memory-controller at 2b0a0000 {
@@ -183,6 +188,170 @@
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
 	};
+
+	oscclk6a: oscclk6a {
+		/* Reference 24MHz clock */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "oscclk6a";
+	};
+
+	dcc at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <0>;
+		arm,vexpress,site = <0xff>; /* Master site */
+
+		osc at 0 {
+			/* A15 PLL 0 reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <0>;
+			freq-range = <17000000 50000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk0";
+		};
+
+		osc at 1 {
+			/* A15 PLL 1 reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <1>;
+			freq-range = <17000000 50000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk1";
+		};
+
+		osc at 2 {
+			/* A7 PLL 0 reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <2>;
+			freq-range = <17000000 50000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk2";
+		};
+
+		osc at 3 {
+			/* A7 PLL 1 reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <3>;
+			freq-range = <17000000 50000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk3";
+		};
+
+		osc at 4 {
+			/* External AXI master clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <4>;
+			freq-range = <20000000 40000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk4";
+		};
+
+		oscclk5: osc at 5 {
+			/* HDLCD PLL reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <5>;
+			freq-range = <23750000 165000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk5";
+		};
+
+		osc at 6 {
+			/* Static memory controller clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <6>;
+			freq-range = <20000000 40000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk6";
+		};
+
+		osc at 7 {
+			/* SYS PLL reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <7>;
+			freq-range = <17000000 50000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk7";
+		};
+
+		osc at 8 {
+			/* DDR2 PLL reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <8>;
+			freq-range = <20000000 50000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk8";
+		};
+
+		volt at 0 {
+			/* A15 CPU core voltage */
+			compatible = "arm,vexpress-config,volt";
+			reg = <0>;
+			regulator-name = "A15 Vcore";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-always-on;
+		};
+
+		volt at 1 {
+			/* A7 CPU core voltage */
+			compatible = "arm,vexpress-config,volt";
+			reg = <1>;
+			regulator-name = "A7 Vcore";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-always-on;
+		};
+
+		amp at 0 {
+			/* Total current for the two A15 cores */
+			compatible = "arm,vexpress-config,amp";
+			reg = <0>;
+			label = "A15 Icore";
+		};
+
+		amp at 1 {
+			/* Total current for the three A7 cores */
+			compatible = "arm,vexpress-config,amp";
+			reg = <1>;
+			label = "A7 Icore";
+		};
+
+		temp at 0 {
+			/* DCC internal temperature */
+			compatible = "arm,vexpress-config,temp";
+			reg = <0>;
+			label = "DCC";
+		};
+
+		power at 0 {
+			/* Total power for the two A15 cores */
+			compatible = "arm,vexpress-config,power";
+			reg = <0>;
+			label = "A15 Pcore";
+		};
+		power at 1 {
+			/* Total power for the three A7 cores */
+			compatible = "arm,vexpress-config,power";
+			reg = <1>;
+			label = "A7 Pcore";
+		};
+
+		energy at 0 {
+			/* Total energy for the two A15 cores */
+			compatible = "arm,vexpress-config,energy";
+			reg = <0>;
+			label = "A15 Jcore";
+		};
+
+		energy at 2 {
+			/* Total energy for the three A7 cores */
+			compatible = "arm,vexpress-config,energy";
+			reg = <2>;
+			label = "A7 Jcore";
+		};
+	};
 };
 
 /include/ "vexpress-v2m-rs1.dtsi"
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index 18917a0..84b9a19 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -56,6 +56,9 @@
 		compatible = "arm,hdlcd";
 		reg = <0x2a110000 0x1000>;
 		interrupts = <0 85 4>;
+		arm,vexpress,site = <0xff>;
+		clocks = <&oscclk3>;
+		clock-names = "pxlclk";
 	};
 
 	memory-controller at 2a150000 {
@@ -162,6 +165,74 @@
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
 	};
+
+	dcc at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <0>;
+		arm,vexpress,site = <0xff>; /* Master site */
+
+		osc at 0 {
+			/* CPU and internal AXI reference clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <0>;
+			freq-range = <50000000 100000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk0";
+		};
+
+		osc at 1 {
+			/* Multiplexed AXI master clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <1>;
+			freq-range = <5000000 50000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk1";
+		};
+
+		osc at 2 {
+			/* DDR2 */
+			compatible = "arm,vexpress-config,osc";
+			reg = <2>;
+			freq-range = <80000000 120000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk2";
+		};
+
+		oscclk3: osc at 3 {
+			/* HDLCD */
+			compatible = "arm,vexpress-config,osc";
+			reg = <3>;
+			freq-range = <23750000 165000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk3";
+		};
+
+		osc at 4 {
+			/* Test chip gate configuration */
+			compatible = "arm,vexpress-config,osc";
+			reg = <4>;
+			freq-range = <80000000 80000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk4";
+		};
+
+		osc at 5 {
+			/* SMB clock */
+			compatible = "arm,vexpress-config,osc";
+			reg = <5>;
+			freq-range = <25000000 60000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk5";
+		};
+
+		temp at 0 {
+			/* DCC internal operating temperature */
+			compatible = "arm,vexpress-config,temp";
+			reg = <0>;
+			label = "DCC";
+		};
+	};
 };
 
 /include/ "vexpress-v2m-rs1.dtsi"
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 3f0c736..5a421f7 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -70,11 +70,16 @@
 		compatible = "arm,pl111", "arm,primecell";
 		reg = <0x10020000 0x1000>;
 		interrupts = <0 44 4>;
+		arm,vexpress,site = <0xff>;
+		clocks = <&oscclk1>, <&oscclk2>;
+		clock-names = "clcdclk", "apb_pclk";
 	};
 
 	memory-controller at 100e0000 {
 		compatible = "arm,pl341", "arm,primecell";
 		reg = <0x100e0000 0x1000>;
+		clocks = <&oscclk2>;
+		clock-names = "apb_pclk";
 	};
 
 	memory-controller at 100e1000 {
@@ -82,6 +87,8 @@
 		reg = <0x100e1000 0x1000>;
 		interrupts = <0 45 4>,
 			     <0 46 4>;
+		clocks = <&oscclk2>;
+		clock-names = "apb_pclk";
 	};
 
 	timer at 100e4000 {
@@ -89,12 +96,16 @@
 		reg = <0x100e4000 0x1000>;
 		interrupts = <0 48 4>,
 			     <0 49 4>;
+		clocks = <&oscclk2>, <&oscclk2>;
+		clock-names = "timclk", "apb_pclk";
 	};
 
 	watchdog at 100e5000 {
 		compatible = "arm,sp805", "arm,primecell";
 		reg = <0x100e5000 0x1000>;
 		interrupts = <0 51 4>;
+		clocks = <&oscclk2>, <&oscclk2>;
+		clock-names = "wdogclk", "apb_pclk";
 	};
 
 	scu at 1e000000 {
@@ -192,6 +203,116 @@
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
 	};
+
+	dcc at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <0>;
+		arm,vexpress,site = <0xff>; /* Master site */
+
+		osc at 0 {
+			/* ACLK clock to the AXI master port on the test chip */
+			compatible = "arm,vexpress-config,osc";
+			reg = <0>;
+			freq-range = <30000000 50000000>;
+			#clock-cells = <0>;
+			clock-output-names = "extsaxiclk";
+		};
+
+		oscclk1: osc at 1 {
+			/* Reference clock for the CLCD */
+			compatible = "arm,vexpress-config,osc";
+			reg = <1>;
+			freq-range = <10000000 80000000>;
+			#clock-cells = <0>;
+			clock-output-names = "clcdclk";
+		};
+
+		oscclk2: osc at 2 {
+			/* Reference clock for the test chip internal PLLs */
+			compatible = "arm,vexpress-config,osc";
+			reg = <2>;
+			freq-range = <33000000 100000000>;
+			#clock-cells = <0>;
+			clock-output-names = "tcrefclk";
+		};
+
+		volt at 0 {
+			/* Test Chip internal logic voltage */
+			compatible = "arm,vexpress-config,volt";
+			reg = <0>;
+			regulator-name = "VD10";
+			regulator-always-on;
+		};
+
+		volt at 1 {
+			/* PL310, L2 cache, RAM cell supply (not PL310 logic) */
+			compatible = "arm,vexpress-config,volt";
+			reg = <1>;
+			regulator-name = "VD10_S2";
+			regulator-always-on;
+		};
+
+		volt at 2 {
+			/* Cortex-A9 system supply, Cores, MPEs, SCU and PL310 logic */
+			compatible = "arm,vexpress-config,volt";
+			reg = <2>;
+			regulator-name = "VD10_S3";
+			regulator-always-on;
+		};
+
+		volt at 3 {
+			/* DDR2 SDRAM and Test Chip DDR2 I/O supply */
+			compatible = "arm,vexpress-config,volt";
+			reg = <3>;
+			regulator-name = "VCC1V8";
+			regulator-always-on;
+		};
+
+		volt at 4 {
+			/* DDR2 SDRAM VTT termination voltage */
+			compatible = "arm,vexpress-config,volt";
+			reg = <4>;
+			regulator-name = "DDR2VTT";
+			regulator-always-on;
+		};
+
+		volt at 5 {
+			/* Local board supply for miscellaneous logic external to the Test Chip */
+			compatible = "arm,vexpress-config,volt";
+			reg = <5>;
+			regulator-name = "VCC3V3";
+			regulator-always-on;
+		};
+
+		amp at 0 {
+			/* PL310, L2 cache, RAM cell supply (not PL310 logic) */
+			compatible = "arm,vexpress-config,amp";
+			reg = <0>;
+			label = "VD10_S2";
+		};
+
+		amp at 1 {
+			/* Cortex-A9 system supply, Cores, MPEs, SCU and PL310 logic */
+			compatible = "arm,vexpress-config,amp";
+			reg = <1>;
+			label = "VD10_S3";
+		};
+
+		power at 0 {
+			/* PL310, L2 cache, RAM cell supply (not PL310 logic) */
+			compatible = "arm,vexpress-config,power";
+			reg = <0>;
+			label = "PVD10_S2";
+		};
+
+		power at 1 {
+			/* Cortex-A9 system supply, Cores, MPEs, SCU and PL310 logic */
+			compatible = "arm,vexpress-config,power";
+			reg = <1>;
+			label = "PVD10_S3";
+		};
+	};
 };
 
 /include/ "vexpress-v2m.dtsi"
-- 
1.7.9.5
