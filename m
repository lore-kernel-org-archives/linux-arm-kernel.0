From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 1 Nov 2013 19:35:59 +0800
Subject: [PATCH 1/8] lib/genalloc: add a helper function for DMA buffer
 allocation
In-Reply-To: <cover.1383303752.git.b42378@freescale.com>
References: <cover.1383303752.git.b42378@freescale.com>
Message-ID: <554196b707b88047dce4e300848b81cc2677578d.1383303752.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using pool space for DMA buffer, there might be duplicated calling
of gen_pool_alloc() and gen_pool_virt_to_phys() in each implementation.

Thus it's better to add a simple helper function, a compatible one to
the common dma_alloc_coherent(), to save some code.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 include/linux/genalloc.h |  2 ++
 lib/genalloc.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index f8d41cb..1eda33d 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -94,6 +94,8 @@ static inline int gen_pool_add(struct gen_pool *pool, unsigned long addr,
 }
 extern void gen_pool_destroy(struct gen_pool *);
 extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
+extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
 extern void gen_pool_for_each_chunk(struct gen_pool *,
 	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 26cf20b..dda3116 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -313,6 +313,34 @@ retry:
 EXPORT_SYMBOL(gen_pool_alloc);
 
 /**
+ * gen_pool_dma_alloc - allocate special memory from the pool for DMA usage
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: dma-view physical address
+ *
+ * Allocate the requested number of bytes from the specified pool.
+ * Uses the pool allocation function (with first-fit algorithm by default).
+ * Can not be used in NMI handler on architectures without
+ * NMI-safe cmpxchg implementation.
+ */
+void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
+{
+	unsigned long vaddr;
+
+	if (!pool)
+		return NULL;
+
+	vaddr = gen_pool_alloc(pool, size);
+	if (!vaddr)
+		return NULL;
+
+	*dma = gen_pool_virt_to_phys(pool, vaddr);
+
+	return (void *)vaddr;
+}
+EXPORT_SYMBOL(gen_pool_dma_alloc);
+
+/**
  * gen_pool_free - free allocated special memory back to the pool
  * @pool: pool to free to
  * @addr: starting address of memory to free back to pool
-- 
1.8.4
