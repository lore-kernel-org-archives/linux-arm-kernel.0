From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Tue,  3 Feb 2015 18:25:07 +0530
Subject: [PATCH v5 3/3] Documentation: dma: Add APM X-Gene SoC DMA engine
 driver documentation
In-Reply-To: <1422968107-23125-1-git-send-email-rsahu@apm.com>
References: <1422968107-23125-1-git-send-email-rsahu@apm.com>
Message-ID: <1422968107-23125-4-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree binding for APM X-Gene SoC DMA engine driver.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 .../devicetree/bindings/dma/apm-xgene-dma.txt      | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apm-xgene-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt b/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
new file mode 100644
index 0000000..cfbdcdb
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
@@ -0,0 +1,49 @@
+Applied Micro X-Gene SoC DMA nodes
+
+DMA nodes are defined to describe on-chip DMA interfaces in
+APM X-Gene SoC.
+
+Required properties for DMA interfaces:
+- compatible: Should be "apm,xgene-dma".
+- device_type: set to "dma".
+- reg: Address and length of the register set for the device.
+  It contains the information of registers in the same order
+  as described by reg-names.
+- reg-names: Should contain the register set names.
+  - "dma_csr": DMA control and status register address space.
+  - "ring_csr": Descriptor ring control and status register
+                address space.
+  - "ring_cmd_csr": Descriptor ring command register address space.
+- interrupts: DMA has 5 interrupts sources. 1st interrupt is
+  DMA error reporting interrupt. 2nd, 3rd, 4th and 5th interrupts
+  are completion interrupts for each DMA channels.
+- clocks: Reference to the clock entry.
+
+Optional properties:
+- dma-coherent : Present if dma operations are coherent
+
+Example:
+	dmaclk: dmaclk at 1f27c000 {
+		compatible = "apm,xgene-device-clock";
+		#clock-cells = <1>;
+		clocks = <&socplldiv2 0>;
+		reg = <0x0 0x1f27c000 0x0 0x1000>;
+		reg-names = "csr-reg";
+		clock-output-names = "dmaclk";
+	};
+
+	dma: dma at 1f270000 {
+		compatible = "apm,xgene-dma";
+		device_type = "dma";
+		reg = <0x0 0x1f270000 0x0 0x10000>,
+		      <0x0 0x1f200000 0x0 0x10000>,
+		      <0x0 0x1b008000 0x0 0x2000>;
+		reg-names = "dma_csr", "ring_csr", "ring_cmd_csr";
+		interrupts = <0x0 0xb8 0x4>,
+			     <0x0 0xb9 0x4>,
+			     <0x0 0xba 0x4>,
+			     <0x0 0xbb 0x4>,
+			     <0x0 0x82 0x4>;
+		dma-coherent;
+		clocks = <&dmaclk 0>;
+	};
--
1.8.2.1
