From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Thu, 21 Sep 2017 17:29:18 +0200
Subject: [PATCH v5 1/4] dt-bindings: Document the STM32 DMAMUX bindings
In-Reply-To: <1506007761-11621-1-git-send-email-pierre-yves.mordret@st.com>
References: <1506007761-11621-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1506007761-11621-2-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the documentation of device tree bindings for the STM32
DMAMUX.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 Version history:
    v5:
    v4:
        * Add multi-master ability for STM32 DMAMUX
        * Get rid of st,dmamux properties
    v3:
        * Change compatible to st,stm32h7-dmamux to be mode Soc specific
        * Add verbosity in dma-cells
    v2:
        * Move clock bindings from optional to mandatory one
        * Drop channelID bindings as managed dynamically from now on by
          DMAMUX driver.
---
---
 .../devicetree/bindings/dma/stm32-dmamux.txt       | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt

diff --git a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
new file mode 100644
index 0000000..1b893b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
@@ -0,0 +1,84 @@
+STM32 DMA MUX (DMA request router)
+
+Required properties:
+- compatible:	"st,stm32h7-dmamux"
+- reg:		Memory map for accessing module
+- #dma-cells:	Should be set to <3>.
+		First parameter is request line number.
+		Second is DMA channel configuration
+		Third is Fifo threshold
+		For more details about the three cells, please see
+		stm32-dma.txt documentation binding file
+- dma-masters:	Phandle pointing to the DMA controllers.
+		Several controllers are allowed. Only "st,stm32-dma" DMA
+		compatible are supported.
+
+Optional properties:
+- dma-channels : Number of DMA requests supported.
+- dma-requests : Number of DMAMUX requests supported.
+- resets: Reference to a reset controller asserting the DMA controller
+- clocks: Input clock of the DMAMUX instance.
+
+Example:
+
+/* DMA controller 1 */
+dma1: dma-controller at 40020000 {
+	compatible = "st,stm32-dma";
+	reg = <0x40020000 0x400>;
+	interrupts = <11>,
+		     <12>,
+		     <13>,
+		     <14>,
+		     <15>,
+		     <16>,
+		     <17>,
+		     <47>;
+	clocks = <&timer_clk>;
+	#dma-cells = <4>;
+	st,mem2mem;
+	resets = <&rcc 150>;
+	dma-channels = <8>;
+	dma-requests = <8>;
+};
+
+/* DMA controller 1 */
+dma2: dma at 40020400 {
+	compatible = "st,stm32-dma";
+	reg = <0x40020400 0x400>;
+	interrupts = <56>,
+		     <57>,
+		     <58>,
+		     <59>,
+		     <60>,
+		     <68>,
+		     <69>,
+		     <70>;
+	clocks = <&timer_clk>;
+	#dma-cells = <4>;
+	st,mem2mem;
+	resets = <&rcc 150>;
+	dma-channels = <8>;
+	dma-requests = <8>;
+};
+
+/* DMA mux */
+dmamux1: dma-router at 40020800 {
+	compatible = "st,stm32h7-dmamux";
+	reg = <0x40020800 0x3c>;
+	#dma-cells = <3>;
+	dma-requests = <128>;
+	dma-channels = <16>;
+	dma-masters = <&dma1 &dma2>;
+	clocks = <&timer_clk>;
+};
+
+/* DMA client */
+usart1: serial at 40011000 {
+	compatible = "st,stm32-usart", "st,stm32-uart";
+	reg = <0x40011000 0x400>;
+	interrupts = <37>;
+	clocks = <&timer_clk>;
+	dmas = <&dmamux1 41 0x414 0>,
+	       <&dmamux1 42 0x414 0>;
+	dma-names = "rx", "tx";
+};
-- 
2.7.4
