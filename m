From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  9 Nov 2016 21:21:56 +0800
Subject: [PATCH v2 4/9] arm64: dts: rockchip: add eDP device node for rk3399
In-Reply-To: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
References: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1478697721-2323-5-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yakir Yang <ykk@rock-chips.com>

Add rk3399 eDP device node, and connect to VOP device node with
remote endpoint.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
(Caesar rebase the lastest and solve the conflict)

---

Changes in v2:
- Yakir posted the original patch on
- https://patchwork.kernel.org/patch/9191777

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index f1d289a..6544910 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1304,6 +1304,11 @@
 		vopl_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vopl_out_edp: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&edp_in_vopl>;
+			};
 		};
 	};
 
@@ -1330,6 +1335,11 @@
 		vopb_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vopb_out_edp: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&edp_in_vopb>;
+			};
 		};
 	};
 
@@ -1342,6 +1352,41 @@
 		status = "disabled";
 	};
 
+	edp: edp at ff970000 {
+		compatible = "rockchip,rk3399-edp";
+		reg = <0x0 0xff970000 0x0 0x8000>;
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_EDP>, <&cru PCLK_EDP_CTRL>;
+		clock-names = "dp", "pclk";
+		resets = <&cru SRST_P_EDP_CTRL>;
+		reset-names = "dp";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_hpd>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp_in: port at 0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				edp_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_edp>;
+				};
+
+				edp_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_edp>;
+				};
+			};
+		};
+	};
+
 	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vopl_out>, <&vopb_out>;
@@ -1469,6 +1514,13 @@
 			};
 		};
 
+		edp {
+			edp_hpd: edp-hpd {
+				rockchip,pins =
+					<4 23 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
 		gmac {
 			rgmii_pins: rgmii-pins {
 				rockchip,pins =
-- 
2.7.4
