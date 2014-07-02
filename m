From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed,  2 Jul 2014 11:03:35 -0700
Subject: [PATCHv4 2/5] lib/genalloc.c: Add genpool range check function
In-Reply-To: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1404324218-4743-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


After allocating an address from a particular genpool,
there is no good way to verify if that address actually
belongs to a genpool. Introduce addr_in_gen_pool which
will return if an address plus size falls completely
within the genpool range.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 include/linux/genalloc.h |  3 +++
 lib/genalloc.c           | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 3cd0934..1ccaab4 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -121,6 +121,9 @@ extern struct gen_pool *devm_gen_pool_create(struct device *dev,
 		int min_alloc_order, int nid);
 extern struct gen_pool *dev_get_gen_pool(struct device *dev);
 
+bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
+			size_t size);
+
 #ifdef CONFIG_OF
 extern struct gen_pool *of_get_named_gen_pool(struct device_node *np,
 	const char *propname, int index);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index c2b3ad7..6f03722 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -403,6 +403,35 @@ void gen_pool_for_each_chunk(struct gen_pool *pool,
 EXPORT_SYMBOL(gen_pool_for_each_chunk);
 
 /**
+ * addr_in_gen_pool - checks if an address falls within the range of a pool
+ * @pool:	the generic memory pool
+ * @start:	start address
+ * @size:	size of the region
+ *
+ * Check if the range of addresses falls within the specified pool. Takes
+ * the rcu_read_lock for the duration of the check.
+ */
+bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
+			size_t size)
+{
+	bool found = false;
+	unsigned long end = start + size;
+	struct gen_pool_chunk *chunk;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(chunk, &(pool)->chunks, next_chunk) {
+		if (start >= chunk->start_addr && start <= chunk->end_addr) {
+			if (end <= chunk->end_addr) {
+				found = true;
+				break;
+			}
+		}
+	}
+	rcu_read_unlock();
+	return found;
+}
+
+/**
  * gen_pool_avail - get available free space of the pool
  * @pool: pool to get available free space
  *
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
