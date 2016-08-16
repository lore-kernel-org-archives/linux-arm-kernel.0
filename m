From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 16 Aug 2016 16:26:50 +0100
Subject: [PATCH] ARM: irq_work: Do not attempt to IPI on non IPI-capable HW
Message-ID: <1471361210-29914-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all of the ARM HW is IPI capable (i.e. most of the non-SMP
systems). Unfortunately, some systems do advertise being SMP
capable, even if they have a single core and do not define
a cross call method. In this case, irq_work_queue dies
as arch_irq_work_has_interrupt() fails to detect this
particular case.

Let's redefine arch_irq_work_has_interrupt() to actually check
if we're IPI capable instead of simply being SMP. This sidesteps
the issue entierely.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/irq_work.h | 6 +++++-
 arch/arm/include/asm/smp_plat.h | 2 ++
 arch/arm/kernel/smp.c           | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/irq_work.h b/arch/arm/include/asm/irq_work.h
index 712d03e..3ba3583 100644
--- a/arch/arm/include/asm/irq_work.h
+++ b/arch/arm/include/asm/irq_work.h
@@ -5,7 +5,11 @@
 
 static inline bool arch_irq_work_has_interrupt(void)
 {
-	return is_smp();
+#ifdef CONFIG_SMP
+	return !!__smp_cross_call;
+#else
+	return false;
+#endif
 }
 
 #endif /* _ASM_ARM_IRQ_WORK_H */
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index f908071..ffee073 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -26,6 +26,8 @@ static inline bool is_smp(void)
 #endif
 }
 
+extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
+
 /**
  * smp_cpuid_part() - return part id for a given cpu
  * @cpu:	logical cpu id.
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8615216..f9d771f 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -465,7 +465,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static void (*__smp_cross_call)(const struct cpumask *, unsigned int);
+void (*__smp_cross_call)(const struct cpumask *, unsigned int);
 
 void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
 {
-- 
2.1.4
