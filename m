From: laura@labbott.name (Laura Abbott)
Date: Mon, 16 Nov 2015 16:57:33 -0800
Subject: [PATCHv2 1/3] ion: Devicetree bindings for Ion
In-Reply-To: <1447721855-7574-1-git-send-email-laura@labbott.name>
References: <1447721855-7574-1-git-send-email-laura@labbott.name>
Message-ID: <1447721855-7574-2-git-send-email-laura@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This adds a base set of devicetree bindings for the Ion memory
manager. This supports setting up the generic set of heaps and
their properties.

Signed-off-by: Laura Abbott <laura@labbott.name>
---
 drivers/staging/android/ion/devicetree.txt | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 drivers/staging/android/ion/devicetree.txt

diff --git a/drivers/staging/android/ion/devicetree.txt b/drivers/staging/android/ion/devicetree.txt
new file mode 100644
index 0000000..e1ea537
--- /dev/null
+++ b/drivers/staging/android/ion/devicetree.txt
@@ -0,0 +1,50 @@
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
+		compatbile = "qcom,msm8916-ion", "linux,ion";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ion-system-heap {
+			compatbile = "qcom,system-heap", "linux,ion-heap-system"
+		};
+
+		ion-camera-region {
+			compatible = "qcom,camera-heap", "linux,ion-heap-dma"
+			memory-region = <&camera_region>;
+		};
+
+		ion-fb-region {
+			compatbile = "qcom,fb-heap", "linux,ion-heap-dma"
+			memory-region = <&fb_region>;
+		};
+	}
-- 
2.5.0
