From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 23 Jun 2016 20:51:03 +0800
Subject: [v3 PATCH 4/5] Documentation: bindings: add dt documentation for cdn
 DP controller
In-Reply-To: <1466686264-6744-1-git-send-email-zyw@rock-chips.com>
References: <1466686264-6744-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1466686264-6744-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a binding that describes the cdn DP controller for
rk3399.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

Changes in v3:
- add SoC specific compatible string
- remove reg = <1>;

Changes in v2: None
Changes in v1:
- add extcon node description
- add #sound-dai-cells description

 .../bindings/display/rockchip/cdn-dp-rockchip.txt  | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
new file mode 100644
index 0000000..b14b2b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
@@ -0,0 +1,61 @@
+Rockchip RK3399 specific extensions to the cdn Display Port
+================================
+
+Required properties:
+- compatible: must be "rockchip,rk3399-cdn-dp"
+
+- reg: physical base address of the controller and length
+
+- clocks: from common clock binding: handle to dp clock.
+
+- clock-names: from common clock binding:
+	       Required elements: "core-clk" "pclk" "spdif"
+
+- rockchip,grf: this soc should set GRF regs, so need get grf here.
+
+- ports: contain a port nodes with endpoint definitions as defined in
+	 Documentation/devicetree/bindings/media/video-interfaces.txt.
+	 contained 2 endpoints, connecting to the output of vop.
+
+- phys: from general PHY binding: the phandle for the PHY device.
+
+- extcon: extcon specifier for the Power Delivery
+
+- #sound-dai-cells = it must be 1 if your system is using 2 DAIs: I2S, SPDIF
+
+-------------------------------------------------------------------------------
+
+Example:
+	cdn_dp: dp at fec00000 {
+		compatible = "rockchip,rk3399-cdn-dp";
+		reg = <0x0 0xfec00000 0x0 0x100000>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_DP_CORE>, <&cru PCLK_DP_CTRL>,
+			 <&cru SCLK_SPDIF_REC_DPTX>;
+		clock-names = "core-clk", "pclk", "spdif";
+		phys = <&tcphy0>;
+		extcon = <&fusb1>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#sound-dai-cells = <1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dp_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dp_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_dp>;
+				};
+
+				dp_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_dp>;
+				};
+			};
+		};
+	};
-- 
2.6.3
