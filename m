From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 15 Feb 2018 14:05:53 +0000
Subject: [PATCH 1/2] arm64: dts: rockchip: Fix DWMMC clocks
Message-ID: <74be71477b800f8a7b93a9e92ffeff9bf38c52ce.1518703554.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying to boot an RK3328 box with an HS200-capable eMMC, I see said eMMC
fail to initialise as it can't run its tuning procedure, because the
sample clock is missing. Upon closer inspection, whilst the clock is
present in the DT, its name is subtly incorrect per the binding, so
__of_clk_get_by_name() never finds it. By inspection, the drive clock
suffers from a similar problem, so has never worked properly either.

Fix up all instances of the incorrect clock names across the 64-bit DTs.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 822488bdf364..be2bfbc6b483 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -730,7 +730,7 @@
 		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		status = "disabled";
 	};
@@ -741,7 +741,7 @@
 		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		status = "disabled";
 	};
@@ -752,7 +752,7 @@
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index aa4d07046a7b..03458ac44201 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -257,7 +257,7 @@
 		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>,
 			 <&cru SCLK_SDIO0_DRV>, <&cru SCLK_SDIO0_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		resets = <&cru SRST_SDIO0>;
-- 
2.16.1.dirty
