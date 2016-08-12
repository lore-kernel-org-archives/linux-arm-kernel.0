From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 12 Aug 2016 14:54:51 -0700
Subject: [PATCH v11 PATCH 4/5] Documentation: bindings: add dt documentation
 for cdn DP controller
In-Reply-To: <1471038892-28099-1-git-send-email-zyw@rock-chips.com>
References: <1471038892-28099-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1471038892-28099-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a binding that describes the cdn DP controller for
rk3399.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v11:
- refer dp phy

Changes in v10:
- add pclk_vio_grf clock

Changes in v9:
- modify the reference phy = <&tcphy0 0>, <&tcphy1 0>;

Changes in v8: None
Changes in v7: None
Changes in v6:
- add assigned-clocks and assigned-clock-rates
- add power-domains

Changes in v5: None
Changes in v4:
- add a reset node
- support 2 phys

Changes in v3:
- add SoC specific compatible string
- remove reg = <1>;

Changes in v2: None
Changes in v1:
- add extcon node description
- add #sound-dai-cells description

 .../bindings/display/rockchip/cdn-dp-rockchip.txt  | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
new file mode 100644
index 0000000..d34a56e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
@@ -0,0 +1,74 @@
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
+	       Required elements: "core-clk" "pclk" "spdif" "grf"
+
+- resets : a list of phandle + reset specifier pairs
+- reset-names : string reset name, must be:
+		"spdif"
+- power-domains : power-domain property defined with a phandle
+		  to respective power domain.
+- assigned-clocks: main clock, should be <&cru SCLK_DP_CORE>
+- assigned-clock-rates : the DP core clk frequency, shall be: 100000000
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
+			 <&cru SCLK_SPDIF_REC_DPTX>, <&cru PCLK_VIO_GRF>;
+		clock-names = "core-clk", "pclk", "spdif", "grf";
+		assigned-clocks = <&cru SCLK_DP_CORE>;
+		assigned-clock-rates = <100000000>;
+		power-domains = <&power RK3399_PD_HDCP>;
+		phys = <&tcphy0_dp>, <&tcphy1_dp>;
+		resets = <&cru SRST_DPTX_SPDIF_REC>;
+		reset-names = "spdif";
+		extcon = <&fusb0>, <&fusb1>;
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
1.9.1
