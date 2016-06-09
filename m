From: thommyj@gmail.com (Thommy Jakobsson)
Date: Thu,  9 Jun 2016 12:43:20 +0200
Subject: [PATCH v3 1/2] arm-smmu: doc: add SMMU mask documentation
In-Reply-To: <1465469001-2352-1-git-send-email-thommyj@gmail.com>
References: <5757FD62.2010403@arm.com>
 <1465469001-2352-1-git-send-email-thommyj@gmail.com>
Message-ID: <1465469001-2352-2-git-send-email-thommyj@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation on how to use a mask for a StreamId.

Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 19fe6f2..faf32d8b 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -37,7 +37,15 @@ conditions.
 
 - mmu-masters   : A list of phandles to device nodes representing bus
                   masters for which the SMMU can provide a translation
-                  and their corresponding StreamIDs (see example below).
+                  and their corresponding StreamIDs.
+
+                  Upper halfword of the StreamID-cell is describing an
+                  (optional) mask. If supported by the SMMU, it will use
+                  the following comparison when matching
+                  (incoming StreamID & !mask) == (DT StreamId & !mask)
+                  If no mask is given, a default mask of 0 is used (i.e
+                  entire ID is used for matching). See example below.
+
                   Each device node linked from this list must have a
                   "#stream-id-cells" property, indicating the number of
                   StreamIDs associated with it.
@@ -55,6 +63,12 @@ conditions.
                   SMMU configuration registers. In this case non-secure
                   aliases of secure registers have to be used during
                   SMMU configuration.
+- mmu-masters-mask : An optional list that specifies a mask per StreamID.
+                  A master included in this liss, have to specify masks
+                  for all of its StreamIDs. A master not included in the
+                  list will default to mask 0 (i.e entire ID is used).
+                  This can for example be used in systems where parts of
+                  the StreamID is dynamic.
 
 Example:
 
@@ -70,9 +84,12 @@ Example:
                              <0 37 4>;
 
                 /*
-                 * Two DMA controllers, the first with two StreamIDs (0xd01d
+                 * Three DMA controllers, the first with two StreamIDs (0xd01d
                  * and 0xd01e) and the second with only one (0xd11c).
+                 * The third uses a mask to use all StreamIDs that starts with
+                 * 0xd8
                  */
                 mmu-masters = <&dma0 0xd01d 0xd01e>,
-                              <&dma1 0xd11c>;
+                              <&dma1 0xd11c>,
+                              <&dma2 0x07ffd800>;
         };
-- 
1.9.1
