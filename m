From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  6 Jun 2013 11:30:44 +0200
Subject: [PATCH v3 2/2] ARM PJ4B: Add support for errata 4611
In-Reply-To: <1370511044-31900-1-git-send-email-gregory.clement@free-electrons.com>
References: <1370511044-31900-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1370511044-31900-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lior Amsalem <alior@marvell.com>

A CP15 clean operation can result in a dead lock state if it is hit by
an incoming snoop event. The fix to this issue is the following:
before any CP15 clean type operation in Cache Coherency mode, issue a
Data Memory Barrier (DMB) or a Data Synchronization Barrier (DSB)
instruction.

[gregory.clement at free-electrons.com:use save/restore IRQ macros]
[gregory.clement at free-electrons.com:add errata description in changelog]
[gregory.clement at free-electrons.com:make this errata depend on Armada 370]
Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig                |  9 +++++++++
 arch/arm/include/asm/tlbflush.h | 22 ++++++++++++++++++++++
 arch/arm/mm/proc-macros.S       | 11 +++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 95cbe9d..3126557 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1087,6 +1087,15 @@ if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
 
+config PJ4B_ERRATA_4611
+	bool "PJ4B Errata 4611: A Deadlock can Occur if a CP15 Clean/Clean and Invalidate Operation is Hit By a Snoop Event"
+	depends on CPU_PJ4B && MACH_ARMADA_370
+	help
+	  A CP15 clean operation can result in a dead lock state if it is hit
+	  by an incoming snoop event.  Workaround: Before any CP15 clean type
+	  operation in Cache Coherency mode, issue a Data Memory Barrier (DMB)
+	  or a Data Synchronization Barrier (DSB) instruction.
+
 config PJ4B_ERRATA_4742
 	bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the CPU Core to Cease Operation"
 	depends on CPU_PJ4B && MACH_ARMADA_370
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index a3625d1..f9129e4 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -475,7 +475,18 @@ static inline void flush_pmd_entry(void *pmd)
 {
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
+#ifdef CONFIG_PJ4B_ERRATA_4611
+	unsigned long flags;
+	raw_local_irq_save(flags);
+	dmb();
+#endif
+
 	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
+
+#ifdef CONFIG_PJ4B_ERRATA_4611
+	raw_local_irq_restore(flags);
+#endif
+
 	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
 
 	if (tlb_flag(TLB_WB))
@@ -486,7 +497,18 @@ static inline void clean_pmd_entry(void *pmd)
 {
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
+#ifdef CONFIG_PJ4B_ERRATA_4611
+	unsigned long flags;
+	raw_local_irq_save(flags);
+	dmb();
+#endif
+
 	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
+
+#ifdef CONFIG_PJ4B_ERRATA_4611
+	raw_local_irq_restore(flags);
+#endif
+
 	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
 }
 
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index f9a0aa7..2eba2b7 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -178,7 +178,18 @@
 #endif
 
 	str	r3, [r0]
+
+#ifdef CONFIG_PJ4B_ERRATA_4611
+        save_and_disable_irqs_notrace r2	@ Disable interrupts
+	dmb					@ ensure ordering with previous memory accesses
+#endif
+
 	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
+
+#ifdef CONFIG_PJ4B_ERRATA_4611
+	restore_irqs_notrace r2			@ Restore interrupts
+	dsb					@ drain write buffer
+#endif
 	.endm
 
 
-- 
1.8.1.2
