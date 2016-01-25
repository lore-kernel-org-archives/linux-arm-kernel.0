From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 25 Jan 2016 15:33:43 +0800
Subject: [PATCH] ARM64: rk3368: add tuning clk for emmc and sdmmc
Message-ID: <1453707223-28855-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tuning clk for emmc and sdmmc, otherwise I get
the following failure while enabling mmc-hs200-1_8v.

dwmmc_rockchip ff0f0000.dwmmc: Tuning clock (sample_clk) not defined.
mmc0: tuning execution failed
mmc0: error -5 whilst initialising MMC card

With it
dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase to 170
mmc0: new HS200 MMC card at address 0001
mmcblk0: mmc0:0001 M8G1GC 7.28 GiB

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 122777b..1cf3cf7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -231,8 +231,9 @@
 		compatible = "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff0c0000 0x0 0x4000>;
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
+			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -256,6 +257,9 @@
 		clock-freq-min-max = <400000 150000000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
 		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
+			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
-- 
2.3.7
