From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 26 Sep 2011 16:24:47 +0100
Subject: [PATCHv3 2/4] picoxcell: add the DTS for pc3x2 and pc3x3 devices
In-Reply-To: <1317050689-16417-1-git-send-email-jamie@jamieiles.com>
References: <1317050689-16417-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1317050689-16417-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This describes the basic hierarchy of picoxcell pc3x3 devices including
clocks and bus interconnect.  Some onchip devices are currently omitted
as there haven't been bindings created for them.

v2:	- change timer compatible strings to be more soc specific
	- split vic node into 2 devices

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi |  249 ++++++++++++++++++++++
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi |  365 ++++++++++++++++++++++++++++++++
 2 files changed, 614 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/picoxcell-pc3x2.dtsi
 create mode 100644 arch/arm/boot/dts/picoxcell-pc3x3.dtsi

diff --git a/arch/arm/boot/dts/picoxcell-pc3x2.dtsi b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
new file mode 100644
index 0000000..f0a8c20
--- /dev/null
+++ b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
@@ -0,0 +1,249 @@
+/*
+ *  Copyright (C) 2011 Picochip, Jamie Iles
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+/include/ "skeleton.dtsi"
+/ {
+	model = "Picochip picoXcell PC3X2";
+	compatible = "picochip,pc3x2";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,1176jz-s";
+			clock-frequency = <400000000>;
+			reg = <0>;
+			d-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-line-size = <32>;
+			i-cache-size = <32768>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pclk: clock at 0 {
+			compatible = "fixed-clock";
+			clock-outputs = "bus", "pclk";
+			clock-frequency = <200000000>;
+			ref-clock = <&ref_clk>, "ref";
+		};
+	};
+
+	paxi {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x80000000 0x400000>;
+
+		emac: gem at 30000 {
+			compatible = "cadence,gem";
+			reg = <0x30000 0x10000>;
+			interrupts = <31>;
+		};
+
+		dmac1: dmac at 40000 {
+			compatible = "snps,dw-dmac";
+			reg = <0x40000 0x10000>;
+			interrupts = <25>;
+		};
+
+		dmac2: dmac at 50000 {
+			compatible = "snps,dw-dmac";
+			reg = <0x50000 0x10000>;
+			interrupts = <26>;
+		};
+
+		vic0: interrupt-controller at 60000 {
+			compatible = "arm,pl192-vic";
+			interrupt-controller;
+			reg = <0x60000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		vic1: interrupt-controller at 64000 {
+			compatible = "arm,pl192-vic";
+			interrupt-controller;
+			reg = <0x64000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		fuse: picoxcell-fuse at 80000 {
+			compatible = "picoxcell,fuse-pc3x2";
+			reg = <0x80000 0x10000>;
+		};
+
+		ssi: picoxcell-spi at 90000 {
+			compatible = "picoxcell,spi";
+			reg = <0x90000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <10>;
+		};
+
+		ipsec: spacc at 100000 {
+			compatible = "picochip,spacc-ipsec";
+			reg = <0x100000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <24>;
+			ref-clock = <&pclk>, "ref";
+		};
+
+		srtp: spacc at 140000 {
+			compatible = "picochip,spacc-srtp";
+			reg = <0x140000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <23>;
+		};
+
+		l2_engine: spacc at 180000 {
+			compatible = "picochip,spacc-l2";
+			reg = <0x180000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <22>;
+			ref-clock = <&pclk>, "ref";
+		};
+
+		apb {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x200000 0x80000>;
+
+			rtc0: rtc at 00000 {
+				compatible = "picochip,pc3x2-rtc";
+				clock-freq = <200000000>;
+				reg = <0x00000 0xf>;
+				interrupt-parent = <&vic1>;
+				interrupts = <8>;
+			};
+
+			timer0: timer at 10000 {
+				compatible = "picochip,pc3x2-timer";
+				interrupt-parent = <&vic0>;
+				interrupts = <4>;
+				clock-freq = <200000000>;
+				reg = <0x10000 0x14>;
+			};
+
+			timer1: timer at 10014 {
+				compatible = "picochip,pc3x2-timer";
+				interrupt-parent = <&vic0>;
+				interrupts = <5>;
+				clock-freq = <200000000>;
+				reg = <0x10014 0x14>;
+			};
+
+			timer2: timer at 10028 {
+				compatible = "picochip,pc3x2-timer";
+				interrupt-parent = <&vic0>;
+				interrupts = <6>;
+				clock-freq = <200000000>;
+				reg = <0x10028 0x14>;
+			};
+
+			timer3: timer at 1003c {
+				compatible = "picochip,pc3x2-timer";
+				interrupt-parent = <&vic0>;
+				interrupts = <7>;
+				clock-freq = <200000000>;
+				reg = <0x1003c 0x14>;
+			};
+
+			gpio: gpio at 20000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x20000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg-io-width = <4>;
+
+				banka: gpio-controller at 0 {
+					compatible = "snps,dw-apb-gpio-bank";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-generic,nr-gpio = <8>;
+
+					regoffset-dat = <0x50>;
+					regoffset-set = <0x00>;
+					regoffset-dirout = <0x04>;
+				};
+
+				bankb: gpio-controller at 1 {
+					compatible = "snps,dw-apb-gpio-bank";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-generic,nr-gpio = <8>;
+
+					regoffset-dat = <0x54>;
+					regoffset-set = <0x0c>;
+					regoffset-dirout = <0x10>;
+				};
+			};
+
+			uart0: uart at 30000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x30000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <10>;
+				clock-frequency = <3686400>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+			};
+
+			uart1: uart at 40000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x40000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <9>;
+				clock-frequency = <3686400>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+			};
+
+			wdog: watchdog at 50000 {
+				compatible = "snps,dw-apb-wdg";
+				reg = <0x50000 0x10000>;
+				interrupt-parent = <&vic0>;
+				interrupts = <11>;
+				bus-clock = <&pclk>, "bus";
+			};
+		};
+	};
+
+	rwid-axi {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		ebi at 50000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x40000000 0x08000000
+				  1 0 0x48000000 0x08000000
+				  2 0 0x50000000 0x08000000
+				  3 0 0x58000000 0x08000000>;
+		};
+
+		axi2pico at c0000000 {
+			compatible = "picochip,axi2pico-pc3x2";
+			reg = <0xc0000000 0x10000>;
+			interrupts = <13 14 15 16 17 18 19 20 21>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/picoxcell-pc3x3.dtsi b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
new file mode 100644
index 0000000..daa962d
--- /dev/null
+++ b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
@@ -0,0 +1,365 @@
+/*
+ *  Copyright (C) 2011 Picochip, Jamie Iles
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+/include/ "skeleton.dtsi"
+/ {
+	model = "Picochip picoXcell PC3X3";
+	compatible = "picochip,pc3x3";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,1176jz-s";
+			cpu-clock = <&arm_clk>, "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-line-size = <32>;
+			i-cache-size = <32768>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		clkgate: clkgate at 800a0048 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x800a0048 4>;
+			compatible = "picochip,pc3x3-clk-gate";
+
+			tzprot_clk: clock at 0 {
+				compatible = "picochip,pc3x3-gated-clk";
+				clock-outputs = "bus";
+				picochip,clk-disable-bit = <0>;
+				clock-frequency = <200000000>;
+				ref-clock = <&ref_clk>, "ref";
+			};
+
+			spi_clk: clock at 1 {
+				compatible = "picochip,pc3x3-gated-clk";
+				clock-outputs = "bus";
+				picochip,clk-disable-bit = <1>;
+				clock-frequency = <200000000>;
+				ref-clock = <&ref_clk>, "ref";
+			};
+
+			dmac0_clk: clock at 2 {
+				compatible = "picochip,pc3x3-gated-clk";
+				clock-outputs = "bus";
+				picochip,clk-disable-bit = <2>;
+				clock-frequency = <200000000>;
+				ref-clock = <&ref_clk>, "ref";
+			};
+
+			dmac1_clk: clock at 3 {
+				compatible = "picochip,pc3x3-gated-clk";
+				clock-outputs = "bus";
+				picochip,clk-disable-bit = <3>;
+				clock-frequency = <200000000>;
+				ref-clock = <&ref_clk>, "ref";
+			};
+
+			ebi_clk: clock at 4 {
+				compatible = "picochip,pc3x3-gated-clk";
+				clock-outputs = "bus";
+				picochip,clk-disable-bit = <4>;
+				clock-frequency = <200000000>;
+				ref-clock = <&ref_clk>, "ref";
+			};
+
+			ipsec_clk: clock at 5 {
+				compatible = "picochip,pc3x3-gated-clk";
+				clock-outputs = "bus";
+				picochip,clk-disable-bit = <5>;
+				clock-frequency = <200000000>;
+				ref-clock = <&ref_clk>, "ref";
+			};
+
+			l2_clk: clock at 6 {
+				compatible = "picochip,pc3x3-gated-clk";
+				clock-outputs = "bus";
+				picochip,clk-disable-bit = <6>;
+				clock-frequency = <200000000>;
+				ref-clock = <&ref_clk>, "ref";
+			};
+
+			trng_clk: clock at 7 {
+				compatible = "picochip,pc3x3-gated-clk";
+				clock-outputs = "bus";
+				picochip,clk-disable-bit = <7>;
+				clock-frequency = <200000000>;
+				ref-clock = <&ref_clk>, "ref";
+			};
+
+			fuse_clk: clock at 8 {
+				compatible = "picochip,pc3x3-gated-clk";
+				clock-outputs = "bus";
+				picochip,clk-disable-bit = <8>;
+				clock-frequency = <200000000>;
+				ref-clock = <&ref_clk>, "ref";
+			};
+
+			otp_clk: clock at 9 {
+				compatible = "picochip,pc3x3-gated-clk";
+				clock-outputs = "bus";
+				picochip,clk-disable-bit = <9>;
+				clock-frequency = <200000000>;
+				ref-clock = <&ref_clk>, "ref";
+			};
+		};
+
+		arm_clk: clock at 11 {
+			compatible = "picochip,pc3x3-pll";
+			reg = <0x800a0050 0x8>;
+			picochip,min-freq = <140000000>;
+			picochip,max-freq = <700000000>;
+			ref-clock = <&ref_clk>, "ref";
+			clock-outputs = "cpu";
+		};
+
+		pclk: clock at 12 {
+			compatible = "fixed-clock";
+			clock-outputs = "bus", "pclk";
+			clock-frequency = <200000000>;
+			ref-clock = <&ref_clk>, "ref";
+		};
+	};
+
+	paxi {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x80000000 0x400000>;
+
+		emac: gem at 30000 {
+			compatible = "cadence,gem";
+			reg = <0x30000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <31>;
+		};
+
+		dmac1: dmac at 40000 {
+			compatible = "snps,dw-dmac";
+			reg = <0x40000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <25>;
+		};
+
+		dmac2: dmac at 50000 {
+			compatible = "snps,dw-dmac";
+			reg = <0x50000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <26>;
+		};
+
+		vic0: interrupt-controller at 60000 {
+			compatible = "arm,pl192-vic";
+			interrupt-controller;
+			reg = <0x60000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		vic1: interrupt-controller at 64000 {
+			compatible = "arm,pl192-vic";
+			interrupt-controller;
+			reg = <0x64000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		fuse: picoxcell-fuse at 80000 {
+			compatible = "picoxcell,fuse-pc3x3";
+			reg = <0x80000 0x10000>;
+		};
+
+		ssi: picoxcell-spi at 90000 {
+			compatible = "picoxcell,spi";
+			reg = <0x90000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <10>;
+		};
+
+		ipsec: spacc at 100000 {
+			compatible = "picochip,spacc-ipsec";
+			reg = <0x100000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <24>;
+			ref-clock = <&ipsec_clk>, "ref";
+		};
+
+		srtp: spacc at 140000 {
+			compatible = "picochip,spacc-srtp";
+			reg = <0x140000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <23>;
+		};
+
+		l2_engine: spacc at 180000 {
+			compatible = "picochip,spacc-l2";
+			reg = <0x180000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <22>;
+			ref-clock = <&l2_clk>, "ref";
+		};
+
+		apb {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x200000 0x80000>;
+
+			rtc0: rtc at 00000 {
+				compatible = "picochip,pc3x2-rtc";
+				clock-freq = <200000000>;
+				reg = <0x00000 0xf>;
+				interrupt-parent = <&vic0>;
+				interrupts = <8>;
+			};
+
+			timer0: timer at 10000 {
+				compatible = "picochip,pc3x2-timer";
+				interrupt-parent = <&vic0>;
+				interrupts = <4>;
+				clock-freq = <200000000>;
+				reg = <0x10000 0x14>;
+			};
+
+			timer1: timer at 10014 {
+				compatible = "picochip,pc3x2-timer";
+				interrupt-parent = <&vic0>;
+				interrupts = <5>;
+				clock-freq = <200000000>;
+				reg = <0x10014 0x14>;
+			};
+
+			gpio: gpio at 20000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x20000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg-io-width = <4>;
+
+				banka: gpio-controller at 0 {
+					compatible = "snps,dw-apb-gpio-bank";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-generic,nr-gpio = <8>;
+
+					regoffset-dat = <0x50>;
+					regoffset-set = <0x00>;
+					regoffset-dirout = <0x04>;
+				};
+
+				bankb: gpio-controller at 1 {
+					compatible = "snps,dw-apb-gpio-bank";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-generic,nr-gpio = <16>;
+
+					regoffset-dat = <0x54>;
+					regoffset-set = <0x0c>;
+					regoffset-dirout = <0x10>;
+				};
+
+				bankd: gpio-controller at 2 {
+					compatible = "snps,dw-apb-gpio-bank";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-generic,nr-gpio = <30>;
+
+					regoffset-dat = <0x5c>;
+					regoffset-set = <0x24>;
+					regoffset-dirout = <0x28>;
+				};
+			};
+
+			uart0: uart at 30000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x30000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <10>;
+				clock-frequency = <3686400>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+			};
+
+			uart1: uart at 40000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x40000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <9>;
+				clock-frequency = <3686400>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+			};
+
+			wdog: watchdog at 50000 {
+				compatible = "snps,dw-apb-wdg";
+				reg = <0x50000 0x10000>;
+				interrupt-parent = <&vic0>;
+				interrupts = <11>;
+				bus-clock = <&pclk>, "bus";
+			};
+
+			timer2: timer at 60000 {
+				compatible = "picochip,pc3x2-timer";
+				interrupt-parent = <&vic0>;
+				interrupts = <6>;
+				clock-freq = <200000000>;
+				reg = <0x60000 0x14>;
+			};
+
+			timer3: timer at 60014 {
+				compatible = "picochip,pc3x2-timer";
+				interrupt-parent = <&vic0>;
+				interrupts = <7>;
+				clock-freq = <200000000>;
+				reg = <0x60014 0x14>;
+			};
+		};
+	};
+
+	rwid-axi {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		ebi at 50000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x40000000 0x08000000
+				  1 0 0x48000000 0x08000000
+				  2 0 0x50000000 0x08000000
+				  3 0 0x58000000 0x08000000>;
+		};
+
+		axi2pico at c0000000 {
+			compatible = "picochip,axi2pico-pc3x3";
+			reg = <0xc0000000 0x10000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <13 14 15 16 17 18 19 20 21>;
+		};
+
+		otp at ffff8000 {
+			compatible = "picochip,otp-pc3x3";
+			reg = <0xffff8000 0x8000>;
+		};
+	};
+};
-- 
1.7.4.1
