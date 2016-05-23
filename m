From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 23 May 2016 21:11:10 +0800
Subject: [PATCH 1/3] arm64: dts: rockchip: add VOP and VOP iommu node for
 rk3399
In-Reply-To: <1464009056-32158-1-git-send-email-ykk@rock-chips.com>
References: <1464009056-32158-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1464009070-32215-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Yao <mark.yao@rock-chips.com>

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 46f325a..54e5c25 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -543,6 +543,64 @@
 		status = "disabled";
 	};
 
+	vopl: vop at ff8f0000 {
+		compatible = "rockchip,rk3399-vop-lit";
+		reg = <0x0 0xff8f0000 0x0 0x3efc>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_A_VOP1>, <&cru SRST_H_VOP1>, <&cru SRST_D_VOP1>;
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
+	vopl_mmu: iommu at ff8f3f00 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff8f3f00 0x0 0x100>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vopl_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vopb: vop at ff900000 {
+		compatible = "rockchip,rk3399-vop-big";
+		reg = <0x0 0xff900000 0x0 0x3efc>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_A_VOP0>, <&cru SRST_H_VOP0>, <&cru SRST_D_VOP0>;
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
+	vopb_mmu: iommu at ff903f00 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff903f00 0x0 0x100>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vopb_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	display_subsystem: display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vopl_out>, <&vopb_out>;
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3399-pinctrl";
 		rockchip,grf = <&grf>;
-- 
1.9.1
