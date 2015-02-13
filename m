From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:41:01 +0800
Subject: [RFC PATCH v3 18/26] early kprobes: allows __alloc_insn_slot() from
 early kprobes slots.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806061-62236-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduces early_slots_start/end and bitmap for struct kprobe_insn_cache
then uses previous introduced macro to generate allocator. This patch
makes get/free_insn_slot() and get/free_optinsn_slot() transparent to
early kprobes.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/kprobes.h | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/kprobes.c        | 14 ++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index cd7a2a5..6100678 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -319,6 +319,17 @@ static inline int ek_free_##__name(__t *__s)				\
 			(__ek_##__name##_bitmap));			\
 }
 
+/*
+ * Start and end of early kprobes area, including code area and
+ * insn_slot area.
+ */
+extern char __early_kprobes_start[];
+extern char __early_kprobes_end[];
+
+extern kprobe_opcode_t __early_kprobes_code_area_start[];
+extern kprobe_opcode_t __early_kprobes_code_area_end[];
+extern kprobe_opcode_t __early_kprobes_insn_slot_start[];
+extern kprobe_opcode_t __early_kprobes_insn_slot_end[];
 
 #else
 #define __DEFINE_EKPROBE_ALLOC_OPS(__t, __name)				\
@@ -348,6 +359,8 @@ static inline int ek_free_##__name(__t *__s)				\
 
 #endif
 
+__DEFINE_EKPROBE_ALLOC_OPS(kprobe_opcode_t, opcode)
+
 struct kprobe_insn_cache {
 	struct mutex mutex;
 	void *(*alloc)(void);	/* allocate insn page */
@@ -355,8 +368,35 @@ struct kprobe_insn_cache {
 	struct list_head pages; /* list of kprobe_insn_page */
 	size_t insn_size;	/* size of instruction slot */
 	int nr_garbage;
+#ifdef CONFIG_EARLY_KPROBES
+# define slots_start(c)	((c)->early_slots_start)
+# define slots_end(c)	((c)->early_slots_end)
+# define slots_bitmap(c)	((c)->early_slots_bitmap)
+	kprobe_opcode_t *early_slots_start;
+	kprobe_opcode_t *early_slots_end;
+	unsigned long early_slots_bitmap[EARLY_KPROBES_BITMAP_SZ];
+#else
+# define slots_start(c)	NULL
+# define slots_end(c)	NULL
+# define slots_bitmap(c)	NULL
+#endif
 };
 
+static inline kprobe_opcode_t *
+__get_insn_slot_early(struct kprobe_insn_cache *c)
+{
+	return __ek_alloc_opcode(slots_start(c),
+			slots_end(c), slots_bitmap(c));
+}
+
+static inline int
+__free_insn_slot_early(struct kprobe_insn_cache *c,
+		kprobe_opcode_t *slot)
+{
+	return __ek_free_opcode(slot, slots_start(c),
+			slots_end(c), slots_bitmap(c));
+}
+
 extern kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c);
 extern void __free_insn_slot(struct kprobe_insn_cache *c,
 			     kprobe_opcode_t *slot, int dirty);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 647c95a..fa1e422 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -143,6 +143,10 @@ struct kprobe_insn_cache kprobe_insn_slots = {
 	.pages = LIST_HEAD_INIT(kprobe_insn_slots.pages),
 	.insn_size = MAX_INSN_SIZE,
 	.nr_garbage = 0,
+#ifdef CONFIG_EARLY_KPROBES
+	.early_slots_start = __early_kprobes_insn_slot_start,
+	.early_slots_end = __early_kprobes_insn_slot_end,
+#endif
 };
 static int collect_garbage_slots(struct kprobe_insn_cache *c);
 
@@ -155,6 +159,9 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	struct kprobe_insn_page *kip;
 	kprobe_opcode_t *slot = NULL;
 
+	if (kprobes_is_early())
+		return __get_insn_slot_early(c);
+
 	mutex_lock(&c->mutex);
  retry:
 	list_for_each_entry(kip, &c->pages, list) {
@@ -255,6 +262,9 @@ void __free_insn_slot(struct kprobe_insn_cache *c,
 {
 	struct kprobe_insn_page *kip;
 
+	if (unlikely(__free_insn_slot_early(c, slot)))
+		return;
+
 	mutex_lock(&c->mutex);
 	list_for_each_entry(kip, &c->pages, list) {
 		long idx = ((long)slot - (long)kip->insns) /
@@ -286,6 +296,10 @@ struct kprobe_insn_cache kprobe_optinsn_slots = {
 	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
 	/* .insn_size is initialized later */
 	.nr_garbage = 0,
+#ifdef CONFIG_EARLY_KPROBES
+	.early_slots_start = __early_kprobes_code_area_start,
+	.early_slots_end = __early_kprobes_code_area_end,
+#endif
 };
 #endif
 #endif
-- 
1.8.4
