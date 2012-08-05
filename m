From: robherring2@gmail.com (Rob Herring)
Date: Sat,  4 Aug 2012 20:24:00 -0500
Subject: [PATCH v2 5/5] ARM: convert asm/irqflags.h to use
 asm-generic/irqflags.h
In-Reply-To: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
References: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
Message-ID: <1344129840-16447-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

By implmenting arch_local_irq_restore with constant flags, we can use
asm-generic/irqflags.h and remove some of the ARM version of irqflags.h.

Verified the code is equivalent by checking the disassembled code.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/irqflags.h |  131 ++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 86 deletions(-)

diff --git a/arch/arm/include/asm/irqflags.h b/arch/arm/include/asm/irqflags.h
index 1e6cca5..67bfb53 100644
--- a/arch/arm/include/asm/irqflags.h
+++ b/arch/arm/include/asm/irqflags.h
@@ -8,88 +8,68 @@
 /*
  * CPU interrupt mask handling.
  */
-#if __LINUX_ARM_ARCH__ >= 6
+#define ARCH_IRQ_DISABLED	PSR_I_BIT
+#define ARCH_IRQ_ENABLED	0
 
-static inline unsigned long arch_local_irq_save(void)
+static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
 
 	asm volatile(
-		"	mrs	%0, cpsr	@ arch_local_irq_save\n"
-		"	cpsid	i"
+		"	mrs	%0, cpsr	@ arch_local_save_flags\n"
 		: "=r" (flags) : : "memory", "cc");
 	return flags;
 }
 
-static inline void arch_local_irq_enable(void)
+static inline void constant_arch_local_irq_restore(unsigned long flags)
 {
-	asm volatile(
-		"	cpsie i			@ arch_local_irq_enable"
-		:
-		:
-		: "memory", "cc");
+#if __LINUX_ARM_ARCH__ >= 6
+	if (flags == ARCH_IRQ_ENABLED)
+		asm volatile(
+			"	cpsie i			@ constant_arch_local_irq_restore"
+			: : : "memory", "cc");
+	else if (flags == ARCH_IRQ_DISABLED)
+		asm volatile(
+			"	cpsid i			@ constant_arch_local_irq_restore"
+			: : : "memory", "cc");
+#else
+	unsigned long temp;
+	if (flags == ARCH_IRQ_ENABLED)
+		asm volatile(
+			"	mrs	%0, cpsr	@ constant_arch_local_irq_restore\n"
+			"	bic	%0, %0, #128\n"
+			"	msr	cpsr_c, %0"
+			: "=r" (temp)
+			:
+			: "memory", "cc");
+	else if (flags == ARCH_IRQ_DISABLED)
+		asm volatile(
+			"	mrs	%0, cpsr	@ constant_arch_local_irq_restore\n"
+			"	orr	%0, %0, #128\n"
+			"	msr	cpsr_c, %0"
+			: "=r" (temp)
+			:
+			: "memory", "cc");
+#endif
 }
 
-static inline void arch_local_irq_disable(void)
+static inline void _arch_local_irq_restore(unsigned long flags)
 {
-	asm volatile(
-		"	cpsid i			@ arch_local_irq_disable"
-		:
+		asm volatile(
+		"	msr	cpsr_c, %0	@ _arch_local_irq_restore"
 		:
+		: "r" (flags)
 		: "memory", "cc");
 }
 
+#define arch_local_irq_restore(flags) \
+	(__builtin_constant_p(flags) ? constant_arch_local_irq_restore(flags) : \
+	_arch_local_irq_restore(flags))
+
+#if __LINUX_ARM_ARCH__ >= 6
 #define local_fiq_enable()  __asm__("cpsie f	@ __stf" : : : "memory", "cc")
 #define local_fiq_disable() __asm__("cpsid f	@ __clf" : : : "memory", "cc")
 #else
-
-/*
- * Save the current interrupt enable state & disable IRQs
- */
-static inline unsigned long arch_local_irq_save(void)
-{
-	unsigned long flags, temp;
-
-	asm volatile(
-		"	mrs	%0, cpsr	@ arch_local_irq_save\n"
-		"	orr	%1, %0, #128\n"
-		"	msr	cpsr_c, %1"
-		: "=r" (flags), "=r" (temp)
-		:
-		: "memory", "cc");
-	return flags;
-}
-
-/*
- * Enable IRQs
- */
-static inline void arch_local_irq_enable(void)
-{
-	unsigned long temp;
-	asm volatile(
-		"	mrs	%0, cpsr	@ arch_local_irq_enable\n"
-		"	bic	%0, %0, #128\n"
-		"	msr	cpsr_c, %0"
-		: "=r" (temp)
-		:
-		: "memory", "cc");
-}
-
-/*
- * Disable IRQs
- */
-static inline void arch_local_irq_disable(void)
-{
-	unsigned long temp;
-	asm volatile(
-		"	mrs	%0, cpsr	@ arch_local_irq_disable\n"
-		"	orr	%0, %0, #128\n"
-		"	msr	cpsr_c, %0"
-		: "=r" (temp)
-		:
-		: "memory", "cc");
-}
-
 /*
  * Enable FIQs
  */
@@ -122,34 +102,13 @@ static inline void arch_local_irq_disable(void)
 
 #endif
 
-/*
- * Save the current interrupt enable state.
- */
-static inline unsigned long arch_local_save_flags(void)
-{
-	unsigned long flags;
-	asm volatile(
-		"	mrs	%0, cpsr	@ local_save_flags"
-		: "=r" (flags) : : "memory", "cc");
-	return flags;
-}
-
-/*
- * restore saved IRQ & FIQ state
- */
-static inline void arch_local_irq_restore(unsigned long flags)
-{
-	asm volatile(
-		"	msr	cpsr_c, %0	@ local_irq_restore"
-		:
-		: "r" (flags)
-		: "memory", "cc");
-}
-
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
 	return flags & PSR_I_BIT;
 }
+#define arch_irqs_disabled_flags arch_irqs_disabled_flags
+
+#include <asm-generic/irqflags.h>
 
 #endif
 #endif
-- 
1.7.9.5
