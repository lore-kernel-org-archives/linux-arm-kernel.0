From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Mar 2017 16:52:59 +0800
Subject: [PATCH 1/3] arm64: dts: zte: add mmc devices for zx296718
In-Reply-To: <1490086381-17030-1-git-send-email-shawnguo@kernel.org>
References: <1490086381-17030-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1490086381-17030-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Nie <jun.nie@linaro.org>

Add three mmc devices for zx296718 SoC, and enable the SD and eMMMC on
zx296718-evb board.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718-evb.dts |  8 ++++
 arch/arm64/boot/dts/zte/zx296718.dtsi    | 66 ++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718-evb.dts b/arch/arm64/boot/dts/zte/zx296718-evb.dts
index e164ff6de5fc..238311b4cf0f 100644
--- a/arch/arm64/boot/dts/zte/zx296718-evb.dts
+++ b/arch/arm64/boot/dts/zte/zx296718-evb.dts
@@ -59,6 +59,14 @@
 
 };
 
+&emmc {
+	status = "okay";
+};
+
+&sd1 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 8c20d295fa86..921f3ec52a1a 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -298,6 +298,51 @@
 			status = "disabled";
 		};
 
+		sd0: mmc at 1110000 {
+			compatible = "zte,zx296718-dw-mshc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x01110000 0x1000>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			fifo-depth = <32>;
+			data-addr = <0x200>;
+			fifo-watermark-aligned;
+			bus-width = <4>;
+			clock-frequency = <50000000>;
+			clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
+			clock-names = "biu", "ciu";
+			num-slots = <1>;
+			max-frequency = <50000000>;
+			cap-sdio-irq;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
+			sd-uhs-ddr50;
+			status = "disabled";
+		};
+
+		sd1: mmc at 1111000 {
+			compatible = "zte,zx296718-dw-mshc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x01111000 0x1000>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			fifo-depth = <32>;
+			data-addr = <0x200>;
+			fifo-watermark-aligned;
+			bus-width = <4>;
+			clock-frequency = <167000000>;
+			clocks = <&topcrm SD1_AHB>, <&topcrm SD1_WCLK>;
+			clock-names = "biu", "ciu";
+			num-slots = <1>;
+			max-frequency = <167000000>;
+			cap-sdio-irq;
+			cap-sd-highspeed;
+			status = "disabled";
+		};
+
 		dma: dma-controller at 1460000 {
 			compatible = "zte,zx296702-dma";
 			reg = <0x01460000 0x1000>;
@@ -332,6 +377,27 @@
 			reg = <0x1463000 0x1000>;
 		};
 
+		emmc: mmc at 1470000{
+			compatible = "zte,zx296718-dw-mshc";
+			reg = <0x01470000 0x1000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			zte,aon-syscon = <&aon_sysctrl>;
+			bus-width = <8>;
+			fifo-depth = <128>;
+			data-addr = <0x200>;
+			fifo-watermark-aligned;
+			clock-frequency = <167000000>;
+			clocks = <&topcrm EMMC_NAND_AHB>, <&topcrm EMMC_WCLK>;
+			clock-names = "biu", "ciu";
+			max-frequency = <167000000>;
+			cap-mmc-highspeed;
+			mmc-ddr-1_8v;
+			mmc-hs200-1_8v;
+			non-removable;
+			disable-wp;
+			status = "disabled";
+		};
+
 		audiocrm: clock-controller at 1480000 {
 			compatible = "zte,zx296718-audiocrm";
 			reg = <0x01480000 0x1000>;
-- 
1.9.1
