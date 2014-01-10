From: agross@codeaurora.org (Andy Gross)
Date: Fri, 10 Jan 2014 13:07:54 -0600
Subject: [PATCH v2 2/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <1389380874-22753-1-git-send-email-agross@codeaurora.org>
References: <1389380874-22753-1-git-send-email-agross@codeaurora.org>
Message-ID: <1389380874-22753-3-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding support for the QCOM BAM DMA driver.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../devicetree/bindings/dma/qcom_bam_dma.txt       | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
new file mode 100644
index 0000000..6a48188
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
@@ -0,0 +1,52 @@
+QCOM BAM DMA controller
+
+Required properties:
+- compatible:	Must be "qcom,bam-v1.4.0" for MSM8974 V1
+		Must be "qcom,bam-v1.4.1" for MSM8974 V2
+- reg: Address range for DMA registers
+- interrupts: single interrupt for this controller
+- #dma-cells: must be <3>
+- clocks: required clock
+- clock-names: name of clock
+
+Example:
+
+	uart-bam: dma at f9984000 = {
+		compatible = "qcom,bam-v1.4.1";
+		reg = <0xf9984000 0x15000>;
+		interrupts = <0 94 0>;
+		clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
+		clock-names = "bam_clk";
+		#dma-cells = <3>;
+	};
+
+Client:
+Required properties:
+- dmas: List of dma channel requests
+- dma-names: Names of aforementioned requested channels
+
+Clients must use the format described in the dma.txt file, using a four cell
+specifier for each channel.
+
+The four cells in order are:
+  1. A phandle pointing to the DMA controller
+  2. The channel number
+  3. The execution environment value for this channel.  This is used to indicate
+     the trustzone index used during register access.
+  4. Direction of the fixed unidirectional channel
+     0 - Memory to Device
+     1 - Device to Memory
+     2 - Device to Device
+
+Example:
+	serial at f991e000 {
+		compatible = "qcom,msm-uart";
+		reg = <0xf991e000 0x1000>
+			<0xf9944000 0x19000>;
+		interrupts = <0 108 0>;
+		clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+		clock-names = "core", "iface";
+
+		dmas = <&uart-bam 0 0 1>, <&uart-bam 1 0 0>;
+		dma-names = "rx", "tx";
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
