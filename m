From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 14 Sep 2015 14:26:21 +0100
Subject: [RFC PATCH v2 7/7] arm64: irqflags: Automatically identify I bit
 mis-management
In-Reply-To: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1442237181-17064-8-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is self-test code to identify circumstances where the I bit is
set by hardware but no software exists to copy its state to the PMR.

I don't really expect this patch to be retained much after the RFC stage.
However I have included it in this RFC series to document the testing I
have done and to allow further testing under different workloads.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/include/asm/irqflags.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index cf8a5184fce7..b2998b7946b6 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -19,8 +19,10 @@
 #ifdef __KERNEL__
 
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/preempt.h>
 
 #include <asm/alternative.h>
+#include <asm/bug.h>
 #include <asm/cpufeature.h>
 #include <asm/ptrace.h>
 
@@ -94,6 +96,33 @@ static inline void maybe_switch_to_sysreg_gic_cpuif(void) {}
 
 #else /* CONFIG_IRQFLAGS_GIC_MASKING */
 
+static inline void check_for_i_bit(void)
+{
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	unsigned long flags;
+
+	/* check whether the I-bit is spuriously enabled */
+	if (!in_nmi()) {
+		asm volatile(ALTERNATIVE(
+			"mov	%0, #0",
+			"mrs	%0, daif",
+			ARM64_HAS_SYSREG_GIC_CPUIF)
+			: "=r" (flags));
+
+		WARN_ONCE(flags & PSR_I_BIT, "I bit is set: %08lx\n", flags);
+	}
+
+	/* check that the PMR has a legal value */
+	asm volatile(ALTERNATIVE(
+		"mov	%0, #" __stringify(ICC_PMR_EL1_MASKED),
+		"mrs_s  %0, " __stringify(ICC_PMR_EL1),
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		: "=r" (flags));
+	WARN_ONCE((flags & ICC_PMR_EL1_MASKED) != ICC_PMR_EL1_MASKED,
+		  "ICC_PMR_EL1 has a bad value: %08lx\n", flags);
+#endif
+}
+
 /*
  * CPU interrupt mask handling.
  */
@@ -101,6 +130,7 @@ static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags, masked = ICC_PMR_EL1_MASKED;
 
+	check_for_i_bit();
 	asm volatile(ALTERNATIVE(
 		"mrs	%0, daif		// arch_local_irq_save\n"
 		"msr	daifset, #2",
@@ -119,6 +149,7 @@ static inline void arch_local_irq_enable(void)
 {
 	unsigned long unmasked = ICC_PMR_EL1_UNMASKED;
 
+	check_for_i_bit();
 	asm volatile(ALTERNATIVE(
 		"msr	daifclr, #2		// arch_local_irq_enable",
 		"msr_s  " __stringify(ICC_PMR_EL1) ",%0",
@@ -132,6 +163,7 @@ static inline void arch_local_irq_disable(void)
 {
 	unsigned long masked = ICC_PMR_EL1_MASKED;
 
+	check_for_i_bit();
 	asm volatile(ALTERNATIVE(
 		"msr	daifset, #2		// arch_local_irq_disable",
 		"msr_s  " __stringify(ICC_PMR_EL1) ",%0",
@@ -148,6 +180,7 @@ static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
 
+	check_for_i_bit();
 	asm volatile(ALTERNATIVE(
 		"mrs	%0, daif		// arch_local_save_flags",
 		"mrs_s  %0, " __stringify(ICC_PMR_EL1),
@@ -164,6 +197,7 @@ static inline unsigned long arch_local_save_flags(void)
  */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
+	check_for_i_bit();
 	asm volatile(ALTERNATIVE(
 		"msr	daif, %0		// arch_local_irq_restore",
 		"msr_s  " __stringify(ICC_PMR_EL1) ",%0",
@@ -175,6 +209,7 @@ static inline void arch_local_irq_restore(unsigned long flags)
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
+	check_for_i_bit();
 	asm volatile(ALTERNATIVE(
 		"and	%0, %0, #" __stringify(PSR_I_BIT) "\n"
 		"nop",
-- 
2.4.3
