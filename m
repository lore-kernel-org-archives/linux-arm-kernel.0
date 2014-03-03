From: cosminstefan.stoica@freescale.com (Stoica Cosmin Stefan)
Date: Mon, 3 Mar 2014 17:29:33 +0200
Subject: [PATCH v2] ARM: dts: vf610-twr: Add support for sdhc1
In-Reply-To: <1393591611-3147-1-git-send-email-cosminstefan.stoica@freescale.com>
References: <1393591611-3147-1-git-send-email-cosminstefan.stoica@freescale.com>
Message-ID: <1393860573-16615-1-git-send-email-cosminstefan.stoica@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cosmin Stoica <cosminstefan.stoica@freescale.com>

The kernel was not able to boot from SD card because sdhc support
was not present into the dts.

A new entry for sdhc1 was added for vf610-twr board based on the
compatible entry present on imx53.

After applying these changes, the kernel is able to boot successfully
from SD card.

Changes v1-v2:
According to Shawn Guo's comments:
- moved esdhc1 node before fec0 in board dts file;
- reformatted clocks line;
- removed duplicate property (bus-width) in dtsi file.

Signed-off-by: Cosmin Stoica <cosminstefan.stoica@freescale.com>
Signed-off-by: Chircu Bogdan <Bogdan.Chircu@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts |    8 ++++++++
 arch/arm/boot/dts/vf610.dtsi    |   11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 7dd1d6e..e77c98e 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -111,6 +111,13 @@
 	};
 };
 
+&esdhc1 {
+   pinctrl-names = "default";
+   pinctrl-0 = <&pinctrl_esdhc1_1>;
+   bus-width = <4>;
+   status = "okay";
+};
+
 &fec0 {
 	phy-mode = "rmii";
 	pinctrl-names = "default";
@@ -227,3 +234,4 @@
 	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
 };
+
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index c63d26d..70de377 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -344,6 +344,17 @@
 				status = "disabled";
 			};
 
+			esdhc1: esdhc at 400b2000 {
+				   compatible = "fsl,imx53-esdhc";
+				   reg = <0x400b2000 0x4000>;
+				   interrupts = <0 28 0x04>;
+				   clocks = <&clks VF610_CLK_IPG_BUS>,
+                                           <&clks VF610_CLK_PLATFORM_BUS>,
+                                           <&clks VF610_CLK_ESDHC1>;
+				   clock-names = "ipg", "ahb", "per";
+				   status = "disabled";
+			};
+
 			fec0: ethernet at 400d0000 {
 				compatible = "fsl,mvf600-fec";
 				reg = <0x400d0000 0x1000>;
-- 
1.7.9.5
