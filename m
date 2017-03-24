From: jagan@openedev.com (Jagan Teki)
Date: Fri, 24 Mar 2017 21:48:40 +0530
Subject: [PATCH v2 05/15] ARM: dts: imx6ul-isiot-common: Add touchscreen node
In-Reply-To: <1490372330-5611-1-git-send-email-jagan@openedev.com>
References: <1490372330-5611-1-git-send-email-jagan@openedev.com>
Message-ID: <1490372330-5611-6-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add touchscreen node as i2c1 slave device on Engicam Is.IoT MX6UL
modules, the touchscreen controlled 'st,stmpe-ts' connected via
i2c with st,stmpe811 mfd interface.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Fix commit message s/mfb/mfd
- Use proper [label:] node-name[@unit-address] for mfd device 
- Use pinctrl-names as pinctrl_stmpe instead of pinctrl_stmpe_ts
- Use proper [label:] node-name[@unit-address] for stmpe_touchscreen

 arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
index 9660e20..827f0dc 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
@@ -40,6 +40,34 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+&i2c1 {
+	stmpe811: gpio-expander at 44 {
+		compatible = "st,stmpe811";
+		reg = <0x44>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_stmpe>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		stmpe: touchscreen {
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
+	pinctrl_stmpe: stmpegrp  {
+		fsl,pins = <
+			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18 0x1b0b0
+		>;
+	};
 };
-- 
1.9.1
