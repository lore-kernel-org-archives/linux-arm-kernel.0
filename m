From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:49 +0800
Subject: [RFC PATCH v4 11/34] early kprobes: introduces macros for allocing
 early kprobe resources.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-12-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduces macros to genearte common early kprobe related resource
allocator.

All early kprobe related resources are statically allocated during
linking for each early kprobe slot. For each type of resource, a bitmap
is used to track allocation. __DEFINE_EKPROBE_ALLOC_OPS defines alloc
and free handler for them. The range of the resource and the bitmap
should be provided for allocaing and freeing. DEFINE_EKPROBE_ALLOC_OPS
defines bitmap and the array used by it.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/kprobes.h | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index b7cb992..3d721eb 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -269,6 +269,83 @@ extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
 
+#ifdef CONFIG_EARLY_KPROBES
+
+#define NR_EARLY_KPROBES_SLOTS	CONFIG_NR_EARLY_KPROBES_SLOTS
+#define EARLY_KPROBES_BITMAP_SZ	round_up(NR_EARLY_KPROBES_SLOTS, BITS_PER_LONG)
+
+#define __ek_in_range(v, s, e)	(((v) >= (s)) && ((v) < (e)))
+#define __ek_buf_sz(s, e)	((void *)(e) - (void *)(s))
+#define __ek_elem_sz_b(s, e)	(__ek_buf_sz(s, e) / NR_EARLY_KPROBES_SLOTS)
+#define __ek_elem_sz(s, e)	(__ek_elem_sz_b(s, e) / sizeof(s[0]))
+#define __ek_elem_idx(v, s, e)	(__ek_buf_sz(s, v) / __ek_elem_sz_b(s, e))
+#define __ek_get_elem(i, s, e)	(&((s)[__ek_elem_sz(s, e) * (i)]))
+#define __DEFINE_EKPROBE_ALLOC_OPS(__t, __name)				\
+static inline __t *__ek_alloc_##__name(__t *__s, __t *__e, unsigned long *__b)\
+{									\
+	int __i = find_next_zero_bit(__b, NR_EARLY_KPROBES_SLOTS, 0);	\
+	if (__i >= NR_EARLY_KPROBES_SLOTS)				\
+		return NULL;						\
+	set_bit(__i, __b);						\
+	return __ek_get_elem(__i, __s, __e);				\
+}									\
+static inline int __ek_free_##__name(__t *__v, __t *__s, __t *__e, unsigned long *__b)	\
+{									\
+	if (!__ek_in_range(__v, __s, __e))				\
+		return 0;						\
+	clear_bit(__ek_elem_idx(__v, __s, __e), __b);			\
+	return 1;							\
+}
+
+#define __DEFINE_EKPROBE_AREA(__t, __name, __static)			\
+__static __t __ek_##__name##_slots[NR_EARLY_KPROBES_SLOTS];		\
+__static unsigned long __ek_##__name##_bitmap[EARLY_KPROBES_BITMAP_SZ];
+
+#define DEFINE_EKPROBE_ALLOC_OPS(__t, __name, __static)			\
+__DEFINE_EKPROBE_AREA(__t, __name, __static)				\
+__DEFINE_EKPROBE_ALLOC_OPS(__t, __name)					\
+static inline __t *ek_alloc_##__name(void)				\
+{									\
+	return __ek_alloc_##__name(&((__ek_##__name##_slots)[0]),	\
+			&((__ek_##__name##_slots)[NR_EARLY_KPROBES_SLOTS]),\
+			(__ek_##__name##_bitmap));			\
+}									\
+static inline int ek_free_##__name(__t *__s)				\
+{									\
+	return __ek_free_##__name(__s, &((__ek_##__name##_slots)[0]),	\
+			&((__ek_##__name##_slots)[NR_EARLY_KPROBES_SLOTS]),\
+			(__ek_##__name##_bitmap));			\
+}
+
+
+#else
+#define __DEFINE_EKPROBE_ALLOC_OPS(__t, __name)				\
+static inline __t *__ek_alloc_##__name(__t *__s, __t *__e, unsigned long *__b)\
+{									\
+	return NULL;							\
+}									\
+static inline int __ek_free_##__name(__t *__v, __t *__s, __t *__e, unsigned long *__b)\
+{									\
+	return 0;							\
+}
+
+#define __DEFINE_EKPROBE_AREA(__t, __name, __static)			\
+__static __t __ek_##__name##_slots[0];					\
+__static unsigned long __ek_##__name##_bitmap[0];
+
+#define DEFINE_EKPROBE_ALLOC_OPS(__t, __name, __static)			\
+__DEFINE_EKPROBE_ALLOC_OPS(__t, __name)					\
+static inline __t *ek_alloc_##__name(void)				\
+{									\
+	return NULL;							\
+}									\
+static inline int ek_free_##__name(__t *__s)				\
+{									\
+	return 0;							\
+}
+
+#endif
+
 struct kprobe_insn_cache {
 	struct mutex mutex;
 	void *(*alloc)(void);	/* allocate insn page */
-- 
1.8.4
