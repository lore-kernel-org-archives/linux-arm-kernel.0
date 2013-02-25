From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 25 Feb 2013 11:49:41 +0800
Subject: [PATCH v5 12/12] ARM: dts: support pinmux in pxa910
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361764181-26647-13-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio range, pinmux settings in pxa910 dkb DTS file.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/pxa910-dkb.dts |  248 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/pxa910.dtsi    |   29 ++++-
 2 files changed, 275 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/pxa910-dkb.dts
index 595492a..04db0b6 100644
--- a/arch/arm/boot/dts/pxa910-dkb.dts
+++ b/arch/arm/boot/dts/pxa910-dkb.dts
@@ -170,6 +170,254 @@
 			rtc: rtc at d4010000 {
 				status = "okay";
 			};
+			gpio-keys {
+				compatible = "gpio-keys";
+
+				/* in6, out3, out4 */
+				right {
+					label = "right";
+					gpios = <&gcb0 12 0>;
+					linux,code = <106>;	/* KEY_RIGHT */
+				};
+				num5 {
+					label = "5";
+					gpios = <&gcb0 4 0>;
+					linux,code = <6>;	/* KEY_5 */
+				};
+			};
+			gpio at d4019000 {
+				status = "okay";
+
+				/*
+				 * In theorical, some gpios could be routed to
+				 * multiple pins. So define the gpio-ranges in
+				 * board file, not silicon file.
+				 */
+				gcb0: gpio at d4019000 {
+					/* <gpio_offset, pin_offset, nr_pins> */
+					gpio-ranges = <&pmx 0 55 32>;
+				};
+				gcb1: gpio at d4019004 {
+					/* <gpio_offset, pin_offset, nr_pins> */
+					gpio-ranges = <&pmx 0 87 23 &pmx 23 188 9>;
+				};
+				gcb2: gpio at d4019008 {
+					/* <gpio_offset, pin_offset, nr_pins> */
+					gpio-ranges = <&pmx 0 197 3 &pmx 3 110 29>;
+				};
+				gcb3: gpio at d4019100 {
+					/* <gpio_offset, pin_offset, nr_pins> */
+					gpio-ranges = < &pmx 0 139 14 &pmx 14 166 7
+							&pmx 21 45 4 &pmx 25 203 1
+							&pmx 26 50 4 &pmx 30 27 2>;
+				};
+			};
+			pmx: pinmux at d401e000 {
+				/* pin base, nr pins & gpio function */
+				pinctrl-single,gpio-range = <
+					/*
+					 * GPIO number is hardcoded for range@here.
+					 * In gpio chip, GPIO number is not hardcoded for range.
+					 * Since one gpio pin may be routed to multiple pins,
+					 * define these gpio range in pxa910-dkb.dts not pxa910.dtsi.
+					 */
+						&range 55 55 0	/* GPIO0 ~ GPIO54 */
+						&range 188 5 1	/* GPIO55 ~ GPIO59 */ 
+						&range 193 7 0	/* GPIO60 ~ GPIO66 */
+						&range 110 43 0	/* GPIO67 ~ GPIO109 */
+						&range 166 7 0	/* GPIO110 ~ GPIO116 */
+						&range 45 4 0	/* GPIO117 ~ GPIO120 */
+						&range 50 2 1	/* GPIO122 ~ GPIO123 */
+						&range 203 1 0	/* GPIO121 */
+						&range 52 1 0	/* GPIO124 */
+						&range 53 1 1	/* GPIO125 */
+						&range 27 2 0	/* GPIO126 ~ GPIO127 */
+					>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&keypad_pmx_func>;
+
+				uart1_pmx_func: pinmux_uart1_pins at 0 {
+					pinctrl-single,pins = <
+						0x198 0x6	/* GPIO47_UART1_RXD */
+						0x19c 0x6	/* GPIO48_UART1_TXD */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0xc000 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				uart2_pmx_func: pinmux_uart2_pins at 0 {
+					pinctrl-single,pins = <
+						0x150 0x4	/* GPIO29_UART2_CTS */
+						0x154 0x4	/* GPIO30_UART2_RTS */
+						0x158 0x4	/* GPIO31_UART2_TXD */
+						0x15c 0x4	/* GPIO32_UART2_RXD */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				uart3_pmx_func: pinmux_uart3_pins at 0 {
+					pinctrl-single,pins = <
+						0x188 0x7	/* GPIO43_UART3_RXD */
+						0x18c 0x7	/* GPIO44_UART3_TXD */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				twsi1_pmx_func: pinmux_twsi1_pins at 0 {
+					pinctrl-single,pins = <
+						0x1b0 0x2	/* GPIO53_TWSI_SCL */
+						0x1b4 0x2	/* GPIO54_TWSI_SDA */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				nand_pmx_func: pinmux_nand_pins at 0 {
+					pinctrl-single,pins = <
+						0x040 0x0	/* ND_IO0 */
+						0x03c 0x0	/* ND_IO1 */
+						0x038 0x0	/* ND_IO2 */
+						0x034 0x0	/* ND_IO3 */
+						0x030 0x0	/* ND_IO4 */
+						0x02c 0x0	/* ND_IO5 */
+						0x028 0x0	/* ND_IO6 */
+						0x024 0x0	/* ND_IO7 */
+						0x020 0x0	/* ND_IO8 */
+						0x01c 0x0	/* ND_IO9 */
+						0x018 0x0	/* ND_IO10 */
+						0x014 0x0	/* ND_IO11 */
+						0x010 0x0	/* ND_IO12 */
+						0x00c 0x0	/* ND_IO13 */
+						0x008 0x0	/* ND_IO14 */
+						0x004 0x0	/* ND_IO15 */
+						0x044 0x0	/* ND_nCS0 */
+						0x060 0x1	/* ND_ALE */
+						0x05c 0x0	/* ND_CLE */
+						0x054 0x1	/* ND_nWE */
+						0x058 0x1	/* ND_nRE */
+						0x068 0x0	/* ND_RDY0 */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				mmc1_pmx_func1: pinmux_mmc1_pins at 0 {
+					pinctrl-single,pins = <
+						0x0a0 0x0	/* MMC1_DATA0 */
+						0x09c 0x0	/* MMC1_DATA1 */
+						0x098 0x0	/* MMC1_DATA2 */
+						0x094 0x0	/* MMC1_DATA3 */
+						0x090 0x0	/* MMC1_DATA4 */
+						0x08c 0x0	/* MMC1_DATA5 */
+						0x088 0x0	/* MMC1_DATA6 */
+						0x084 0x0	/* MMC1_DATA7 */
+						0x0a4 0x0	/* MMC1_CMD */
+						0x0a8 0x0	/* MMC1_CLK */
+					>;
+					pinctrl-single,slew-rate = <0x1800 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				mmc1_pmx_func2: pinmux_mmc1_pins at 1 {
+					pinctrl-single,pins = <
+						0x0ac 0x0	/* MMC1_CD */
+						0x0b0 0x0	/* MMC1_WP */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				mmc2_pmx_func: pinmux_mmc2_pins at 0 {
+					pinctrl-single,pins = <
+						0x180 0x1	/* MMC2_CMD */
+						0x184 0x1	/* MMC2_CLK */
+						0x17c 0x1	/* MMC2_DATA0 */
+						0x178 0x1	/* MMC2_DATA1 */
+						0x174 0x1	/* MMC2_DATA2 */
+						0x170 0x1	/* MMC2_DATA3 */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				ssp1_pmx_func: pinmux_ssp1_pins at 0 {
+					pinctrl-single,pins = <
+						0x130 0x1	/* GPIO21_SSP1_SCLK */
+						0x134 0x1	/* GPIO22_SSP1_FRM */
+						0x138 0x1	/* GPIO23_SSP1_TXD */
+						0x13c 0x1	/* GPIO24_SSP1_RXD */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				keypad_pmx_func: pinmux_keypad_pins at 0 {
+					pinctrl-single,pins = <
+						0x0dc 0x1	/* GPIO0_MKIN0 */
+						0x0e0 0x1	/* GPIO1_MKOUT0 */
+						0x0e4 0x1	/* GPIO2_MKIN1 */
+						0x0e8 0x1	/* GPIO3_MKOUT1 */
+						0x0ec 0x1	/* GPIO4_MKIN2 */
+						0x0f0 0x1	/* GPIO5_MKOUT2 */
+						0x0f4 0x1	/* GPIO6_MKIN3 */
+						0x0f8 0x1	/* GPIO7_MKOUT3 */
+						0x0fc 0x1	/* GPIO8_MKIN4 */
+						0x100 0x1	/* GPIO9_MKOUT4 */
+						0x10c 0x1	/* GPIO12_MKIN6 */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0xa000 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				nfc_pmx_func: pinmux_nfc_pins at 0 {
+					pinctrl-single,pins = <
+						0x120 0x0	/* GPIO17 */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0x0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+				wlan_pmx_func: pinmux_wlan_pins at 0 {
+					pinctrl-single,pins = <
+						0x114 0x0	/* GPIO14 */
+						0x12c 0x0	/* GPIO20 */
+						0x160 0x0	/* GPIO33 */
+						0x164 0x0	/* GPIO34 */
+						0x168 0x0	/* GPIO35 */
+						0x16c 0x0	/* GPIO36 */
+					>;
+					pinctrl-single,slew-rate = <0x1000 0x1800>;
+					pinctrl-single,bias-pullup = <0 0xc000 0 0xc000>;
+					pinctrl-single,bias-pulldown = <0 0xa000 0 0xa000>;
+					pinctrl-single,input-schmitt = <0 0x30>;
+					pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index 825aaca..20a3418 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -93,28 +93,37 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xd4019000 0x1000>;
-				gpio-controller;
-				#gpio-cells = <2>;
+				marvell,gpio-ed-mask = <1>;
+				marvell,nr-gpios = <128>;
 				interrupts = <49>;
 				interrupt-names = "gpio_mux";
 				interrupt-controller;
 				#interrupt-cells = <1>;
+				status = "disabled";
 				ranges;
 
 				gcb0: gpio at d4019000 {
 					reg = <0xd4019000 0x4>;
+					gpio-controller;
+					#gpio-cells = <2>;
 				};
 
 				gcb1: gpio at d4019004 {
 					reg = <0xd4019004 0x4>;
+					gpio-controller;
+					#gpio-cells = <2>;
 				};
 
 				gcb2: gpio at d4019008 {
 					reg = <0xd4019008 0x4>;
+					gpio-controller;
+					#gpio-cells = <2>;
 				};
 
 				gcb3: gpio at d4019100 {
 					reg = <0xd4019100 0x4>;
+					gpio-controller;
+					#gpio-cells = <2>;
 				};
 			};
 
@@ -144,6 +153,22 @@
 				interrupt-names = "rtc 1Hz", "rtc alarm";
 				status = "disabled";
 			};
+
+			pmx: pinmux at d401e000 {
+				compatible = "pinconf-single";
+				reg = <0xd401e000 0x330>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				#gpio-range-cells = <3>;
+				ranges;
+
+				pinctrl-single,register-width = <32>;
+				pinctrl-single,function-mask = <7>;
+
+				range: gpio-range {
+					#pinctrl-single,gpio-range-cells = <3>;
+				};
+			};
 		};
 	};
 };
-- 
1.7.10.4
