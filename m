From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 22 Sep 2015 15:48:17 +0800
Subject: [PATCH v5 09/17] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
References: <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1442908097-6948-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip DP driver is a helper driver of analogix_dp coder driver,
so most of the DT property should be descriped in analogix_dp document.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v5:
- Split binding doc's from driver changes. (Rob)
- Add eDP hotplug pinctrl property. (Heiko)

Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../bindings/video/analogix_dp-rockchip.txt        | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt

diff --git a/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
new file mode 100644
index 0000000..ec93917
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
@@ -0,0 +1,90 @@
+Rockchip RK3288 specific extensions to the Analogix Display Port
+================================
+
+Required properties:
+- compatible: "rockchip,rk3288-edp";
+
+- reg: physical base address of the controller and length
+
+- clocks: from common clock binding: handle to dp clock.
+	  of memory mapped region.
+
+- clock-names: from common clock binding:
+	       Required elements: "dp" "pclk"
+
+- resets: Must contain an entry for each entry in reset-names.
+	  See ../reset/reset.txt for details.
+
+- pinctrl-names: Names corresponding to the chip hotplug pinctrl states.
+- pinctrl-0: pin-control mode. should be <&edp_hpd>
+
+- reset-names: Must include the name "dp"
+
+- rockchip,grf: this soc should set GRF regs, so need get grf here.
+
+- ports: contain a port node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+
+For the below properties, please refer to Analogix DP binding document:
+ * Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
+- phys (required)
+- phy-names (required)
+- hpd-gpios (optional)
+-------------------------------------------------------------------------------
+
+Example:
+	dp-controller: dp at ff970000 {
+		compatible = "rockchip,rk3288-dp";
+		reg = <0xff970000 0x4000>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
+		clock-names = "dp", "pclk";
+		phys = <&dp_phy>;
+		phy-names = "dp";
+
+		rockchip,grf = <&grf>;
+		resets = <&cru 111>;
+		reset-names = "dp";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_hpd>;
+
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			edp_in: port at 0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				edp_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_edp>;
+				};
+				edp_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_edp>;
+				};
+			};
+
+			edp_out: port at 1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				edp_out_panel: endpoint {
+					reg = <0>;
+					remote-endpoint = <&panel_in_edp>
+				};
+			};
+		};
+	};
+
+	pinctrl {
+		edp {
+			edp_hpd: edp-hpd {
+				rockchip,pins = <7 11 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+	};
-- 
1.9.1
