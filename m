From: labbott@fedoraproject.org (Laura Abbott)
Date: Tue,  6 Oct 2015 13:47:12 -0700
Subject: [RFC][PATCH 1/2] WIP: Devicetree bindings for Ion
In-Reply-To: <1444164433-9107-1-git-send-email-labbott@fedoraproject.org>
References: <1444164433-9107-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <1444164433-9107-2-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laura Abbott <laura@labbott.name>


This adds a base set of devicetree bindings for the Ion memory
manager. This supports setting up the generic set of heaps and
their properties.

Signed-off-by: Laura Abbott <laura@labbott.name>
Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
---
 drivers/staging/android/ion/devicetree.txt | 53 ++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 drivers/staging/android/ion/devicetree.txt

diff --git a/drivers/staging/android/ion/devicetree.txt b/drivers/staging/android/ion/devicetree.txt
new file mode 100644
index 0000000..4a0c941
--- /dev/null
+++ b/drivers/staging/android/ion/devicetree.txt
@@ -0,0 +1,53 @@
+Ion Memory Manager
+
+Ion is a memory manager that allows for sharing of buffers via dma-buf.
+Ion allows for different types of allocation via an abstraction called
+a 'heap'. A heap represents a specific type of memory. Each heap has
+a different type. There can be multiple instances of the same heap
+type.
+
+Required properties for Ion
+
+- compatible: "linux,ion"
+
+All child nodes of a linux,ion node are interpreted as heaps
+
+required properties for heaps
+
+- linux,ion-heap-id: The Ion heap id used for allocation selection
+- linux,ion-heap-type: Ion heap type defined in ion.h
+- linux,ion-heap-name: Human readble name of the heap
+
+
+Optional properties
+- memory-region: A phandle to a memory region. Required for DMA heap type
+(see reserved-memory.txt for details on the reservation)
+- linux,ion-heap-align: Alignment for the heap.
+
+Example:
+
+	ion {
+		compatbile = "linux,ion";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ion-system-heap {
+			linux,ion-heap-id = <0>;
+			linux,ion-heap-type = <ION_SYSTEM_HEAP_TYPE>;
+			linux,ion-heap-name = "system";
+		};
+
+		ion-camera-region {
+			linux,ion-heap-id = <1>;
+			linux,ion-heap-type = <ION_DMA_HEAP_TYPE>;
+			linux,ion-heap-name = "camera"
+			memory-region = <&camera_region>;
+		};
+
+		ion-fb-region {
+			linux,ion-heap-id = <2>;
+			linux,ion-heap-type = <ION_DMA_HEAP_TYPE>;
+			linux,ion-heap-name = "fb"
+			memory-region = <&fb_region>;
+		};
+	}
-- 
2.4.3
