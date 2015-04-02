From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 02 Apr 2015 17:34:34 +0900
Subject: [PATCH 3/6] arm64: dts: exynos: Add USB3.0 Host dt node for Exynos5433
In-Reply-To: <1427963677-32661-1-git-send-email-cw00.choi@samsung.com>
References: <1427963677-32661-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1427963677-32661-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaewon Kim <jaewon02.kim@samsung.com>

This patch adds PHY and USB3.0 Host device tree node
using DWC3 chip and set USB3.0 Host related clock parent
for Exynos5433.

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 46 ++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index b460f5f..9cca236 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1006,6 +1006,52 @@
 			samsung,pmu-syscon = <&pmu_system_controller>;
 			status = "disabled";
 		};
+
+		usbhost30_phy: phy at 15580000 {
+			compatible = "samsung,exynos5433-usbdrd-phy";
+			reg = <0x15580000 0x100>;
+			clocks = <&cmu_fsys CLK_ACLK_USBHOST30>, <&xxti>,
+				<&cmu_fsys CLK_PHYCLK_USBHOST30_UHOST30_PHYCLOCK>,
+				<&cmu_fsys CLK_PHYCLK_USBHOST30_UHOST30_PIPE_PCLK>,
+				<&cmu_fsys CLK_SCLK_USBHOST30>;
+			clock-names = "phy", "ref", "phy_utmi", "phy_pipe", "itp";
+			assigned-clocks =
+				<&cmu_fsys CLK_MOUT_PHYCLK_USBHOST30_UHOST30_PIPE_PCLK_USER>,
+				<&cmu_fsys CLK_MOUT_PHYCLK_USBHOST30_UHOST30_PHYCLOCK_USER>;
+			assigned-clock-parents =
+				<&cmu_fsys CLK_PHYCLK_USBHOST30_UHOST30_PIPE_PCLK_PHY>,
+				<&cmu_fsys CLK_PHYCLK_USBHOST30_UHOST30_PHYCLOCK_PHY>;
+			#phy-cells = <1>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			status = "disabled";
+		};
+
+		usbhost30: usb at 15a00000 {
+			compatible = "samsung,exynos5250-dwusb3";
+			clocks = <&cmu_fsys CLK_ACLK_USBHOST30>,
+				<&cmu_fsys CLK_SCLK_USBHOST30>;
+			clock-names = "usbdrd30", "usbdrd30_susp_clk";
+			assigned-clocks =
+				<&cmu_fsys CLK_MOUT_SCLK_USBHOST30_USER>,
+				<&cmu_top CLK_MOUT_SCLK_USBHOST30>,
+				<&cmu_top CLK_DIV_SCLK_USBHOST30>;
+			assigned-clock-parents =
+				<&cmu_top CLK_SCLK_USBHOST30_FSYS>,
+				<&cmu_top CLK_MOUT_BUS_PLL_USER>;
+			assigned-clock-rates = <0>, <0>, <66700000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			dwc3 {
+				compatible = "snps,dwc3";
+				reg = <0x154a0000 0x10000>;
+				interrupts = <0 244 0>;
+				phys = <&usbhost30_phy 0>, <&usbhost30_phy 1>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
 	};
 
 	timer {
-- 
1.8.5.5
