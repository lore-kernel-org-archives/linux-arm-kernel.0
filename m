From: briannorris@chromium.org (Brian Norris)
Date: Tue, 10 May 2016 17:02:54 -0700
Subject: [PATCH 1/2] ARM64: dts: rockchip: add sdhci/emmc for rk3399
Message-ID: <1462924975-69072-1-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bindings for rk3399's SDHCI + eMMC PHY have been accepted, so let's
support eMMC now.

Note that 'rockchip,rk3399-sdhci-5.1' is not documented, but per Heiko's
previous suggestion, we don't want to clutter the arasan doc, and it's
just a precautionary measure to have it.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 46f325a143b0..947d1221592d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -215,6 +215,17 @@
 		status = "disabled";
 	};
 
+	sdhci: sdhci at fe330000 {
+		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
+		reg = <0x0 0xfe330000 0x0 0x10000>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
+		clock-names = "clk_xin", "clk_ahb";
+		phys = <&emmc_phy>;
+		phy-names = "phy_arasan";
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb at fe380000 {
 		compatible = "generic-ehci";
 		reg = <0x0 0xfe380000 0x0 0x20000>;
@@ -481,8 +492,18 @@
 	};
 
 	grf: syscon at ff770000 {
-		compatible = "rockchip,rk3399-grf", "syscon";
+		compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff770000 0x0 0x10000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		emmc_phy: phy at f780 {
+			compatible = "rockchip,rk3399-emmc-phy";
+			reg = <0xf780 0x20>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
 	};
 
 	watchdog at ff840000 {
-- 
2.8.0.rc3.226.g39d4020
