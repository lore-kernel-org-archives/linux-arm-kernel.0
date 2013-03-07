From: ian.campbell@citrix.com (Ian Campbell)
Date: Thu,  7 Mar 2013 07:17:25 +0000
Subject: [PATCH] xen: arm: mandate EABI and use generic atomic operations.
Message-ID: <1362640645-26564-1-git-send-email-ian.campbell@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring has observed that c81611c4e96f "xen: event channel arrays are
xen_ulong_t and not unsigned long" introduced a compile failure when building
without CONFIG_AEABI:

/tmp/ccJaIZOW.s: Assembler messages:
/tmp/ccJaIZOW.s:831: Error: even register required -- `ldrexd r5,r6,[r4]'

Will Deacon pointed out that this is because OABI does not require even base
registers for 64-bit values. We can avoid this by simply using the existing
atomic64_xchg operation and the same containerof trick as used by the cmpxchg
macros. However since this code is used on memory which is shared with the
hypervisor we require proper atomic instructions and cannot use the generic
atomic64 callbacks (which are based on spinlocks), therefore add a dependency
on !GENERIC_ATOMIC64. Since we already depend on !CPU_V6 there isn't much
downside to this.

While thinking about this we also observed that OABI has different struct
alignment requirements to EABI, which is a problem for hypercall argument
structs which are shared with the hypervisor and which must be in EABI layout.
Since I don't expect people to want to run OABI kernels on Xen depend on
CONFIG_AEABI explicitly too (although it also happens to be enforced by the
!GENERIC_ATOMIC64 requirement too).

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <robherring2@gmail.com>
Cc: Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/arm/Kconfig                  |    3 ++-
 arch/arm/include/asm/xen/events.h |   25 ++++---------------------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..be632ba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1887,8 +1887,9 @@ config XEN_DOM0
 
 config XEN
 	bool "Xen guest support on ARM (EXPERIMENTAL)"
-	depends on ARM && OF
+	depends on ARM && AEABI && OF
 	depends on CPU_V7 && !CPU_V6
+	depends on !GENERIC_ATOMIC64
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
 
diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
index 5c27696..8b1f37b 100644
--- a/arch/arm/include/asm/xen/events.h
+++ b/arch/arm/include/asm/xen/events.h
@@ -2,6 +2,7 @@
 #define _ASM_ARM_XEN_EVENTS_H
 
 #include <asm/ptrace.h>
+#include <asm/atomic.h>
 
 enum ipi_vector {
 	XEN_PLACEHOLDER_VECTOR,
@@ -15,26 +16,8 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 	return raw_irqs_disabled_flags(regs->ARM_cpsr);
 }
 
-/*
- * We cannot use xchg because it does not support 8-byte
- * values. However it is safe to use {ldr,dtd}exd directly because all
- * platforms which Xen can run on support those instructions.
- */
-static inline xen_ulong_t xchg_xen_ulong(xen_ulong_t *ptr, xen_ulong_t val)
-{
-	xen_ulong_t oldval;
-	unsigned int tmp;
-
-	wmb();
-	asm volatile("@ xchg_xen_ulong\n"
-		"1:     ldrexd  %0, %H0, [%3]\n"
-		"       strexd  %1, %2, %H2, [%3]\n"
-		"       teq     %1, #0\n"
-		"       bne     1b"
-		: "=&r" (oldval), "=&r" (tmp)
-		: "r" (val), "r" (ptr)
-		: "memory", "cc");
-	return oldval;
-}
+#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((ptr),	\
+							    atomic64_t,	\
+							    counter), (val))
 
 #endif /* _ASM_ARM_XEN_EVENTS_H */
-- 
1.7.10.4
