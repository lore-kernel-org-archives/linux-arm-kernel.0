From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 22 Dec 2015 14:17:17 +0000
Subject: [PATCH RESEND v4] arm: remove !CPU_V6 and !GENERIC_ATOMIC64 build
 dependencies for XEN
Message-ID: <alpine.DEB.2.02.1512221404060.3096@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

Would you please consider this patch for the next merge window? It
is a very old patch (March 2014) which has been left over.

See some of the original threads here:

http://marc.info/?l=linux-arm-kernel&m=138920414402610&w=2
http://marc.info/?l=linux-arm-kernel&m=139031200118436&w=2

Many thanks,

Stefano

---

Remove !GENERIC_ATOMIC64 build dependency:
- introduce xen_atomic64_xchg
- use it to implement xchg_xen_ulong

Remove !CPU_V6 build dependency:
- introduce __cmpxchg8 and __cmpxchg16, compiled even ifdef
  CONFIG_CPU_V6
- implement sync_cmpxchg using __cmpxchg8 and __cmpxchg16

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Acked-by: Ian Campbell <ian.campbell@citrix.com>
CC: arnd at arndb.de
CC: will.deacon at arm.com
CC: catalin.marinas at arm.com
CC: linux-arm-kernel at lists.infradead.org
CC: linux-kernel at vger.kernel.org
CC: xen-devel at lists.xenproject.org

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 34e1569..e09ed94 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1807,8 +1807,7 @@ config XEN_DOM0
 config XEN
 	bool "Xen guest support on ARM"
 	depends on ARM && AEABI && OF
-	depends on CPU_V7 && !CPU_V6
-	depends on !GENERIC_ATOMIC64
+	depends on CPU_V7
 	depends on MMU
 	select ARCH_DMA_ADDR_T_64BIT
 	select ARM_PSCI
diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 97882f9..3b342ec 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -152,6 +152,44 @@ extern void __bad_cmpxchg(volatile void *ptr, int size);
  * cmpxchg only support 32-bits operands on ARMv6.
  */
 
+static inline unsigned long __cmpxchg8(volatile void *ptr, unsigned long old,
+				      unsigned long new)
+{
+	unsigned long oldval, res;
+
+	do {
+		asm volatile("@ __cmpxchg8\n"
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
+		asm volatile("@ __cmpxchg16\n"
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
@@ -162,28 +200,10 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
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
+		oldval = __cmpxchg8(ptr, old, new);
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
+		oldval = __cmpxchg16(ptr, old, new);
 		break;
 #endif
 	case 4:
diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
index 9732b8e..4103319 100644
--- a/arch/arm/include/asm/sync_bitops.h
+++ b/arch/arm/include/asm/sync_bitops.h
@@ -20,7 +20,29 @@
 #define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
 #define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
 #define sync_test_bit(nr, addr)		test_bit(nr, addr)
-#define sync_cmpxchg			cmpxchg
 
+static inline unsigned long sync_cmpxchg(volatile void *ptr,
+										 unsigned long old,
+										 unsigned long new)
+{
+	unsigned long oldval;
+	int size = sizeof(*(ptr));
+
+	smp_mb();
+	switch (size) {
+	case 1:
+		oldval = __cmpxchg8(ptr, old, new);
+		break;
+	case 2:
+		oldval = __cmpxchg16(ptr, old, new);
+		break;
+	default:
+		oldval = __cmpxchg(ptr, old, new, size);
+		break;
+	}
+	smp_mb();
+
+	return oldval;
+}
 
 #endif
diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
index 71e473d..f646422 100644
--- a/arch/arm/include/asm/xen/events.h
+++ b/arch/arm/include/asm/xen/events.h
@@ -16,7 +16,37 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 	return raw_irqs_disabled_flags(regs->ARM_cpsr);
 }
 
-#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((ptr),	\
+#ifdef CONFIG_GENERIC_ATOMIC64
+/* if CONFIG_GENERIC_ATOMIC64 is defined we cannot use the generic
+ * atomic64_xchg function because it is implemented using spin locks.
+ * Here we need proper atomic instructions to read and write memory
+ * shared with the hypervisor.
+ */
+static inline u64 xen_atomic64_xchg(atomic64_t *ptr, u64 new)
+{
+	u64 result;
+	unsigned long tmp;
+
+	smp_mb();
+
+	__asm__ __volatile__("@ xen_atomic64_xchg\n"
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
+#else
+#define xen_atomic64_xchg atomic64_xchg
+#endif
+
+#define xchg_xen_ulong(ptr, val) xen_atomic64_xchg(container_of((ptr),	\
 							    atomic64_t,	\
 							    counter), (val))
 
