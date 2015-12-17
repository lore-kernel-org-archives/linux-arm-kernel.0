From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 17 Dec 2015 12:01:17 -0500
Subject: [PATCH V10 2/7] dma: hidma: Add Device Tree support
In-Reply-To: <1450371684-23415-1-git-send-email-okaya@codeaurora.org>
References: <1450371684-23415-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1450371684-23415-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the Qualcomm Technologies HIDMA driver.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt

diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
new file mode 100644
index 0000000..0e6ed1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
@@ -0,0 +1,79 @@
+Qualcomm Technologies HIDMA Management interface
+
+Qualcomm Technologies HIDMA is a high speed DMA device. It only supports
+memcpy and memset capabilities. It has been designed for virtualized
+environments.
+
+Each HIDMA HW instance consists of multiple DMA channels. These channels
+share the same bandwidth. The bandwidth utilization can be parititioned
+among channels based on the priority and weight assignments.
+
+There are only two priority levels and 15 weigh assignments possible.
+
+Other parameters here determine how much of the system bus this HIDMA
+instance can use like maximum read/write request and and number of bytes to
+read/write in a single burst.
+
+Main node required properties:
+- compatible: "qcom,hidma-mgmt-1.0";
+- reg: Address range for DMA device
+- dma-channels: Number of channels supported by this DMA controller.
+- max-write-burst-bytes: Maximum write burst in bytes. A memcpy requested is
+  fragmented to multiples of this amount.
+- max-read-burst-bytes: Maximum read burst in bytes. A memcpy request is
+  fragmented to multiples of this amount.
+- max-write-transactions: Maximum write transactions to perform in a burst
+- max-read-transactions: Maximum read transactions to perform in a burst
+- channel-reset-timeout-cycles: Channel reset timeout in cycles for this SOC.
+
+Sub-nodes:
+
+HIDMA has one or more DMA channels that are used to move data from one
+memory location to another.
+
+Each DMA channel is described as a sub-node under the management object.
+When a transfer channel is given to the guest operating system, only the channel
+object is created. The drivers have support for both flat and hierarchical
+configuration.
+
+Required properties:
+- compatible: must contain "qcom,hidma-1.0"
+- reg: Addresses for the transfer and event channel
+- interrupts: Should contain the event interrupt
+- desc-count: Number of asynchronous requests this channel can handle
+- channel-index: The HW event channel completions will be delivered.
+
+Example:
+
+Hypervisor OS configuration:
+
+	hidma-mgmt at f9984000 = {
+		compatible = "qcom,hidma-mgmt-1.0";
+		reg = <0xf9984000 0x15000>;
+		dma-channels = <6>;
+		max-write-burst-bytes = <1024>;
+		max-read-burst-bytes = <1024>;
+		max-write-transactions = <31>;
+		max-read-transactions = <31>;
+		channel-reset-timeout-cycles = <0x500>;
+
+		hidma_24: dma-controller at 0x5c050000 {
+			compatible = "qcom,hidma-1.0";
+			reg = <0 0x5c050000 0x0 0x1000>,
+			      <0 0x5c0b0000 0x0 0x1000>;
+			interrupts = <0 389 0>;
+			desc-count = <10>;
+			channel-index = <4>;
+		};
+	};
+
+Guest OS configuration:
+
+	hidma_24: dma-controller at 0x5c050000 {
+		compatible = "qcom,hidma-1.0";
+		reg = <0 0x5c050000 0x0 0x1000>,
+		      <0 0x5c0b0000 0x0 0x1000>;
+		interrupts = <0 389 0>;
+		desc-count = <10>;
+		channel-index = <4>;
+	};
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
