From: tharvey@gateworks.com (Tim Harvey)
Date: Thu,  4 Jun 2015 12:32:26 -0700
Subject: [PATCH] ARM: dts: ventana: add UHS-I support for Ventana boards
Message-ID: <1433446346-7382-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UHS-I support is available on Ventana boards with micro-SD sockets depending
on the board revision. To support this pinctl states for 100Mhz and 200MHz
must be added as well as pinmux of the VSELECT signal. In order to support
UHS-I the I/O rail of the 4-bit data bus must be switchable between 1.8V
and 3.3V.

By adding the no-1-8-v property, which disables UHS-I support, we allow the
bootloader to be in charge of selecting which boards have this capability
by removing that property if the board model/revision implement the support.

Additionally we will remove NANDF_CS1 here from the nand pinmux group as the
second chip-select is not used on any ventana boards and this is the pad
that is used for SD3_VELECT.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi |  1 -
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 35 ++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 35 ++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 34 ++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi |  1 -
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi |  1 -
 6 files changed, 96 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 35b391a..e5b601c 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -254,7 +254,6 @@
 				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
 				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
 				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
-				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
 				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
 				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
 				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 5db12c0..24c672b4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -316,10 +316,13 @@
 };
 
 &usdhc3 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&reg_3p3v>;
+	no-1-8-v; /* firmware will remove if board revision supports */
 	status = "okay";
 };
 
@@ -386,7 +389,6 @@
 				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
 				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
 				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
-				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
 				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
 				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
 				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
@@ -475,7 +477,34 @@
 				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
 				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
 				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
-				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00	0x1b0b0 /* CD */
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x17059 /* CD */
+				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
+			>;
+		};
+
+		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
+				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x170b9
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170b9
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170b9
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170b9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170b9
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x170b9 /* CD */
+				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
+			>;
+		};
+
+		pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
+				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170f9
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170f9
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170f9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170f9
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x170f9 /* CD */
+				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index b3b7e0a..f49a7c8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -322,10 +322,13 @@
 };
 
 &usdhc3 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&reg_3p3v>;
+	no-1-8-v; /* firmware will remove if board revision supports */
 	status = "okay";
 };
 
@@ -392,7 +395,6 @@
 				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
 				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
 				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
-				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
 				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
 				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
 				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
@@ -483,7 +485,34 @@
 				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
 				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
 				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
-				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0 /* CD */
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x17059 /* CD */
+				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
+			>;
+		};
+
+		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
+				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170b9
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170b9
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170b9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170b9
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x170b9 /* CD */
+				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
+			>;
+		};
+
+		pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
+				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170f9
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170f9
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170f9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170f9
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x170f9 /* CD */
+				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index f72eb31..58f8ae0 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -415,10 +415,13 @@
 };
 
 &usdhc3 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&reg_3p3v>;
+	no-1-8-v; /* firmware will remove if board revision supports */
 	status = "okay";
 };
 
@@ -489,7 +492,6 @@
 				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
 				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
 				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
-				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
 				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
 				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
 				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
@@ -579,6 +581,34 @@
 				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
 				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
 				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x17059 /* CD */
+				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
+			>;
+		};
+
+		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
+				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170b9
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170b9
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170b9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170b9
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x170b9 /* CD */
+				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
+			>;
+		};
+
+		pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
+				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170f9
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170f9
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170f9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170f9
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x170f9 /* CD */
+				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 9c21b12..8e06496 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -256,7 +256,6 @@
 				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
 				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
 				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
-				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
 				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
 				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
 				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index 9be089d..2344f83 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -208,7 +208,6 @@
 				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
 				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
 				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
-				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
 				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
 				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
 				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
-- 
1.9.1
