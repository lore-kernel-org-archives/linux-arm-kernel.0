From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 24 Apr 2013 17:38:21 +1200
Subject: [PATCH 2/3] dts: vt8500: Add devicetree support for WM8750 SoC and
 APC8750 board
In-Reply-To: <1366781902-13025-1-git-send-email-linux@prisktech.co.nz>
References: <1366781902-13025-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1366781902-13025-3-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the WonderMedia WM8750 SoC and the VIA
APC8750 board.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/boot/dts/Makefile           |    1 +
 arch/arm/boot/dts/wm8750-apc8750.dts |   26 +++
 arch/arm/boot/dts/wm8750.dtsi        |  349 ++++++++++++++++++++++++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 arch/arm/boot/dts/wm8750-apc8750.dts
 create mode 100644 arch/arm/boot/dts/wm8750.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..389536e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
 dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
 	wm8505-ref.dtb \
 	wm8650-mid.dtb \
+	wm8750-apc8750.dtb \
 	wm8850-w70v2.dtb
 dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb
 
diff --git a/arch/arm/boot/dts/wm8750-apc8750.dts b/arch/arm/boot/dts/wm8750-apc8750.dts
new file mode 100644
index 0000000..62675eb
--- /dev/null
+++ b/arch/arm/boot/dts/wm8750-apc8750.dts
@@ -0,0 +1,26 @@
+/*
+ * wm8750-apc8750.dts
+ *  - Device tree file for VIA APC8750
+ *
+ * Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/dts-v1/;
+/include/ "wm8750.dtsi"
+
+/ {
+	model = "VIA APC8750";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c>;
+
+	i2c: i2c {
+		wm,pins = <168 169 170 171>;
+		wm,function = <2>;	/* alt */
+		wm,pull = <2>;	/* pull-up */
+	};
+};
diff --git a/arch/arm/boot/dts/wm8750.dtsi b/arch/arm/boot/dts/wm8750.dtsi
new file mode 100644
index 0000000..81683fa
--- /dev/null
+++ b/arch/arm/boot/dts/wm8750.dtsi
@@ -0,0 +1,349 @@
+/*
+ * wm8750.dtsi - Device tree file for Wondermedia WM8750 SoC
+ *
+ * Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "wm,wm8750";
+
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu {
+			device_type = "cpu";
+			compatible = "arm,arm1176";
+		};
+	};
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		i2c0 = &i2c_0;
+		i2c1 = &i2c_1;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+		interrupt-parent = <&intc0>;
+
+		intc0: interrupt-controller at d8140000 {
+			compatible = "via,vt8500-intc";
+			interrupt-controller;
+			reg = <0xd8140000 0x10000>;
+			#interrupt-cells = <1>;
+		};
+
+		/* Secondary IC cascaded to intc0 */
+		intc1: interrupt-controller at d8150000 {
+			compatible = "via,vt8500-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0xD8150000 0x10000>;
+			interrupts = <56 57 58 59 60 61 62 63>;
+		};
+
+		pinctrl: pinctrl at d8110000 {
+			compatible = "wm,wm8750-pinctrl";
+			reg = <0xd8110000 0x10000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		pmc at d8130000 {
+			compatible = "via,vt8500-pmc";
+			reg = <0xd8130000 0x1000>;
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ref24: ref24M {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+					clock-frequency = <24000000>;
+				};
+
+				ref25: ref25M {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+					clock-frequency = <25000000>;
+				};
+
+				plla: plla {
+					#clock-cells = <0>;
+					compatible = "wm,wm8750-pll-clock";
+					clocks = <&ref25>;
+					reg = <0x200>;
+				};
+
+				pllb: pllb {
+					#clock-cells = <0>;
+					compatible = "wm,wm8750-pll-clock";
+					clocks = <&ref25>;
+					reg = <0x204>;
+				};
+
+				pllc: pllc {
+					#clock-cells = <0>;
+					compatible = "wm,wm8750-pll-clock";
+					clocks = <&ref25>;
+					reg = <0x208>;
+				};
+
+				plld: plld {
+					#clock-cells = <0>;
+					compatible = "wm,wm8750-pll-clock";
+					clocks = <&ref25>;
+					reg = <0x20C>;
+				};
+
+				plle: plle {
+					#clock-cells = <0>;
+					compatible = "wm,wm8750-pll-clock";
+					clocks = <&ref25>;
+					reg = <0x210>;
+				};
+
+				clkarm: arm {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&plla>;
+					divisor-reg = <0x300>;
+				};
+
+				clkahb: ahb {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x304>;
+				};
+
+				clkddr: ddr {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&plld>;
+					divisor-reg = <0x310>;
+				};
+
+				clkuart0: uart0 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x254>;
+					enable-bit = <24>;
+				};
+
+				clkuart1: uart1 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x254>;
+					enable-bit = <25>;
+				};
+
+                                clkuart2: uart2 {
+                                        #clock-cells = <0>;
+                                        compatible = "via,vt8500-device-clock";
+                                        clocks = <&ref24>;
+                                        enable-reg = <0x254>;
+                                        enable-bit = <26>;
+                                };
+
+                                clkuart3: uart3 {
+                                        #clock-cells = <0>;
+                                        compatible = "via,vt8500-device-clock";
+                                        clocks = <&ref24>;
+                                        enable-reg = <0x254>;
+                                        enable-bit = <27>;
+                                };
+
+                                clkuart4: uart4 {
+                                        #clock-cells = <0>;
+                                        compatible = "via,vt8500-device-clock";
+                                        clocks = <&ref24>;
+                                        enable-reg = <0x254>;
+                                        enable-bit = <28>;
+                                };
+
+                                clkuart5: uart5 {
+                                        #clock-cells = <0>;
+                                        compatible = "via,vt8500-device-clock";
+                                        clocks = <&ref24>;
+                                        enable-reg = <0x254>;
+                                        enable-bit = <29>;
+                                };
+
+				clkpwm: pwm {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x350>;
+					enable-reg = <0x250>;
+					enable-bit = <17>;
+				};
+
+				clksdhc: sdhc {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x330>;
+					divisor-mask = <0x3f>;
+					enable-reg = <0x250>;
+					enable-bit = <0>;
+				};
+
+				clksf: sf {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x314>;
+					enable-reg = <0x254>;
+					enable-bit = <23>;
+				};
+
+				clki2c0: i2c0clk {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x3A0>;
+					enable-reg = <0x250>;
+					enable-bit = <8>;
+				};
+
+				clki2c1: i2c1clk {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x3A4>;
+					enable-reg = <0x250>;
+					enable-bit = <9>;
+				};
+			};
+		};
+
+		sf at d8002000 {
+			compatible = "wm,wm8505-sf";
+			reg = <0xd8002000 0x400>;
+			clocks = <&clksf>;
+		};
+
+		pwm: pwm at d8220000 {
+			#pwm-cells = <3>;
+			compatible = "via,vt8500-pwm";
+			reg = <0xd8220000 0x100>;
+			clocks = <&clkpwm>;
+		};
+
+		timer at d8130100 {
+			compatible = "via,vt8500-timer";
+			reg = <0xd8130100 0x28>;
+			interrupts = <36>;
+		};
+
+		ehci at d8007900 {
+			compatible = "via,vt8500-ehci";
+			reg = <0xd8007900 0x200>;
+			interrupts = <26>;
+		};
+
+		uhci at d8007b00 {
+			compatible = "platform-uhci";
+			reg = <0xd8007b00 0x200>;
+			interrupts = <26>;
+		};
+
+		uhci at d8008d00 {
+			compatible = "platform-uhci";
+			reg = <0xd8008d00 0x200>;
+			interrupts = <26>;
+		};
+
+		uart0: uart at d8200000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8200000 0x1040>;
+			interrupts = <32>;
+			clocks = <&clkuart0>;
+		};
+
+		uart1: uart at d82b0000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd82b0000 0x1040>;
+			interrupts = <33>;
+			clocks = <&clkuart1>;
+		};
+
+                uart2: uart at d8210000 {
+                        compatible = "via,vt8500-uart";
+                        reg = <0xd8210000 0x1040>;
+                        interrupts = <47>;
+                        clocks = <&clkuart2>;
+                };
+
+                uart3: uart at d82c0000 {
+                        compatible = "via,vt8500-uart";
+                        reg = <0xd82c0000 0x1040>;
+                        interrupts = <50>;
+                        clocks = <&clkuart3>;
+                };
+
+                uart4: uart at d8370000 {
+                        compatible = "via,vt8500-uart";
+                        reg = <0xd8370000 0x1040>;
+                        interrupts = <30>;
+                        clocks = <&clkuart4>;
+                };
+
+                uart5: uart at d8380000 {
+                        compatible = "via,vt8500-uart";
+                        reg = <0xd8380000 0x1040>;
+                        interrupts = <43>;
+                        clocks = <&clkuart5>;
+                };
+
+		rtc at d8100000 {
+			compatible = "via,vt8500-rtc";
+			reg = <0xd8100000 0x10000>;
+			interrupts = <48>;
+		};
+
+		sdhc at d800a000 {
+			compatible = "wm,wm8505-sdhc";
+			reg = <0xd800a000 0x1000>;
+			interrupts = <20 21>;
+			clocks = <&clksdhc>;
+			bus-width = <4>;
+			sdon-inverted;
+		};
+
+		i2c_0: i2c at d8280000 {
+			compatible = "wm,wm8505-i2c";
+			reg = <0xd8280000 0x1000>;
+			interrupts = <19>;
+			clocks = <&clki2c0>;
+			clock-frequency = <400000>;
+		};
+
+		i2c_1: i2c at d8320000 {
+			compatible = "wm,wm8505-i2c";
+			reg = <0xd8320000 0x1000>;
+			interrupts = <18>;
+			clocks = <&clki2c1>;
+			clock-frequency = <400000>;
+		};
+	};
+};
-- 
1.7.9.5
