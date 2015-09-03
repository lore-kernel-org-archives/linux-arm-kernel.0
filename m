From: stefan@agner.ch (Stefan Agner)
Date: Wed,  2 Sep 2015 18:06:36 -0700
Subject: [PATCH v12 4/5] ARM: dts: vf610twr: add NAND flash controller
 peripherial
In-Reply-To: <1441242397-870-1-git-send-email-stefan@agner.ch>
References: <1441242397-870-1-git-send-email-stefan@agner.ch>
Message-ID: <1441242397-870-5-git-send-email-stefan@agner.ch>
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
 arch/arm/boot/dts/vf610-twr.dts | 47 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vfxxx.dtsi    | 10 +++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 375ab23..64d1696 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -237,6 +237,33 @@
 			>;
 		};
 
+		pinctrl_nfc: nfcgrp {
+			fsl,pins = <
+			VF610_PAD_PTD31__NF_IO15	0x28df
+			VF610_PAD_PTD30__NF_IO14	0x28df
+			VF610_PAD_PTD29__NF_IO13	0x28df
+			VF610_PAD_PTD28__NF_IO12	0x28df
+			VF610_PAD_PTD27__NF_IO11	0x28df
+			VF610_PAD_PTD26__NF_IO10	0x28df
+			VF610_PAD_PTD25__NF_IO9		0x28df
+			VF610_PAD_PTD24__NF_IO8		0x28df
+			VF610_PAD_PTD23__NF_IO7		0x28df
+			VF610_PAD_PTD22__NF_IO6		0x28df
+			VF610_PAD_PTD21__NF_IO5		0x28df
+			VF610_PAD_PTD20__NF_IO4		0x28df
+			VF610_PAD_PTD19__NF_IO3		0x28df
+			VF610_PAD_PTD18__NF_IO2		0x28df
+			VF610_PAD_PTD17__NF_IO1		0x28df
+			VF610_PAD_PTD16__NF_IO0		0x28df
+			VF610_PAD_PTB24__NF_WE_B	0x28c2
+			VF610_PAD_PTB25__NF_CE0_B	0x28c2
+			VF610_PAD_PTB27__NF_RE_B	0x28c2
+			VF610_PAD_PTC26__NF_RB_B	0x283d
+			VF610_PAD_PTC27__NF_ALE		0x28c2
+			VF610_PAD_PTC28__NF_CLE		0x28c2
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
index 4aa3351..17066a2 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -520,6 +520,16 @@
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
 		};
 	};
 };
-- 
2.5.1
