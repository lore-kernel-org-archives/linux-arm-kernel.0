From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Mon, 25 Apr 2016 20:30:33 +0800
Subject: [PATCH v8 3/8] arm64: dts: mediatek: Add node for Mediatek Video
 Processor Unit
In-Reply-To: <1461587438-59886-3-git-send-email-tiffany.lin@mediatek.com>
References: <1461587438-59886-1-git-send-email-tiffany.lin@mediatek.com>
 <1461587438-59886-2-git-send-email-tiffany.lin@mediatek.com>
 <1461587438-59886-3-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1461587438-59886-4-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew-CT Chen <andrew-ct.chen@mediatek.com>

Add VPU drivers for MT8173

Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>

---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index eab7efc..ae147bb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -125,6 +125,18 @@
 		clock-output-names = "cpum_ck";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		vpu_dma_reserved: vpu_dma_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0 0xb7000000 0 0x500000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
@@ -269,6 +281,17 @@
 			clock-names = "spi", "wrap";
 		};
 
+		vpu: vpu at 10020000 {
+			compatible = "mediatek,mt8173-vpu";
+			reg = <0 0x10020000 0 0x30000>,
+			      <0 0x10050000 0 0x100>;
+			reg-names = "tcm", "cfg_reg";
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_SCP_SEL>;
+			clock-names = "main";
+			memory-region = <&vpu_dma_reserved>;
+		};
+
 		sysirq: intpol-controller at 10200620 {
 			compatible = "mediatek,mt8173-sysirq",
 				     "mediatek,mt6577-sysirq";
-- 
1.7.9.5
