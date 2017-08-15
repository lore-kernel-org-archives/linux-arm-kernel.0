From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 15 Aug 2017 10:26:01 -0700
Subject: [PATCH 4/6] ARM: dts: cygnus: Add additional peripherals to dtsi
In-Reply-To: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
References: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1502817964-8221-5-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Richardson <jonathan.richardson@broadcom.com>

Add nodes for peripherals in Cygnus dtsi: sdhci, keypad, spi, dma,
pinmux configs.

Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 102 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index bc08987..306b04c 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -124,6 +124,21 @@
 			compatible = "brcm,cygnus-pinmux";
 			reg = <0x0301d0c8 0x30>,
 			      <0x0301d24c 0x2c>;
+
+			spi_0: spi_0 {
+				function = "spi0";
+				groups = "spi0_grp";
+			};
+
+			spi_1: spi_1 {
+				function = "spi1";
+				groups = "spi1_grp";
+			};
+
+			spi_2: spi_2 {
+				function = "spi2";
+				groups = "spi2_grp";
+			};
 		};
 
 		mailbox: mailbox at 03024024 {
@@ -305,6 +320,23 @@
 			};
 		};
 
+		dma0: dma at 18018000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x18018000 0x1000>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb_clk>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+		};
+
 		uart0: serial at 18020000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x18020000 0x100>;
@@ -349,6 +381,52 @@
 			status = "disabled";
 		};
 
+		spi0: spi at 18028000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x18028000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&spi_0>;
+			clocks = <&axi81_clk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		spi1: spi at 18029000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x18029000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&spi_1>;
+			clocks = <&axi81_clk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		spi2: spi at 1802a000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x1802a000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&spi_2>;
+			clocks = <&axi81_clk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		sdhci0: sdhci at 18041000 {
+			compatible = "brcm,sdhci-iproc-cygnus";
+			reg = <0x18041000 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&lcpll0 BCM_CYGNUS_LCPLL0_SDIO_CLK>;
+			bus-width = <4>;
+			sdhci,auto-cmd12;
+			status = "disabled";
+		};
+
 		eth0: ethernet at 18042000 {
 			compatible = "brcm,amac";
 			reg = <0x18042000 0x1000>,
@@ -358,6 +436,16 @@
 			status = "disabled";
 		};
 
+		sdhci1: sdhci at 18043000 {
+			compatible = "brcm,sdhci-iproc-cygnus";
+			reg = <0x18043000 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&lcpll0 BCM_CYGNUS_LCPLL0_SDIO_CLK>;
+			bus-width = <4>;
+			sdhci,auto-cmd12;
+			status = "disabled";
+		};
+
 		nand: nand at 18046000 {
 			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x18046000 0x600>, <0xf8105408 0x600>,
@@ -472,5 +560,19 @@
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
+
+		keypad: keypad at 180ac000 {
+			compatible = "brcm,bcm-keypad";
+			reg = <0x180ac000 0x14c>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&asiu_clks BCM_CYGNUS_ASIU_KEYPAD_CLK>;
+			clock-names = "peri_clk";
+			clock-frequency = <31250>;
+			pull-up-enabled;
+			col-debounce-filter-period = <0>;
+			status-debounce-filter-period = <0>;
+			row-output-enabled;
+			status = "disabled";
+		};
 	};
 };
-- 
2.5.0
