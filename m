From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed, 27 Jul 2016 16:42:05 -0700
Subject: [PATCH v5 3/6] common: DMA-mapping: add DMA_ATTR_PRIVILEGED attribute
In-Reply-To: <20160727234208.2101-1-mitchelh@codeaurora.org>
References: <20160727234208.2101-1-mitchelh@codeaurora.org>
Message-ID: <20160727234208.2101-4-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DMA_ATTR_PRIVILEGED attribute to the DMA-mapping
subsystem.

Some advanced peripherals such as remote processors and GPUs perform
accesses to DMA buffers in both privileged "supervisor" and unprivileged
"user" modes.  This attribute is used to indicate to the DMA-mapping
subsystem that the buffer is fully accessible at the elevated privilege
level (and ideally inaccessible or at least read-only at the
lesser-privileged levels).

Cc: linux-doc at vger.kernel.org
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---

Notes:
    v2..v3
    
      - Not worrying about executability.

 Documentation/DMA-attributes.txt | 10 ++++++++++
 include/linux/dma-mapping.h      |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 2d455a5cf671..7728bda278c9 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -126,3 +126,13 @@ means that we won't try quite as hard to get them.
 
 NOTE: At the moment DMA_ATTR_ALLOC_SINGLE_PAGES is only implemented on ARM,
 though ARM64 patches will likely be posted soon.
+
+DMA_ATTR_PRIVILEGED
+------------------------------
+
+Some advanced peripherals such as remote processors and GPUs perform
+accesses to DMA buffers in both privileged "supervisor" and unprivileged
+"user" modes.  This attribute is used to indicate to the DMA-mapping
+subsystem that the buffer is fully accessible at the elevated privilege
+level (and ideally inaccessible or at least read-only at the
+lesser-privileged levels).
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 66533e18276c..73f477609262 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -56,6 +56,12 @@
  * that gives better TLB efficiency.
  */
 #define DMA_ATTR_ALLOC_SINGLE_PAGES	(1UL << 7)
+/*
+ * DMA_ATTR_PRIVILEGED: used to indicate that the buffer is fully
+ * accessible at an elevated privilege level (and ideally inaccessible or
+ * at least read-only@lesser-privileged levels).
+ */
+#define DMA_ATTR_PRIVILEGED		(1UL << 8)
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
