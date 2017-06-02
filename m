From: anup.patel@broadcom.com (Anup Patel)
Date: Fri,  2 Jun 2017 12:04:34 +0530
Subject: [PATCH v6 10/11] arm64: dts: Add PL022,
 PL330 and SP805 DT nodes for Stingray
In-Reply-To: <1496385275-6899-1-git-send-email-anup.patel@broadcom.com>
References: <1496385275-6899-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1496385275-6899-11-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have two instance of PL022 SPI controllers, one instance of
DMA PL330, and one non-secure SP805 Watchdog on Stingray SOC.

This patch adds DT nodes for the above mentioned devices in
Stingray DT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Pramod KUMAR <pramod.kumar@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../boot/dts/broadcom/stingray/bcm958742k.dts      | 30 +++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 52 ++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
index c309cda..5671669 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
@@ -46,3 +46,33 @@
 &uart3 {
 	status = "okay";
 };
+
+&ssp0 {
+	pinctrl-0 = <&spi0_pins>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpio_hsls 34 0>;
+	status = "okay";
+
+	spi-flash at 0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
+&ssp1 {
+	pinctrl-0 = <&spi1_pins>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpio_hsls 96 0>;
+	status = "okay";
+
+	spi-flash at 0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 91ba61e..88a6176 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -279,6 +279,14 @@
 			status = "disabled";
 		};
 
+		wdt0: watchdog at 000c0000 {
+			compatible = "arm,sp805", "arm,primecell";
+			reg = <0x000c0000 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_25m_div2_clk>, <&hsls_div4_clk>;
+			clock-names = "wdogclk", "apb_pclk";
+		};
+
 		gpio_hsls: gpio at 000d0000 {
 			compatible = "brcm,iproc-gpio";
 			reg = <0x000d0000 0x864>;
@@ -359,11 +367,55 @@
 			status = "disabled";
 		};
 
+		ssp0: ssp at 00180000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x00180000 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_div2_clk>, <&hsls_div2_clk>;
+			clock-names = "spiclk", "apb_pclk";
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		ssp1: ssp at 00190000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x00190000 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsls_div2_clk>, <&hsls_div2_clk>;
+			clock-names = "spiclk", "apb_pclk";
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		hwrng: hwrng at 00220000 {
 			compatible = "brcm,iproc-rng200";
 			reg = <0x00220000 0x28>;
 		};
 
+		dma0: dma at 00310000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x00310000 0x1000>;
+			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&hsls_div2_clk>;
+			clock-names = "apb_pclk";
+			iommus = <&smmu 0x6000 0x0000>;
+		};
+
 		nand: nand at 00360000 {
 			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x00360000 0x600>,
-- 
2.7.4
