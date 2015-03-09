From: stefan@agner.ch (Stefan Agner)
Date: Mon,  9 Mar 2015 17:38:52 +0100
Subject: [PATCH v2 6/6] ARM: dts: vf-colibri: enable NAND flash controller
In-Reply-To: <1425919132-13827-1-git-send-email-stefan@agner.ch>
References: <1425919132-13827-1-git-send-email-stefan@agner.ch>
Message-ID: <1425919132-13827-7-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable NAND access by adding pinmux and NAND flash controller  node
to device tree. The NAND chips currently used on the Colibri VF61
requires 8-bit ECC per 512 byte page, hence specify 32-bit ECC
strength per 2k page size.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 5c2b732..76139d7 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -46,6 +46,19 @@
 	pinctrl-0 = <&pinctrl_i2c0>;
 };
 
+&nfc {
+	assigned-clocks = <&clks VF610_CLK_NFC>;
+	assigned-clock-rates = <33000000>;
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	nand-ecc-strength = <32>;
+	nand-ecc-step-size = <2048>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nfc_1>;
+	status = "okay";
+};
+
 &pwm0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm0>;
@@ -141,6 +154,25 @@
 			>;
 		};
 
+		pinctrl_nfc_1: nfcgrp_1 {
+			fsl,pins = <
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
 				VF610_PAD_PTB0__FTM0_CH0		0x1182
-- 
2.3.1
