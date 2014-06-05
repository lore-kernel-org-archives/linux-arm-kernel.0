From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 5 Jun 2014 21:37:09 +0800
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of Hisilicon
 System MMU binding
In-Reply-To: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1401975430-2648-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a description of the device tree binding for the Hisilicon
System MMU architecture.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../devicetree/bindings/iommu/hisilicon,smmu.txt   | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/hisilicon,smmu.txt

diff --git a/Documentation/devicetree/bindings/iommu/hisilicon,smmu.txt b/Documentation/devicetree/bindings/iommu/hisilicon,smmu.txt
new file mode 100644
index 0000000..a2b2f23
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/hisilicon,smmu.txt
@@ -0,0 +1,70 @@
+* Hisilicon System MMU Architecture Implementation
+
+Hisilicon SoCs may contain an implementation of the Hisilicon System Memory
+Management Unit Architecture, which can be used to provide 1 or 2 stages
+of address translation to bus masters external to the CPU.
+
+The SMMU may also raise interrupts in response to various fault
+conditions.
+
+** System MMU required properties:
+
+- compatible    : Should be one of:
+
+                        "hisilicon,smmu-v1"
+
+                  depending on the particular implementation and/or the
+                  version of the architecture implemented.
+
+- reg           : Base address and size of the SMMU.
+
+- #global-interrupts : The number of global interrupts exposed by the
+                       device.
+
+- interrupts    : Interrupt list, with the first #global-irqs entries
+                  corresponding to the global interrupts and exactly one
+                  following entry corresponding to context interrupt.
+
+- smmu-masters  : A list of phandles to device nodes representing bus
+                  masters for which the SMMU can provide a translation
+                  and their corresponding StreamIDs (see example below).
+
+** System MMU optional properties:
+
+- smmu-cb-memtype   : A list of StreamIDs which not translate address but
+                  translate attributes. The StreamIDs list here can not be
+                  used for map(translation) mode again.
+                  StreamID first, then the type list below:
+                  1, cahceable, WBRAWA, Normal outer and inner write-back
+                  2, non-cacheable, Normal outer and inner non-cacheable
+                  3, device, nGnRE
+                  others, bypass
+
+- smmu-bypass-vmid  : Specify which context bank is used for bypass mode.
+                  If omit, vmid=255 is default.
+
+Example:
+
+        smmu {
+                compatible = "hisilicon,smmu-v1";
+                reg = <0x40040000 0x1000>;
+                #global-interrupts = <1>;
+
+                /*
+                 * Global and context faults may use the same interrupt, if
+                 * only one exist.
+                 */
+                interrupts = <0 188 4>,
+                             <0 188 4>; /* The last is the context interrupt */
+
+                /*
+                 * StreamID = 0 is bypass and force cacheable(WBRAWA).
+                 */
+                smmu-cb-memtype = <0x0 1>;
+
+                /*
+                 * Two DMA controllers, each with exactly one StreamID.
+                 */
+                smmu-masters = <&dma0 0x0001>,
+                               <&dma1 0x0002>;
+        };
--
1.8.0
