From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 14 May 2014 17:33:05 -0700
Subject: [RFC PATCH 09/10] ARM: tegra124: Add XHCI controller and PHY
In-Reply-To: <1400113986-339-1-git-send-email-abrestic@chromium.org>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
Message-ID: <1400113986-339-10-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And nodes for the XHCI host controller and XUSB PHY present on Tegra124.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/arm/boot/dts/tegra124.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 47fb61c..ee3209bc 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -462,6 +462,43 @@
 		clock-names = "pclk", "clk32k_in";
 	};
 
+	usb at 0,70090000 {
+		compatible = "nvidia,tegra124-xhci";
+		reg = <0x0 0x70090000 0x0 0x8000>,
+		      <0x0 0x70098000 0x0 0x1000>,
+		      <0x0 0x70099000 0x0 0x1000>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_XUSB_HOST>,
+			 <&tegra_car TEGRA124_CLK_XUSB_FALCON_SRC>;
+		clock-names = "xusb_host", "xusb_falcon_src";
+		resets = <&tegra_car 89>;
+		reset-names = "xusb_host";
+		phys = <&xusb_phy>;
+		phy-names = "xusb";
+		status = "disabled";
+	};
+
+	xusb_phy: phy at 0,7009f000 {
+		compatible = "nvidia,tegra124-xusb-phy";
+		reg = <0x0 0x7009f000 0x0 0x1000>;
+		#phy-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_XUSB_SS>,
+			 <&tegra_car TEGRA124_CLK_XUSB_SS_SRC>,
+			 <&tegra_car TEGRA124_CLK_XUSB_HS_SRC>,
+			 <&tegra_car TEGRA124_CLK_XUSB_FS_SRC>,
+			 <&tegra_car TEGRA124_CLK_PLL_U_480M>,
+			 <&tegra_car TEGRA124_CLK_CLK_M>,
+			 <&tegra_car TEGRA124_CLK_PLL_E>;
+		clock-names = "xusb_ss", "xusb_ss_src", "xusb_hs_src",
+			      "xusb_fs_src", "pll_u_480M", "clk_m",
+			      "pll_e";
+		resets = <&tegra_car 156>;
+		reset-names = "xusb_ss";
+		nvidia,clkrst = <&tegra_car>;
+		status = "disabled";
+	};
+
 	sdhci at 0,700b0000 {
 		compatible = "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0000 0x0 0x200>;
-- 
1.9.1.423.g4596e3a
