From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 15:54:55 +0200
Subject: [PATCH v2 2/4] arm64: dts: rockchip: add rk3328 display nodes
In-Reply-To: <20180515135457.6252-1-heiko@sntech.de>
References: <20180515135457.6252-1-heiko@sntech.de>
Message-ID: <20180515135457.6252-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the chain of display nodes from the core display-subsystem
through the one vop to the dw-hdmi output.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Robin Murphy <robin.murphy@arm.com>
---
changes in v2:
- remove trailing 0 from vop irq

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 56 ++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 04d81ea0924e..16e7cf210875 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -185,6 +185,11 @@
 		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
 	};
 
+	display_subsystem: display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop_out>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
@@ -634,6 +639,28 @@
 		status = "disabled";
 	};
 
+	vop: vop at ff370000 {
+		compatible = "rockchip,rk3328-vop";
+		reg = <0x0 0xff370000 0x0 0x3efc>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_VOP>, <&cru DCLK_LCDC>, <&cru HCLK_VOP>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_VOP_A>, <&cru SRST_VOP_H>, <&cru SRST_VOP_D>;
+		reset-names = "axi", "ahb", "dclk";
+		iommus = <&vop_mmu>;
+		status = "disabled";
+
+		vop_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			vop_out_hdmi: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop>;
+			};
+		};
+	};
+
 	vop_mmu: iommu at ff373f00 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff373f00 0x0 0x100>;
@@ -645,6 +672,35 @@
 		status = "disabled";
 	};
 
+	hdmi: hdmi at ff3c0000 {
+		compatible = "rockchip,rk3328-dw-hdmi";
+		reg = <0x0 0xff3c0000 0x0 0x20000>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_HDMI>,
+			 <&cru SCLK_HDMI_SFC>;
+		clock-names = "iahb",
+			      "isfr";
+		phys = <&hdmiphy>;
+		phy-names = "hdmi";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_cec &hdmii2c_xfer &hdmi_hpd>;
+		rockchip,grf = <&grf>;
+		status = "disabled";
+
+		ports {
+			hdmi_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				hdmi_in_vop: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vop_out_hdmi>;
+				};
+			};
+		};
+	};
+
 	hdmiphy: phy at ff430000 {
 		compatible = "rockchip,rk3328-hdmi-phy";
 		reg = <0x0 0xff430000 0x0 0x10000>;
-- 
2.17.0
