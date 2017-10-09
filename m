From: hjc@rock-chips.com (Sandy Huang)
Date: Mon,  9 Oct 2017 16:06:47 +0800
Subject: [PATCH v3 2/4] devicetree/bindings: display: Add document for
 rockchip RGB output
In-Reply-To: <1507536396-106827-1-git-send-email-hjc@rock-chips.com>
References: <1507536396-106827-1-git-send-email-hjc@rock-chips.com>
Message-ID: <1507536409-110749-1-git-send-email-hjc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This path add support rv1108 rgb output interface driver.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
Changes in v3:
 move rgb-mode to panel node which describe at:
 Documentation/devicetree/bindings/display/panel/panel-rgb.txt

Changes in v2:
 1. rename rockchip,rgb-mode to rgb-mode;
 2. delete reg for signle endpoint;
 .../bindings/display/rockchip/rockchip-rgb.txt     | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
new file mode 100644
index 0000000..d91a7bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
@@ -0,0 +1,72 @@
+Rockchip RV1108 RGB interface
+================================
+
+Required properties:
+- compatible: matching the soc type:
+	- "rockchip,rv1108-rgb";
+
+Optional properties:
+- pinctrl-names: must contain a "lcdc" entry.
+- pinctrl-0: pin control group to be used for this interface.
+
+The rgb has two video ports described by:
+	Documentation/devicetree/bindings/media/video-interfaces.txt
+Their connections are modeled using the OF graph bindings specified in
+	Documentation/devicetree/bindings/graph.txt.
+
+- video port 0 for the VOP input, the remote endpoint maybe vopb/vopl/vop
+- video port 1 for either a panel or subsequent encoder
+
+the panel described by:
+	Documentation/devicetree/bindings/display/panel/simple-panel.txt
+rgb-mode nodes described by:
+	Documentation/devicetree/bindings/display/panel/panel-rgb.txt
+Panel other required properties:
+- ports for remote rgb output.
+
+Example:
+
+panel: panel {
+	compatible = "auo,b101ean01";
+	enable-gpios = <&gpio7 21 GPIO_ACTIVE_HIGH>;
+	rgb-mode = "p888";
+
+	ports {
+		panel_in_rgb: endpoint {
+			remote-endpoint = <&rgb_out_panel>;
+		};
+	};
+};
+
+For Rockchip RV1108:
+
+	rgb: rgb {
+		compatible = "rockchip,rv1108-rgb";
+		pinctrl-names = "lcdc";
+		pinctrl-0 = <&lcdc_ctl>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rgb_in: port at 0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				rgb_in_vop: endpoint {
+					remote-endpoint = <&vop_out_rgb>;
+				};
+			};
+
+			rgb_out: port at 1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				rgb_out_panel: endpoint {
+					remote-endpoint = <&panel_in_rgb>;
+				};
+			};
+		};
+	};
-- 
2.7.4
