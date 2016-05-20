From: yt.shen@mediatek.com (yt.shen at mediatek.com)
Date: Fri, 20 May 2016 23:05:36 +0800
Subject: [RFC v2 5/5] arm: dts: mt2701: Add display subsystem related nodes
 for MT2701
In-Reply-To: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
References: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1463756736-46573-6-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YT Shen <yt.shen@mediatek.com>

This patch adds the device nodes for the DISP function blocks for MT2701

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi |  117 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 363de0d..0beef2a 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -24,6 +24,13 @@
 	compatible = "mediatek,mt2701";
 	interrupt-parent = <&sysirq>;
 
+	aliases {
+		rdma0 = &rdma0;
+		rdma1 = &rdma1;
+		dpi0 = &dpi0;
+		dpi1 = &dpi1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -171,6 +178,14 @@
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
 	};
 
+	mipi_tx0: mipi-dphy at 10010000 {
+		compatible = "mediatek,mt2701-mipi-tx";
+		reg = <0 0x10010000 0 0x90>;
+		clocks = <&clk26m>;
+		clock-output-names = "mipi_tx0_pll";
+		status = "disabled";
+	};
+
 	sysirq: interrupt-controller at 10200100 {
 		compatible = "mediatek,mt2701-sysirq",
 			     "mediatek,mt6577-sysirq";
@@ -255,6 +270,79 @@
 		status = "disabled";
 	};
 
+	ovl at 14007000 {
+		compatible = "mediatek,mt2701-disp-ovl";
+		reg = <0 0x14007000 0 0x1000>;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_OVL>;
+		iommus = <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
+		mediatek,larb = <&larb0>;
+	};
+
+	rdma0: rdma at 14008000 {
+		compatible = "mediatek,mt2701-disp-rdma";
+		reg = <0 0x14008000 0 0x1000>;
+		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_RDMA>;
+		iommus = <&iommu MT2701_M4U_PORT_DISP_RDMA>;
+		mediatek,larb = <&larb0>;
+	};
+
+	wdma at 14009000 {
+		compatible = "mediatek,mt2701-disp-wdma";
+		reg = <0 0x14009000 0 0x1000>;
+		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_WDMA>;
+		iommus = <&iommu MT2701_M4U_PORT_DISP_WDMA>;
+		mediatek,larb = <&larb0>;
+	};
+
+	bls at 1400a000 {
+		compatible = "mediatek,mt2701-disp-bls";
+		reg = <0 0x1400a000 0 0x1000>;
+		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_BLS>;
+	};
+
+	color at 1400b000 {
+		compatible = "mediatek,mt2701-disp-color";
+		reg = <0 0x1400b000 0 0x1000>;
+		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_COLOR>;
+	};
+
+	dsi0: dsi at 1400c000 {
+		compatible = "mediatek,mt2701-dsi";
+		reg = <0 0x1400c000 0 0x1000>;
+		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DSI_ENGINE>, <&mmsys CLK_MM_DSI_DIG>,
+			 <&mipi_tx0>;
+		clock-names = "engine", "digital", "hs";
+		phys = <&mipi_tx0>;
+		phy-names = "dphy";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	dpi0: dpi at 1400d000 {
+		compatible = "mediatek,mt2701-dpi";
+		reg = <0 0x1400d000 0 0x1000>;
+		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DPI_DIGL>,
+			 <&mmsys CLK_MM_DPI_ENGINE>;
+		clock-names = "clk_dpi_digl",
+			      "clk_dpi_engine";
+		status = "disabled";
+	};
+
+	mutex: mutex at 1400e000 {
+		compatible = "mediatek,mt2701-disp-mutex";
+		reg = <0 0x1400e000 0 0x1000>;
+		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_MUTEX_32K>;
+	};
+
 	larb0: larb at 14010000 {
 		compatible = "mediatek,mt2701-smi-larb";
 		reg = <0 0x14010000 0 0x1000>;
@@ -265,6 +353,35 @@
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
 	};
 
+	rdma1: rdma at 14012000 {
+		compatible = "mediatek,mt2701-disp-rdma";
+		reg = <0 0x14012000 0 0x1000>;
+		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_RDMA1>;
+		iommus = <&iommu MT2701_M4U_PORT_DISP_RDMA1>;
+		mediatek,larb = <&larb0>;
+	};
+
+	ufoe at 14013000 {
+		compatible = "mediatek,mt2701-disp-ufoe";
+		reg = <0 0x14013000 0 0x1000>;
+		clocks = <&mmsys CLK_MM_DISP_UFOE>;
+	};
+
+	dpi1: dpi at 14014000 {
+		compatible = "mediatek,mt2701-dpi";
+		reg = <0 0x14014000 0 0x1000>;
+		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DPI1_DIGL>,
+			 <&mmsys CLK_MM_DPI1_ENGINE>,
+			 <&topckgen CLK_TOP_DPI1_SEL>,
+			 <&topckgen CLK_TOP_TVDPLL>,
+			 <&topckgen CLK_TOP_TVDPLL_D2>,
+			 <&topckgen CLK_TOP_TVDPLL_D4>;
+		clock-names = "pixel", "engine", "sel","div1","div2","div4";
+		status = "disabled";
+	};
+
 	imgsys: syscon at 15000000 {
 		compatible = "mediatek,mt2701-imgsys", "syscon";
 		reg = <0 0x15000000 0 0x1000>;
-- 
1.7.9.5
