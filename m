From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 Oct 2018 12:38:20 +0200
Subject: [PATCH v3 7/7] ARM: dts: rockchip: add rk3066/rk3188 power-domains
In-Reply-To: <20181023103820.6464-1-heiko@sntech.de>
References: <20181023103820.6464-1-heiko@sntech.de>
Message-ID: <20181023103820.6464-8-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the power-domain nodes to both rk3066 and rk3188 including
their clocks and qos connections.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 52 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi  | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 2ab3c4b32003..112d2bf8e998 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3066a-cru.h>
+#include <dt-bindings/power/rk3066-power.h>
 #include "rk3xxx.dtsi"
 
 / {
@@ -595,6 +596,7 @@
 			  "ppmmu2",
 			  "pp3",
 			  "ppmmu3";
+	power-domains = <&power RK3066_PD_GPU>;
 };
 
 &i2c0 {
@@ -643,6 +645,56 @@
 	dma-names = "rx-tx";
 };
 
+&pmu {
+	power: power-controller {
+		compatible = "rockchip,rk3066-power-controller";
+		#power-domain-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pd_vio at RK3066_PD_VIO {
+			reg = <RK3066_PD_VIO>;
+			clocks = <&cru ACLK_LCDC0>,
+				 <&cru ACLK_LCDC1>,
+				 <&cru DCLK_LCDC0>,
+				 <&cru DCLK_LCDC1>,
+				 <&cru HCLK_LCDC0>,
+				 <&cru HCLK_LCDC1>,
+				 <&cru SCLK_CIF1>,
+				 <&cru ACLK_CIF1>,
+				 <&cru HCLK_CIF1>,
+				 <&cru SCLK_CIF0>,
+				 <&cru ACLK_CIF0>,
+				 <&cru HCLK_CIF0>,
+				 <&cru ACLK_IPP>,
+				 <&cru HCLK_IPP>,
+				 <&cru ACLK_RGA>,
+				 <&cru HCLK_RGA>;
+			pm_qos = <&qos_lcdc0>,
+				 <&qos_lcdc1>,
+				 <&qos_cif0>,
+				 <&qos_cif1>,
+				 <&qos_ipp>,
+				 <&qos_rga>;
+		};
+
+		pd_video at RK3066_PD_VIDEO {
+			reg = <RK3066_PD_VIDEO>;
+			clocks = <&cru ACLK_VDPU>,
+				 <&cru ACLK_VEPU>,
+				 <&cru HCLK_VDPU>,
+				 <&cru HCLK_VEPU>;
+			pm_qos = <&qos_vpu>;
+		};
+
+		pd_gpu at RK3066_PD_GPU {
+			reg = <RK3066_PD_GPU>;
+			clocks = <&cru ACLK_GPU>;
+			pm_qos = <&qos_gpu>;
+		};
+	};
+};
+
 &pwm0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_out>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index b6f790973736..7e0dc52630d9 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3188-cru.h>
+#include <dt-bindings/power/rk3188-power.h>
 #include "rk3xxx.dtsi"
 
 / {
@@ -80,6 +81,7 @@
 		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_LCDC0>, <&cru DCLK_LCDC0>, <&cru HCLK_LCDC0>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		power-domains = <&power RK3188_PD_VIO>;
 		resets = <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>;
 		reset-names = "axi", "ahb", "dclk";
 		status = "disabled";
@@ -96,6 +98,7 @@
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_LCDC1>, <&cru DCLK_LCDC1>, <&cru HCLK_LCDC1>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		power-domains = <&power RK3188_PD_VIO>;
 		resets = <&cru SRST_LCDC1_AXI>, <&cru SRST_LCDC1_AHB>, <&cru SRST_LCDC1_DCLK>;
 		reset-names = "axi", "ahb", "dclk";
 		status = "disabled";
@@ -620,6 +623,7 @@
 			  "ppmmu2",
 			  "pp3",
 			  "ppmmu3";
+	power-domains = <&power RK3188_PD_GPU>;
 };
 
 &i2c0 {
@@ -652,6 +656,53 @@
 	pinctrl-0 = <&i2c4_xfer>;
 };
 
+&pmu {
+	power: power-controller {
+		compatible = "rockchip,rk3188-power-controller";
+		#power-domain-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pd_vio at RK3188_PD_VIO {
+			reg = <RK3188_PD_VIO>;
+			clocks = <&cru ACLK_LCDC0>,
+				 <&cru ACLK_LCDC1>,
+				 <&cru DCLK_LCDC0>,
+				 <&cru DCLK_LCDC1>,
+				 <&cru HCLK_LCDC0>,
+				 <&cru HCLK_LCDC1>,
+				 <&cru SCLK_CIF0>,
+				 <&cru ACLK_CIF0>,
+				 <&cru HCLK_CIF0>,
+				 <&cru ACLK_IPP>,
+				 <&cru HCLK_IPP>,
+				 <&cru ACLK_RGA>,
+				 <&cru HCLK_RGA>;
+			pm_qos = <&qos_lcdc0>,
+				 <&qos_lcdc1>,
+				 <&qos_cif0>,
+				 <&qos_cif1>,
+				 <&qos_ipp>,
+				 <&qos_rga>;
+		};
+
+		pd_video at RK3188_PD_VIDEO {
+			reg = <RK3188_PD_VIDEO>;
+			clocks = <&cru ACLK_VDPU>,
+				 <&cru ACLK_VEPU>,
+				 <&cru HCLK_VDPU>,
+				 <&cru HCLK_VEPU>;
+			pm_qos = <&qos_vpu>;
+		};
+
+		pd_gpu at RK3188_PD_GPU {
+			reg = <RK3188_PD_GPU>;
+			clocks = <&cru ACLK_GPU>;
+			pm_qos = <&qos_gpu>;
+		};
+	};
+};
+
 &pwm0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_out>;
-- 
2.18.0
