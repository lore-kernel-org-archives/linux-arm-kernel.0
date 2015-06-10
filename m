From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 10 Jun 2015 12:24:13 +0100
Subject: [PATCH] ARM: irqflags: Get arch_irqs_disabled from asm-generic
Message-ID: <1433935453-22381-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit cb1293e2f594 ("ARM: 8375/1: disable some options on ARMv7-M")
causes the build to on ARMv7-M machines:

  CC      arch/arm/kernel/asm-offsets.s
In file included from include/linux/sem.h:5:0,
                 from include/linux/sched.h:35,
                 from arch/arm/kernel/asm-offsets.c:14:
include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
include/linux/rcupdate.h:539:2: error: implicit declaration of function
'arch_irqs_disabled' [-Werror=implicit-function-declaration]
  return preempt_count() != 0 || irqs_disabled();

asm-generic/irqflags.h provides an implementation of arch_irqs_disabled().
Lets grab an implementation from there!

Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---

Notes:
    Compile tested on v4.1-rc6 using all arch/arm/configs.
    Boot tested on v4.1-rc6 with versatile_defconfig and multi_v7_defconfig.
    Boot tested on linux-next-20150608 using stm32_defconfig (out-of-tree).

 arch/arm/include/asm/irqflags.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/include/asm/irqflags.h b/arch/arm/include/asm/irqflags.h
index 3b763d6652a0..43908146a5cf 100644
--- a/arch/arm/include/asm/irqflags.h
+++ b/arch/arm/include/asm/irqflags.h
@@ -20,6 +20,7 @@

 #if __LINUX_ARM_ARCH__ >= 6

+#define arch_local_irq_save arch_local_irq_save
 static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags;
@@ -31,6 +32,7 @@ static inline unsigned long arch_local_irq_save(void)
 	return flags;
 }

+#define arch_local_irq_enable arch_local_irq_enable
 static inline void arch_local_irq_enable(void)
 {
 	asm volatile(
@@ -40,6 +42,7 @@ static inline void arch_local_irq_enable(void)
 		: "memory", "cc");
 }

+#define arch_local_irq_disable arch_local_irq_disable
 static inline void arch_local_irq_disable(void)
 {
 	asm volatile(
@@ -56,6 +59,7 @@ static inline void arch_local_irq_disable(void)
 /*
  * Save the current interrupt enable state & disable IRQs
  */
+#define arch_local_irq_save arch_local_irq_save
 static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags, temp;
@@ -73,6 +77,7 @@ static inline unsigned long arch_local_irq_save(void)
 /*
  * Enable IRQs
  */
+#define arch_local_irq_enable arch_local_irq_enable
 static inline void arch_local_irq_enable(void)
 {
 	unsigned long temp;
@@ -88,6 +93,7 @@ static inline void arch_local_irq_enable(void)
 /*
  * Disable IRQs
  */
+#define arch_local_irq_disable arch_local_irq_disable
 static inline void arch_local_irq_disable(void)
 {
 	unsigned long temp;
@@ -135,6 +141,7 @@ static inline void arch_local_irq_disable(void)
 /*
  * Save the current interrupt enable state.
  */
+#define arch_local_save_flags arch_local_save_flags
 static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
@@ -147,6 +154,7 @@ static inline unsigned long arch_local_save_flags(void)
 /*
  * restore saved IRQ & FIQ state
  */
+#define arch_local_irq_restore arch_local_irq_restore
 static inline void arch_local_irq_restore(unsigned long flags)
 {
 	asm volatile(
@@ -156,10 +164,13 @@ static inline void arch_local_irq_restore(unsigned long flags)
 		: "memory", "cc");
 }

+#define arch_irqs_disabled_flags arch_irqs_disabled_flags
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
 	return flags & IRQMASK_I_BIT;
 }

+#include <asm-generic/irqflags.h>
+
 #endif /* ifdef __KERNEL__ */
 #endif /* ifndef __ASM_ARM_IRQFLAGS_H */
--
2.4.2
