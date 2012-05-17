From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 17 May 2012 18:53:04 +0200
Subject: [PATCH 1/3] common: DMA-mapping: add DMA_ATTR_NO_KERNEL_MAPPING
 attribute
In-Reply-To: <1337273586-11089-1-git-send-email-m.szyprowski@samsung.com>
References: <1337273586-11089-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1337273586-11089-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA_ATTR_NO_KERNEL_MAPPING attribute which lets the
platform to avoid creating a kernel virtual mapping for the allocated
buffer. On some architectures creating such mapping is non-trivial task
and consumes very limited resources (like kernel virtual address space
or dma consistent address space). Buffers allocated with this attribute
can be only passed to user space by calling dma_mmap_attrs().

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 Documentation/DMA-attributes.txt |   18 ++++++++++++++++++
 include/linux/dma-attrs.h        |    1 +
 2 files changed, 19 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 5c72eed..725580d 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -49,3 +49,21 @@ DMA_ATTR_NON_CONSISTENT lets the platform to choose to return either
 consistent or non-consistent memory as it sees fit.  By using this API,
 you are guaranteeing to the platform that you have all the correct and
 necessary sync points for this memory in the driver.
+
+DMA_ATTR_NO_KERNEL_MAPPING
+--------------------------
+
+DMA_ATTR_NO_KERNEL_MAPPING lets the platform to avoid creating a kernel
+virtual mapping for the allocated buffer. On some architectures creating
+such mapping is non-trivial task and consumes very limited resources
+(like kernel virtual address space or dma consistent address space).
+Buffers allocated with this attribute can be only passed to user space
+by calling dma_mmap_attrs(). By using this API, you are guaranteeing
+that you won't dereference the pointer returned by dma_alloc_attr(). You
+can threat it as a cookie that must be passed to dma_mmap_attrs() and
+dma_free_attrs(). Make sure that both of these also get this attribute
+set on each call.
+
+Since it is optional for platforms to implement
+DMA_ATTR_NO_KERNEL_MAPPING, those that do not will simply ignore the
+attribute and exhibit default behavior.
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index 547ab56..a37c10c 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -15,6 +15,7 @@ enum dma_attr {
 	DMA_ATTR_WEAK_ORDERING,
 	DMA_ATTR_WRITE_COMBINE,
 	DMA_ATTR_NON_CONSISTENT,
+	DMA_ATTR_NO_KERNEL_MAPPING,
 	DMA_ATTR_MAX,
 };
 
-- 
1.7.10.1
