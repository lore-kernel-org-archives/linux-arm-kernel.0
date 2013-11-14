From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 14 Nov 2013 15:19:47 +0000
Subject: [PATCH] xen/arm: remove !CPU_V6 and !GENERIC_ATOMIC64 build
 dependencies for XEN
Message-ID: <1384442387-18519-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove !GENERIC_ATOMIC64 build dependency:
- rename atomic64_xchg to armv7_atomic64_xchg and define it even ifdef
  GENERIC_ATOMIC64;
- call armv7_atomic64_xchg directly from xen/events.h.

Remove !CPU_V6 build dependency:
- introduce __cmpxchg8 and __cmpxchg16, compiled even ifdef
  CONFIG_CPU_V6;
- rename sync_cmpxchg to sync_cmpxchg16;
- implement sync_cmpxchg16 using __cmpxchg16.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: arnd at arndb.de
CC: linux at arm.linux.org.uk
---
 arch/arm/Kconfig                   |    3 +-
 arch/arm/include/asm/atomic.h      |   47 +++++++++++++++------------
 arch/arm/include/asm/cmpxchg.h     |   60 ++++++++++++++++++++++++------------
 arch/arm/include/asm/sync_bitops.h |   11 ++++++-
 arch/arm/include/asm/xen/events.h  |    2 +-
 drivers/xen/grant-table.c          |    6 ++--
 6 files changed, 81 insertions(+), 48 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 01f7013..3a888e1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1885,8 +1885,7 @@ config XEN_DOM0
 config XEN
 	bool "Xen guest support on ARM (EXPERIMENTAL)"
 	depends on ARM && AEABI && OF
-	depends on CPU_V7 && !CPU_V6
-	depends on !GENERIC_ATOMIC64
+	depends on CPU_V7
 	select ARM_PSCI
 	select SWIOTLB_XEN
 	help
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index da1c77d..6d22634 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -398,26 +398,7 @@ static inline u64 atomic64_cmpxchg(atomic64_t *ptr, u64 old, u64 new)
 	return oldval;
 }
 
-static inline u64 atomic64_xchg(atomic64_t *ptr, u64 new)
-{
-	u64 result;
-	unsigned long tmp;
-
-	smp_mb();
-
-	__asm__ __volatile__("@ atomic64_xchg\n"
-"1:	ldrexd	%0, %H0, [%3]\n"
-"	strexd	%1, %4, %H4, [%3]\n"
-"	teq	%1, #0\n"
-"	bne	1b"
-	: "=&r" (result), "=&r" (tmp), "+Qo" (ptr->counter)
-	: "r" (&ptr->counter), "r" (new)
-	: "cc");
-
-	smp_mb();
-
-	return result;
-}
+#define armv7_atomic64_xchg atomic64_xchg
 
 static inline u64 atomic64_dec_if_positive(atomic64_t *v)
 {
@@ -485,6 +466,30 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 #define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
 
-#endif /* !CONFIG_GENERIC_ATOMIC64 */
+#else /* !CONFIG_GENERIC_ATOMIC64 */
+#include <asm-generic/atomic64.h>
+#endif
+
+static inline u64 armv7_atomic64_xchg(atomic64_t *ptr, u64 new)
+{
+	u64 result;
+	unsigned long tmp;
+
+	smp_mb();
+
+	__asm__ __volatile__("@ atomic64_xchg\n"
+"1:	ldrexd	%0, %H0, [%3]\n"
+"	strexd	%1, %4, %H4, [%3]\n"
+"	teq	%1, #0\n"
+"	bne	1b"
+	: "=&r" (result), "=&r" (tmp), "+Qo" (ptr->counter)
+	: "r" (&ptr->counter), "r" (new)
+	: "cc");
+
+	smp_mb();
+
+	return result;
+}
+
 #endif
 #endif
diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 4f009c1..5b5eeb9 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -133,6 +133,44 @@ extern void __bad_cmpxchg(volatile void *ptr, int size);
  * cmpxchg only support 32-bits operands on ARMv6.
  */
 
+static inline unsigned long __cmpxchg8(volatile void *ptr, unsigned long old,
+				      unsigned long new)
+{
+	unsigned long oldval, res;
+
+	do {
+		asm volatile("@ __cmpxchg1\n"
+		"	ldrexb	%1, [%2]\n"
+		"	mov	%0, #0\n"
+		"	teq	%1, %3\n"
+		"	strexbeq %0, %4, [%2]\n"
+			: "=&r" (res), "=&r" (oldval)
+			: "r" (ptr), "Ir" (old), "r" (new)
+			: "memory", "cc");
+	} while (res);
+
+	return oldval;
+}
+
+static inline unsigned long __cmpxchg16(volatile void *ptr, unsigned long old,
+				      unsigned long new)
+{
+	unsigned long oldval, res;
+
+	do {
+		asm volatile("@ __cmpxchg1\n"
+		"	ldrexh	%1, [%2]\n"
+		"	mov	%0, #0\n"
+		"	teq	%1, %3\n"
+		"	strexheq %0, %4, [%2]\n"
+			: "=&r" (res), "=&r" (oldval)
+			: "r" (ptr), "Ir" (old), "r" (new)
+			: "memory", "cc");
+	} while (res);
+
+	return oldval;
+}
+
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      unsigned long new, int size)
 {
@@ -141,28 +179,10 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	switch (size) {
 #ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
 	case 1:
-		do {
-			asm volatile("@ __cmpxchg1\n"
-			"	ldrexb	%1, [%2]\n"
-			"	mov	%0, #0\n"
-			"	teq	%1, %3\n"
-			"	strexbeq %0, %4, [%2]\n"
-				: "=&r" (res), "=&r" (oldval)
-				: "r" (ptr), "Ir" (old), "r" (new)
-				: "memory", "cc");
-		} while (res);
+		__cmpxchg8(ptr, old, new);
 		break;
 	case 2:
-		do {
-			asm volatile("@ __cmpxchg1\n"
-			"	ldrexh	%1, [%2]\n"
-			"	mov	%0, #0\n"
-			"	teq	%1, %3\n"
-			"	strexheq %0, %4, [%2]\n"
-				: "=&r" (res), "=&r" (oldval)
-				: "r" (ptr), "Ir" (old), "r" (new)
-				: "memory", "cc");
-		} while (res);
+		__cmpxchg16(ptr, old, new);
 		break;
 #endif
 	case 4:
diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
index 63479ee..02865ad 100644
--- a/arch/arm/include/asm/sync_bitops.h
+++ b/arch/arm/include/asm/sync_bitops.h
@@ -21,7 +21,16 @@
 #define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
 #define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
 #define sync_test_bit(nr, addr)		test_bit(nr, addr)
-#define sync_cmpxchg			cmpxchg
 
+static inline u16 sync_cmpxchg16(volatile void *ptr, u16 old, u16 new)
+{
+	unsigned long ret;
+
+	smp_mb();
+	ret = __cmpxchg16(ptr, old, new);
+	smp_mb();
+
+	return ret;
+}
 
 #endif
diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
index 8b1f37b..4269519 100644
--- a/arch/arm/include/asm/xen/events.h
+++ b/arch/arm/include/asm/xen/events.h
@@ -16,7 +16,7 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 	return raw_irqs_disabled_flags(regs->ARM_cpsr);
 }
 
-#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((ptr),	\
+#define xchg_xen_ulong(ptr, val) armv7_atomic64_xchg(container_of((ptr),	\
 							    atomic64_t,	\
 							    counter), (val))
 
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 62ccf54..bd37c14 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -430,7 +430,7 @@ static int gnttab_end_foreign_access_ref_v1(grant_ref_t ref, int readonly)
 		flags = nflags;
 		if (flags & (GTF_reading|GTF_writing))
 			return 0;
-	} while ((nflags = sync_cmpxchg(pflags, flags, 0)) != flags);
+	} while ((nflags = sync_cmpxchg16(pflags, flags, 0)) != flags);
 
 	return 1;
 }
@@ -600,7 +600,7 @@ static unsigned long gnttab_end_foreign_transfer_ref_v1(grant_ref_t ref)
 	 * reference and return failure (== 0).
 	 */
 	while (!((flags = *pflags) & GTF_transfer_committed)) {
-		if (sync_cmpxchg(pflags, flags, 0) == flags)
+		if (sync_cmpxchg16(pflags, flags, 0) == flags)
 			return 0;
 		cpu_relax();
 	}
@@ -631,7 +631,7 @@ static unsigned long gnttab_end_foreign_transfer_ref_v2(grant_ref_t ref)
 	 * reference and return failure (== 0).
 	 */
 	while (!((flags = *pflags) & GTF_transfer_committed)) {
-		if (sync_cmpxchg(pflags, flags, 0) == flags)
+		if (sync_cmpxchg16(pflags, flags, 0) == flags)
 			return 0;
 		cpu_relax();
 	}
-- 
1.7.2.5
