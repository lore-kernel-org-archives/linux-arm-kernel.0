From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue, 24 Nov 2015 15:19:08 +0200
Subject: [PATCH 07/14] ARM: am437x: cm-t43: dts: add USB support
In-Reply-To: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Message-ID: <1448371155-17307-8-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB support for CompuLab sbc-t43 single board computer,
defaulting to host mode.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
---
 arch/arm/boot/dts/am437x-cm-t43.dts  | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-sbc-t43.dts | 22 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 856b2ce..70d5c20 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -327,6 +327,36 @@
 	dual_emac_res_vlan = <2>;
 };
 
+&dwc3_1 {
+	status = "okay";
+};
+
+&usb2_phy1 {
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&dwc3_2 {
+	status = "okay";
+};
+
+&usb2_phy2 {
+	status = "okay";
+};
+
+&usb2 {
+	dr_mode = "host";
+	status = "okay";
+	interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "peripheral", "host", "otg";
+};
+
 &elm {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/am437x-sbc-t43.dts b/arch/arm/boot/dts/am437x-sbc-t43.dts
index f3cd76b..5d2919e 100644
--- a/arch/arm/boot/dts/am437x-sbc-t43.dts
+++ b/arch/arm/boot/dts/am437x-sbc-t43.dts
@@ -36,6 +36,18 @@
 			AM4372_IOPAD(0x97c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE3)  /* uart1_rtsn.i2c2_scl */
 		>;
 	};
+
+	usb2_phy1_default: usb2_phy1_default {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0xac0, DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+
+	usb2_phy2_default: usb2_phy2_default {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0xac4, DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
 };
 
 &i2c1 {
@@ -55,3 +67,13 @@
 	pinctrl-0 = <&uart0_pins_default>;
 };
 
+&dwc3_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_phy1_default>;
+};
+
+&dwc3_2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_phy2_default>;
+};
+
-- 
1.9.1
