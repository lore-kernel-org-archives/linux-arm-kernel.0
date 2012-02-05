From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 19:29:35 +0100
Subject: [PATCH 1/2] genalloc: add support of named pool
Message-ID: <1328466576-29384-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

so we can get the pool in the driver by name instead of passing it via
parameter

this will be use on AT91 to get access from different drivers to the sram or
gpbr as example

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Hi,

	if you don't mind I'll apply this via at91 tree as it's needed to
	finish a cleanup on at91 to allow multiple soc in the same kernel

Best Regards,
J.
 include/linux/genalloc.h |   50 +++++++++++++++++++++++++++++++++++-
 lib/genalloc.c           |   64 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 107 insertions(+), 7 deletions(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 5e98eeb..8b54532 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -33,9 +33,12 @@
  *  General purpose special memory pool descriptor.
  */
 struct gen_pool {
+	char *name;			/* pool name */
 	spinlock_t lock;
 	struct list_head chunks;	/* list of chunks in this pool */
 	int min_alloc_order;		/* minimum allocation order */
+
+	struct list_head list;		/* list of pool */
 };
 
 /*
@@ -50,7 +53,21 @@ struct gen_pool_chunk {
 	unsigned long bits[0];		/* bitmap for allocating memory chunk */
 };
 
-extern struct gen_pool *gen_pool_create(int, int);
+extern struct gen_pool *gen_pool_create_byname(const char*, int, int);
+
+/**
+ * gen_pool_create - create a new special memory pool
+ * @min_alloc_order: log base 2 of number of bytes each bitmap bit represents
+ * @nid: node id of the node the pool structure should be allocated on, or -1
+ *
+ * Create a new special memory pool that can be used to manage special purpose
+ * memory not managed by the regular kmalloc/kfree interface.
+ */
+static inline struct gen_pool *gen_pool_create(int min_alloc_order, int nid)
+{
+	return gen_pool_create_byname(NULL, min_alloc_order, nid);
+}
+extern struct gen_pool *gen_pool_byname(const char *name);
 extern phys_addr_t gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long);
 extern int gen_pool_add_virt(struct gen_pool *, unsigned long, phys_addr_t,
 			     size_t, int);
@@ -78,4 +95,35 @@ extern void gen_pool_for_each_chunk(struct gen_pool *,
 	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
 extern size_t gen_pool_avail(struct gen_pool *);
 extern size_t gen_pool_size(struct gen_pool *);
+
+/**
+ * gen_pool_alloc_byname - allocate special memory from the pool
+ * @name: name of the pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ *
+ * Allocate the requested number of bytes from the specified pool.
+ * Uses a first-fit algorithm. Can not be used in NMI handler on
+ * architectures without NMI-safe cmpxchg implementation.
+ */
+static inline unsigned long gen_pool_alloc_byname(const char* name, size_t size)
+{
+	return gen_pool_alloc(gen_pool_byname(name), size);
+}
+
+/**
+ * gen_pool_free_byname - free allocated special memory back to the pool
+ * @name: name of the pool to allocate from
+ * @addr: starting address of memory to free back to pool
+ * @size: size in bytes of memory to free
+ *
+ * Free previously allocated special memory back to the specified
+ * pool.  Can not be used in NMI handler on architectures without
+ * NMI-safe cmpxchg implementation.
+ */
+static inline void gen_pool_free_byname(const char* name,
+					unsigned long addr, size_t size)
+{
+	gen_pool_free(gen_pool_byname(name), addr, size);
+}
+
 #endif /* __GENALLOC_H__ */
diff --git a/lib/genalloc.c b/lib/genalloc.c
index f352cc4..f1772b0 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -35,6 +35,9 @@
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
 
+static LIST_HEAD(pools);
+static DEFINE_SPINLOCK(pools_lock);
+
 static int set_bits_ll(unsigned long *addr, unsigned long mask_to_set)
 {
 	unsigned long val, nval;
@@ -136,26 +139,63 @@ static int bitmap_clear_ll(unsigned long *map, int start, int nr)
 }
 
 /**
- * gen_pool_create - create a new special memory pool
+ * gen_pool_byname - get pool by name
+ * @name: pool name
+ */
+struct gen_pool *gen_pool_byname(const char *name)
+{
+	struct gen_pool *pool;
+
+	if (!name)
+		return NULL;
+
+	spin_lock(&pools_lock);
+	list_for_each_entry(pool, &pools, list) {
+		if (pool->name && strcmp(pool->name, name) == 0)
+			goto end;
+	}
+	pool = NULL;
+end:
+	spin_unlock(&pools_lock);
+	return pool;
+}
+EXPORT_SYMBOL(gen_pool_byname);
+
+/**
+ * gen_pool_create_byname - create a new special memory pool
+ * @name: pool name if NULL you will not be able to get it via gen_pool_byname
  * @min_alloc_order: log base 2 of number of bytes each bitmap bit represents
  * @nid: node id of the node the pool structure should be allocated on, or -1
  *
  * Create a new special memory pool that can be used to manage special purpose
  * memory not managed by the regular kmalloc/kfree interface.
  */
-struct gen_pool *gen_pool_create(int min_alloc_order, int nid)
+struct gen_pool *gen_pool_create_byname(const char *name,
+					int min_alloc_order, int nid)
 {
-	struct gen_pool *pool;
+	struct gen_pool *pool = NULL;
+
+	if (gen_pool_byname(name))
+		goto end;
 
+	spin_lock(&pools_lock);
 	pool = kmalloc_node(sizeof(struct gen_pool), GFP_KERNEL, nid);
 	if (pool != NULL) {
 		spin_lock_init(&pool->lock);
 		INIT_LIST_HEAD(&pool->chunks);
 		pool->min_alloc_order = min_alloc_order;
+		pool->name = kstrdup(name, GFP_KERNEL);
+		if (!pool->name) {
+			kfree(pool);
+			goto end;
+		}
+		list_add_tail(&pool->list, &pools);
 	}
+end:
+	spin_unlock(&pools_lock);
 	return pool;
 }
-EXPORT_SYMBOL(gen_pool_create);
+EXPORT_SYMBOL(gen_pool_create_byname);
 
 /**
  * gen_pool_add_virt - add a new chunk of special memory to the pool
@@ -244,6 +284,8 @@ void gen_pool_destroy(struct gen_pool *pool)
 
 		kfree(chunk);
 	}
+	list_del(&pool->list);
+	kfree(pool->name);
 	kfree(pool);
 	return;
 }
@@ -262,9 +304,14 @@ unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
 {
 	struct gen_pool_chunk *chunk;
 	unsigned long addr = 0;
-	int order = pool->min_alloc_order;
+	int order;
 	int nbits, start_bit = 0, end_bit, remain;
 
+	if (!pool)
+		return addr;
+
+	order = pool->min_alloc_order;
+
 #ifndef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 	BUG_ON(in_nmi());
 #endif
@@ -315,9 +362,14 @@ EXPORT_SYMBOL(gen_pool_alloc);
 void gen_pool_free(struct gen_pool *pool, unsigned long addr, size_t size)
 {
 	struct gen_pool_chunk *chunk;
-	int order = pool->min_alloc_order;
+	int order;
 	int start_bit, nbits, remain;
 
+	if (!pool)
+		return;
+
+	order = pool->min_alloc_order;
+
 #ifndef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 	BUG_ON(in_nmi());
 #endif
-- 
1.7.7
