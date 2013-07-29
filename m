From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Jul 2013 14:31:53 +0200
Subject: [PATCH 4/5] ARM: dove: relocate internal registers device nodes
In-Reply-To: <1375101114-28858-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1375101114-28858-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1375101114-28858-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With mbus node in place, now relocate all internal device nodes
to internal-regs node with proper address ranges.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi |  955 +++++++++++++++++++++----------------------
 1 file changed, 474 insertions(+), 481 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index bdda016..867b945 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -5,6 +5,7 @@
 / {
 	compatible = "marvell,dove";
 	model = "Marvell Armada 88AP510 SoC";
+	interrupt-parent = <&intc>;
 
 	aliases {
 		gpio0 = &gpio0;
@@ -41,489 +42,481 @@
 			  MBUS_ID(0x01, 0xfd) 0 0xf8000000 0x8000000   /* BootROM  128M */
 			  MBUS_ID(0x03, 0x01) 0 0xc8000000 0x0100000   /* CESA SRAM  1M */
 			  MBUS_ID(0x0d, 0x00) 0 0xf0000000 0x0100000>; /* PMU  SRAM  1M */
-	};
-
-	soc at f1000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		interrupt-parent = <&intc>;
-
-		ranges = <0xc8000000 0xc8000000 0x0100000   /* CESA SRAM   1M */
-		          0xe0000000 0xe0000000 0x8000000   /* PCIe0 Mem 128M */
-		          0xe8000000 0xe8000000 0x8000000   /* PCIe1 Mem 128M */
-		          0xf0000000 0xf0000000 0x0100000   /* ScratchPad  1M */
-		          0x00000000 0xf1000000 0x1000000   /* SB/NB regs 16M */
-		          0xf2000000 0xf2000000 0x0100000   /* PCIe0 I/O   1M */
-		          0xf2100000 0xf2100000 0x0100000   /* PCIe0 I/O   1M */
-		          0xf8000000 0xf8000000 0x8000000>; /* BootROM   128M */
-
-		mbusc: mbus-ctrl at 20000 {
-			compatible = "marvell,mbus-controller";
-			reg = <0x20000 0x80>, <0x800100 0x8>;
-		};
-
-		timer: timer at 20300 {
-			compatible = "marvell,orion-timer";
-			reg = <0x20300 0x20>;
-			interrupt-parent = <&bridge_intc>;
-			interrupts = <1>, <2>;
-			clocks = <&core_clk 0>;
-		};
-
-		intc: main-interrupt-ctrl at 20200 {
-			compatible = "marvell,orion-intc";
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			reg = <0x20200 0x10>, <0x20210 0x10>;
-		};
-
-		bridge_intc: bridge-interrupt-ctrl at 20110 {
-			compatible = "marvell,orion-bridge-intc";
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			reg = <0x20110 0x8>;
-			interrupts = <0>;
-			marvell,#interrupts = <5>;
-		};
-
-		core_clk: core-clocks at d0214 {
-			compatible = "marvell,dove-core-clock";
-			reg = <0xd0214 0x4>;
-			#clock-cells = <1>;
-		};
-
-		gate_clk: clock-gating-ctrl at d0038 {
-			compatible = "marvell,dove-gating-clock";
-			reg = <0xd0038 0x4>;
-			clocks = <&core_clk 0>;
-			#clock-cells = <1>;
-		};
-
-		thermal: thermal-diode at d001c {
-			compatible = "marvell,dove-thermal";
-			reg = <0xd001c 0x0c>, <0xd005c 0x08>;
-		};
-
-		uart0: serial at 12000 {
-			compatible = "ns16550a";
-			reg = <0x12000 0x100>;
-			reg-shift = <2>;
-			interrupts = <7>;
-			clocks = <&core_clk 0>;
-			status = "disabled";
-		};
-
-		uart1: serial at 12100 {
-			compatible = "ns16550a";
-			reg = <0x12100 0x100>;
-			reg-shift = <2>;
-			interrupts = <8>;
-			clocks = <&core_clk 0>;
-			pinctrl-0 = <&pmx_uart1>;
-			pinctrl-names = "default";
-			status = "disabled";
-		};
-
-		uart2: serial at 12200 {
-			compatible = "ns16550a";
-			reg = <0x12000 0x100>;
-			reg-shift = <2>;
-			interrupts = <9>;
-			clocks = <&core_clk 0>;
-			status = "disabled";
-		};
-
-		uart3: serial at 12300 {
-			compatible = "ns16550a";
-			reg = <0x12100 0x100>;
-			reg-shift = <2>;
-			interrupts = <10>;
-			clocks = <&core_clk 0>;
-			status = "disabled";
-		};
-
-		gpio0: gpio-ctrl at d0400 {
-			compatible = "marvell,orion-gpio";
-			#gpio-cells = <2>;
-			gpio-controller;
-			reg = <0xd0400 0x20>;
-			ngpios = <32>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			interrupts = <12>, <13>, <14>, <60>;
-		};
-
-		gpio1: gpio-ctrl at d0420 {
-			compatible = "marvell,orion-gpio";
-			#gpio-cells = <2>;
-			gpio-controller;
-			reg = <0xd0420 0x20>;
-			ngpios = <32>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			interrupts = <61>;
-		};
-
-		gpio2: gpio-ctrl at e8400 {
-			compatible = "marvell,orion-gpio";
-			#gpio-cells = <2>;
-			gpio-controller;
-			reg = <0xe8400 0x0c>;
-			ngpios = <8>;
-		};
-
-		pinctrl: pin-ctrl at d0200 {
-			compatible = "marvell,dove-pinctrl";
-			reg = <0xd0200 0x10>;
-			clocks = <&gate_clk 22>;
-
-			pmx_gpio_0: pmx-gpio-0 {
-				marvell,pins = "mpp0";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_1: pmx-gpio-1 {
-				marvell,pins = "mpp1";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_2: pmx-gpio-2 {
-				marvell,pins = "mpp2";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_3: pmx-gpio-3 {
-				marvell,pins = "mpp3";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_4: pmx-gpio-4 {
-				marvell,pins = "mpp4";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_5: pmx-gpio-5 {
-				marvell,pins = "mpp5";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_6: pmx-gpio-6 {
-				marvell,pins = "mpp6";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_7: pmx-gpio-7 {
-				marvell,pins = "mpp7";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_8: pmx-gpio-8 {
-				marvell,pins = "mpp8";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_9: pmx-gpio-9 {
-				marvell,pins = "mpp9";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_10: pmx-gpio-10 {
-				marvell,pins = "mpp10";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_11: pmx-gpio-11 {
-				marvell,pins = "mpp11";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_12: pmx-gpio-12 {
-				marvell,pins = "mpp12";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_13: pmx-gpio-13 {
-				marvell,pins = "mpp13";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_14: pmx-gpio-14 {
-				marvell,pins = "mpp14";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_15: pmx-gpio-15 {
-				marvell,pins = "mpp15";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_16: pmx-gpio-16 {
-				marvell,pins = "mpp16";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_17: pmx-gpio-17 {
-				marvell,pins = "mpp17";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_18: pmx-gpio-18 {
-				marvell,pins = "mpp18";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_19: pmx-gpio-19 {
-				marvell,pins = "mpp19";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_20: pmx-gpio-20 {
-				marvell,pins = "mpp20";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_21: pmx-gpio-21 {
-				marvell,pins = "mpp21";
-				marvell,function = "gpio";
-			};
-
-			pmx_camera: pmx-camera {
-				marvell,pins = "mpp_camera";
-				marvell,function = "camera";
-			};
-
-			pmx_camera_gpio: pmx-camera-gpio {
-				marvell,pins = "mpp_camera";
-				marvell,function = "gpio";
-			};
-
-			pmx_sdio0: pmx-sdio0 {
-				marvell,pins = "mpp_sdio0";
-				marvell,function = "sdio0";
-			};
-
-			pmx_sdio0_gpio: pmx-sdio0-gpio {
-				marvell,pins = "mpp_sdio0";
-				marvell,function = "gpio";
-			};
-
-			pmx_sdio1: pmx-sdio1 {
-				marvell,pins = "mpp_sdio1";
-				marvell,function = "sdio1";
-			};
-
-			pmx_sdio1_gpio: pmx-sdio1-gpio {
-				marvell,pins = "mpp_sdio1";
-				marvell,function = "gpio";
-			};
-
-			pmx_audio1_gpio: pmx-audio1-gpio {
-				marvell,pins = "mpp_audio1";
-				marvell,function = "gpio";
-			};
-
-			pmx_spi0: pmx-spi0 {
-				marvell,pins = "mpp_spi0";
-				marvell,function = "spi0";
-			};
-
-			pmx_spi0_gpio: pmx-spi0-gpio {
-				marvell,pins = "mpp_spi0";
-				marvell,function = "gpio";
-			};
-
-			pmx_uart1: pmx-uart1 {
-				marvell,pins = "mpp_uart1";
-				marvell,function = "uart1";
-			};
-
-			pmx_uart1_gpio: pmx-uart1-gpio {
-				marvell,pins = "mpp_uart1";
-				marvell,function = "gpio";
-			};
-
-			pmx_nand: pmx-nand {
-				marvell,pins = "mpp_nand";
-				marvell,function = "nand";
-			};
-
-			pmx_nand_gpo: pmx-nand-gpo {
-				marvell,pins = "mpp_nand";
-				marvell,function = "gpo";
-			};
-		};
-
-		spi0: spi-ctrl at 10600 {
-			compatible = "marvell,orion-spi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			interrupts = <6>;
-			reg = <0x10600 0x28>;
-			clocks = <&core_clk 0>;
-			pinctrl-0 = <&pmx_spi0>;
-			pinctrl-names = "default";
-			status = "disabled";
-		};
-
-		spi1: spi-ctrl at 14600 {
-			compatible = "marvell,orion-spi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			interrupts = <5>;
-			reg = <0x14600 0x28>;
-			clocks = <&core_clk 0>;
-			status = "disabled";
-		};
-
-		i2c0: i2c-ctrl at 11000 {
-			compatible = "marvell,mv64xxx-i2c";
-			reg = <0x11000 0x20>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <11>;
-			clock-frequency = <400000>;
-			timeout-ms = <1000>;
-			clocks = <&core_clk 0>;
-			status = "disabled";
-		};
-
-		ehci0: usb-host at 50000 {
-			compatible = "marvell,orion-ehci";
-			reg = <0x50000 0x1000>;
-			interrupts = <24>;
-			clocks = <&gate_clk 0>;
-			status = "okay";
-		};
-
-		ehci1: usb-host at 51000 {
-			compatible = "marvell,orion-ehci";
-			reg = <0x51000 0x1000>;
-			interrupts = <25>;
-			clocks = <&gate_clk 1>;
-			status = "okay";
-		};
-
-		sdio0: sdio-host at 92000 {
-			compatible = "marvell,dove-sdhci";
-			reg = <0x92000 0x100>;
-			interrupts = <35>, <37>;
-			clocks = <&gate_clk 8>;
-			pinctrl-0 = <&pmx_sdio0>;
-			pinctrl-names = "default";
-			status = "disabled";
-		};
-
-		sdio1: sdio-host at 90000 {
-			compatible = "marvell,dove-sdhci";
-			reg = <0x90000 0x100>;
-			interrupts = <36>, <38>;
-			clocks = <&gate_clk 9>;
-			pinctrl-0 = <&pmx_sdio1>;
-			pinctrl-names = "default";
-			status = "disabled";
-		};
-
-		sata0: sata-host at a0000 {
-			compatible = "marvell,orion-sata";
-			reg = <0xa0000 0x2400>;
-			interrupts = <62>;
-			clocks = <&gate_clk 3>;
-			nr-ports = <1>;
-			status = "disabled";
-		};
-
-		rtc: real-time-clock at d8500 {
-			compatible = "marvell,orion-rtc";
-			reg = <0xd8500 0x20>;
-		};
-
-		crypto: crypto-engine at 30000 {
-			compatible = "marvell,orion-crypto";
-			reg = <0x30000 0x10000>,
-			      <0xc8000000 0x800>;
-			reg-names = "regs", "sram";
-			interrupts = <31>;
-			clocks = <&gate_clk 15>;
-			status = "okay";
-		};
-
-		xor0: dma-engine at 60800 {
-			compatible = "marvell,orion-xor";
-			reg = <0x60800 0x100
-			       0x60a00 0x100>;
-			clocks = <&gate_clk 23>;
-			status = "okay";
-
-			channel0 {
-				interrupts = <39>;
-				dmacap,memcpy;
-				dmacap,xor;
-			};
-
-			channel1 {
-				interrupts = <40>;
-				dmacap,memset;
-				dmacap,memcpy;
-				dmacap,xor;
-			};
-		};
-
-		xor1: dma-engine at 60900 {
-			compatible = "marvell,orion-xor";
-			reg = <0x60900 0x100
-			       0x60b00 0x100>;
-			clocks = <&gate_clk 24>;
-			status = "okay";
-
-			channel0 {
-				interrupts = <42>;
-				dmacap,memcpy;
-				dmacap,xor;
-			};
-
-			channel1 {
-				interrupts = <43>;
-				dmacap,memset;
-				dmacap,memcpy;
-				dmacap,xor;
-			};
-		};
-
-		mdio: mdio-bus at 72004 {
-			compatible = "marvell,orion-mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x72004 0x84>;
-			interrupts = <30>;
-			clocks = <&gate_clk 2>;
-			status = "disabled";
-
-			ethphy: ethernet-phy {
-				device-type = "ethernet-phy";
-				/* set phy address in board file */
-			};
-		};
 
-		eth: ethernet-ctrl at 72000 {
-			compatible = "marvell,orion-eth";
+		internal-regs {
+			compatible = "simple-bus";
 			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x72000 0x4000>;
-			clocks = <&gate_clk 2>;
-			marvell,tx-checksum-limit = <1600>;
-			status = "disabled";
-
-			ethernet-port at 0 {
-				device_type = "network";
-				compatible = "marvell,orion-eth-port";
-				reg = <0>;
-				interrupts = <29>;
-				/* overwrite MAC address in bootloader */
-				local-mac-address = [00 00 00 00 00 00];
-				phy-handle = <&ethphy>;
+			#size-cells = <1>;
+			ranges = <0x00000000 MBUS_ID(0xf0, 0x01) 0 0x0100000   /* MBUS regs  1M */
+				  0x00800000 MBUS_ID(0xf0, 0x02) 0 0x1000000   /* AXI  regs 16M */
+				  0xffffe000 MBUS_ID(0x03, 0x01) 0 0x0000800   /* CESA SRAM  2k */
+				  0xfffff000 MBUS_ID(0x0d, 0x00) 0 0x0000800>; /* PMU  SRAM  2k */
+
+			mbusc: mbus-ctrl at 20000 {
+				compatible = "marvell,mbus-controller";
+				reg = <0x20000 0x80>, <0x800100 0x8>;
+			};
+
+			timer: timer at 20300 {
+				compatible = "marvell,orion-timer";
+				reg = <0x20300 0x20>;
+				interrupt-parent = <&bridge_intc>;
+				interrupts = <1>, <2>;
+				clocks = <&core_clk 0>;
+			};
+
+			intc: main-interrupt-ctrl at 20200 {
+				compatible = "marvell,orion-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x20200 0x10>, <0x20210 0x10>;
+			};
+
+			bridge_intc: bridge-interrupt-ctrl at 20110 {
+				compatible = "marvell,orion-bridge-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x20110 0x8>;
+				interrupts = <0>;
+				marvell,#interrupts = <5>;
+			};
+
+			core_clk: core-clocks at d0214 {
+				compatible = "marvell,dove-core-clock";
+				reg = <0xd0214 0x4>;
+				#clock-cells = <1>;
+			};
+
+			gate_clk: clock-gating-ctrl at d0038 {
+				compatible = "marvell,dove-gating-clock";
+				reg = <0xd0038 0x4>;
+				clocks = <&core_clk 0>;
+				#clock-cells = <1>;
+			};
+
+			thermal: thermal-diode at d001c {
+				compatible = "marvell,dove-thermal";
+				reg = <0xd001c 0x0c>, <0xd005c 0x08>;
+			};
+
+			uart0: serial at 12000 {
+				compatible = "ns16550a";
+				reg = <0x12000 0x100>;
+				reg-shift = <2>;
+				interrupts = <7>;
+				clocks = <&core_clk 0>;
+				status = "disabled";
+			};
+
+			uart1: serial at 12100 {
+				compatible = "ns16550a";
+				reg = <0x12100 0x100>;
+				reg-shift = <2>;
+				interrupts = <8>;
+				clocks = <&core_clk 0>;
+				pinctrl-0 = <&pmx_uart1>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			uart2: serial at 12200 {
+				compatible = "ns16550a";
+				reg = <0x12000 0x100>;
+				reg-shift = <2>;
+				interrupts = <9>;
+				clocks = <&core_clk 0>;
+				status = "disabled";
+			};
+
+			uart3: serial at 12300 {
+				compatible = "ns16550a";
+				reg = <0x12100 0x100>;
+				reg-shift = <2>;
+				interrupts = <10>;
+				clocks = <&core_clk 0>;
+				status = "disabled";
+			};
+
+			gpio0: gpio-ctrl at d0400 {
+				compatible = "marvell,orion-gpio";
+				#gpio-cells = <2>;
+				gpio-controller;
+				reg = <0xd0400 0x20>;
+				ngpios = <32>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <12>, <13>, <14>, <60>;
+			};
+
+			gpio1: gpio-ctrl at d0420 {
+				compatible = "marvell,orion-gpio";
+				#gpio-cells = <2>;
+				gpio-controller;
+				reg = <0xd0420 0x20>;
+				ngpios = <32>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <61>;
+			};
+
+			gpio2: gpio-ctrl at e8400 {
+				compatible = "marvell,orion-gpio";
+				#gpio-cells = <2>;
+				gpio-controller;
+				reg = <0xe8400 0x0c>;
+				ngpios = <8>;
+			};
+
+			pinctrl: pin-ctrl at d0200 {
+				compatible = "marvell,dove-pinctrl";
+				reg = <0xd0200 0x10>;
+				clocks = <&gate_clk 22>;
+
+				pmx_gpio_0: pmx-gpio-0 {
+					marvell,pins = "mpp0";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_1: pmx-gpio-1 {
+					marvell,pins = "mpp1";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_2: pmx-gpio-2 {
+					marvell,pins = "mpp2";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_3: pmx-gpio-3 {
+					marvell,pins = "mpp3";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_4: pmx-gpio-4 {
+					marvell,pins = "mpp4";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_5: pmx-gpio-5 {
+					marvell,pins = "mpp5";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_6: pmx-gpio-6 {
+					marvell,pins = "mpp6";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_7: pmx-gpio-7 {
+					marvell,pins = "mpp7";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_8: pmx-gpio-8 {
+					marvell,pins = "mpp8";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_9: pmx-gpio-9 {
+					marvell,pins = "mpp9";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_10: pmx-gpio-10 {
+					marvell,pins = "mpp10";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_11: pmx-gpio-11 {
+					marvell,pins = "mpp11";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_12: pmx-gpio-12 {
+					marvell,pins = "mpp12";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_13: pmx-gpio-13 {
+					marvell,pins = "mpp13";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_14: pmx-gpio-14 {
+					marvell,pins = "mpp14";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_15: pmx-gpio-15 {
+					marvell,pins = "mpp15";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_16: pmx-gpio-16 {
+					marvell,pins = "mpp16";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_17: pmx-gpio-17 {
+					marvell,pins = "mpp17";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_18: pmx-gpio-18 {
+					marvell,pins = "mpp18";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_19: pmx-gpio-19 {
+					marvell,pins = "mpp19";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_20: pmx-gpio-20 {
+					marvell,pins = "mpp20";
+					marvell,function = "gpio";
+				};
+
+				pmx_gpio_21: pmx-gpio-21 {
+					marvell,pins = "mpp21";
+					marvell,function = "gpio";
+				};
+
+				pmx_camera: pmx-camera {
+					marvell,pins = "mpp_camera";
+					marvell,function = "camera";
+				};
+
+				pmx_camera_gpio: pmx-camera-gpio {
+					marvell,pins = "mpp_camera";
+					marvell,function = "gpio";
+				};
+
+				pmx_sdio0: pmx-sdio0 {
+					marvell,pins = "mpp_sdio0";
+					marvell,function = "sdio0";
+				};
+
+				pmx_sdio0_gpio: pmx-sdio0-gpio {
+					marvell,pins = "mpp_sdio0";
+					marvell,function = "gpio";
+				};
+
+				pmx_sdio1: pmx-sdio1 {
+					marvell,pins = "mpp_sdio1";
+					marvell,function = "sdio1";
+				};
+
+				pmx_sdio1_gpio: pmx-sdio1-gpio {
+					marvell,pins = "mpp_sdio1";
+					marvell,function = "gpio";
+				};
+
+				pmx_audio1_gpio: pmx-audio1-gpio {
+					marvell,pins = "mpp_audio1";
+					marvell,function = "gpio";
+				};
+
+				pmx_spi0: pmx-spi0 {
+					marvell,pins = "mpp_spi0";
+					marvell,function = "spi0";
+				};
+
+				pmx_spi0_gpio: pmx-spi0-gpio {
+					marvell,pins = "mpp_spi0";
+					marvell,function = "gpio";
+				};
+
+				pmx_uart1: pmx-uart1 {
+					marvell,pins = "mpp_uart1";
+					marvell,function = "uart1";
+				};
+
+				pmx_uart1_gpio: pmx-uart1-gpio {
+					marvell,pins = "mpp_uart1";
+					marvell,function = "gpio";
+				};
+
+				pmx_nand: pmx-nand {
+					marvell,pins = "mpp_nand";
+					marvell,function = "nand";
+				};
+
+				pmx_nand_gpo: pmx-nand-gpo {
+					marvell,pins = "mpp_nand";
+					marvell,function = "gpo";
+				};
+			};
+
+			spi0: spi-ctrl at 10600 {
+				compatible = "marvell,orion-spi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				interrupts = <6>;
+				reg = <0x10600 0x28>;
+				clocks = <&core_clk 0>;
+				pinctrl-0 = <&pmx_spi0>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			spi1: spi-ctrl at 14600 {
+				compatible = "marvell,orion-spi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <1>;
+				interrupts = <5>;
+				reg = <0x14600 0x28>;
+				clocks = <&core_clk 0>;
+				status = "disabled";
+			};
+
+			i2c0: i2c-ctrl at 11000 {
+				compatible = "marvell,mv64xxx-i2c";
+				reg = <0x11000 0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <11>;
+				clock-frequency = <400000>;
+				timeout-ms = <1000>;
+				clocks = <&core_clk 0>;
+				status = "disabled";
+			};
+
+			ehci0: usb-host at 50000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x50000 0x1000>;
+				interrupts = <24>;
+				clocks = <&gate_clk 0>;
+				status = "okay";
+			};
+
+			ehci1: usb-host at 51000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x51000 0x1000>;
+				interrupts = <25>;
+				clocks = <&gate_clk 1>;
+				status = "okay";
+			};
+
+			sdio0: sdio-host at 92000 {
+				compatible = "marvell,dove-sdhci";
+				reg = <0x92000 0x100>;
+				interrupts = <35>, <37>;
+				clocks = <&gate_clk 8>;
+				pinctrl-0 = <&pmx_sdio0>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			sdio1: sdio-host at 90000 {
+				compatible = "marvell,dove-sdhci";
+				reg = <0x90000 0x100>;
+				interrupts = <36>, <38>;
+				clocks = <&gate_clk 9>;
+				pinctrl-0 = <&pmx_sdio1>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			sata0: sata-host at a0000 {
+				compatible = "marvell,orion-sata";
+				reg = <0xa0000 0x2400>;
+				interrupts = <62>;
+				clocks = <&gate_clk 3>;
+				nr-ports = <1>;
+				status = "disabled";
+			};
+
+			rtc: real-time-clock at d8500 {
+				compatible = "marvell,orion-rtc";
+				reg = <0xd8500 0x20>;
+			};
+
+			crypto: crypto-engine at 30000 {
+				compatible = "marvell,orion-crypto";
+				reg = <0x30000 0x10000>,
+				      <0xffffe000 0x800>;
+				reg-names = "regs", "sram";
+				interrupts = <31>;
+				clocks = <&gate_clk 15>;
+				status = "okay";
+			};
+
+			xor0: dma-engine at 60800 {
+				compatible = "marvell,orion-xor";
+				reg = <0x60800 0x100
+				       0x60a00 0x100>;
+				clocks = <&gate_clk 23>;
+				status = "okay";
+
+				channel0 {
+					interrupts = <39>;
+					dmacap,memcpy;
+					dmacap,xor;
+				};
+
+				channel1 {
+					interrupts = <40>;
+					dmacap,memcpy;
+					dmacap,xor;
+				};
+			};
+
+			xor1: dma-engine at 60900 {
+				compatible = "marvell,orion-xor";
+				reg = <0x60900 0x100
+				       0x60b00 0x100>;
+				clocks = <&gate_clk 24>;
+				status = "okay";
+
+				channel0 {
+					interrupts = <42>;
+					dmacap,memcpy;
+					dmacap,xor;
+				};
+
+				channel1 {
+					interrupts = <43>;
+					dmacap,memcpy;
+					dmacap,xor;
+				};
+			};
+
+			mdio: mdio-bus at 72004 {
+				compatible = "marvell,orion-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x72004 0x84>;
+				interrupts = <30>;
+				clocks = <&gate_clk 2>;
+				status = "disabled";
+
+				ethphy: ethernet-phy {
+					device-type = "ethernet-phy";
+					/* set phy address in board file */
+				};
+			};
+
+			eth: ethernet-ctrl at 72000 {
+				compatible = "marvell,orion-eth";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x72000 0x4000>;
+				clocks = <&gate_clk 2>;
+				marvell,tx-checksum-limit = <1600>;
+				status = "disabled";
+
+				ethernet-port at 0 {
+					device_type = "network";
+					compatible = "marvell,orion-eth-port";
+					reg = <0>;
+					interrupts = <29>;
+					/* overwrite MAC address in bootloader */
+					local-mac-address = [00 00 00 00 00 00];
+					phy-handle = <&ethphy>;
+				};
 			};
 		};
 	};
-- 
1.7.10.4
