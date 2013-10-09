From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 Oct 2013 14:52:11 +0800
Subject: [PATCH] pinctrl: imx: update fsl,pins description in bindings doc
Message-ID: <1381301531-19212-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While commit e164153 (pinctrl: imx: move hard-coding data into device
tree) moves to use DTC macro for imx pinctrl device tree setting, it
changes the semantics of fsl,pins without updating the bindings doc
properly.  Let's update the fsl,pins description to stop confusing
people.

While at it, the example in the document is updated, and the stale TODO
gets removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/pinctrl/fsl,imx-pinctrl.txt           |   37 ++++++++++----------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
index 3a7caf7..9fde25f 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
@@ -22,11 +22,12 @@ Required properties for iomux controller:
   Please refer to each fsl,<soc>-pinctrl.txt binding doc for supported SoCs.
 
 Required properties for pin configuration node:
-- fsl,pins: two integers array, represents a group of pins mux and config
-  setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is a
-  pin working on a specific function, which consists of a tuple of
-  <mux_reg conf_reg input_reg mux_val input_val>.  CONFIG is the pad setting
-  value like pull-up on this pin.
+- fsl,pins: each entry consists of 6 integers and represents the mux and config
+  setting for one pin. The first 5 integers <mux_reg conf_reg input_reg mux_val
+  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
+  imx*-pinfunc.h under device tree source folder. The last integer CONFIG is
+  the pad setting value like pull-up on this pin. And that's why fsl,pins entry
+  looks like <PIN_FUNC_ID CONFIG> in the example below.
 
 Bits used for CONFIG:
 NO_PAD_CTL(1 << 31): indicate this pin does not need config.
@@ -72,17 +73,18 @@ iomuxc@020e0000 {
 	/* shared pinctrl settings */
 	usdhc4 {
 		pinctrl_usdhc4_1: usdhc4grp-1 {
-			fsl,pins = <1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
-				    1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
-				    1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
-				    1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
-				    1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
-				    1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
-				    1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
-				    1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
-				    1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
-				    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
-		};
+			fsl,pins = <
+				MX6QDL_PAD_SD4_CMD__SD4_CMD    0x17059
+				MX6QDL_PAD_SD4_CLK__SD4_CLK    0x10059
+				MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17059
+				MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17059
+				MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17059
+				MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17059
+				MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x17059
+				MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17059
+				MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17059
+				MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17059
+			>;
 	};
 	....
 };
@@ -90,6 +92,3 @@ Refer to the IOMUXC controller chapter in imx6q datasheet,
 0x17059 means enable hysteresis, 47KOhm Pull Up, 50Mhz speed,
 80Ohm driver strength and Fast Slew Rate.
 User should refer to each SoC spec to set the correct value.
-
-TODO: when dtc macro support is available, we can change above raw data
-to dt macro which can get better readability in dts file.
-- 
1.7.9.5
