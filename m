From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  4 May 2012 19:23:23 +0100
Subject: [PATCH 13/15] ARM: ux500: Add support for ab8500 regulators into the
 Device Tree
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1336155805-18554-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we supply the information required to setup regulators
successfully on Snowball and other db8500 variants which use
the ab8500 regulators. This information includes values used
for regulator related register initialisation and platform
specific regulator setup information.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi  |   98 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/snowball.dts |    2 +
 2 files changed, 100 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 1188925..2609f53 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -202,6 +202,104 @@
 				reg = <5>; /* mailbox 5 is i2c */
 				interrupts = <0 40 0x4>;
 				stericsson,irq-base = <520>;
+
+				ab8500-regulators {
+					compatible = "stericsson,ab8500-regulator";
+					stericsson,regurequestctrl2 = <0x00>;
+					stericsson,regurequestctrl3 = <0x00>;
+					stericsson,regurequestctrl4 = <0x00>;
+					stericsson,regusysclkreq1hpvalid1 = <0x00>;
+					stericsson,regusysclkreq1hpvalid2 = <0x40>;
+					stericsson,reguhwhpreq1valid1 = <0x00>;
+					stericsson,reguhwhpreq1valid2 = <0x00>;
+					stericsson,reguhwhpreq2valid1 = <0x00>;
+					stericsson,reguhwhpreq2valid2 = <0x04>;
+					stericsson,reguswhpreqvalid1 = <0x00>;
+					stericsson,reguswhpreqvalid2 = <0x00>;
+					stericsson,regusysclkreqvalid1 = <0x2a>;
+					stericsson,regusysclkreqvalid2 = <0x20>;
+					stericsson,regumisc1 = <0x10>;
+					stericsson,vaudiosupply = <0x00>;
+					stericsson,reguctrl1vamic = <0x00>;
+					stericsson,vpllvanaregu = <0x02>;
+					stericsson,vrefddr = <0x00>;
+					stericsson,extsupplyregu = <0x2a>;
+					stericsson,vaux12regu = <0x01>;
+					stericsson,vrf1vaux3regu = <0x00>;
+					stericsson,vsmps1sel1 = <0x24>;
+					stericsson,vaux1sel = <0x08>;
+					stericsson,vaux2sel = <0x0d>;
+					stericsson,vrf1vaux3sel = <0x07>;
+					stericsson,reguctrl2spare = <0x00>;
+					stericsson,reguctrldisch = <0x00>;
+					stericsson,reguctrldisch2 = <0x00>;
+
+					/* It's imperative that these remain in order. */
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
