From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Wed,  6 Dec 2017 12:10:07 +0100
Subject: [PATCH 2/3] arm64: dts: rockchip: add usb3-phy phandle for dwc3.
In-Reply-To: <20171206111008.3079-1-enric.balletbo@collabora.com>
References: <20171206111008.3079-1-enric.balletbo@collabora.com>
Message-ID: <20171206111008.3079-2-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the usb3-phy for both of the two dwc3 controllers on
rk3399.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 17e5e1a..c18ff88 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -397,9 +397,11 @@
 		#size-cells = <2>;
 		ranges;
 		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
-			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
+			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
+			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
 		clock-names = "ref_clk", "suspend_clk",
-			      "bus_clk", "grf_clk";
+			      "bus_clk", "aclk_usb3_rksoc_axi_perf",
+			      "aclk_usb3", "grf_clk";
 		status = "disabled";
 
 		usbdrd_dwc3_0: dwc3 {
@@ -407,14 +409,15 @@
 			reg = <0x0 0xfe800000 0x0 0x100000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
 			dr_mode = "otg";
-			phys = <&u2phy0_otg>;
-			phy-names = "usb2-phy";
+			phys = <&u2phy0_otg>, <&tcphy0_usb3>;
+			phy-names = "usb2-phy", "usb3-phy";
 			phy_type = "utmi_wide";
 			snps,dis_enblslpm_quirk;
 			snps,dis-u2-freeclk-exists-quirk;
 			snps,dis_u2_susphy_quirk;
 			snps,dis-del-phy-power-chg-quirk;
 			snps,dis-tx-ipgap-linecheck-quirk;
+			power-domains = <&power RK3399_PD_USB3>;
 			status = "disabled";
 		};
 	};
@@ -425,9 +428,11 @@
 		#size-cells = <2>;
 		ranges;
 		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
-			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_GRF>;
+			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
+			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
 		clock-names = "ref_clk", "suspend_clk",
-			      "bus_clk", "grf_clk";
+			      "bus_clk", "aclk_usb3_rksoc_axi_perf",
+			      "aclk_usb3", "grf_clk";
 		status = "disabled";
 
 		usbdrd_dwc3_1: dwc3 {
@@ -435,14 +440,15 @@
 			reg = <0x0 0xfe900000 0x0 0x100000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
 			dr_mode = "otg";
-			phys = <&u2phy1_otg>;
-			phy-names = "usb2-phy";
+			phys = <&u2phy1_otg>, <&tcphy1_usb3>;
+			phy-names = "usb2-phy", "usb3-phy";
 			phy_type = "utmi_wide";
 			snps,dis_enblslpm_quirk;
 			snps,dis-u2-freeclk-exists-quirk;
 			snps,dis_u2_susphy_quirk;
 			snps,dis-del-phy-power-chg-quirk;
 			snps,dis-tx-ipgap-linecheck-quirk;
+			power-domains = <&power RK3399_PD_USB3>;
 			status = "disabled";
 		};
 	};
@@ -991,6 +997,12 @@
 				clocks = <&cru HCLK_SDIO>;
 				pm_qos = <&qos_sdioaudio>;
 			};
+			pd_usb3 at RK3399_PD_USB3 {
+				reg = <RK3399_PD_USB3>;
+				clocks = <&cru ACLK_USB3>;
+				pm_qos = <&qos_usb_otg0>,
+					 <&qos_usb_otg1>;
+			};
 			pd_vio at RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
 				#address-cells = <1>;
-- 
2.9.3
