From: jagan@openedev.com (Jagan Teki)
Date: Wed, 22 Mar 2017 23:18:10 +0530
Subject: [PATCH 05/12] ARM: dts: imx6ul-isiot-common: Add touchscreen node
In-Reply-To: <1490204897-14525-1-git-send-email-jagan@openedev.com>
References: <1490204897-14525-1-git-send-email-jagan@openedev.com>
Message-ID: <1490204897-14525-6-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add touchscreen node as i2c1 slave device on Engicam Is.IoT MX6UL
modules, the touchscreen controlled 'st,stmpe-ts' connected via
i2c with st,stmpe811 mfb interface.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
index 9660e20..b149b5e 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
@@ -40,6 +40,34 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+&i2c1 {
+	touch: stmpe811 at 44 {
+		compatible = "st,stmpe811";
+		reg = <0x44>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_stmpe_ts>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		stmpe_touchscreen {
+			compatible = "st,stmpe-ts";
+			st,sample-time = <4>;
+			st,mod-12b = <1>;
+			st,ref-sel = <0>;
+			st,adc-freq = <1>;
+			st,ave-ctrl = <1>;
+			st,touch-det-delay = <2>;
+			st,settling = <2>;
+			st,fraction-z = <7>;
+			st,i-drive = <1>;
+		};
+	};
+};
+
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat
@@ -104,4 +132,10 @@
 			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17  0x79
 		>;
 	};
+
+	pinctrl_stmpe_ts:  stmpe-tsgrp  {
+		fsl,pins = <
+			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18 0x1b0b0
+		>;
+	};
 };
-- 
1.9.1
