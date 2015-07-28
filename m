From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:04:02 +0000
Subject: [PATCH 08/10] ARM: dts: atlas7: add software digital radio nodes and
 its DMA channels
In-Reply-To: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
References: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438074244-18708-9-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yonghui Zhang <yonghui.zhang@csr.com>

this patch adds SDR(software digital raio) nodes and the DMA channels
for it.

Signed-off-by: Yonghui Zhang <yonghui.zhang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 456cf81..de38bc98 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1370,11 +1370,42 @@
 			compatible = "arteris, flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x13000000 0x13000000 0x3000>;
+			ranges = <0x13000000 0x13000000 0x3000>,
+				<0x13010000 0x13010000 0x1400>,
+				<0x13010800 0x13010800 0x100>,
+				<0x13011000 0x13011000 0x100>;
 			gpum at 0x13000000 {
 				compatible = "sirf,nocfw-gpum";
 				reg = <0x13000000 0x3000>;
 			};
+			dmacsdrr: dma-controller at 13010800 {
+				cell-index = <5>;
+				compatible = "sirf,atlas7-dmac-v2";
+				reg = <0x13010800 0x100>;
+				interrupts = <0 8 0>;
+				clocks = <&car 127>;
+				#dma-cells = <1>;
+				#dma-channels = <1>;
+			};
+			dmacsdrw: dma-controller at 13011000 {
+				cell-index = <6>;
+				compatible = "sirf,atlas7-dmac-v2";
+				reg = <0x13011000 0x100>;
+				interrupts = <0 9 0>;
+				clocks = <&car 127>;
+				#dma-cells = <1>;
+				#dma-channels = <1>;
+			};
+			sdr at 0x13010000 {
+				compatible = "sirf,atlas7-sdr";
+				reg = <0x13010000 0x1400>;
+				interrupts = <0 7 0>,
+					   <0 8 0>,
+					   <0 9 0>;
+				clocks = <&car 127>;
+				dmas = <&dmacsdrr 0>, <&dmacsdrw 0>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		mediam {
-- 
1.9.1
