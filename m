From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  9 Nov 2016 21:22:00 +0800
Subject: [PATCH v2 8/9] arm64: dts: rockchip: support dwc3 USB for rk3399
In-Reply-To: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
References: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1478697721-2323-9-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brian Norris <briannorris@chromium.org>

Add the dwc3 usb needed node information for rk3399.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2:
- the original patches from brian posting on
  https://chromium-review.googlesource.com/343603

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 09ebf4e..3659c56 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -353,6 +353,60 @@
 		status = "disabled";
 	};
 
+	usbdrd3_0: usb at fe800000 {
+		compatible = "rockchip,rk3399-dwc3";
+		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
+			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
+		clock-names = "ref_clk", "suspend_clk",
+			      "bus_clk", "grf_clk";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+		usbdrd_dwc3_0: dwc3 at fe800000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xfe800000 0x0 0x100000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
+			dr_mode = "otg";
+			phys = <&tcphy0_usb3>;
+			phy-names = "usb3-phy";
+			phy_type = "utmi_wide";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,dis_u2_susphy_quirk;
+			snps,dis-del-phy-power-chg-quirk;
+			snps,xhci-slow-suspend-quirk;
+			status = "disabled";
+		};
+	};
+
+	usbdrd3_1: usb at fe900000 {
+		compatible = "rockchip,rk3399-dwc3";
+		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
+			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_GRF>;
+		clock-names = "ref_clk", "suspend_clk",
+			      "bus_clk", "grf_clk";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+		usbdrd_dwc3_1: dwc3 at fe900000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xfe900000 0x0 0x100000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
+			dr_mode = "host";
+			phys = <&tcphy1_usb3>;
+			phy-names = "usb3-phy";
+			phy_type = "utmi_wide";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,dis_u2_susphy_quirk;
+			snps,dis-del-phy-power-chg-quirk;
+			snps,xhci-slow-suspend-quirk;
+			status = "disabled";
+		};
+	};
+
 	gic: interrupt-controller at fee00000 {
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <4>;
-- 
2.7.4
