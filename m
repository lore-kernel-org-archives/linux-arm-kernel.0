From: stefan@agner.ch (Stefan Agner)
Date: Wed,  2 Sep 2015 18:06:37 -0700
Subject: [PATCH v12 5/5] ARM: dts: vf-colibri: enable NAND flash controller
In-Reply-To: <1441242397-870-1-git-send-email-stefan@agner.ch>
References: <1441242397-870-1-git-send-email-stefan@agner.ch>
Message-ID: <1441242397-870-6-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable NAND access by adding pinmux and NAND flash controller node
to device tree. The NAND chips currently used on the Colibri VF61
requires 8-bit ECC per 512 byte page, hence specify 32-bit ECC
strength per 2k page size.

Reviewed-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 68ca125..e5949b9 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -52,6 +52,26 @@
 	pinctrl-0 = <&pinctrl_i2c0>;
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
+		nand-bus-width = <8>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <32>;
+		nand-ecc-step-size = <2048>;
+		nand-on-flash-bbt;
+	};
+};
+
 &pwm0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm0>;
@@ -156,6 +176,25 @@
 			>;
 		};
 
+		pinctrl_nfc: nfcgrp {
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
2.5.1
