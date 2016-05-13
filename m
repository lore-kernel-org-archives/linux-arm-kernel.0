From: briannorris@chromium.org (Brian Norris)
Date: Fri, 13 May 2016 15:12:03 -0700
Subject: [PATCH v4 2/3] ARM64: dts: rockchip: add sdhci/emmc for rk3399
In-Reply-To: <1463177524-113856-1-git-send-email-briannorris@chromium.org>
References: <1463177524-113856-1-git-send-email-briannorris@chromium.org>
Message-ID: <1463177524-113856-2-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description for the SDHCI v5.1 eMMC controller on rk3399. Fix it to
200 MHz, to support all supported timing modes.

Note that 'rockchip,rk3399-sdhci-5.1' is not documented; we presumably
have a compliant Arasan controller, but let's have a rockchip property
as the canonical backup/precautionary measure. Per Heiko's previous
suggestion, let's not clutter the arasan doc with it.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v4:

 * split "simple-mfd" out into patch 1

v3:

 * correct emmc_phy reg length to 0x24

v2:

 * improved commit message
 * assign eMMC clock to 200 MHz

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e1c3667a9bea..99078f5ebeb9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -215,6 +215,19 @@
 		status = "disabled";
 	};
 
+	sdhci: sdhci at fe330000 {
+		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
+		reg = <0x0 0xfe330000 0x0 0x10000>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
+		clock-names = "clk_xin", "clk_ahb";
+		assigned-clocks = <&cru SCLK_EMMC>;
+		assigned-clock-rates = <200000000>;
+		phys = <&emmc_phy>;
+		phy-names = "phy_arasan";
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb at fe380000 {
 		compatible = "generic-ehci";
 		reg = <0x0 0xfe380000 0x0 0x20000>;
@@ -486,6 +499,13 @@
 
 		#address-cells = <1>;
 		#size-cells = <1>;
+
+		emmc_phy: phy at f780 {
+			compatible = "rockchip,rk3399-emmc-phy";
+			reg = <0xf780 0x24>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
 	};
 
 	watchdog at ff840000 {
-- 
2.8.0.rc3.226.g39d4020
