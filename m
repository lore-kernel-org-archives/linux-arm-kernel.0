From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 20 Dec 2017 23:12:01 +0000
Subject: [PATCH 4/4] ARM: dts: vf610-zii-dev-rev-b: add interrupts for 88e1545
 PHY
In-Reply-To: <20171220231108.GJ10595@n2100.armlinux.org.uk>
References: <20171220231108.GJ10595@n2100.armlinux.org.uk>
Message-ID: <E1eRnWr-0006VS-1m@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 88e1545 PHY has its interrupts wired to the VF610, so we might as
well use them.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
This is certainly not correct, as all PHYs on this device share the
same interrupt line, but we can't specify the pinmux settings
individually on each PHY.  How should this be handled?
---
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 782b69a3acdf..d6786c5d0109 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -312,12 +312,20 @@
 					#size-cells = <0>;
 
 					switch2phy0: phy at 0 {
+						interrupt-parent = <&gpio0>;
+						interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
 						reg = <0>;
+						pinctrl-names = "default";
+						pinctrl-0 = <&pinctrl_mv88e1545>;
 					};
 					switch2phy1: phy at 1 {
+						interrupt-parent = <&gpio0>;
+						interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
 						reg = <1>;
 					};
 					switch2phy2: phy at 2 {
+						interrupt-parent = <&gpio0>;
+						interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
 						reg = <2>;
 					};
 				};
@@ -488,6 +496,12 @@
 		>;
 	};
 
+	pinctrl_mv88e1545: pinctrl-mv88e1545 {
+		fsl,pins = <
+			VF610_PAD_PTB0__GPIO_22		0x219d
+		>;
+	};
+
 	pinctrl_pca9554_22: pinctrl-pca95540-22 {
 		fsl,pins = <
 			VF610_PAD_PTB28__GPIO_98	0x219d
-- 
2.7.4
