From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:43 +0200
Subject: [PATCH 02/15] ARM: dts: sun5i: Move q8 display bits to
 sun5i-a13-q8-tablet.dts
In-Reply-To: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467993956-19535-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a preparation patch for renaming sun5i-q8-common.dtsi to
sun5i-reference-design-tablet.dtsi and sharing it between all
the A13 tablet dts files.

Since we only have a panel config for the 18 tablets (for now) move
this to the q8 specific dts file.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts | 36 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-q8-common.dtsi    | 36 -------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
index dce7782..afe14f7 100644
--- a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
+++ b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
@@ -47,4 +47,40 @@
 / {
 	model = "Q8 A13 Tablet";
 	compatible = "allwinner,q8-a13", "allwinner,sun5i-a13";
+
+	panel: panel {
+		compatible = "urt,umsh-8596md-t", "simple-panel";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+			/* TODO: lcd panel uses axp gpio0 as enable pin */
+			backlight = <&backlight>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&tcon0_out_lcd>;
+			};
+		};
+	};
+};
+
+&be0 {
+	status = "okay";
+};
+
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_rgb666_pins>;
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_lcd: endpoint at 0 {
+		reg = <0>;
+		remote-endpoint = <&panel_input>;
+	};
 };
diff --git a/arch/arm/boot/dts/sun5i-q8-common.dtsi b/arch/arm/boot/dts/sun5i-q8-common.dtsi
index 8977fb2..ca5d0c4 100644
--- a/arch/arm/boot/dts/sun5i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun5i-q8-common.dtsi
@@ -59,29 +59,6 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-
-	panel: panel {
-		compatible = "urt,umsh-8596md-t", "simple-panel";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port at 0 {
-			reg = <0>;
-			/* TODO: lcd panel uses axp gpio0 as enable pin */
-			backlight = <&backlight>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			panel_input: endpoint at 0 {
-				reg = <0>;
-				remote-endpoint = <&tcon0_out_lcd>;
-			};
-		};
-	};
-};
-
-&be0 {
-	status = "okay";
 };
 
 &codec {
@@ -202,19 +179,6 @@
 	status = "okay";
 };
 
-&tcon0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&lcd_rgb666_pins>;
-	status = "okay";
-};
-
-&tcon0_out {
-	tcon0_out_lcd: endpoint at 0 {
-		reg = <0>;
-		remote-endpoint = <&panel_input>;
-	};
-};
-
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins_b>;
-- 
2.7.4
