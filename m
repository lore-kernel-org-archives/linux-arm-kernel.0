From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 19 Mar 2015 14:52:31 +0000
Subject: [PATCH] arm64: percpu: Make this_cpu accessors pre-empt safe
Message-ID: <1426776751-20526-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this_cpu operations were implemented for arm64 in:
 5284e1b arm64: xchg: Implement cmpxchg_double
 f97fc81 arm64: percpu: Implement this_cpu operations

Unfortunately, it is possible for pre-emption to take place between
address generation and data access. This can lead to cases where data
is being manipulated by this_cpu for a different CPU than it was
called on. Which effectively breaks the spec.

This patch disables pre-emption for the this_cpu operations
guaranteeing that address generation and data manipulation.

Fixes: 5284e1b: arm64: xchg: Implement cmpxchg_double
Fixes: f97fc81: arm64: percpu: Implement this_cpu operations
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/include/asm/cmpxchg.h | 32 ++++++++++++++++------
 arch/arm64/include/asm/percpu.h  | 57 ++++++++++++++++++++++++++++++++--------
 2 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index cb95930..0ff749b 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -246,14 +246,30 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 	__ret; \
 })
 
-#define this_cpu_cmpxchg_1(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
-#define this_cpu_cmpxchg_2(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
-#define this_cpu_cmpxchg_4(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
-#define this_cpu_cmpxchg_8(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
-
-#define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2) \
-	cmpxchg_double_local(raw_cpu_ptr(&(ptr1)), raw_cpu_ptr(&(ptr2)), \
-				o1, o2, n1, n2)
+#define _protect_cmpxchg_local(pcp, o, n)			\
+({								\
+	typeof(*raw_cpu_ptr(&(pcp))) __ret;			\
+	__pcp_preempt_disable();				\
+	__ret = cmpxchg_local(raw_cpu_ptr(&(pcp)), o, n);	\
+	__pcp_preempt_enable();					\
+	__ret;							\
+})
+
+#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+
+#define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2)		\
+({									\
+	int __ret;							\
+	__pcp_preempt_disable();					\
+	__ret = cmpxchg_double_local(	raw_cpu_ptr(&(ptr1)),		\
+					raw_cpu_ptr(&(ptr2)),		\
+					o1, o2, n1, n2);		\
+	__pcp_preempt_enable();						\
+	__ret;								\
+})
 
 #define cmpxchg64(ptr,o,n)		cmpxchg((ptr),(o),(n))
 #define cmpxchg64_local(ptr,o,n)	cmpxchg_local((ptr),(o),(n))
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 09da25b..94f118e 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -204,25 +204,60 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
 	return ret;
 }
 
+/*
+ * Modules aren't allowed to use preempt_enable_no_resched, and it is
+ * undef'ed. If we are unable to use preempt_enable_no_resched, then
+ * fallback to the standard preempt_enable.
+ */
+#ifdef preempt_enable_no_resched
+#define __pcp_preempt_enable()	preempt_enable_no_resched()
+#else
+#define __pcp_preempt_enable()	preempt_enable()
+#endif /* preempt_enable_no_resched */
+
+#define	__pcp_preempt_disable()	preempt_disable()
+
+#define _percpu_read(pcp)						\
+({									\
+	typeof(pcp) __retval;						\
+	__pcp_preempt_disable();					\
+	__retval = (typeof(pcp)) __percpu_read(raw_cpu_ptr(&(pcp)), 	\
+					sizeof(pcp));			\
+	__pcp_preempt_enable();						\
+	__retval;							\
+})
+
+#define _percpu_write(pcp, val)						\
+do {									\
+	__pcp_preempt_disable();					\
+	__percpu_write(raw_cpu_ptr(&(pcp)), (unsigned long) (val), 	\
+				sizeof(pcp));				\
+	__pcp_preempt_enable();						\
+} while(0)								\
+
+#define _pcp_protect(operation, pcp, val)			\
+({								\
+	typeof(pcp) __retval;					\
+	__pcp_preempt_disable();				\
+	__retval = (typeof(pcp)) operation(raw_cpu_ptr(&(pcp)),	\
+				(val), sizeof(pcp));		\
+	__pcp_preempt_enable();					\
+	__retval;						\
+})
+
 #define _percpu_add(pcp, val) \
-	__percpu_add(raw_cpu_ptr(&(pcp)), val, sizeof(pcp))
+	_pcp_protect(__percpu_add, pcp, val)
 
-#define _percpu_add_return(pcp, val) (typeof(pcp)) (_percpu_add(pcp, val))
+#define _percpu_add_return(pcp, val) _percpu_add(pcp, val)
 
 #define _percpu_and(pcp, val) \
-	__percpu_and(raw_cpu_ptr(&(pcp)), val, sizeof(pcp))
+	_pcp_protect(__percpu_and, pcp, val)
 
 #define _percpu_or(pcp, val) \
-	__percpu_or(raw_cpu_ptr(&(pcp)), val, sizeof(pcp))
-
-#define _percpu_read(pcp) (typeof(pcp))	\
-	(__percpu_read(raw_cpu_ptr(&(pcp)), sizeof(pcp)))
-
-#define _percpu_write(pcp, val) \
-	__percpu_write(raw_cpu_ptr(&(pcp)), (unsigned long)(val), sizeof(pcp))
+	_pcp_protect(__percpu_or, pcp, val)
 
 #define _percpu_xchg(pcp, val) (typeof(pcp)) \
-	(__percpu_xchg(raw_cpu_ptr(&(pcp)), (unsigned long)(val), sizeof(pcp)))
+	_pcp_protect(__percpu_xchg, pcp, (unsigned long)(val))
 
 #define this_cpu_add_1(pcp, val) _percpu_add(pcp, val)
 #define this_cpu_add_2(pcp, val) _percpu_add(pcp, val)
-- 
2.1.0
