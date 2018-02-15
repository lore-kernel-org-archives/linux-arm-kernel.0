From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 15 Feb 2018 14:05:54 +0000
Subject: [PATCH 2/2] ARM: dts: rockchip: Fix DWMMC clocks
In-Reply-To: <74be71477b800f8a7b93a9e92ffeff9bf38c52ce.1518703554.git.robin.murphy@arm.com>
References: <74be71477b800f8a7b93a9e92ffeff9bf38c52ce.1518703554.git.robin.murphy@arm.com>
Message-ID: <cccc5187b9925bb7f025326220f75f9919d562c2.1518703554.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying to boot an RK3328 box with an HS200-capable eMMC, I see said eMMC
fail to initialise as it can't run its tuning procedure, because the
sample clock is missing. Upon closer inspection, whilst the clock is
present in the DT, its name is subtly incorrect per the binding, so
__of_clk_get_by_name() never finds it. By inspection, the drive clock
suffers from a similar problem, so has never worked properly either.

This error has propagated across the 32-bit DTs too, so fix those up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 4 ++--
 arch/arm/boot/dts/rk322x.dtsi | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 3b704cfed69a..a97458112ff6 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -280,7 +280,7 @@
 		max-frequency = <37500000>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		resets = <&cru SRST_SDIO>;
@@ -298,7 +298,7 @@
 		max-frequency = <37500000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		default-sample-phase = <158>;
 		disable-wp;
 		dmas = <&pdma 12>;
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 780ec3a99b21..341deaf62ff6 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -621,7 +621,7 @@
 		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
@@ -634,7 +634,7 @@
 		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdio_clk &sdio_cmd &sdio_bus4>;
@@ -649,7 +649,7 @@
 		max-frequency = <37500000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		bus-width = <8>;
 		default-sample-phase = <158>;
 		fifo-depth = <0x100>;
-- 
2.16.1.dirty
