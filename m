From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:57:01 +0000
Subject: [PATCH v6 10/24] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-11-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead disabling interrupts by setting the PSR.I bit, use a priority
higher than the one used for interrupts to mask them via PMR.

The value chosen for PMR to enable/disable interrupts encodes the status
of interrupts on a single bit. This information is stored in the irqflags
values used when saving/restoring IRQ status.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 arch/arm64/include/asm/efi.h      |   3 +-
 arch/arm64/include/asm/irqflags.h | 132 +++++++++++++++++++++++++++++---------
 2 files changed, 105 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 7ed3208..3e06891 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -42,7 +42,8 @@
 
 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
-#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+#define ARCH_EFI_IRQ_FLAGS_MASK \
+	(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | ARCH_FLAG_PMR_EN)
 
 /* arch specific definitions used by the stub code */
 
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 24692ed..e0a32e4 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -18,7 +18,27 @@
 
 #ifdef __KERNEL__
 
+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
+
+
+/*
+ * When ICC_PMR_EL1 is used for interrupt masking, only the bit indicating
+ * whether the normal interrupts are masked is kept along with the daif
+ * flags.
+ */
+#define ARCH_FLAG_PMR_EN 0x1
+
+#define MAKE_ARCH_FLAGS(daif, pmr)					\
+	((daif) | (((pmr) >> GIC_PRIO_STATUS_SHIFT) & ARCH_FLAG_PMR_EN))
+
+#define ARCH_FLAGS_GET_PMR(flags)				 \
+	((((flags) & ARCH_FLAG_PMR_EN) << GIC_PRIO_STATUS_SHIFT) \
+		| GIC_PRIO_IRQOFF)
+
+#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)
 
 /*
  * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
@@ -34,35 +54,62 @@
  */
 
 /*
- * CPU interrupt mask handling.
+ * Local definitions to help us manage between PMR and daif
  */
-static inline unsigned long arch_local_irq_save(void)
-{
-	unsigned long flags;
-	asm volatile(
-		"mrs	%0, daif		// arch_local_irq_save\n"
-		"msr	daifset, #2"
-		: "=r" (flags)
-		:
-		: "memory");
-	return flags;
-}
+#define _save_daif(dest)						\
+	asm volatile("mrs	%0, daif" : "=&r" (dest) : : "memory")
+
+#define _restore_daif(daif)						\
+	asm volatile("msr	daif, %0" : : "r" (daif) : "memory")
 
+#define _save_pmr(dest)							\
+	asm volatile(ALTERNATIVE(					\
+		     "mov	%0, #" __stringify(GIC_PRIO_IRQON),	\
+		     "mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1),	\
+		     ARM64_HAS_IRQ_PRIO_MASKING)			\
+		: "=&r" (dest)						\
+		:							\
+		: "memory")
+
+#define _restore_pmr(pmr)						\
+	asm volatile(ALTERNATIVE(					\
+		     "nop\n"						\
+		     "nop",						\
+		     "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"	\
+		     "dsb	sy",					\
+		     ARM64_HAS_IRQ_PRIO_MASKING)			\
+		:							\
+		: "r" (pmr)						\
+		: "memory")
+
+/*
+ * CPU interrupt mask handling.
+ */
 static inline void arch_local_irq_enable(void)
 {
-	asm volatile(
-		"msr	daifclr, #2		// arch_local_irq_enable"
-		:
+	unsigned long unmasked = GIC_PRIO_IRQON;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifclr, #2		// arch_local_irq_enable\n"
+		"nop",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
+		"dsb	sy",
+		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
+		: "r" (unmasked)
 		: "memory");
 }
 
 static inline void arch_local_irq_disable(void)
 {
-	asm volatile(
-		"msr	daifset, #2		// arch_local_irq_disable"
-		:
+	unsigned long masked = GIC_PRIO_IRQOFF;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0",
+		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
+		: "r" (masked)
 		: "memory");
 }
 
@@ -71,12 +118,24 @@ static inline void arch_local_irq_disable(void)
  */
 static inline unsigned long arch_local_save_flags(void)
 {
+	unsigned long daif_flags;
+	unsigned long pmr;
+
+	_save_daif(daif_flags);
+
+	_save_pmr(pmr);
+
+	return MAKE_ARCH_FLAGS(daif_flags, pmr);
+}
+
+static inline unsigned long arch_local_irq_save(void)
+{
 	unsigned long flags;
-	asm volatile(
-		"mrs	%0, daif		// arch_local_save_flags"
-		: "=r" (flags)
-		:
-		: "memory");
+
+	flags = arch_local_save_flags();
+
+	arch_local_irq_disable();
+
 	return flags;
 }
 
@@ -85,16 +144,31 @@ static inline unsigned long arch_local_save_flags(void)
  */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	asm volatile(
-		"msr	daif, %0		// arch_local_irq_restore"
-	:
-	: "r" (flags)
-	: "memory");
+	unsigned long pmr = ARCH_FLAGS_GET_PMR(flags);
+
+	flags = ARCH_FLAGS_GET_DAIF(flags);
+
+	/*
+	 * Code switching from PSR.I interrupt disabling to PMR masking
+	 * should not lie between consecutive calls to local_irq_save()
+	 * and local_irq_restore() in the same context.
+	 * So restoring PMR and then the daif flags should be safe.
+	 */
+	_restore_pmr(pmr);
+
+	_restore_daif(flags);
 }
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags & PSR_I_BIT;
+	return (ARCH_FLAGS_GET_DAIF(flags) & (PSR_I_BIT)) |
+		!(ARCH_FLAGS_GET_PMR(flags) & GIC_PRIO_STATUS_BIT);
 }
+
+#undef _save_daif
+#undef _restore_daif
+#undef _save_pmr
+#undef _restore_pmr
+
 #endif
 #endif
-- 
1.9.1
