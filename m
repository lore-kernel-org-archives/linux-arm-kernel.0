From: briannorris@chromium.org (Brian Norris)
Date: Thu,  9 Feb 2017 17:05:17 -0800
Subject: [PATCH v2 2/6] arm64: dts: rockchip: support dwc3 USB for rk3399
In-Reply-To: <20170210010521.78872-1-briannorris@chromium.org>
References: <20170210010521.78872-1-briannorris@chromium.org>
Message-ID: <20170210010521.78872-3-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the dwc3 usb needed node information for rk3399.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Somewhat rewritten from Caesar's reposting (v2) of my patch.
Changes (?? -> v1):
 * Include USB2 PHY (which is now in -next)
 * Don't include USB3 PHY, as extcon support is not ready yet
 * Drop non-upstream properties
 * Fixup whitespace a bit

v1 -> v2:
 * add phy_type = "utmi_wide"
 * sort by unit address
 * match upstream clock names and delete unnecessary ones
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 8e6d1bdeb9c3..a9702c29d71a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -371,6 +371,60 @@
 		status = "disabled";
 	};
 
+	usbdrd3_0: usb at fe800000 {
+		compatible = "rockchip,rk3399-dwc3";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
+			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
+		clock-names = "ref_clk", "suspend_clk",
+			      "bus_clk", "grf_clk";
+		status = "disabled";
+
+		usbdrd_dwc3_0: dwc3 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xfe800000 0x0 0x100000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
+			dr_mode = "otg";
+			phys = <&u2phy0_otg>;
+			phy-names = "usb2-phy";
+			phy_type = "utmi_wide";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,dis_u2_susphy_quirk;
+			snps,dis-del-phy-power-chg-quirk;
+			status = "disabled";
+		};
+	};
+
+	usbdrd3_1: usb at fe900000 {
+		compatible = "rockchip,rk3399-dwc3";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
+			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_GRF>;
+		clock-names = "ref_clk", "suspend_clk",
+			      "bus_clk", "grf_clk";
+		status = "disabled";
+
+		usbdrd_dwc3_1: dwc3 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xfe900000 0x0 0x100000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
+			dr_mode = "otg";
+			phys = <&u2phy1_otg>;
+			phy-names = "usb2-phy";
+			phy_type = "utmi_wide";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,dis_u2_susphy_quirk;
+			snps,dis-del-phy-power-chg-quirk;
+			status = "disabled";
+		};
+	};
+
 	gic: interrupt-controller at fee00000 {
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <4>;
-- 
2.11.0.483.g087da7b7c-goog
