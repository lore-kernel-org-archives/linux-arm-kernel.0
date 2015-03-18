From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 18 Mar 2015 14:20:27 +0000
Subject: [RFC PATCH 6/7] arm64: irqflags: Automatically identify I bit
 mis-management
In-Reply-To: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1426688428-3150-7-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is self-test code to identify circumstances where the I bit is
set by hardware but no software exists to copy its state to the PMR.

I don't really expect this patch to be retained much after the RFC stage.
However I have included it in this RFC series to document the testing I
have done and to allow further testing under different workloads.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/include/asm/irqflags.h | 29 +++++++++++++++++++++++++++++
 arch/arm64/kernel/irq.c           |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 7b6866022f82..89be5f830857 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -18,6 +18,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm/bug.h>
 #include <asm/ptrace.h>
 
 #ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
@@ -90,6 +91,23 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 
 #include <linux/irqchip/arm-gic-v3.h>
 
+extern bool enable_i_bit_check;
+
+static inline void check_for_i_bit(void)
+{
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS_SELF_TEST
+	unsigned long psr;
+
+	if (enable_i_bit_check) {
+		asm volatile("mrs %0, daif" : "=r"(psr));
+		if (psr & PSR_I_BIT) {
+			enable_i_bit_check = false;
+			WARN(true, "I bit is set: %08lx\n", psr);
+		}
+	}
+#endif
+}
+
 /*
  * CPU interrupt mask handling.
  */
@@ -97,6 +115,8 @@ static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags, masked = ICC_PMR_EL1_MASKED;
 
+	check_for_i_bit();
+
 	asm volatile(
 		"// arch_local_irq_save\n"
 		"mrs_s  %0, " __stringify(ICC_PMR_EL1) "\n"
@@ -113,6 +133,8 @@ static inline void arch_local_irq_enable(void)
 {
 	unsigned long unmasked = ICC_PMR_EL1_UNMASKED;
 
+	check_for_i_bit();
+
 	asm volatile(
 		"// arch_local_irq_enable\n"
 		"msr_s  " __stringify(ICC_PMR_EL1) ",%0\n"
@@ -126,6 +148,8 @@ static inline void arch_local_irq_disable(void)
 {
 	unsigned long masked = ICC_PMR_EL1_MASKED;
 
+	check_for_i_bit();
+
 	asm volatile(
 		"// arch_local_irq_disable\n"
 		"msr_s  " __stringify(ICC_PMR_EL1) ",%0\n"
@@ -142,6 +166,8 @@ static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
 
+	check_for_i_bit();
+
 	asm volatile(
 		"// arch_local_save_flags\n"
 		"mrs_s  %0, " __stringify(ICC_PMR_EL1) "\n"
@@ -157,6 +183,8 @@ static inline unsigned long arch_local_save_flags(void)
  */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
+	check_for_i_bit();
+
 	asm volatile(
 		"// arch_local_irq_restore\n"
 		"msr_s  " __stringify(ICC_PMR_EL1) ",%0\n"
@@ -168,6 +196,7 @@ static inline void arch_local_irq_restore(unsigned long flags)
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
+	check_for_i_bit();
 	return !(flags & ICC_PMR_EL1_G_BIT);
 }
 
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 240b75c0e94f..7d68193af26c 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -31,6 +31,12 @@
 
 unsigned long irq_err_count;
 
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS_SELF_TEST
+/* enable_i_bit_check is declared in asm/irqflags.h */
+bool enable_i_bit_check = true;
+EXPORT_SYMBOL(enable_i_bit_check);
+#endif
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 #ifdef CONFIG_SMP
-- 
2.1.0
