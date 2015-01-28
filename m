From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:15 +0100
Subject: [PATCH 08/15] ARM: add missing arch_irqs_disabled function
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building with CONFIG_DEBUG_LOCK_ALLOC and CONFIG_PREEMPT_COUNT,
the generic rcu_read_lock_sched_held function requires a definition
of arch_irqs_disabled. All other architectures provide this, so
this patch adds the trivial wrapper around arch_irqs_disabled_flags()
that a lot of the others use as well.

include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
include/linux/rcupdate.h:516:2: error: implicit declaration of function 'arch_irqs_disabled'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/irqflags.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/irqflags.h b/arch/arm/include/asm/irqflags.h
index 3b763d6652a0..202dfeecd07a 100644
--- a/arch/arm/include/asm/irqflags.h
+++ b/arch/arm/include/asm/irqflags.h
@@ -161,5 +161,10 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return flags & IRQMASK_I_BIT;
 }
 
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
 #endif /* ifdef __KERNEL__ */
 #endif /* ifndef __ASM_ARM_IRQFLAGS_H */
-- 
2.1.0.rc2
