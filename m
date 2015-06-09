From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 09 Jun 2015 12:41:50 +0100
Subject: [PATCH] ARM: Re-enable TRACE_IRQFLAGS_SUPPORT on ARMv7-M
In-Reply-To: <CALszF6DPzhAufUyWW-a3X7Cp4=tjSyCBM=Y4LcnWnUH=41qeoQ@mail.gmail.com>
References: <1433802288-25508-1-git-send-email-mcoquelin.stm32@gmail.com>	<20150608224749.GB7557@n2100.arm.linux.org.uk>
 <CALszF6DPzhAufUyWW-a3X7Cp4=tjSyCBM=Y4LcnWnUH=41qeoQ@mail.gmail.com>
Message-ID: <5576D0FE.10900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/15 10:14, Maxime Coquelin wrote:
>> The real solution is to provide a definition _in asm-generic_ for
>> arch_irqs_disabled(), rather than having almost every arch doing:
>>
>> static inline bool arch_irqs_disabled(void)
>> {
>>          return arch_irqs_disabled_flags(arch_local_save_flags());
>> }
>>
>> I'm personally refusing to take a patch for ARM which adds yet another
>> copy of the above.  This is, after all, exactly the kind of stuff that
>> should be in asm-generic, or if not, in include/linux but overridable
>> by arch stuff.
>>
>> We keep going between the two extremes of "lets push lots of stuff into
>> arch stuff" and "lets try to extract the common bits out of arch code".
>>
>> Let's try and settle on one approach, and apply it universally.
>
> I agree on the idea but I don't measure all the impacts it would have.

Hey Maxime, just out of interest...

Does the following patch, which makes the arch_irqs_disabled() 
implementation from asm-generic available on arm, fix the build for you?

I've only done a real quick 'n dirty check for regression: 
multi_v7_defconfig still works ;-)

If the patch is useful I can test it a bit harder...


 From d86ef4466cfdbe622a65bcc7e72a8ca0d1dd2879 Mon Sep 17 00:00:00 2001
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 9 Jun 2015 12:35:24 +0100
Subject: [PATCH] ARM: irqflags: Get arch_irqs_disabled from asm-generic

asm-generic/irqflags.h provides an implementation of
arch_irqs_disabled(). Lets grab that implementation.

Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
  arch/arm/include/asm/irqflags.h | 11 +++++++++++
  1 file changed, 11 insertions(+)

diff --git a/arch/arm/include/asm/irqflags.h 
b/arch/arm/include/asm/irqflags.h
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
@@ -156,10 +164,13 @@ static inline void arch_local_irq_restore(unsigned 
long flags)
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
