From: cosminstefan.stoica@freescale.com (Stoica Cosmin Stefan)
Date: Thu, 6 Mar 2014 18:40:34 +0200
Subject: [PATCH v3] ARM: dts: vf610-twr: Add support for sdhc1
Message-ID: <1394124034-21452-1-git-send-email-cosminstefan.stoica@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cosmin Stoica <cosminstefan.stoica@freescale.com>

The kernel was not able to boot from SD card because sdhc support
was not present into the dts.

A new entry for sdhc1 was added for vf610-twr board based on the
compatible entry present on imx53.

After applying these changes, the kernel is able to boot successfully
from SD card.

Changes v2-v3:
Use tabs instead of spaces for identaion
Changes according to Shawn Guo's comments:
- rebased on Shawn Guo's latest for-next tree
- remove EOL at EOF

Changes v1-v2:
According to Shawn Guo's comments:
- moved esdhc1 node before fec0 in board dts file;
- reformatted clocks line;
- removed duplicate property (bus-width) in dtsi file.

Signed-off-by: Cosmin Stoica <cosminstefan.stoica@freescale.com>
Signed-off-by: Chircu Bogdan <Bogdan.Chircu@freescale.com>
Signed-off-by: Eddy Petrisor <eddy.petrisor@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts |   19 +++++++++++++++++++
 arch/arm/boot/dts/vf610.dtsi    |   11 +++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 7dd1d6e..f3af8ea 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -111,6 +111,13 @@
 	};
 };
 
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &fec0 {
 	phy-mode = "rmii";
 	pinctrl-names = "default";
@@ -158,6 +165,18 @@
 			>;
 		};
 
+		pinctrl_esdhc1: esdhc1grp {
+			fsl,fsl,pins = <
+				VF610_PAD_PTA24__ESDHC1_CLK	0x31ef
+				VF610_PAD_PTA25__ESDHC1_CMD	0x31ef
+				VF610_PAD_PTA26__ESDHC1_DAT0	0x31ef
+				VF610_PAD_PTA27__ESDHC1_DAT1	0x31ef
+				VF610_PAD_PTA28__ESDHC1_DATA2	0x31ef
+				VF610_PAD_PTA29__ESDHC1_DAT3	0x31ef
+				VF610_PAD_PTA7__GPIO_134	0x219d
+			>;
+		};
+
 		pinctrl_fec0: fec0grp {
 			fsl,pins = <
 				VF610_PAD_PTA6__RMII_CLKIN		0x30d1
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 8048733..acf544e 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -347,6 +347,17 @@
 				status = "disabled";
 			};
 
+			esdhc1: esdhc@400b2000 {
+				compatible = "fsl,imx53-esdhc";
+				reg = <0x400b2000 0x4000>;
+				interrupts = <0 28 0x04>;
+				clocks = <&clks VF610_CLK_IPG_BUS>,
+					<&clks VF610_CLK_PLATFORM_BUS>,
+					<&clks VF610_CLK_ESDHC1>;
+				clock-names = "ipg", "ahb", "per";
+				status = "disabled";
+			};
+
 			fec0: ethernet at 400d0000 {
 				compatible = "fsl,mvf600-fec";
 				reg = <0x400d0000 0x1000>;
-- 
1.7.9.5
