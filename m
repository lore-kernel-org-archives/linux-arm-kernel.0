From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 15 Nov 2018 15:50:12 +0100
Subject: [PATCH 14/15] arm64: dts: allwinner: h5: Add Video Engine and
 reserved memory node
In-Reply-To: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181115145013.3378-15-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds nodes for the Video Engine and the associated reserved memory
for the H5. Up to 96 MiB of memory are dedicated to the CMA pool.

The pool is located at the end of the first 256 MiB of RAM so that the
VPU can access it. It is unclear whether this is still a hard
requirement for this platform, but it seems safer that way.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 4f0e2df875ba..6cc9698cab49 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -93,6 +93,20 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		cma_pool: cma at 4a000000 {
+			compatible = "shared-dma-pool";
+			size = <0x6000000>;
+			alloc-ranges = <0x4a000000 0x6000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
 	soc {
 		syscon: system-control at 1c00000 {
 			compatible = "allwinner,sun50i-h5-system-control";
@@ -116,6 +130,17 @@
 			};
 		};
 
+		video-codec at 1c0e000 {
+			compatible = "allwinner,sun50i-h5-video-engine";
+			reg = <0x01c0e000 0x1000>;
+			clocks = <&ccu CLK_BUS_VE>, <&ccu CLK_VE>,
+				 <&ccu CLK_DRAM_VE>;
+			clock-names = "ahb", "mod", "ram";
+			resets = <&ccu RST_BUS_VE>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			allwinner,sram = <&ve_sram 1>;
+		};
+
 		mali: gpu at 1e80000 {
 			compatible = "allwinner,sun50i-h5-mali", "arm,mali-450";
 			reg = <0x01e80000 0x30000>;
-- 
2.19.1
