From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 21 Dec 2012 17:45:12 +0800
Subject: [PATCH v6 2/8] ARM: dts: support pinctrl single in pxa910
In-Reply-To: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1356083118-18857-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl-single support with device tree in pxa910 dkb platform.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/pxa910-dkb.dts |  204 +++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/pxa910.dtsi    |   68 +++++++++++++
 2 files changed, 271 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/pxa910-dkb.dts
index 595492a..76e9c8d 100644
--- a/arch/arm/boot/dts/pxa910-dkb.dts
+++ b/arch/arm/boot/dts/pxa910-dkb.dts
@@ -24,10 +24,212 @@
 
 	soc {
 		apb at d4000000 {
-			uart1: uart at d4017000 {
+			pmx: pinmux at d401e000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&board_pins>;
+
+				board_pins: pinmux_board_pins {
+					/* pins not owned by device driver */
+					/* w1 */
+					pinctrl-single,pins = <
+						0x0cc 0x2	/* CLK_REQ_W1 */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				uart1_pins: pinmux_uart1_pins {
+					pinctrl-single,pins = <
+						0x198 0x6	/* GPIO47_UART1_RXD */
+						0x19c 0x6	/* GPIO48_UART1_TXD */
+					>;
+					/* power source, mask */
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					/* bias, mask, disable, pull down, pull up */
+					pinctrl-single,bias = <0xc000 0xe000 0 0xa000 0xc000>;
+					/* input schmitt, mask, disable */
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				uart2_pins: pinmux_uart2_pins {
+					pinctrl-single,pins = <
+						0x150 0x4	/* GPIO29_UART2_CTS */
+						0x154 0x4	/* GPIO30_UART2_RTS */
+						0x158 0x4	/* GPIO31_UART2_TXD */
+						0x15c 0x4	/* GPIO32_UART2_RXD */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				uart3_pins: pinmux_uart3_pins {
+					pinctrl-single,pins = <
+						0x188 0x7	/* GPIO43_UART3_RXD */
+						0x18c 0x7	/* GPIO44_UART3_TXD */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				twsi1_pins: pinmux_twsi1_pins {
+					pinctrl-single,pins = <
+						0x1b0 0x2	/* GPIO53_TWSI_SCL */
+						0x1b4 0x2	/* GPIO54_TWSI_SDA */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				nand_pins: pinmux_nand_pins {
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
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				mmc1_ldata_pins: pinmux_mmc1_ldata_pins {
+					pinctrl-single,pins = <
+						0x0a0 0x0	/* MMC1_DATA0 */
+						0x09c 0x0	/* MMC1_DATA1 */
+						0x098 0x0	/* MMC1_DATA2 */
+						0x094 0x0	/* MMC1_DATA3 */
+					>;
+					pinctrl-single,power-source = <0x1800 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				mmc1_hdata_pins: pinmux_mmc1_hdata_pins {
+					pinctrl-single,pins = <
+						0x090 0x0	/* MMC1_DATA4 */
+						0x08c 0x0	/* MMC1_DATA5 */
+						0x088 0x0	/* MMC1_DATA6 */
+						0x084 0x0	/* MMC1_DATA7 */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				mmc1_clk_pins: pinmux_mmc1_clk_pins {
+					pinctrl-single,pins = <
+						0x0a4 0x0	/* MMC1_CMD */
+						0x0a8 0x0	/* MMC1_CLK */
+					>;
+					pinctrl-single,power-source = <0x1800 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				mmc1_cd_pins: pinmux_mmc1_cd_pins {
+					pinctrl-single,pins = <
+						0x0ac 0x0	/* MMC1_CD */
+						0x0b0 0x0	/* MMC1_WP */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				mmc2_pins: pinmux_mmc2_pins {
+					pinctrl-single,pins = <
+						0x180 0x1	/* MMC2_CMD */
+						0x184 0x1	/* MMC2_CLK */
+						0x17c 0x1	/* MMC2_DATA0 */
+						0x178 0x1	/* MMC2_DATA1 */
+						0x174 0x1	/* MMC2_DATA2 */
+						0x170 0x1	/* MMC2_DATA3 */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				ssp1_pins: pinmux_ssp1_pins {
+					pinctrl-single,pins = <
+						0x130 0x1	/* GPIO21_SSP1_SCLK */
+						0x134 0x1	/* GPIO22_SSP1_FRM */
+						0x138 0x1	/* GPIO23_SSP1_TXD */
+						0x13c 0x1	/* GPIO24_SSP1_RXD */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				keypad_pins: pinmux_keypad_pins {
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
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				nfc_pins: pinmux_nfc_pins {
+					pinctrl-single,pins = <
+						0x120 0x0	/* GPIO17 */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				wlan_pins: pinmux_wlan_pins {
+					pinctrl-single,pins = <
+						0x114 0x0	/* GPIO14 */
+						0x12c 0x0	/* GPIO20 */
+						0x160 0x0	/* GPIO33 */
+						0x164 0x0	/* GPIO34 */
+						0x168 0x0	/* GPIO35 */
+						0x16c 0x0	/* GPIO36 */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+			};
+			uart1: uart at d4017000 {	/* FFUART */
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart1_pins>;
+				status = "okay";
+			};
+			uart2: uart at d4018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart2_pins>;
+				status = "okay";
+			};
+			uart3: uart at d4036000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart3_pins>;
 				status = "okay";
 			};
 			twsi1: i2c at d4011000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&twsi1_pins>;
 				status = "okay";
 
 				pmic: 88pm860x at 34 {
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index 825aaca..c2f8b21 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -54,6 +54,74 @@
 			reg = <0xd4000000 0x00200000>;
 			ranges;
 
+			pmx: pinmux at d401e000 {
+				compatible = "pinconf-single";
+				reg = <0xd401e000 0x0330>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				pinctrl-single,register-width = <32>;
+				pinctrl-single,function-mask = <7>;
+
+				range0: range at d401e0dc {
+					/* GPIO0 ~ GPIO54 */
+					reg = <0xd401e0dc 0xdc>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <0 0>;
+				};
+				range1: range at d401e2f0 {
+					/* GPIO55 ~ GPIO59 */
+					reg = <0xd401e2f0 0x14>;
+					pinctrl-single,gpio = <55 1>;
+				};
+				range2: range at d401e304 {
+					/* GPIO60 ~ GPIO66 */
+					reg = <0xd401e304 0x1c>;
+					pinctrl-single,gpio = <60 0>;
+				};
+				range3: range at d401e1b8 {
+					/* GPIO67 ~ GPIO109 */
+					reg = <0xd401e1b8 0xac>;
+					pinctrl-single,gpio = <67 0>;
+				};
+				range4: range at d401e298 {
+					/* GPIO110 ~ GPIO116 */
+					reg = <0xd401e298 0x1c>;
+					pinctrl-single,gpio = <110 0>;
+				};
+				range5: range at d401e0b4 {
+					/* GPIO117 ~ GPIO120 */
+					reg = <0xd401e0b4 0x10>;
+					pinctrl-single,gpio = <117 1>;
+				};
+				range6: range at d401e32c {
+					/* GPIO121 */
+					reg = <0xd401e32c 0x04>;
+					pinctrl-single,gpio = <121 0>;
+				};
+				range7: range at d401e0c8 {
+					/* GPIO122 ~ GPIO123 */
+					reg = <0xd401e0c8 0x08>;
+					pinctrl-single,gpio = <122 1>;
+				};
+				range8: range at d401e0d0 {
+					/* GPIO124 */
+					reg = <0xd401e0d0 0x04>;
+					pinctrl-single,gpio = <124 0>;
+				};
+				range9: range at d401e0d4 {
+					/* GPIO125 */
+					reg = <0xd401e0d4 0x04>;
+					pinctrl-single,gpio = <125 1>;
+				};
+				range10: range at d401e06c {
+					/* GPIO126 ~ GPIO127 */
+					reg = <0xd401e06c 0x08>;
+					pinctrl-single,gpio = <126 0>;
+				};
+			};
+
 			timer0: timer at d4014000 {
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4014000 0x100>;
-- 
1.7.10.4
