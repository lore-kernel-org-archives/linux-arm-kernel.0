From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jun 2016 14:12:15 +0100
Subject: [PATCH] arm64: barrier: implement wfe-base smp_cond_load_acquire
Message-ID: <1466169136-28672-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

smp_cond_load_acquire is used to spin on a variable until some
expression involving that variable becomes true.

On arm64, we can build this using WFE and LDXR, since clearing of the
exclusive monitor as a result of the variable being changed by another
CPU generates an event, which will wake us up out of WFE.

This patch implements smp_cond_load_acquire using LDAXR and WFE, which
themselves are contained in an internal __cmpwait_acquire function.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Based on Peter's locking/core branch.

 arch/arm64/include/asm/barrier.h | 13 ++++++++++
 arch/arm64/include/asm/cmpxchg.h | 52 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index dae5c49618db..4bb2b09f8ca9 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -91,6 +91,19 @@ do {									\
 	__u.__val;							\
 })
 
+#define smp_cond_load_acquire(ptr, cond_expr)				\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	typeof(*ptr) VAL;						\
+	for (;;) {							\
+		VAL = smp_load_acquire(__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		__cmpwait_acquire(__PTR, VAL);				\
+	}								\
+	VAL;								\
+})
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 510c7b404454..84b83e521edc 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -224,4 +224,56 @@ __CMPXCHG_GEN(_mb)
 	__ret;								\
 })
 
+#define __CMPWAIT_CASE(w, sz, name, acq, cl)				\
+static inline void __cmpwait_case_##name(volatile void *ptr,		\
+					 unsigned long val)		\
+{									\
+	unsigned long tmp;						\
+									\
+	asm volatile(							\
+	"	ld" #acq "xr" #sz "\t%" #w "[tmp], %[v]\n"		\
+	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+	"	cbnz	%" #w "[tmp], 1f\n"				\
+	"	wfe\n"							\
+	"1:"								\
+	: [tmp] "=&r" (tmp), [v] "+Q" (*(unsigned long *)ptr)		\
+	: [val] "r" (val)						\
+	: cl);								\
+}
+
+__CMPWAIT_CASE(w, b, acq_1, a, "memory");
+__CMPWAIT_CASE(w, h, acq_2, a, "memory");
+__CMPWAIT_CASE(w,  , acq_4, a, "memory");
+__CMPWAIT_CASE( ,  , acq_8, a, "memory");
+
+#undef __CMPWAIT_CASE
+
+#define __CMPWAIT_GEN(sfx)						\
+static inline void __cmpwait##sfx(volatile void *ptr,			\
+				  unsigned long val,			\
+				  int size)				\
+{									\
+	switch (size) {							\
+	case 1:								\
+		return __cmpwait_case##sfx##_1(ptr, (u8)val);		\
+	case 2:								\
+		return __cmpwait_case##sfx##_2(ptr, (u16)val);		\
+	case 4:								\
+		return __cmpwait_case##sfx##_4(ptr, val);		\
+	case 8:								\
+		return __cmpwait_case##sfx##_8(ptr, val);		\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+									\
+	unreachable();							\
+}
+
+__CMPWAIT_GEN(_acq)
+
+#undef __CMPWAIT_GEN
+
+#define __cmpwait_acquire(ptr, val) \
+	__cmpwait_acq((ptr), (unsigned long)(val), sizeof(*(ptr)))
+
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.1.4
