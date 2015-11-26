From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 26 Nov 2015 15:50:23 +0800
Subject: [PATCH v5 09/11] Documentation: dt-bindings: Add bindings for rk3288
 DW MIPI DSI driver
In-Reply-To: <1448524225-5489-1-git-send-email-zyw@rock-chips.com>
References: <1448524225-5489-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1448524225-5489-10-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add device tree bindings for rk3288 specific Synopsys DW MIPI DSI driver

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v5: None
Changes in v4: None
Changes in v3:
- move dw_mipi_dsi_rockchip.txt to bindings/display/rockchip/

Changes in v2: None

 .../display/rockchip/dw_mipi_dsi_rockchip.txt      | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
new file mode 100644
index 0000000..acd9ec9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -0,0 +1,56 @@
+Rockchip specific extensions to the Synopsys Designware MIPI DSI
+================================
+
+Required properties:
+- compatible: "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi".
+- rockchip,grf: this soc should set GRF regs to mux vopl/vopb.
+- ports: contain a port node with endpoint definitions as defined in [1].
+  For vopb,set the reg = <0> and set the reg = <1> for vopl.
+
+For more required properties, please refer to [2].
+
+[1] Documentation/devicetree/bindings/media/video-interfaces.txt
+[2] Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
+
+Example:
+	mipi_dsi: mipi at ff960000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0xff960000 0x4000>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_MIPI_24M>, <&cru PCLK_MIPI_DSI0>;
+		clock-names = "ref", "pclk";
+		rockchip,grf = <&grf>;
+		status = "okay";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			mipi_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				mipi_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_mipi>;
+				};
+				mipi_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_mipi>;
+				};
+			};
+		};
+
+		panel {
+			compatible ="boe,tv080wum-nl0";
+			reg = <0>;
+
+			enable-gpios = <&gpio7 3 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&lcd_en>;
+			backlight = <&backlight>;
+			status = "okay";
+		};
+	};
-- 
2.6.3
