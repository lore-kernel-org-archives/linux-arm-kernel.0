From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 31 Oct 2018 14:43:13 +0000
Subject: [PATCH V3 05/10] dt-bindings: pinctrl: imx7ulp: back to imx legacy
 binding for consistency
In-Reply-To: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1540996688-23681-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already had an earlier conclusion that all new i.MX Socs will keep
using the legacy i.MX Pinctrl bindings instead of generic pin config.
However, MX7ULP generic pin config binding support has already been in
tree before that time. Per SoC maintainers' suggestions, in order to
get a better consistency for all i.MX devices, we'd like to go back to
imx legacy binding for MX7ULP as well.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-gpio at vger.kernel.org
Cc: devicetree at vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
 v3: new patch
---
 .../bindings/pinctrl/fsl,imx7ulp-pinctrl.txt       | 66 ++++++++++------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
index 44ad670a..bfa3703 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
@@ -7,55 +7,47 @@ Note:
 This binding doc is only for the IOMUXC1 support in A7 Domain and it only
 supports generic pin config.
 
-Please also refer pinctrl-bindings.txt in this directory for generic pinctrl
-binding.
-
-=== Pin Controller Node ===
+Please refer to fsl,imx-pinctrl.txt in this directory for common binding
+part and usage.
 
 Required properties:
-- compatible:	"fsl,imx7ulp-iomuxc1"
-- reg:		Should contain the base physical address and size of the iomuxc
-		registers.
-
-=== Pin Configuration Node ===
-- pinmux: One integers array, represents a group of pins mux setting.
-	The format is pinmux = <PIN_FUNC_ID>, PIN_FUNC_ID is a pin working on
-	a specific function.
-
-	NOTE: i.MX7ULP PIN_FUNC_ID consists of 4 integers as it shares one mux
-	and config register as follows:
-	<mux_conf_reg input_reg mux_mode input_val>
-
-	Refer to imx7ulp-pinfunc.h in in device tree source folder for all
-	available imx7ulp PIN_FUNC_ID.
-
-Optional Properties:
-- drive-strength		Integer. Controls Drive Strength
-					0: Standard
-					1: Hi Driver
-- drive-push-pull		Bool. Enable Pin Push-pull
-- drive-open-drain		Bool. Enable Pin Open-drian
-- slew-rate:			Integer. Controls Slew Rate
-					0: Standard
-					1: Slow
-- bias-disable:			Bool. Pull disabled
-- bias-pull-down:		Bool. Pull down on pin
-- bias-pull-up:			Bool. Pull up on pin
+- compatible:	"fsl,imx7ulp-iomuxc1".
+- fsl,pins:	Each entry consists of 5 integers which represents the mux
+		and config setting for one pin. The first 4 integers
+		<mux_conf_reg input_reg mux_mode input_val> are specified
+		using a PIN_FUNC_ID macro, which can be found in
+		imx7ulp-pinfunc.h in the device tree source folder.
+		The last integer CONFIG is the pad setting value like
+		pull-up on this pin.
+
+		Please refer to i.MX7ULP Reference Manual for detailed
+		CONFIG settings.
+
+CONFIG bits definition:
+PAD_CTL_OBE		(1 << 17)
+PAD_CTL_IBE		(1 << 16)
+PAD_CTL_LK		(1 << 16)
+PAD_CTL_DSE_HI		(1 << 6)
+PAD_CTL_DSE_STD		(0 << 6)
+PAD_CTL_ODE		(1 << 5)
+PAD_CTL_PUSH_PULL	(0 << 5)
+PAD_CTL_SRE_SLOW	(1 << 2)
+PAD_CTL_SRE_STD		(0 << 2)
+PAD_CTL_PE		(1 << 0)
 
 Examples:
 #include "imx7ulp-pinfunc.h"
 
 /* Pin Controller Node */
-iomuxc1: iomuxc at 40ac0000 {
+iomuxc1: pinctrl@40ac0000 {
 	compatible = "fsl,imx7ulp-iomuxc1";
 	reg = <0x40ac0000 0x1000>;
 
 	/* Pin Configuration Node */
 	pinctrl_lpuart4: lpuart4grp {
-		pinmux = <
-			IMX7ULP_PAD_PTC3__LPUART4_RX
-			IMX7ULP_PAD_PTC2__LPUART4_TX
+		fsl,pins = <
+			IMX7ULP_PAD_PTC3__LPUART4_RX	0x1
+			IMX7ULP_PAD_PTC2__LPUART4_TX	0x1
 		>;
-		bias-pull-up;
 	};
 };
-- 
2.7.4
