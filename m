From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Thu, 28 Sep 2017 17:36:40 +0200
Subject: [PATCH v5 1/4] dt-bindings: Document the STM32 MDMA bindings
In-Reply-To: <1506613003-28376-1-git-send-email-pierre-yves.mordret@st.com>
References: <1506613003-28376-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1506613003-28376-2-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the STM32 MDMA
controller.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
  Version history:
     v5:
     v4:
     v3:
         * None
     v2:
         * change compatible into st,stm32h7-mdma to be more SoC specific
---
---
 .../devicetree/bindings/dma/stm32-mdma.txt         | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-mdma.txt

diff --git a/Documentation/devicetree/bindings/dma/stm32-mdma.txt b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
new file mode 100644
index 0000000..d18772d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
@@ -0,0 +1,94 @@
+* STMicroelectronics STM32 MDMA controller
+
+The STM32 MDMA is a general-purpose direct memory access controller capable of
+supporting 64 independent DMA channels with 256 HW requests.
+
+Required properties:
+- compatible: Should be "st,stm32h7-mdma"
+- reg: Should contain MDMA registers location and length. This should include
+  all of the per-channel registers.
+- interrupts: Should contain the MDMA interrupt.
+- clocks: Should contain the input clock of the DMA instance.
+- resets: Reference to a reset controller asserting the DMA controller.
+- #dma-cells : Must be <5>. See DMA client paragraph for more details.
+
+Optional properties:
+- dma-channels: Number of DMA channels supported by the controller.
+- dma-requests: Number of DMA request signals supported by the controller.
+- st,ahb-addr-masks: Array of u32 mask to list memory devices addressed via
+  AHB bus.
+
+Example:
+
+	mdma1: dma at 52000000 {
+		compatible = "st,stm32h7-mdma";
+		reg = <0x52000000 0x1000>;
+		interrupts = <122>;
+		clocks = <&timer_clk>;
+		resets = <&rcc 992>;
+		#dma-cells = <5>;
+		dma-channels = <16>;
+		dma-requests = <32>;
+		st,ahb-addr-masks = <0x20000000>, <0x00000000>;
+	};
+
+* DMA client
+
+DMA clients connected to the STM32 MDMA controller must use the format
+described in the dma.txt file, using a five-cell specifier for each channel:
+a phandle to the MDMA controller plus the following five integer cells:
+
+1. The request line number
+2. The priority level
+	0x00: Low
+	0x01: Medium
+	0x10: High
+	0x11: Very high
+3. A 32bit mask specifying the DMA channel configuration
+ -bit 0-1: Source increment mode
+	0x00: Source address pointer is fixed
+	0x10: Source address pointer is incremented after each data transfer
+	0x11: Source address pointer is decremented after each data transfer
+ -bit 2-3: Destination increment mode
+	0x00: Destination address pointer is fixed
+	0x10: Destination address pointer is incremented after each data
+	transfer
+	0x11: Destination address pointer is decremented after each data
+	transfer
+ -bit 8-9: Source increment offset size
+	0x00: byte (8bit)
+	0x01: half-word (16bit)
+	0x10: word (32bit)
+	0x11: double-word (64bit)
+ -bit 10-11: Destination increment offset size
+	0x00: byte (8bit)
+	0x01: half-word (16bit)
+	0x10: word (32bit)
+	0x11: double-word (64bit)
+-bit 25-18: The number of bytes to be transferred in a single transfer
+	(min = 1 byte, max = 128 bytes)
+-bit 29:28: Trigger Mode
+	0x00: Each MDMA request triggers a buffer transfer (max 128 bytes)
+	0x01: Each MDMA request triggers a block transfer (max 64K bytes)
+	0x10: Each MDMA request triggers a repeated block transfer
+	0x11: Each MDMA request triggers a linked list transfer
+4. A 32bit value specifying the register to be used to acknowledge the request
+   if no HW ack signal is used by the MDMA client
+5. A 32bit mask specifying the value to be written to acknowledge the request
+   if no HW ack signal is used by the MDMA client
+
+Example:
+
+	i2c4: i2c at 5c002000 {
+		compatible = "st,stm32f7-i2c";
+		reg = <0x5c002000 0x400>;
+		interrupts = <95>,
+			     <96>;
+		clocks = <&timer_clk>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dmas = <&mdma1 36 0x0 0x40008 0x0 0x0>,
+		       <&mdma1 37 0x0 0x40002 0x0 0x0>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
-- 
2.7.4
