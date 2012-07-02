From: shijie8@gmail.com (Huang Shijie)
Date: Sun,  1 Jul 2012 23:24:35 -0400
Subject: [PATCH v2 2/3] ARM: imx6q: add DT node for gpmi nand
In-Reply-To: <1341199476-7446-1-git-send-email-shijie8@gmail.com>
References: <1341199476-7446-1-git-send-email-shijie8@gmail.com>
Message-ID: <1341199476-7446-3-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT node for gpmi nand.
Add the pinmux support for gpmi nand.

The gpmi nand may conflicts with other modules, such as MMC.
So we do not enable the gpmi nand for mx6q-arm2 board, just add the
node for the board.

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>
Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 arch/arm/boot/dts/imx6q-arm2.dts |    6 ++++++
 arch/arm/boot/dts/imx6q.dtsi     |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index bdab44c..14e72e2 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -22,6 +22,12 @@
 	};
 
 	soc {
+		gpmi-nand at 00112000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_gpmi_nand_1>;
+			status = "disabled"; /* gpmi nand conflicts with SD */
+		};
+
 		aips-bus at 02100000 { /* AIPS2 */
 			ethernet at 02188000 {
 				phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 3197744..16a3884 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -92,6 +92,18 @@
 			reg = <0x00110000 0x2000>;
 		};
 
+		gpmi-nand at 00112000 {
+		       compatible = "fsl,imx6q-gpmi-nand";
+		       #address-cells = <1>;
+		       #size-cells = <1>;
+		       reg = <0x00112000 0x2000>, <0x00114000 0x2000>;
+		       reg-names = "gpmi-nand", "bch";
+		       interrupts = <0 13 0x04>, <0 15 0x04>;
+		       interrupt-names = "gpmi-dma", "bch";
+		       fsl,gpmi-dma-channel = <0>;
+		       status = "disabled";
+		};
+
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
@@ -500,6 +512,30 @@
 					};
 				};
 
+				gpmi-nand {
+					pinctrl_gpmi_nand_1: gpmi-nand-1 {
+						fsl,pins = <1328 0xb0b1		/* MX6Q_PAD_NANDF_CLE__RAWNAND_CLE */
+							    1336 0xb0b1		/* MX6Q_PAD_NANDF_ALE__RAWNAND_ALE */
+							    1344 0xb0b1		/* MX6Q_PAD_NANDF_WP_B__RAWNAND_RESETN */
+							    1352 0xb000		/* MX6Q_PAD_NANDF_RB0__RAWNAND_READY0 */
+							    1360 0xb0b1		/* MX6Q_PAD_NANDF_CS0__RAWNAND_CE0N */
+							    1365 0xb0b1		/* MX6Q_PAD_NANDF_CS1__RAWNAND_CE1N */
+							    1371 0xb0b1		/* MX6Q_PAD_NANDF_CS2__RAWNAND_CE2N */
+							    1378 0xb0b1		/* MX6Q_PAD_NANDF_CS3__RAWNAND_CE3N */
+							    1387 0xb0b1		/* MX6Q_PAD_SD4_CMD__RAWNAND_RDN */
+							    1393 0xb0b1		/* MX6Q_PAD_SD4_CLK__RAWNAND_WRN */
+							    1397 0xb0b1		/* MX6Q_PAD_NANDF_D0__RAWNAND_D0 */
+							    1405 0xb0b1		/* MX6Q_PAD_NANDF_D1__RAWNAND_D1 */
+							    1413 0xb0b1		/* MX6Q_PAD_NANDF_D2__RAWNAND_D2 */
+							    1421 0xb0b1		/* MX6Q_PAD_NANDF_D3__RAWNAND_D3 */
+							    1429 0xb0b1		/* MX6Q_PAD_NANDF_D4__RAWNAND_D4 */
+							    1437 0xb0b1		/* MX6Q_PAD_NANDF_D5__RAWNAND_D5 */
+							    1445 0xb0b1		/* MX6Q_PAD_NANDF_D6__RAWNAND_D6 */
+							    1453 0xb0b1		/* MX6Q_PAD_NANDF_D7__RAWNAND_D7 */
+							    1463 0x00b1>;	/* MX6Q_PAD_SD4_DAT0__RAWNAND_DQS */
+					};
+				};
+
 				i2c1 {
 					pinctrl_i2c1_1: i2c1grp-1 {
 						fsl,pins = <137 0x4001b8b1	/* MX6Q_PAD_EIM_D21__I2C1_SCL */
-- 
1.7.4.4
