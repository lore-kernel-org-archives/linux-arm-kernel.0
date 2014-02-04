From: will.deacon@arm.com (Will Deacon)
Date: Tue,  4 Feb 2014 12:29:13 +0000
Subject: [PATCH 2/2] arm64: asm: remove redundant "cc" clobbers
In-Reply-To: <1391516953-14541-1-git-send-email-will.deacon@arm.com>
References: <1391516953-14541-1-git-send-email-will.deacon@arm.com>
Message-ID: <1391516953-14541-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cbnz/tbnz don't update the condition flags, so remove the "cc" clobbers
from inline asm blocks that only use these instructions to implement
conditional branches.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic.h   | 24 ++++++++++--------------
 arch/arm64/include/asm/cmpxchg.h  |  8 ++++----
 arch/arm64/include/asm/futex.h    |  4 ++--
 arch/arm64/include/asm/spinlock.h | 10 +++++-----
 4 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index e32893e005d4..0237f0867e37 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -54,8 +54,7 @@ static inline void atomic_add(int i, atomic_t *v)
 "	stxr	%w1, %w0, %2\n"
 "	cbnz	%w1, 1b"
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
-	: "Ir" (i)
-	: "cc");
+	: "Ir" (i));
 }
 
 static inline int atomic_add_return(int i, atomic_t *v)
@@ -70,7 +69,7 @@ static inline int atomic_add_return(int i, atomic_t *v)
 "	cbnz	%w1, 1b"
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
 	: "Ir" (i)
-	: "cc", "memory");
+	: "memory");
 
 	smp_mb();
 	return result;
@@ -87,8 +86,7 @@ static inline void atomic_sub(int i, atomic_t *v)
 "	stxr	%w1, %w0, %2\n"
 "	cbnz	%w1, 1b"
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
-	: "Ir" (i)
-	: "cc");
+	: "Ir" (i));
 }
 
 static inline int atomic_sub_return(int i, atomic_t *v)
@@ -103,7 +101,7 @@ static inline int atomic_sub_return(int i, atomic_t *v)
 "	cbnz	%w1, 1b"
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
 	: "Ir" (i)
-	: "cc", "memory");
+	: "memory");
 
 	smp_mb();
 	return result;
@@ -125,7 +123,7 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
 "2:"
 	: "=&r" (tmp), "=&r" (oldval), "+Q" (ptr->counter)
 	: "Ir" (old), "r" (new)
-	: "cc", "memory");
+	: "cc");
 
 	smp_mb();
 	return oldval;
@@ -178,8 +176,7 @@ static inline void atomic64_add(u64 i, atomic64_t *v)
 "	stxr	%w1, %0, %2\n"
 "	cbnz	%w1, 1b"
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
-	: "Ir" (i)
-	: "cc");
+	: "Ir" (i));
 }
 
 static inline long atomic64_add_return(long i, atomic64_t *v)
@@ -194,7 +191,7 @@ static inline long atomic64_add_return(long i, atomic64_t *v)
 "	cbnz	%w1, 1b"
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
 	: "Ir" (i)
-	: "cc", "memory");
+	: "memory");
 
 	smp_mb();
 	return result;
@@ -211,8 +208,7 @@ static inline void atomic64_sub(u64 i, atomic64_t *v)
 "	stxr	%w1, %0, %2\n"
 "	cbnz	%w1, 1b"
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
-	: "Ir" (i)
-	: "cc");
+	: "Ir" (i));
 }
 
 static inline long atomic64_sub_return(long i, atomic64_t *v)
@@ -227,7 +223,7 @@ static inline long atomic64_sub_return(long i, atomic64_t *v)
 "	cbnz	%w1, 1b"
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
 	: "Ir" (i)
-	: "cc", "memory");
+	: "memory");
 
 	smp_mb();
 	return result;
@@ -249,7 +245,7 @@ static inline long atomic64_cmpxchg(atomic64_t *ptr, long old, long new)
 "2:"
 	: "=&r" (res), "=&r" (oldval), "+Q" (ptr->counter)
 	: "Ir" (old), "r" (new)
-	: "cc", "memory");
+	: "cc");
 
 	smp_mb();
 	return oldval;
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 189390ce8653..57c0fa7bf711 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -34,7 +34,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 		"	cbnz	%w1, 1b\n"
 			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u8 *)ptr)
 			: "r" (x)
-			: "cc", "memory");
+			: "memory");
 		break;
 	case 2:
 		asm volatile("//	__xchg2\n"
@@ -43,7 +43,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 		"	cbnz	%w1, 1b\n"
 			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u16 *)ptr)
 			: "r" (x)
-			: "cc", "memory");
+			: "memory");
 		break;
 	case 4:
 		asm volatile("//	__xchg4\n"
@@ -52,7 +52,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 		"	cbnz	%w1, 1b\n"
 			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u32 *)ptr)
 			: "r" (x)
-			: "cc", "memory");
+			: "memory");
 		break;
 	case 8:
 		asm volatile("//	__xchg8\n"
@@ -61,7 +61,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 		"	cbnz	%w1, 1b\n"
 			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u64 *)ptr)
 			: "r" (x)
-			: "cc", "memory");
+			: "memory");
 		break;
 	default:
 		BUILD_BUG();
diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 572193d0005d..5f750dc96e0f 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -41,7 +41,7 @@
 "	.popsection\n"							\
 	: "=&r" (ret), "=&r" (oldval), "+Q" (*uaddr), "=&r" (tmp)	\
 	: "r" (oparg), "Ir" (-EFAULT)					\
-	: "cc", "memory")
+	: "memory")
 
 static inline int
 futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
@@ -129,7 +129,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 "	.popsection\n"
 	: "+r" (ret), "=&r" (val), "+Q" (*uaddr), "=&r" (tmp)
 	: "r" (oldval), "r" (newval), "Ir" (-EFAULT)
-	: "cc", "memory");
+	: "memory");
 
 	*uval = val;
 	return ret;
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 3d5cf064d7a1..c45b7b1b7197 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -132,7 +132,7 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 	"	cbnz	%w0, 2b\n"
 	: "=&r" (tmp), "+Q" (rw->lock)
 	: "r" (0x80000000)
-	: "cc", "memory");
+	: "memory");
 }
 
 static inline int arch_write_trylock(arch_rwlock_t *rw)
@@ -146,7 +146,7 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 	"1:\n"
 	: "=&r" (tmp), "+Q" (rw->lock)
 	: "r" (0x80000000)
-	: "cc", "memory");
+	: "memory");
 
 	return !tmp;
 }
@@ -187,7 +187,7 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 	"	cbnz	%w1, 2b\n"
 	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
 	:
-	: "cc", "memory");
+	: "memory");
 }
 
 static inline void arch_read_unlock(arch_rwlock_t *rw)
@@ -201,7 +201,7 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 	"	cbnz	%w1, 1b\n"
 	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
 	:
-	: "cc", "memory");
+	: "memory");
 }
 
 static inline int arch_read_trylock(arch_rwlock_t *rw)
@@ -216,7 +216,7 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 	"1:\n"
 	: "=&r" (tmp), "+r" (tmp2), "+Q" (rw->lock)
 	:
-	: "cc", "memory");
+	: "memory");
 
 	return !tmp2;
 }
-- 
1.8.2.2
