From: rabin@rab.in (Rabin Vincent)
Date: Mon, 11 Jan 2010 20:36:26 +0530
Subject: [PATCH] spinlock: don't use deprecated barriers on ARMv7
Message-ID: <mailman.172.1264441826.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARMv7, the use of the cp15 operations for barriers is deprecated in
favour of the isb, dsb, and dmb instructions.  Change the locking
functions to use the appropriate type of dsb for the architecture being
built for.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/include/asm/spinlock.h |   36 +++++++++++++++++++++++-------------
 1 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index c91c64c..17eb355 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -5,6 +5,22 @@
 #error SMP not supported on pre-ARMv6 CPUs
 #endif
 
+static inline void dsb_sev(void)
+{
+#if __LINUX_ARM_ARCH__ >= 7
+	__asm__ __volatile__ (
+		"dsb\n"
+		"sev"
+	);
+#elif defined(CONFIG_CPU_32v6K)
+	__asm__ __volatile__ (
+		"mcr p15, 0, %0, c7, c10, 4\n"
+		"sev"
+		: : "r" (0)
+	);
+#endif
+}
+
 /*
  * ARMv6 Spin-locking.
  *
@@ -69,13 +85,11 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 
 	__asm__ __volatile__(
 "	str	%1, [%0]\n"
-#ifdef CONFIG_CPU_32v6K
-"	mcr	p15, 0, %1, c7, c10, 4\n" /* DSB */
-"	sev"
-#endif
 	:
 	: "r" (&lock->lock), "r" (0)
 	: "cc");
+
+	dsb_sev();
 }
 
 /*
@@ -132,13 +146,11 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 
 	__asm__ __volatile__(
 	"str	%1, [%0]\n"
-#ifdef CONFIG_CPU_32v6K
-"	mcr	p15, 0, %1, c7, c10, 4\n" /* DSB */
-"	sev\n"
-#endif
 	:
 	: "r" (&rw->lock), "r" (0)
 	: "cc");
+
+	dsb_sev();
 }
 
 /* write_can_lock - would write_trylock() succeed? */
@@ -188,14 +200,12 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 "	strex	%1, %0, [%2]\n"
 "	teq	%1, #0\n"
 "	bne	1b"
-#ifdef CONFIG_CPU_32v6K
-"\n	cmp	%0, #0\n"
-"	mcreq   p15, 0, %0, c7, c10, 4\n"
-"	seveq"
-#endif
 	: "=&r" (tmp), "=&r" (tmp2)
 	: "r" (&rw->lock)
 	: "cc");
+
+	if (tmp == 0)
+		dsb_sev();
 }
 
 static inline int arch_read_trylock(arch_rwlock_t *rw)
-- 
1.6.6
