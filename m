From: andreyknvl@google.com (Andrey Konovalov)
Date: Tue,  6 Nov 2018 18:30:24 +0100
Subject: [PATCH v10 09/22] kasan: add tag related helper functions
In-Reply-To: <cover.1541525354.git.andreyknvl@google.com>
References: <cover.1541525354.git.andreyknvl@google.com>
Message-ID: <b8c56d36b79eecf0c331a0a7a2df12632aefccc9.1541525354.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a few helper functions, that are meant to be used to
work with tags embedded in the top byte of kernel pointers: to set, to
get or to reset (set to 0xff) the top byte.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/kasan_init.c |  2 ++
 include/linux/kasan.h      | 13 +++++++++
 mm/kasan/kasan.h           | 55 ++++++++++++++++++++++++++++++++++++++
 mm/kasan/tags.c            | 37 +++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 18ebc8994a7b..370b19d0e2fb 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -249,6 +249,8 @@ void __init kasan_init(void)
 	memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
+	kasan_init_tags();
+
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 7f6574c35c62..4c9d6f9029f2 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -169,6 +169,19 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 
 #define KASAN_SHADOW_INIT 0xFF
 
+void kasan_init_tags(void);
+
+void *kasan_reset_tag(const void *addr);
+
+#else /* CONFIG_KASAN_SW_TAGS */
+
+static inline void kasan_init_tags(void) { }
+
+static inline void *kasan_reset_tag(const void *addr)
+{
+	return (void *)addr;
+}
+
 #endif /* CONFIG_KASAN_SW_TAGS */
 
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 19b950eaccff..f16bee55b610 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -8,6 +8,10 @@
 #define KASAN_SHADOW_SCALE_SIZE (1UL << KASAN_SHADOW_SCALE_SHIFT)
 #define KASAN_SHADOW_MASK       (KASAN_SHADOW_SCALE_SIZE - 1)
 
+#define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
+#define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
+#define KASAN_TAG_MAX		0xFD /* maximum value for random tags */
+
 #define KASAN_FREE_PAGE         0xFF  /* page was freed */
 #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
 #define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
@@ -126,6 +130,57 @@ static inline void quarantine_reduce(void) { }
 static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
 #endif
 
+#ifdef CONFIG_KASAN_SW_TAGS
+
+#define KASAN_PTR_TAG_SHIFT 56
+#define KASAN_PTR_TAG_MASK (0xFFUL << KASAN_PTR_TAG_SHIFT)
+
+u8 random_tag(void);
+
+static inline void *set_tag(const void *addr, u8 tag)
+{
+	u64 a = (u64)addr;
+
+	a &= ~KASAN_PTR_TAG_MASK;
+	a |= ((u64)tag << KASAN_PTR_TAG_SHIFT);
+
+	return (void *)a;
+}
+
+static inline u8 get_tag(const void *addr)
+{
+	return (u8)((u64)addr >> KASAN_PTR_TAG_SHIFT);
+}
+
+static inline void *reset_tag(const void *addr)
+{
+	return set_tag(addr, KASAN_TAG_KERNEL);
+}
+
+#else /* CONFIG_KASAN_SW_TAGS */
+
+static inline u8 random_tag(void)
+{
+	return 0;
+}
+
+static inline void *set_tag(const void *addr, u8 tag)
+{
+	return (void *)addr;
+}
+
+static inline u8 get_tag(const void *addr)
+{
+	return 0;
+}
+
+static inline void *reset_tag(const void *addr)
+{
+	return (void *)addr;
+}
+
+#endif /* CONFIG_KASAN_SW_TAGS */
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 04194923c543..700323946867 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -38,6 +38,43 @@
 #include "kasan.h"
 #include "../slab.h"
 
+static DEFINE_PER_CPU(u32, prng_state);
+
+void kasan_init_tags(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(prng_state, cpu) = get_random_u32();
+}
+
+/*
+ * If a preemption happens between this_cpu_read and this_cpu_write, the only
+ * side effect is that we'll give a few allocated in different contexts objects
+ * the same tag. Since tag-based KASAN is meant to be used a probabilistic
+ * bug-detection debug feature, this doesn?t have significant negative impact.
+ *
+ * Ideally the tags use strong randomness to prevent any attempts to predict
+ * them during explicit exploit attempts. But strong randomness is expensive,
+ * and we did an intentional trade-off to use a PRNG. This non-atomic RMW
+ * sequence has in fact positive effect, since interrupts that randomly skew
+ * PRNG at unpredictable points do only good.
+ */
+u8 random_tag(void)
+{
+	u32 state = this_cpu_read(prng_state);
+
+	state = 1664525 * state + 1013904223;
+	this_cpu_write(prng_state, state);
+
+	return (u8)(state % (KASAN_TAG_MAX + 1));
+}
+
+void *kasan_reset_tag(const void *addr)
+{
+	return reset_tag(addr);
+}
+
 void check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip)
 {
-- 
2.19.1.930.g4563a0d9d0-goog
