From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 7 Apr 2011 01:23:45 +0800
Subject: [PATCH] genalloc: add support to specify the physical address
Message-ID: <mailman.205.1303240495.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

so we specify the virtual address as base of the pool chunk and then
get the physical address for hardware IP

as example on at91 we will use on spi, uart or macb

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 include/linux/genalloc.h |   20 +++++++++++++++++++-
 lib/genalloc.c           |   39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index b1c70f1..b44625b 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -26,13 +26,31 @@ struct gen_pool {
 struct gen_pool_chunk {
 	spinlock_t lock;
 	struct list_head next_chunk;	/* next chunk in pool */
+	unsigned long phys_addr;	/* physical starting address of memory chunk */
 	unsigned long start_addr;	/* starting address of memory chunk */
 	unsigned long end_addr;		/* ending address of memory chunk */
 	unsigned long bits[0];		/* bitmap for allocating memory chunk */
 };
 
 extern struct gen_pool *gen_pool_create(int, int);
-extern int gen_pool_add(struct gen_pool *, unsigned long, size_t, int);
+extern unsigned long gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long);
+extern int gen_pool_add_virt(struct gen_pool *, unsigned long, unsigned long,
+			     size_t, int);
+/**
+ * gen_pool_add - add a new chunk of special memory to the pool
+ * @pool: pool to add new memory chunk to
+ * @addr: starting address of memory chunk to add to pool
+ * @size: size in bytes of the memory chunk to add to pool
+ * @nid: node id of the node the chunk structure and bitmap should be
+ *       allocated on, or -1
+ *
+ * Add a new chunk of special memory to the specified pool.
+ */
+static inline int gen_pool_add(struct gen_pool *pool, unsigned long addr,
+			       size_t size, int nid)
+{
+	return gen_pool_add_virt(pool, addr, 0, size, nid);
+}
 extern void gen_pool_destroy(struct gen_pool *);
 extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 1923f14..83b069b 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -39,17 +39,18 @@ struct gen_pool *gen_pool_create(int min_alloc_order, int nid)
 EXPORT_SYMBOL(gen_pool_create);
 
 /**
- * gen_pool_add - add a new chunk of special memory to the pool
+ * gen_pool_add_virt - add a new chunk of special memory to the pool
  * @pool: pool to add new memory chunk to
- * @addr: starting address of memory chunk to add to pool
+ * @virt: virtual starting address of memory chunk to add to pool
+ * @phys: physical starting address of memory chunk to add to pool
  * @size: size in bytes of the memory chunk to add to pool
  * @nid: node id of the node the chunk structure and bitmap should be
  *       allocated on, or -1
  *
  * Add a new chunk of special memory to the specified pool.
  */
-int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
-		 int nid)
+int gen_pool_add_virt(struct gen_pool *pool, unsigned long virt, unsigned long phys,
+		 size_t size, int nid)
 {
 	struct gen_pool_chunk *chunk;
 	int nbits = size >> pool->min_alloc_order;
@@ -61,8 +62,9 @@ int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
 		return -1;
 
 	spin_lock_init(&chunk->lock);
-	chunk->start_addr = addr;
-	chunk->end_addr = addr + size;
+	chunk->phys_addr = phys;
+	chunk->start_addr = virt;
+	chunk->end_addr = virt + size;
 
 	write_lock(&pool->lock);
 	list_add(&chunk->next_chunk, &pool->chunks);
@@ -70,7 +72,30 @@ int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
 
 	return 0;
 }
-EXPORT_SYMBOL(gen_pool_add);
+EXPORT_SYMBOL(gen_pool_add_virt);
+
+/**
+ * gen_pool_virt_to_phys - return the physical address of memory
+ * @pool: pool to allocate from
+ * @addr: starting address of memory
+ */
+unsigned long gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long addr)
+{
+	struct list_head *_chunk;
+	struct gen_pool_chunk *chunk;
+
+	read_lock(&pool->lock);
+	list_for_each(_chunk, &pool->chunks) {
+		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
+
+		if (addr >= chunk->start_addr && addr < chunk->end_addr)
+			return chunk->phys_addr + addr - chunk->start_addr;
+	}
+	read_unlock(&pool->lock);
+
+	return ~0UL;
+}
+EXPORT_SYMBOL(gen_pool_virt_to_phys);
 
 /**
  * gen_pool_destroy - destroy a special memory pool
-- 
1.7.4.1


--AhhlLboLdkugWU4S--
