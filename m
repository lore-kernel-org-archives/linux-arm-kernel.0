From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 Jan 2015 22:32:06 +0100
Subject: [PATCH 1/2] ARM: dts: rockchip: Add rk3288 vop and display-subsystem
In-Reply-To: <3715086.HVfme6flvD@phil>
References: <3715086.HVfme6flvD@phil>
Message-ID: <1773321.tR2A6n6Kmk@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree nodes for rk3288 VOP (Video Output Processors), and the
top level display-subsystem root node.

Later patches add endpoints (eDP, HDMI, LVDS, etc) that attach to the
VOPs' output ports.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark yao <mark.yao@rock-chips.com>
Reviewed-by: Stephane Marchesin <marcheu@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 2a878a3..1d22238 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -149,6 +149,11 @@
 		clock-frequency = <24000000>;
 	};
 
+	display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vopl_out>, <&vopb_out>;
+	};
+
 	sdmmc: dwmmc at ff0c0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
@@ -566,6 +571,23 @@
 		status = "disabled";
 	};
 
+	vopb: vop at ff930000 {
+		compatible = "rockchip,rk3288-vop";
+		reg = <0xff930000 0x19c>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>;
+		reset-names = "axi", "ahb", "dclk";
+		iommus = <&vopb_mmu>;
+		status = "disabled";
+
+		vopb_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	vopb_mmu: iommu at ff930300 {
 		compatible = "rockchip,iommu";
 		reg = <0xff930300 0x100>;
@@ -575,6 +597,23 @@
 		status = "disabled";
 	};
 
+	vopl: vop at ff940000 {
+		compatible = "rockchip,rk3288-vop";
+		reg = <0xff940000 0x19c>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_LCDC1_AXI>, <&cru SRST_LCDC1_AHB>, <&cru SRST_LCDC1_DCLK>;
+		reset-names = "axi", "ahb", "dclk";
+		iommus = <&vopl_mmu>;
+		status = "disabled";
+
+		vopl_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	vopl_mmu: iommu at ff940300 {
 		compatible = "rockchip,iommu";
 		reg = <0xff940300 0x100>;
-- 
2.1.1
