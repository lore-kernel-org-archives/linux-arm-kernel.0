From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  8 Jul 2015 17:11:23 +0100
Subject: [PATCH 2/7] dmaengine: st_fdma: Add STMicroelectronics FDMA xbar DT
 binding documentation
In-Reply-To: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1436371888-27863-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DT binding documentation for the FDMA xbar hw
found on STi based chipsets from STMicroelectronics.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/dma/st_fdma.txt | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/st_fdma.txt b/Documentation/devicetree/bindings/dma/st_fdma.txt
index 1ec7470..655ee57 100644
--- a/Documentation/devicetree/bindings/dma/st_fdma.txt
+++ b/Documentation/devicetree/bindings/dma/st_fdma.txt
@@ -3,6 +3,24 @@
 The FDMA is a general-purpose direct memory access controller capable of
 supporting 16 independent DMA channels. It accepts up to 32 DMA requests.
 The FDMA is based on a Slim processor which require a firmware.
+To increase the number of peripheral request, the FDMA crossbar can mutiplex
+up to 96 peripheral requests to one of 3 fdma controlers engine.
+
+* FDMA crossbar
+
+Required properties:
+- compatible		: Should be "st,fdma-xbar-1.0"
+- reg			: Should contain XBAR registers location and length
+- dma-requests		: Should contain the number of peripheral request supported
+- #st,fdma-xbar-cells	: Must be <1>
+
+Example:
+	xbar0: fdma-xbar-mpe at 0 {
+		compatible = "st,fdma-xbar-1.0";
+		reg = <0x8e80000 0x1000>;
+		dma-requests = <79>;
+		#st,fdma-xbar-cells = <1>;
+	};
 
 * FDMA Controller
 
@@ -18,6 +36,11 @@ Required properties:
 See: Documentation/devicetree/bindings/clock/clock-bindings.txt
 
 
+Optional properties:
+- st,fdma-xbar	: Allow to plug controller behind the crossbar at offset X
+  1. A phandle pointing to the FDMA crossbar
+  2. Output offset <2..0>
+
 Example:
 
 	fdma1: fdma-app at 1 {
@@ -26,6 +49,7 @@ Example:
 		interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>;
 		dma-channels = <16>;
 		#dma-cells = <3>;
+		st,fdma-xbar = <&xbar0 0>;
 		st,fw-name = "fdma_STiH407_1.elf";
 		clocks = <&CLK_S_C0_FLEXGEN CLK_FDMA>,
 			 <&CLK_S_C0_FLEXGEN CLK_TX_ICN_DMU>,
-- 
1.9.1
