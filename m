From: thommyj@gmail.com (Thommy Jakobsson)
Date: Mon, 30 May 2016 22:40:05 +0200
Subject: [PATCH 1/2] arm-smmu: doc: add binding for stream ID mask
In-Reply-To: <1464640806-3942-1-git-send-email-thommyj@gmail.com>
References: <1464640806-3942-1-git-send-email-thommyj@gmail.com>
Message-ID: <1464640806-3942-2-git-send-email-thommyj@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for new device tree binding, mmu-masters-mask.

Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 19fe6f2..cabd1dc 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -56,6 +56,13 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.
 
+- mmu-masters-mask : An optional list that specifies a mask per StreamID.
+                  A master included in this liss, have to specify masks
+                  for all of its StreamIDs. A master not included in the
+                  list will default to mask 0 (i.e entire ID is used).
+                  This can for example be used in systems where parts of
+                  the StreamID is dynamic.
+
 Example:
 
         smmu {
@@ -70,9 +77,13 @@ Example:
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
+                              <&dma2 0xd800>;
+                mmu-masters-mask = <&dma2 0x07FF>
         };
-- 
1.9.1
