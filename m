From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 11 Sep 2015 15:14:23 +0100
Subject: [PATCH v2 1/9] dmaengine: st_fdma: Add STMicroelectronics FDMA DT
 binding documentation
In-Reply-To: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1441980871-24475-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DT binding documentation for the FDMA constroller
found on STi based chipsets from STMicroelectronics.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/dma/st_fdma.txt | 78 +++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/st_fdma.txt

diff --git a/Documentation/devicetree/bindings/dma/st_fdma.txt b/Documentation/devicetree/bindings/dma/st_fdma.txt
new file mode 100644
index 0000000..c24b8d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/st_fdma.txt
@@ -0,0 +1,78 @@
+* STMicroelectronics Flexible Direct Memory Access Device Tree bindings
+
+The FDMA is a general-purpose direct memory access controller capable of
+supporting 16 independent DMA channels. It accepts up to 32 DMA requests.
+The FDMA is based on a Slim processor which require a firmware.
+
+* FDMA Controller
+
+Required properties:
+- compatible	: Should be "st,stih407-fdma-mpe31"
+- reg		: Should contain DMA registers location and length
+- interrupts	: Should contain one interrupt shared by all channels
+- dma-channels	: Number of channels supported by the controller
+- #dma-cells	: Must be <3>. See DMA client section below
+- st,fdma-id	: Must contain fdma controller number
+- clocks	: Must contain an entry for each name in clock-names
+- clock-names	: Must contain "fdma_slim, fdma_hi, fdma_low, fdma_ic" entries
+See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+
+Example:
+
+	fdma1: fdma-app at 8e40000 {
+		compatible = "st,stih407-fdma-mpe31";
+		reg = <0x8e40000 0x20000>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>;
+		dma-channels = <16>;
+		#dma-cells = <3>;
+		st,fdma-id = <0>;
+		clocks = <&CLK_S_C0_FLEXGEN CLK_FDMA>,
+			 <&CLK_S_C0_FLEXGEN CLK_TX_ICN_DMU>,
+			 <&CLK_S_C0_FLEXGEN CLK_TX_ICN_DMU>,
+			 <&CLK_S_C0_FLEXGEN CLK_EXT2F_A9>;
+		clock-names = "fdma_slim",
+			      "fdma_hi",
+			      "fdma_low",
+			      "fdma_ic";
+		};
+
+* DMA client
+
+Required properties:
+- dmas: Comma separated list of dma channel requests
+- dma-names: Names of the aforementioned requested channels
+
+Each dmas request consists of 4 cells:
+1. A phandle pointing to the FDMA controller
+2. The request line number
+3. A 32bit mask specifying (see include/linux/platform_data/dma-st-fdma.h)
+ -bit 2-0: Holdoff value, dreq will be masked for
+	0x0: 0-0.5us
+	0x1: 0.5-1us
+	0x2: 1-1.5us
+ -bit 17: data swap
+	0x0: disabled
+	0x1: enabled
+ -bit 21: Increment Address
+	0x0: no address increment between transfers
+	0x1: increment address between transfers
+ -bit 22: 2 STBus Initiator Coprocessor interface
+	0x0: high priority port
+	0x1: low priority port
+4. transfers type
+ 0 free running
+ 1 paced
+
+Example:
+
+	snd_uni_player2: snd-uni-player at 2 {
+		compatible = "st,snd_uni_player";
+		status = "okay";
+		reg = <0x8D82000  0x158>;
+		interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+		version = <5>;
+		dmas = <&fdma0 4 0 1>;
+		dma-names = "tx";
+		description = "Uni Player #2 (DAC)";
+	};
-- 
1.9.1
