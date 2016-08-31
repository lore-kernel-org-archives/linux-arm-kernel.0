From: labbott@redhat.com (Laura Abbott)
Date: Tue, 30 Aug 2016 17:04:27 -0700
Subject: [PATCHv3 1/3] devicetree: bindings for Ion
In-Reply-To: <1472601869-19469-1-git-send-email-labbott@redhat.com>
References: <1472601869-19469-1-git-send-email-labbott@redhat.com>
Message-ID: <1472601869-19469-2-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This adds a base set of devicetree bindings for the Ion memory
manager. This supports setting up the generic set of heaps and
their properties.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/devicetree.txt | 51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 drivers/staging/android/ion/devicetree.txt

diff --git a/drivers/staging/android/ion/devicetree.txt b/drivers/staging/android/ion/devicetree.txt
new file mode 100644
index 0000000..16871527
--- /dev/null
+++ b/drivers/staging/android/ion/devicetree.txt
@@ -0,0 +1,51 @@
+Ion Memory Manager
+
+Ion is a memory manager that allows for sharing of buffers via dma-buf.
+Ion allows for different types of allocation via an abstraction called
+a 'heap'. A heap represents a specific type of memory. Each heap has
+a different type. There can be multiple instances of the same heap
+type.
+
+Specific heap instances are tied to heap IDs. Heap IDs are not to be specified
+in the devicetree.
+
+Required properties for Ion
+
+- compatible: "linux,ion" PLUS a compatible property for the device
+
+All child nodes of a linux,ion node are interpreted as heaps
+
+required properties for heaps
+
+- compatible: compatible string for a heap type PLUS a compatible property
+for the specific instance of the heap. Current heap types
+-- linux,ion-heap-system
+-- linux,ion-heap-system-contig
+-- linux,ion-heap-carveout
+-- linux,ion-heap-chunk
+-- linux,ion-heap-dma
+-- linux,ion-heap-custom
+
+Optional properties
+- memory-region: A phandle to a memory region. Required for DMA heap type
+(see reserved-memory.txt for details on the reservation)
+
+Example:
+
+	ion {
+		compatbile = "hisilicon,ion", "linux,ion";
+
+		ion-system-heap {
+			compatbile = "hisilicon,system-heap", "linux,ion-heap-system"
+		};
+
+		ion-camera-region {
+			compatible = "hisilicon,camera-heap", "linux,ion-heap-dma"
+			memory-region = <&camera_region>;
+		};
+
+		ion-fb-region {
+			compatbile = "hisilicon,fb-heap", "linux,ion-heap-dma"
+			memory-region = <&fb_region>;
+		};
+	}
-- 
2.7.4
