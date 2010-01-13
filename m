From: rabin@rab.in (Rabin Vincent)
Date: Wed, 13 Jan 2010 21:15:36 +0530
Subject: [PATCH] spinlock: don't use deprecated barriers on ARMv7
Message-ID: <1263397536-15736-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARMv7, the use of the cp15 operations for barriers is deprecated in
favour of the isb, dsb, and dmb instructions.  Change the locking
functions to use the appropriate type of dsb for the architecture being
built for.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/include/asm/spinlock.h |   20 +++++++-------------
 arch/arm/include/asm/system.h   |    8 ++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index c91c64c..9ed1064 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -69,13 +69,11 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 
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
+	smp_sev();
 }
 
 /*
@@ -132,13 +130,11 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 
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
+	smp_sev();
 }
 
 /* write_can_lock - would write_trylock() succeed? */
@@ -188,14 +184,12 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
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
+		smp_sev();
 }
 
 static inline int arch_read_trylock(arch_rwlock_t *rw)
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 058e7e9..0b371ba 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -164,6 +164,14 @@ extern unsigned int user_debug;
 #define set_mb(var, value)	do { var = value; smp_mb(); } while (0)
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
+static inline void smp_sev(void)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_CPU_32v6K)
+	dsb();
+	__asm__ __volatile__ ("sev" : : : "memory");
+#endif
+}
+
 extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
-- 
1.6.5
