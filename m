From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 25 Oct 2013 10:16:59 +0800
Subject: [PATCH RFC 1/2] ARM: imx6qdl: provide pinctrl configurations for
 DAT3 pull-down
In-Reply-To: <20131021004610.GB17165@S2101-09.ap.freescale.net>
References: <20131005112147.GX12758@n2100.arm.linux.org.uk>
 <E1VSPw9-0004Ug-BF@rmk-PC.arm.linux.org.uk>
 <20131007055340.GB3739@S2101-09.ap.freescale.net>
 <20131007180357.GS12758@n2100.arm.linux.org.uk>
 <20131008015426.GA7480@S2101-09.ap.freescale.net>
 <52537378.1020904@wwwdotorg.org>
 <20131008034048.GB7480@S2101-09.ap.freescale.net>
 <20131008090015.GC25034@n2100.arm.linux.org.uk>
 <20131019150556.GI25034@n2100.arm.linux.org.uk>
 <20131021004610.GB17165@S2101-09.ap.freescale.net>
Message-ID: <20131025021655.GJ14529@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 08:46:12AM +0800, Shawn Guo wrote:
> On Sat, Oct 19, 2013 at 04:05:56PM +0100, Russell King - ARM Linux wrote:
> > I can't find what the result of this discussion was, but from what I
> > remember, we decided that we weren't going to do this override thing,
> > and instead we were going to separate out the configuration of DAT3.
> > 
> > Who's going to do that?
> 
> I'm going to do that.  Thanks for reminding :)

Okay, here is what I got so far.  However, looking at the changes on
imx6qdl.dtsi, I start being concerned by the point that Matt raises
recently - the device tree blob for particular board is bloated with a
lot of pinctrl setting nodes that the board does not use.  The situation
will become even worse when we have more pinctrl nodes to be added just
for cases like this usdhc DAT3 thing.  Thus, I'm considering to adopt
Matt's proposal to avoid this problem.  Will post a RFC patch to
demonstrate the solution soon.

Shawn

--------8<----------------------

 arch/arm/boot/dts/imx6q-arm2.dts           |    3 +-
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |    2 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts      |    2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi   |    6 +--
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi     |    4 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi   |    4 +-
 arch/arm/boot/dts/imx6qdl.dtsi             |   74 +++++++++++++++++++++++++---
 7 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index edf1bd9..b804cf7 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -85,6 +85,7 @@
 	vmmc-supply = <&reg_3p3v>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3_1
+		     &pinctrl_usdhc3_dat3
 		     &pinctrl_usdhc3_arm2>;
 	status = "okay";
 };
@@ -93,7 +94,7 @@
 	non-removable;
 	vmmc-supply = <&reg_3p3v>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc4_1>;
+	pinctrl-0 = <&pinctrl_usdhc4_1 &pinctrl_usdhc4_dat3>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index 1a3b50d..01df035 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -164,7 +164,7 @@
 
 &usdhc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2_2>;
+	pinctrl-0 = <&pinctrl_usdhc2_2 &pinctrl_usdhc2_dat3>;
 	cd-gpios = <&gpio1 4 0>;
 	wp-gpios = <&gpio1 2 0>;
 	status = "disabled";
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index f004913..b1bffa8 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -192,7 +192,7 @@
 
 &usdhc4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc4_2>;
+	pinctrl-0 = <&pinctrl_usdhc4_2 &pinctrl_usdhc4_dat3>;
 	cd-gpios = <&gpio2 6 0>;
 	wp-gpios = <&gpio2 7 0>;
 	vmmc-supply = <&reg_3p3v>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index ff6f1e8..5421c8e 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -76,9 +76,9 @@
 
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3_1>;
-	pinctrl-1 = <&pinctrl_usdhc3_1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_1_200mhz>;
+	pinctrl-0 = <&pinctrl_usdhc3_1 &pinctrl_usdhc3_dat3>;
+	pinctrl-1 = <&pinctrl_usdhc3_1_100mhz &pinctrl_usdhc3_dat3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_1_200mhz &pinctrl_usdhc3_dat3_200mhz>;
 	cd-gpios = <&gpio6 15 0>;
 	wp-gpios = <&gpio1 13 0>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index e75e11b..c4b7fda 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -244,7 +244,7 @@
 
 &usdhc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2_1>;
+	pinctrl-0 = <&pinctrl_usdhc2_1 &pinctrl_usdhc2_dat3>;
 	bus-width = <8>;
 	cd-gpios = <&gpio2 2 0>;
 	wp-gpios = <&gpio2 3 0>;
@@ -253,7 +253,7 @@
 
 &usdhc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3_1>;
+	pinctrl-0 = <&pinctrl_usdhc3_1 &pinctrl_usdhc3_dat3>;
 	bus-width = <8>;
 	cd-gpios = <&gpio2 0 0>;
 	wp-gpios = <&gpio2 1 0>;
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 35f5479..b1b84ec 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -140,14 +140,14 @@
 
 &usdhc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1_2>;
+	pinctrl-0 = <&pinctrl_usdhc1_2 &pinctrl_usdhc1_dat3>;
 	cd-gpios = <&gpio1 2 0>;
 	status = "okay";
 };
 
 &usdhc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2_2>;
+	pinctrl-0 = <&pinctrl_usdhc2_2 &pinctrl_usdhc2_dat3>;
 	non-removable;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 59154dc..b918d5f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1157,7 +1157,6 @@
 							MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
 							MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
 							MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
-							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
 							MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17059
 							MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17059
 							MX6QDL_PAD_NANDF_D2__SD1_DATA6 0x17059
@@ -1172,9 +1171,20 @@
 							MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
 							MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
 							MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
+						>;
+					};
+
+					pinctrl_usdhc1_dat3: usdhc1dat3 {
+						fsl,pins = <
 							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
 						>;
 					};
+
+					pinctrl_usdhc1_dat3cd: usdhc1dat3cd {
+						fsl,pins = <
+							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x13059
+						>;
+					};
 				};
 
 				usdhc2 {
@@ -1185,7 +1195,6 @@
 							MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
 							MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
 							MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
-							MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
 							MX6QDL_PAD_NANDF_D4__SD2_DATA4 0x17059
 							MX6QDL_PAD_NANDF_D5__SD2_DATA5 0x17059
 							MX6QDL_PAD_NANDF_D6__SD2_DATA6 0x17059
@@ -1200,9 +1209,20 @@
 							MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
 							MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
 							MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
+						>;
+					};
+
+					pinctrl_usdhc2_dat3: usdhc2dat3 {
+						fsl,pins = <
 							MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
 						>;
 					};
+
+					pinctrl_usdhc2_dat3cd: usdhc2dat3cd {
+						fsl,pins = <
+							MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
+						>;
+					};
 				};
 
 				usdhc3 {
@@ -1213,7 +1233,6 @@
 							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
 							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
 							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
-							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
 							MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059
 							MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059
 							MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059
@@ -1228,7 +1247,6 @@
 							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170b9
 							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170b9
 							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170b9
-							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170b9
 							MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x170b9
 							MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x170b9
 							MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x170b9
@@ -1243,7 +1261,6 @@
 							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170f9
 							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170f9
 							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170f9
-							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170f9
 							MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x170f9
 							MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x170f9
 							MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x170f9
@@ -1258,9 +1275,44 @@
 							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
 							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
 							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
+						>;
+					};
+
+					pinctrl_usdhc3_dat3: usdhc3dat3 {
+						fsl,pins = <
 							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
 						>;
 					};
+
+					pinctrl_usdhc3_dat3_100mhz: usdhc3dat3-100mhz {
+						fsl,pins = <
+							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170b9
+						>;
+					};
+
+					pinctrl_usdhc3_dat3_200mhz: usdhc3dat3-200mhz {
+						fsl,pins = <
+							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170f9
+						>;
+					};
+
+					pinctrl_usdhc3_dat3cd: usdhc3dat3cd {
+						fsl,pins = <
+							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x13059
+						>;
+					};
+
+					pinctrl_usdhc3_dat3cd_100mhz: usdhc3dat3cd-100mhz {
+						fsl,pins = <
+							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x130b9
+						>;
+					};
+
+					pinctrl_usdhc3_dat3cd_200mhz: usdhc3dat3cd-200mhz {
+						fsl,pins = <
+							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x130f9
+						>;
+					};
 				};
 
 				usdhc4 {
@@ -1271,7 +1323,6 @@
 							MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17059
 							MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17059
 							MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17059
-							MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17059
 							MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x17059
 							MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17059
 							MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17059
@@ -1286,9 +1337,20 @@
 							MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17059
 							MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17059
 							MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17059
+						>;
+					};
+
+					pinctrl_usdhc4_dat3: usdhc4dat3 {
+						fsl,pins = <
 							MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17059
 						>;
 					};
+
+					pinctrl_usdhc4_dat3cd: usdhc4dat3cd {
+						fsl,pins = <
+							MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x13059
+						>;
+					};
 				};
 
 				weim {
-- 
1.7.9.5
