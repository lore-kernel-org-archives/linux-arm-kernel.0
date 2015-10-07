From: stefan@agner.ch (Stefan Agner)
Date: Wed,  7 Oct 2015 16:58:35 -0700
Subject: [PATCH v13 1/2] ARM: dts: vf610twr: add NAND flash controller
 peripherial
Message-ID: <1444262316-30588-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the NAND flash controller (NFC) peripherial. The driver
supports the SLC NAND chips found on Freescale's Vybrid Tower System
Module. The Micron NAND chip on the module needs 4-bit ECC per 512
byte page. Use 24-bit ECC per 2k page, which is supported by the
driver.

Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
Reviewed-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Shawn,

This are the rebased dt changes of the Vybrid MTD NAND driver
patchset. The driver part has recently been merged:
https://lkml.org/lkml/2015/9/2/678

The driver is lined up fo 4.4, I hope those changes make it into
4.4 as well.

Changes since v12:
- Rebased (and fixed merge conflict)
- Fix indent

 arch/arm/boot/dts/vf610-twr.dts | 47 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vfxxx.dtsi    | 11 ++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 375ab23..5438ee4 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -237,6 +237,33 @@
 			>;
 		};
 
+		pinctrl_nfc: nfcgrp {
+			fsl,pins = <
+				VF610_PAD_PTD31__NF_IO15	0x28df
+				VF610_PAD_PTD30__NF_IO14	0x28df
+				VF610_PAD_PTD29__NF_IO13	0x28df
+				VF610_PAD_PTD28__NF_IO12	0x28df
+				VF610_PAD_PTD27__NF_IO11	0x28df
+				VF610_PAD_PTD26__NF_IO10	0x28df
+				VF610_PAD_PTD25__NF_IO9		0x28df
+				VF610_PAD_PTD24__NF_IO8		0x28df
+				VF610_PAD_PTD23__NF_IO7		0x28df
+				VF610_PAD_PTD22__NF_IO6		0x28df
+				VF610_PAD_PTD21__NF_IO5		0x28df
+				VF610_PAD_PTD20__NF_IO4		0x28df
+				VF610_PAD_PTD19__NF_IO3		0x28df
+				VF610_PAD_PTD18__NF_IO2		0x28df
+				VF610_PAD_PTD17__NF_IO1		0x28df
+				VF610_PAD_PTD16__NF_IO0		0x28df
+				VF610_PAD_PTB24__NF_WE_B	0x28c2
+				VF610_PAD_PTB25__NF_CE0_B	0x28c2
+				VF610_PAD_PTB27__NF_RE_B	0x28c2
+				VF610_PAD_PTC26__NF_RB_B	0x283d
+				VF610_PAD_PTC27__NF_ALE		0x28c2
+				VF610_PAD_PTC28__NF_CLE		0x28c2
+			>;
+		};
+
 		pinctrl_pwm0: pwm0grp {
 			fsl,pins = <
 				VF610_PAD_PTB0__FTM0_CH0		0x1582
@@ -274,6 +301,26 @@
 	};
 };
 
+&nfc {
+	assigned-clocks = <&clks VF610_CLK_NFC>;
+	assigned-clock-rates = <33000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nfc>;
+	status = "okay";
+
+	nand at 0 {
+		compatible = "fsl,vf610-nfc-nandcs";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		nand-bus-width = <16>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <24>;
+		nand-ecc-step-size = <2048>;
+		nand-on-flash-bbt;
+	};
+};
+
 &pwm0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm0>;
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 6865137..6736bae 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -564,6 +564,17 @@
 				status = "disabled";
 			};
 
+			nfc: nand at 400e0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,vf610-nfc";
+				reg = <0x400e0000 0x4000>;
+				interrupts = <83 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks VF610_CLK_NFC>;
+				clock-names = "nfc";
+				status = "disabled";
+			};
+
 			i2c2: i2c at 400e6000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.6.1
