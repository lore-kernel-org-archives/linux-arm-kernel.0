From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:15 +0100
Subject: [PATCH 10/18] ARM: ux500: Add support for ab8500 regulators into the
 Device Tree
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we supply the information required to setup regulators
successfully on Snowball and other db8500 variants which use
the ab8500 regulators.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi  |   68 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/snowball.dts |    2 ++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 1188925..e69c3fa 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -202,6 +202,74 @@
 				reg = <5>; /* mailbox 5 is i2c */
 				interrupts = <0 40 0x4>;
 				stericsson,irq-base = <520>;
+
+				ab8500-regulators {
+					compatible = "stericsson,ab8500-regulator";
+
+					// supplies to the display/camera
+					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
+						regulator-name = "V-DISPLAY";
+						regulator-min-microvolt = <2500000>;
+						regulator-max-microvolt = <2900000>;
+						regulator-boot-on;
+						/* BUG: If turned off MMC will be affected. */
+						regulator-always-on;
+					};
+
+					// supplies to the on-board eMMC
+					ab8500_ldo_aux2_reg: ab8500_ldo_aux2 {
+						regulator-name = "V-eMMC1";
+						regulator-min-microvolt = <1100000>;
+						regulator-max-microvolt = <3300000>;
+					};
+
+					// supply for VAUX3; SDcard slots
+					ab8500_ldo_aux3_reg: ab8500_ldo_aux3 {
+						regulator-name = "V-MMC-SD";
+						regulator-min-microvolt = <1100000>;
+						regulator-max-microvolt = <3300000>;
+					};
+
+					// supply for v-intcore12; VINTCORE12 LDO
+					ab8500_ldo_initcore_reg: ab8500_ldo_initcore {
+						regulator-name = "V-INTCORE";
+					};
+
+					// supply for tvout; gpadc; TVOUT LDO
+					ab8500_ldo_tvout_reg: ab8500_ldo_tvout {
+						regulator-name = "V-TVOUT";
+					};
+
+					// supply for ab8500-usb; USB LDO
+					ab8500_ldo_usb_reg: ab8500_ldo_usb {
+						regulator-name = "dummy";
+					};
+
+					// supply for ab8500-vaudio; VAUDIO LDO
+					ab8500_ldo_audio_reg: ab8500_ldo_audio {
+						regulator-name = "V-AUD";
+					};
+
+					// supply for v-anamic1 VAMic1-LDO
+					ab8500_ldo_anamic1_reg: ab8500_ldo_anamic1 {
+						regulator-name = "V-AMIC1";
+					};
+
+					// supply for v-amic2; VAMIC2 LDO; reuse constants for AMIC1
+					ab8500_ldo_amamic2_reg: ab8500_ldo_amamic2 {
+						regulator-name = "V-AMIC2";
+					};
+
+					// supply for v-dmic; VDMIC LDO
+					ab8500_ldo_dmic_reg: ab8500_ldo_dmic {
+						regulator-name = "V-DMIC";
+					};
+
+					// supply for U8500 CSI/DSI; VANA LDO
+					ab8500_ldo_ana_reg: ab8500_ldo_ana {
+						regulator-name = "V-CSI/DSI";
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 579c304..6b00350 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -94,6 +94,7 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <50000000>;
 			bus-width = <8>;
+			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			mmc-cap-mmc-highspeed;
 
 			cd-gpios  = <&gpio6 26 0x4>; // 218
@@ -107,6 +108,7 @@
 			arm,primecell-periphid = <0x10480180>;
 		        max-frequency = <50000000>;
 			bus-width = <8>;
+			vmmc-supply = <&ab8500_ldo_aux2_reg>;
 			mmc-cap-mmc-highspeed;
 
 			status = "okay";
-- 
1.7.9.5
