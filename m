From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 May 2011 12:19:58 +0100
Subject: [PATCH 4/5] ARM: mm: fix racy ASID rollover broadcast on SMP platforms
In-Reply-To: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
References: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
Message-ID: <1305890399-29075-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If ASID rollover is detected on a CPU in an SMP system, a synchronous
IPI call is made to force the secondaries to reallocate their current
ASIDs.

There is a problem where a CPU may be interrupted in the cpu_switch_mm
code with the context ID held in r1. After servicing the IPI, the
context ID register will be updated with an ASID from the previous
generation, polluting the TLB for when that ASID becomes valid in the
new generation.

This patch disables interrupts during cpu_switch_mm for SMP systems,
preventing incoming rollover broadcasts from being serviced while the
register state is inconsistent. Additionally, the context resetting code
is modified to call cpu_switch_mm, rather than setting the context ID
register directly, so that the TTBR always agrees with the ASID.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/proc-fns.h |   14 ++++++++++++++
 arch/arm/mm/context.c           |    3 +--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 8ec535e..233dccd 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -97,8 +97,22 @@ extern void cpu_resume(void);
 
 #ifdef CONFIG_MMU
 
+#ifdef CONFIG_SMP
+
+#define cpu_switch_mm(pgd,mm)	\
+	({						\
+		unsigned long flags;			\
+		local_irq_save(flags);			\
+		cpu_do_switch_mm(virt_to_phys(pgd),mm);	\
+		local_irq_restore(flags);		\
+	})
+
+#else /* SMP */
+
 #define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
 
+#endif
+
 #define cpu_get_pgd()	\
 	({						\
 		unsigned long pg;			\
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 0d86298..55041c1 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -100,8 +100,7 @@ static void reset_context(void *info)
 	set_mm_context(mm, asid);
 
 	/* set the new ASID */
-	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (mm->context.id));
-	isb();
+	cpu_switch_mm(mm->pgd, mm);
 }
 
 #else
-- 
1.7.0.4
