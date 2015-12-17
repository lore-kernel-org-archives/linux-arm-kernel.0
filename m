From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 17 Dec 2015 22:21:48 +0800
Subject: [PATCH v1 2/6] ARM: dts: add the lcdc and hdmi node for rk3036
In-Reply-To: <1450362112-8075-1-git-send-email-wxt@rock-chips.com>
References: <1450362112-8075-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1450362112-8075-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3036 support two overlay plane and one hwc plane,
it support IOMMU, and its IOMMU same as rk3288's.

Meanwhile, add the inno hdmi for HDMI display.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3036.dtsi | 61 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 620e6e0..11a8078 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -145,6 +145,37 @@
 		};
 	};
 
+	lcdc_mmu: iommu at 10118300 {
+		compatible = "rockchip,iommu";
+		reg = <0x10118300 0x100>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "lcdc_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	lcdc: lcdc at 10118000 {
+		compatible = "rockchip,rk3036-lcdc";
+		reg = <0x10118000 0x19c>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_LCDC>, <&cru SCLK_LCDC>, <&cru HCLK_LCDC>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_LCDC1_A>, <&cru SRST_LCDC1_H>, <&cru SRST_LCDC1_D>;
+		reset-names = "axi", "ahb", "dclk";
+		iommus = <&lcdc_mmu>;
+
+		status = "disabled";
+
+		lcdc_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			lcdc_out_hdmi: endpoint at 0 {
+				reg = <1>;
+				remote-endpoint = <&hdmi_in_lcdc>;
+			};
+		};
+	};
+
 	gic: interrupt-controller at 10139000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
@@ -248,6 +279,27 @@
 		status = "disabled";
 	};
 
+	hdmi: hdmi at 20034000 {
+		compatible = "rockchip,rk3036-inno-hdmi";
+		reg = <0x20034000 0x4000>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru  PCLK_HDMI>;
+		clock-names = "pclk";
+		rockchip,grf = <&grf>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_ctl>;
+		status = "disabled";
+
+		hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hdmi_in_lcdc: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&lcdc_out_hdmi>;
+			};
+		};
+	};
+
 	timer: timer at 20044000 {
 		compatible = "rockchip,rk3036-timer", "rockchip,rk3288-timer";
 		reg = <0x20044000 0x20>;
@@ -484,6 +536,15 @@
 			};
 		};
 
+		hdmi {
+			hdmi_ctl: hdmi-ctl {
+				rockchip,pins = <1 8  RK_FUNC_1 &pcfg_pull_none>,
+						<1 9  RK_FUNC_1 &pcfg_pull_none>,
+						<1 10 RK_FUNC_1 &pcfg_pull_none>,
+						<1 11 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins = <0 0 RK_FUNC_1 &pcfg_pull_none>,
-- 
1.9.1
