From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Fri, 5 May 2017 17:31:20 +0200
Subject: [PATCH v5 1/8] dt-bindings: Document STM32 DCMI bindings
In-Reply-To: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
References: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1493998287-5828-2-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the STM32 DCMI
(Digital Camera Memory Interface).

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 .../devicetree/bindings/media/st,stm32-dcmi.txt    | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmi.txt

diff --git a/Documentation/devicetree/bindings/media/st,stm32-dcmi.txt b/Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
new file mode 100644
index 0000000..f8baf65
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
@@ -0,0 +1,46 @@
+STMicroelectronics STM32 Digital Camera Memory Interface (DCMI)
+
+Required properties:
+- compatible: "st,stm32-dcmi"
+- reg: physical base address and length of the registers set for the device
+- interrupts: should contain IRQ line for the DCMI
+- resets: reference to a reset controller,
+          see Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
+- clocks: list of clock specifiers, corresponding to entries in
+          the clock-names property
+- clock-names: must contain "mclk", which is the DCMI peripherial clock
+- pinctrl: the pincontrol settings to configure muxing properly
+           for pins that connect to DCMI device.
+           See Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt.
+- dmas: phandle to DMA controller node,
+        see Documentation/devicetree/bindings/dma/stm32-dma.txt
+- dma-names: must contain "tx", which is the transmit channel from DCMI to DMA
+
+DCMI supports a single port node with parallel bus. It should contain one
+'port' child node with child 'endpoint' node. Please refer to the bindings
+defined in Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Example:
+
+	dcmi: dcmi at 50050000 {
+		compatible = "st,stm32-dcmi";
+		reg = <0x50050000 0x400>;
+		interrupts = <78>;
+		resets = <&rcc STM32F4_AHB2_RESET(DCMI)>;
+		clocks = <&rcc 0 STM32F4_AHB2_CLOCK(DCMI)>;
+		clock-names = "mclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dcmi_pins>;
+		dmas = <&dma2 1 1 0x414 0x3>;
+		dma-names = "tx";
+		port {
+			dcmi_0: endpoint {
+				remote-endpoint = <...>;
+				bus-width = <8>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				pclk-sample = <1>;
+			};
+		};
+	};
+
-- 
1.9.1
