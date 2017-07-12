From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Thu, 13 Jul 2017 00:03:51 +0800
Subject: [PATCH 1/5] arm64: dts: rockchip: Add rk3399 vop and display-subsystem
In-Reply-To: <1499875435-23944-1-git-send-email-jacob-chen@iotwrt.com>
References: <1499875435-23944-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1499875435-23944-2-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree nodes for rk3399 VOP (Video Output Processors), and the
top level display-subsystem root node.

Later patches add endpoints (eDP, HDMI, MIPI, etc) that attach to the
VOPs' output ports.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 65 ++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e795135..300e500 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1455,6 +1455,71 @@
 		status = "disabled";
 	};
 
+	vopl: vop at ff8f0000 {
+		compatible = "rockchip,rk3399-vop-lit";
+		reg = <0x0 0xff8f0000 0x0 0x1ffc>, <0x0 0xff8f2000 0x0 0x400>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>, <&cru DCLK_VOP1_DIV>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop", "dclk_source";
+		resets = <&cru SRST_A_VOP1>, <&cru SRST_H_VOP1>, <&cru SRST_D_VOP1>;
+		reset-names = "axi", "ahb", "dclk";
+		power-domains = <&power RK3399_PD_VOPL>;
+		iommus = <&vopl_mmu>;
+		status = "disabled";
+
+		vopl_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	vopl_mmu: iommu at ff8f3f00 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff8f3f00 0x0 0x100>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vopl_mmu";
+		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
+		clock-names = "aclk", "hclk";
+		power-domains = <&power RK3399_PD_VOPL>;
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vopb: vop at ff900000 {
+		compatible = "rockchip,rk3399-vop-big";
+		reg = <0x0 0xff900000 0x0 0x1ffc>, <0x0 0xff902000 0x0 0x1000>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>, <&cru DCLK_VOP0_DIV>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop", "dclk_source";
+		resets = <&cru SRST_A_VOP0>, <&cru SRST_H_VOP0>, <&cru SRST_D_VOP0>;
+		reset-names = "axi", "ahb", "dclk";
+		power-domains = <&power RK3399_PD_VOPB>;
+		iommus = <&vopb_mmu>;
+		status = "disabled";
+
+		vopb_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	vopb_mmu: iommu at ff903f00 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff903f00 0x0 0x100>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vopb_mmu";
+		clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
+		clock-names = "aclk", "hclk";
+		power-domains = <&power RK3399_PD_VOPB>;
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vopl_out>, <&vopb_out>;
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3399-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.7.4
