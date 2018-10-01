From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  1 Oct 2018 14:38:42 +0200
Subject: [PATCH v6 4/7] dt-bindings: display: rockchip: update DSI controller
In-Reply-To: <20181001123845.11818-1-heiko@sntech.de>
References: <20181001123845.11818-1-heiko@sntech.de>
Message-ID: <20181001123845.11818-5-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nickey Yang <nickey.yang@rock-chips.com>

This patch update describe panel/port links, including
unit addresses in documentation of device tree bindings
for the rockchip DSI controller based on the Synopsys
DesignWare MIPI DSI host controller.

Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../display/rockchip/dw_mipi_dsi_rockchip.txt | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
index 6bb59ab39f2f..ce4c1fc9116c 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -14,6 +14,8 @@ Required properties:
 - rockchip,grf: this soc should set GRF regs to mux vopl/vopb.
 - ports: contain a port node with endpoint definitions as defined in [2].
   For vopb,set the reg = <0> and set the reg = <1> for vopl.
+- video port 0 for the VOP input, the remote endpoint maybe vopb or vopl
+- video port 1 for either a panel or subsequent encoder
 
 Optional properties:
 - power-domains: a phandle to mipi dsi power domain node.
@@ -40,11 +42,12 @@ Example:
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <1>;
 
-			mipi_in: port {
+			mipi_in: port at 0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+
 				mipi_in_vopb: endpoint at 0 {
 					reg = <0>;
 					remote-endpoint = <&vopb_out_mipi>;
@@ -54,6 +57,16 @@ Example:
 					remote-endpoint = <&vopl_out_mipi>;
 				};
 			};
+
+			mipi_out: port at 1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mipi_out_panel: endpoint {
+					remote-endpoint = <&panel_in_mipi>;
+				};
+			};
 		};
 
 		panel {
@@ -64,5 +77,11 @@ Example:
 			pinctrl-names = "default";
 			pinctrl-0 = <&lcd_en>;
 			backlight = <&backlight>;
+
+			port {
+				panel_in_mipi: endpoint {
+					remote-endpoint = <&mipi_out_panel>;
+				};
+			};
 		};
 	};
-- 
2.18.0
