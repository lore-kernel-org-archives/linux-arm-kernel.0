From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 23 Nov 2014 13:54:42 +0100
Subject: [PATCH 4/5] ARM: dts: sun6i: Add sun6i-a31s.dtsi
In-Reply-To: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
References: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1416747283-13489-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dtsi file for A31s based boards. This is a copy of sun6i-a31.dtsi, with:

-The main pinctrl compatible changed to allwinner,sun6i-a31s.dtsi
-The ohci2 controller is present according to the data-sheet, but not routed
 to the outside, so remove it from the dtsi as having an always disabled node
 is not useful.

All the other nodes present in the original sun6i-a31.dtsi are present in
the A31s too, and are 100% compatible.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31s.dtsi | 925 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 925 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun6i-a31s.dtsi

diff --git a/arch/arm/boot/dts/sun6i-a31s.dtsi b/arch/arm/boot/dts/sun6i-a31s.dtsi
new file mode 100644
index 0000000..b3b99a9
--- /dev/null
+++ b/arch/arm/boot/dts/sun6i-a31s.dtsi
@@ -0,0 +1,925 @@
+/*
+ * Copyright 2013 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		ethernet0 = &gmac;
+	};
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer at 0 {
+			compatible = "allwinner,simple-framebuffer", "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0-hdmi";
+			clocks = <&pll6>;
+			status = "disabled";
+		};
+	};
+
+	cpus {
+		enable-method = "allwinner,sun6i-a31";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <1>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <2>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <3>;
+		};
+	};
+
+	memory {
+		reg = <0x40000000 0x80000000>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
+		interrupts = <0 120 4>,
+			     <0 121 4>,
+			     <0 122 4>,
+			     <0 123 4>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		osc24M: osc24M {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+
+		osc32k: clk at 0 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			clock-output-names = "osc32k";
+		};
+
+		pll1: clk at 01c20000 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun6i-a31-pll1-clk";
+			reg = <0x01c20000 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll1";
+		};
+
+		pll6: clk at 01c20028 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun6i-a31-pll6-clk";
+			reg = <0x01c20028 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll6";
+		};
+
+		cpu: cpu at 01c20050 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-cpu-clk";
+			reg = <0x01c20050 0x4>;
+
+			/*
+			 * PLL1 is listed twice here.
+			 * While it looks suspicious, it's actually documented
+			 * that way both in the datasheet and in the code from
+			 * Allwinner.
+			 */
+			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
+			clock-output-names = "cpu";
+		};
+
+		axi: axi at 01c20050 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-axi-clk";
+			reg = <0x01c20050 0x4>;
+			clocks = <&cpu>;
+			clock-output-names = "axi";
+		};
+
+		ahb1_mux: ahb1_mux at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun6i-a31-ahb1-mux-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
+			clock-output-names = "ahb1_mux";
+		};
+
+		ahb1: ahb1 at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-ahb-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&ahb1_mux>;
+			clock-output-names = "ahb1";
+		};
+
+		ahb1_gates: clk at 01c20060 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun6i-a31-ahb1-gates-clk";
+			reg = <0x01c20060 0x8>;
+			clocks = <&ahb1>;
+			clock-output-names = "ahb1_mipidsi", "ahb1_ss",
+					"ahb1_dma", "ahb1_mmc0", "ahb1_mmc1",
+					"ahb1_mmc2", "ahb1_mmc3", "ahb1_nand1",
+					"ahb1_nand0", "ahb1_sdram",
+					"ahb1_gmac", "ahb1_ts", "ahb1_hstimer",
+					"ahb1_spi0", "ahb1_spi1", "ahb1_spi2",
+					"ahb1_spi3", "ahb1_otg", "ahb1_ehci0",
+					"ahb1_ehci1", "ahb1_ohci0",
+					"ahb1_ohci1", "ahb1_ohci2", "ahb1_ve",
+					"ahb1_lcd0", "ahb1_lcd1", "ahb1_csi",
+					"ahb1_hdmi", "ahb1_de0", "ahb1_de1",
+					"ahb1_fe0", "ahb1_fe1", "ahb1_mp",
+					"ahb1_gpu", "ahb1_deu0", "ahb1_deu1",
+					"ahb1_drc0", "ahb1_drc1";
+		};
+
+		apb1: apb1 at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-apb0-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&ahb1>;
+			clock-output-names = "apb1";
+		};
+
+		apb1_gates: clk at 01c20068 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun6i-a31-apb1-gates-clk";
+			reg = <0x01c20068 0x4>;
+			clocks = <&apb1>;
+			clock-output-names = "apb1_codec", "apb1_digital_mic",
+					"apb1_pio", "apb1_daudio0",
+					"apb1_daudio1";
+		};
+
+		apb2_mux: apb2_mux at 01c20058 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
+			reg = <0x01c20058 0x4>;
+			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+			clock-output-names = "apb2_mux";
+		};
+
+		apb2: apb2 at 01c20058 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun6i-a31-apb2-div-clk";
+			reg = <0x01c20058 0x4>;
+			clocks = <&apb2_mux>;
+			clock-output-names = "apb2";
+		};
+
+		apb2_gates: clk at 01c2006c {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun6i-a31-apb2-gates-clk";
+			reg = <0x01c2006c 0x4>;
+			clocks = <&apb2>;
+			clock-output-names = "apb2_i2c0", "apb2_i2c1",
+					"apb2_i2c2", "apb2_i2c3", "apb2_uart0",
+					"apb2_uart1", "apb2_uart2", "apb2_uart3",
+					"apb2_uart4", "apb2_uart5";
+		};
+
+		mmc0_clk: clk at 01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc0";
+		};
+
+		mmc1_clk: clk at 01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc1";
+		};
+
+		mmc2_clk: clk at 01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc2";
+		};
+
+		mmc3_clk: clk at 01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc3";
+		};
+
+		spi0_clk: clk at 01c200a0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c200a0 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "spi0";
+		};
+
+		spi1_clk: clk at 01c200a4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c200a4 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "spi1";
+		};
+
+		spi2_clk: clk at 01c200a8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c200a8 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "spi2";
+		};
+
+		spi3_clk: clk at 01c200ac {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c200ac 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "spi3";
+		};
+
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+		        #reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-usb-clk";
+			reg = <0x01c200cc 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "usb_phy0", "usb_phy1", "usb_phy2",
+					     "usb_ohci0", "usb_ohci1",
+					     "usb_ohci2";
+		};
+
+		/*
+		 * The following two are dummy clocks, placeholders used in the gmac_tx
+		 * clock. The gmac driver will choose one parent depending on the PHY
+		 * interface mode, using clk_set_rate auto-reparenting.
+		 * The actual TX clock rate is not controlled by the gmac_tx clock.
+		 */
+		mii_phy_tx_clk: clk at 1 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+			clock-output-names = "mii_phy_tx";
+		};
+
+		gmac_int_tx_clk: clk at 2 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <125000000>;
+			clock-output-names = "gmac_int_tx";
+		};
+
+		gmac_tx_clk: clk at 01c200d0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun7i-a20-gmac-clk";
+			reg = <0x01c200d0 0x4>;
+			clocks = <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
+			clock-output-names = "gmac_tx";
+		};
+	};
+
+	soc at 01c00000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dma: dma-controller at 01c02000 {
+			compatible = "allwinner,sun6i-a31-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <0 50 4>;
+			clocks = <&ahb1_gates 6>;
+			resets = <&ahb1_rst 6>;
+			#dma-cells = <1>;
+		};
+
+		mmc0: mmc at 01c0f000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb1_gates 8>, <&mmc0_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 8>;
+			reset-names = "ahb";
+			interrupts = <0 60 4>;
+			status = "disabled";
+		};
+
+		mmc1: mmc at 01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb1_gates 9>, <&mmc1_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 9>;
+			reset-names = "ahb";
+			interrupts = <0 61 4>;
+			status = "disabled";
+		};
+
+		mmc2: mmc at 01c11000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ahb1_gates 10>, <&mmc2_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 10>;
+			reset-names = "ahb";
+			interrupts = <0 62 4>;
+			status = "disabled";
+		};
+
+		mmc3: mmc at 01c12000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c12000 0x1000>;
+			clocks = <&ahb1_gates 11>, <&mmc3_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 11>;
+			reset-names = "ahb";
+			interrupts = <0 63 4>;
+			status = "disabled";
+		};
+
+		usbphy: phy at 01c19400 {
+			compatible = "allwinner,sun6i-a31-usb-phy";
+			reg = <0x01c19400 0x10>,
+			      <0x01c1a800 0x4>,
+			      <0x01c1b800 0x4>;
+			reg-names = "phy_ctrl",
+				    "pmu1",
+				    "pmu2";
+			clocks = <&usb_clk 8>,
+				 <&usb_clk 9>,
+				 <&usb_clk 10>;
+			clock-names = "usb0_phy",
+				      "usb1_phy",
+				      "usb2_phy";
+			resets = <&usb_clk 0>,
+				 <&usb_clk 1>,
+				 <&usb_clk 2>;
+			reset-names = "usb0_reset",
+				      "usb1_reset",
+				      "usb2_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
+		ehci0: usb at 01c1a000 {
+			compatible = "allwinner,sun6i-a31-ehci", "generic-ehci";
+			reg = <0x01c1a000 0x100>;
+			interrupts = <0 72 4>;
+			clocks = <&ahb1_gates 26>;
+			resets = <&ahb1_rst 26>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb at 01c1a400 {
+			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
+			reg = <0x01c1a400 0x100>;
+			interrupts = <0 73 4>;
+			clocks = <&ahb1_gates 29>, <&usb_clk 16>;
+			resets = <&ahb1_rst 29>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ehci1: usb at 01c1b000 {
+			compatible = "allwinner,sun6i-a31-ehci", "generic-ehci";
+			reg = <0x01c1b000 0x100>;
+			interrupts = <0 74 4>;
+			clocks = <&ahb1_gates 27>;
+			resets = <&ahb1_rst 27>;
+			phys = <&usbphy 2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci1: usb at 01c1b400 {
+			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
+			reg = <0x01c1b400 0x100>;
+			interrupts = <0 75 4>;
+			clocks = <&ahb1_gates 30>, <&usb_clk 17>;
+			resets = <&ahb1_rst 30>;
+			phys = <&usbphy 2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		pio: pinctrl at 01c20800 {
+			compatible = "allwinner,sun6i-a31s-pinctrl";
+			reg = <0x01c20800 0x400>;
+			interrupts = <0 11 4>,
+				     <0 15 4>,
+				     <0 16 4>,
+				     <0 17 4>;
+			clocks = <&apb1_gates 5>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+
+			uart0_pins_a: uart0 at 0 {
+				allwinner,pins = "PH20", "PH21";
+				allwinner,function = "uart0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			i2c0_pins_a: i2c0 at 0 {
+				allwinner,pins = "PH14", "PH15";
+				allwinner,function = "i2c0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			i2c1_pins_a: i2c1 at 0 {
+				allwinner,pins = "PH16", "PH17";
+				allwinner,function = "i2c1";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			i2c2_pins_a: i2c2 at 0 {
+				allwinner,pins = "PH18", "PH19";
+				allwinner,function = "i2c2";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			mmc0_pins_a: mmc0 at 0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
+
+			gmac_pins_mii_a: gmac_mii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						"PA8", "PA9", "PA11",
+						"PA12", "PA13", "PA14", "PA19",
+						"PA20", "PA21", "PA22", "PA23",
+						"PA24", "PA26", "PA27";
+				allwinner,function = "gmac";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			gmac_pins_gmii_a: gmac_gmii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						"PA4", "PA5", "PA6", "PA7",
+						"PA8", "PA9", "PA10", "PA11",
+						"PA12", "PA13", "PA14",	"PA15",
+						"PA16", "PA17", "PA18", "PA19",
+						"PA20", "PA21", "PA22", "PA23",
+						"PA24", "PA25", "PA26", "PA27";
+				allwinner,function = "gmac";
+				/*
+				 * data lines in GMII mode run at 125MHz and
+				 * might need a higher signal drive strength
+				 */
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
+
+			gmac_pins_rgmii_a: gmac_rgmii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						"PA9", "PA10", "PA11",
+						"PA12", "PA13", "PA14", "PA19",
+						"PA20", "PA25", "PA26", "PA27";
+				allwinner,function = "gmac";
+				/*
+				 * data lines in RGMII mode use DDR mode
+				 * and need a higher signal drive strength
+				 */
+				allwinner,drive = <3>;
+				allwinner,pull = <0>;
+			};
+		};
+
+		ahb1_rst: reset at 01c202c0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-ahb1-reset";
+			reg = <0x01c202c0 0xc>;
+		};
+
+		apb1_rst: reset at 01c202d0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202d0 0x4>;
+		};
+
+		apb2_rst: reset at 01c202d8 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202d8 0x4>;
+		};
+
+		timer at 01c20c00 {
+			compatible = "allwinner,sun4i-a10-timer";
+			reg = <0x01c20c00 0xa0>;
+			interrupts = <0 18 4>,
+				     <0 19 4>,
+				     <0 20 4>,
+				     <0 21 4>,
+				     <0 22 4>;
+			clocks = <&osc24M>;
+		};
+
+		wdt1: watchdog at 01c20ca0 {
+			compatible = "allwinner,sun6i-a31-wdt";
+			reg = <0x01c20ca0 0x20>;
+		};
+
+		uart0: serial at 01c28000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28000 0x400>;
+			interrupts = <0 0 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb2_gates 16>;
+			resets = <&apb2_rst 16>;
+			dmas = <&dma 6>, <&dma 6>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart1: serial at 01c28400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28400 0x400>;
+			interrupts = <0 1 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb2_gates 17>;
+			resets = <&apb2_rst 17>;
+			dmas = <&dma 7>, <&dma 7>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart2: serial at 01c28800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28800 0x400>;
+			interrupts = <0 2 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb2_gates 18>;
+			resets = <&apb2_rst 18>;
+			dmas = <&dma 8>, <&dma 8>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart3: serial at 01c28c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28c00 0x400>;
+			interrupts = <0 3 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb2_gates 19>;
+			resets = <&apb2_rst 19>;
+			dmas = <&dma 9>, <&dma 9>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart4: serial at 01c29000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c29000 0x400>;
+			interrupts = <0 4 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb2_gates 20>;
+			resets = <&apb2_rst 20>;
+			dmas = <&dma 10>, <&dma 10>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart5: serial at 01c29400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c29400 0x400>;
+			interrupts = <0 5 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb2_gates 21>;
+			resets = <&apb2_rst 21>;
+			dmas = <&dma 22>, <&dma 22>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2c0: i2c at 01c2ac00 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <0 6 4>;
+			clocks = <&apb2_gates 0>;
+			resets = <&apb2_rst 0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c at 01c2b000 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <0 7 4>;
+			clocks = <&apb2_gates 1>;
+			resets = <&apb2_rst 1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c at 01c2b400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <0 8 4>;
+			clocks = <&apb2_gates 2>;
+			resets = <&apb2_rst 2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c3: i2c at 01c2b800 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b800 0x400>;
+			interrupts = <0 9 4>;
+			clocks = <&apb2_gates 3>;
+			resets = <&apb2_rst 3>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		gmac: ethernet at 01c30000 {
+			compatible = "allwinner,sun7i-a20-gmac";
+			reg = <0x01c30000 0x1054>;
+			interrupts = <0 82 4>;
+			interrupt-names = "macirq";
+			clocks = <&ahb1_gates 17>, <&gmac_tx_clk>;
+			clock-names = "stmmaceth", "allwinner_gmac_tx";
+			resets = <&ahb1_rst 17>;
+			reset-names = "stmmaceth";
+			snps,pbl = <2>;
+			snps,fixed-burst;
+			snps,force_sf_dma_mode;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		timer at 01c60000 {
+			compatible = "allwinner,sun6i-a31-hstimer", "allwinner,sun7i-a20-hstimer";
+			reg = <0x01c60000 0x1000>;
+			interrupts = <0 51 4>,
+				     <0 52 4>,
+				     <0 53 4>,
+				     <0 54 4>;
+			clocks = <&ahb1_gates 19>;
+			resets = <&ahb1_rst 19>;
+		};
+
+		spi0: spi at 01c68000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c68000 0x1000>;
+			interrupts = <0 65 4>;
+			clocks = <&ahb1_gates 20>, <&spi0_clk>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
+			resets = <&ahb1_rst 20>;
+			status = "disabled";
+		};
+
+		spi1: spi at 01c69000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c69000 0x1000>;
+			interrupts = <0 66 4>;
+			clocks = <&ahb1_gates 21>, <&spi1_clk>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 24>, <&dma 24>;
+			dma-names = "rx", "tx";
+			resets = <&ahb1_rst 21>;
+			status = "disabled";
+		};
+
+		spi2: spi at 01c6a000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c6a000 0x1000>;
+			interrupts = <0 67 4>;
+			clocks = <&ahb1_gates 22>, <&spi2_clk>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 25>, <&dma 25>;
+			dma-names = "rx", "tx";
+			resets = <&ahb1_rst 22>;
+			status = "disabled";
+		};
+
+		spi3: spi at 01c6b000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c6b000 0x1000>;
+			interrupts = <0 68 4>;
+			clocks = <&ahb1_gates 23>, <&spi3_clk>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 26>, <&dma 26>;
+			dma-names = "rx", "tx";
+			resets = <&ahb1_rst 23>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at 01c81000 {
+			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
+			reg = <0x01c81000 0x1000>,
+			      <0x01c82000 0x1000>,
+			      <0x01c84000 0x2000>,
+			      <0x01c86000 0x2000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupts = <1 9 0xf04>;
+		};
+
+		rtc: rtc at 01f00000 {
+			compatible = "allwinner,sun6i-a31-rtc";
+			reg = <0x01f00000 0x54>;
+			interrupts = <0 40 4>, <0 41 4>;
+		};
+
+		nmi_intc: interrupt-controller at 01f00c0c {
+			compatible = "allwinner,sun6i-a31-sc-nmi";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01f00c0c 0x38>;
+			interrupts = <0 32 4>;
+		};
+
+		prcm at 01f01400 {
+			compatible = "allwinner,sun6i-a31-prcm";
+			reg = <0x01f01400 0x200>;
+
+			ar100: ar100_clk {
+				compatible = "allwinner,sun6i-a31-ar100-clk";
+				#clock-cells = <0>;
+				clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+				clock-output-names = "ar100";
+			};
+
+			ahb0: ahb0_clk {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clocks = <&ar100>;
+				clock-output-names = "ahb0";
+			};
+
+			apb0: apb0_clk {
+				compatible = "allwinner,sun6i-a31-apb0-clk";
+				#clock-cells = <0>;
+				clocks = <&ahb0>;
+				clock-output-names = "apb0";
+			};
+
+			apb0_gates: apb0_gates_clk {
+				compatible = "allwinner,sun6i-a31-apb0-gates-clk";
+				#clock-cells = <1>;
+				clocks = <&apb0>;
+				clock-output-names = "apb0_pio", "apb0_ir",
+						"apb0_timer", "apb0_p2wi",
+						"apb0_uart", "apb0_1wire",
+						"apb0_i2c";
+			};
+
+			ir_clk: ir_clk {
+				#clock-cells = <0>;
+				compatible = "allwinner,sun6i-a31-ir-clk";
+				clocks = <&osc32k>, <&osc24M>;
+				clock-output-names = "ir";
+			};
+
+			apb0_rst: apb0_rst {
+				compatible = "allwinner,sun6i-a31-clock-reset";
+				#reset-cells = <1>;
+			};
+		};
+
+		cpucfg at 01f01c00 {
+			compatible = "allwinner,sun6i-a31-cpuconfig";
+			reg = <0x01f01c00 0x300>;
+		};
+
+		ir at 01f02000 {
+			compatible = "allwinner,sun5i-a13-ir";
+			clocks = <&apb0_gates 1>, <&ir_clk>;
+			clock-names = "apb", "ir";
+			resets = <&apb0_rst 1>;
+			interrupts = <0 37 4>;
+			reg = <0x01f02000 0x40>;
+			status = "disabled";
+		};
+
+		r_pio: pinctrl at 01f02c00 {
+			compatible = "allwinner,sun6i-a31-r-pinctrl";
+			reg = <0x01f02c00 0x400>;
+			interrupts = <0 45 4>,
+				     <0 46 4>;
+			clocks = <&apb0_gates 0>;
+			resets = <&apb0_rst 0>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+
+			ir_pins_a: ir at 0 {
+				allwinner,pins = "PL4";
+				allwinner,function = "s_ir";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+		};
+	};
+};
-- 
2.1.0
