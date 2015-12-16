From: brian.starkey@arm.com (Brian Starkey)
Date: Wed, 16 Dec 2015 16:56:04 +0000
Subject: [PATCH 1/3] memremap: add MEMREMAP_WC flag
In-Reply-To: <1450284966-25369-1-git-send-email-brian.starkey@arm.com>
References: <1450284966-25369-1-git-send-email-brian.starkey@arm.com>
Message-ID: <1450284966-25369-2-git-send-email-brian.starkey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a flag to memremap() for writecombine mappings. Mappings satisfied
by this flag will not be cached, however writes may be delayed or
combined into more efficient bursts. This is most suitable for
buffers written sequentially by the CPU for use by other DMA devices.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/linux/io.h |    1 +
 kernel/memremap.c  |   15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 72c35e0..fb9ca89 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -150,6 +150,7 @@ enum {
 	/* See memremap() kernel-doc for usage description... */
 	MEMREMAP_WB = 1 << 0,
 	MEMREMAP_WT = 1 << 1,
+	MEMREMAP_WC = 1 << 2,
 };
 
 void *memremap(resource_size_t offset, size_t size, unsigned long flags);
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 7658d32..b9face8 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -38,11 +38,13 @@ static void *try_ram_remap(resource_size_t offset, size_t size)
  * memremap() - remap an iomem_resource as cacheable memory
  * @offset: iomem resource start address
  * @size: size of remap
- * @flags: either MEMREMAP_WB or MEMREMAP_WT
+ * @flags: any of MEMREMAP_WB, MEMREMAP_WT and MEMREMAP_WC
  *
  * memremap() is "ioremap" for cases where it is known that the resource
  * being mapped does not have i/o side effects and the __iomem
- * annotation is not applicable.
+ * annotation is not applicable. In the case of multiple flags, the different
+ * mapping types will be attempted in the order listed below until one of
+ * them succeeds.
  *
  * MEMREMAP_WB - matches the default mapping for "System RAM" on
  * the architecture.  This is usually a read-allocate write-back cache.
@@ -54,6 +56,10 @@ static void *try_ram_remap(resource_size_t offset, size_t size)
  * cache or are written through to memory and never exist in a
  * cache-dirty state with respect to program visibility.  Attempts to
  * map "System RAM" with this mapping type will fail.
+ *
+ * MEMREMAP_WC - establish a writecombine mapping, whereby writes may
+ * be coalesced together (e.g. in the CPU's write buffers), but is otherwise
+ * uncached. Attempts to map "System RAM" with this mapping type will fail.
  */
 void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 {
@@ -98,6 +104,11 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 		addr = ioremap_wt(offset, size);
 	}
 
+	if (!addr && (flags & MEMREMAP_WC)) {
+		flags &= ~MEMREMAP_WC;
+		addr = ioremap_wc(offset, size);
+	}
+
 	return addr;
 }
 EXPORT_SYMBOL(memremap);
-- 
1.7.9.5
