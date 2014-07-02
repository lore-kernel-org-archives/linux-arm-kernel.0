From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed,  2 Jul 2014 11:03:34 -0700
Subject: [PATCHv4 1/5] lib/genalloc.c: Add power aligned algorithm
In-Reply-To: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1404324218-4743-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


One of the more common algorithms used for allocation
is to align the start address of the allocation to
the order of size requested. Add this as an algorithm
option for genalloc.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 include/linux/genalloc.h |  4 ++++
 lib/genalloc.c           | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 1c2fdaa..3cd0934 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -110,6 +110,10 @@ extern void gen_pool_set_algo(struct gen_pool *pool, genpool_algo_t algo,
 extern unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data);
 
+extern unsigned long gen_pool_first_fit_order_align(unsigned long *map,
+		unsigned long size, unsigned long start, unsigned int nr,
+		void *data);
+
 extern unsigned long gen_pool_best_fit(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data);
 
diff --git a/lib/genalloc.c b/lib/genalloc.c
index bdb9a45..c2b3ad7 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -481,6 +481,26 @@ unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
 EXPORT_SYMBOL(gen_pool_first_fit);
 
 /**
+ * gen_pool_first_fit_order_align - find the first available region
+ * of memory matching the size requirement. The region will be aligned
+ * to the order of the size specified.
+ * @map: The address to base the search on
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
+ * @nr: The number of zeroed bits we're looking for
+ * @data: additional data - unused
+ */
+unsigned long gen_pool_first_fit_order_align(unsigned long *map,
+		unsigned long size, unsigned long start,
+		unsigned int nr, void *data)
+{
+	unsigned long align_mask = roundup_pow_of_two(nr) - 1;
+
+	return bitmap_find_next_zero_area(map, size, start, nr, align_mask);
+}
+EXPORT_SYMBOL(gen_pool_first_fit_order_align);
+
+/**
  * gen_pool_best_fit - find the best fitting region of memory
  * macthing the size requirement (no alignment constraint)
  * @map: The address to base the search on
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
