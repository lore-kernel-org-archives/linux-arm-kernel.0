From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 05 Mar 2015 14:38:25 +0900
Subject: [PATCH v5 3/9] arm64: dts: exynos: Add SPI/PDMA dt node for Exynos5433
In-Reply-To: <1425533911-14800-1-git-send-email-cw00.choi@samsung.com>
References: <1425533911-14800-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1425533911-14800-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SPI (Serial Peripheral Interface) dt node for Exynos5433 SoC.
SPI transfers serial data by using various peripherals. SPI includes
8-bit/16-bit/32-bit shift registers to transmit and receive data. PDMA is used
for SPI communication.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 114 +++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 9b96bdf..710566a 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -399,6 +399,35 @@
 			interrupts = <1 9 0xf04>;
 		};
 
+		amba {
+			compatible = "arm,amba-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pdma0: pdma at 15610000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0x15610000 0x1000>;
+				interrupts = <0 228 0>;
+				clocks = <&cmu_fsys CLK_PDMA0>;
+				clock-names = "apb_pclk";
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
+
+			pdma1: pdma at 15600000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0x15600000 0x1000>;
+				interrupts = <0 246 0>;
+				clocks = <&cmu_fsys CLK_PDMA1>;
+				clock-names = "apb_pclk";
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
+		};
+
 		serial_0: serial at 14c10000 {
 			compatible = "samsung,exynos5433-uart";
 			reg = <0x14c10000 0x100>;
@@ -499,6 +528,91 @@
 			interrupts = <0 442 0>;
 		};
 
+		spi_0: spi at 14d20000 {
+			compatible = "samsung,exynos7-spi";
+			reg = <0x14d20000 0x100>;
+			interrupts = <0 432 0>;
+			dmas = <&pdma0 9>, <&pdma0 8>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric CLK_PCLK_SPI0>,
+				 <&cmu_top CLK_SCLK_SPI0_PERIC>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_bus>;
+			status = "disabled";
+		};
+
+		spi_1: spi at 14d30000 {
+			compatible = "samsung,exynos7-spi";
+			reg = <0x14d30000 0x100>;
+			interrupts = <0 433 0>;
+			dmas = <&pdma0 11>, <&pdma0 10>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric CLK_PCLK_SPI1>,
+				 <&cmu_top CLK_SCLK_SPI1_PERIC>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_bus>;
+			status = "disabled";
+		};
+
+		spi_2: spi at 14d40000 {
+			compatible = "samsung,exynos7-spi";
+			reg = <0x14d40000 0x100>;
+			interrupts = <0 434 0>;
+			dmas = <&pdma0 13>, <&pdma0 12>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric CLK_PCLK_SPI2>,
+				 <&cmu_top CLK_SCLK_SPI2_PERIC>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi2_bus>;
+			status = "disabled";
+		};
+
+		spi_3: spi at 14d50000 {
+			compatible = "samsung,exynos7-spi";
+			reg = <0x14d50000 0x100>;
+			interrupts = <0 447 0>;
+			dmas = <&pdma0 23>, <&pdma0 22>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric CLK_PCLK_SPI3>,
+				 <&cmu_top CLK_SCLK_SPI3_PERIC>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi3_bus>;
+			status = "disabled";
+		};
+
+		spi_4: spi at 14d00000 {
+			compatible = "samsung,exynos7-spi";
+			reg = <0x14d00000 0x100>;
+			interrupts = <0 412 0>;
+			dmas = <&pdma0 25>, <&pdma0 24>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric CLK_PCLK_SPI4>,
+				 <&cmu_top CLK_SCLK_SPI4_PERIC>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi4_bus>;
+			status = "disabled";
+		};
+
 		hsi2c_0: hsi2c at 14e40000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x14e40000 0x1000>;
-- 
1.8.5.5
