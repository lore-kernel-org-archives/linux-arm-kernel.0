From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 13:50:16 +0100
Subject: [PATCH 07/10] arm64: switch_mm: simplify mm and CPU checks
In-Reply-To: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
Message-ID: <1442494219-6133-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

switch_mm performs some checks to try and avoid entering the ASID
allocator:

  (1) If we're switching to the init_mm (no user mappings), then simply
      set a reserved TTBR0 value with no page table (the zero page)

  (2) If prev == next *and* the mm_cpumask indicates that we've run on
      this CPU before, then we can skip the allocator.

However, there is plenty of redundancy here. With the new ASID allocator,
if prev == next, then we know that our ASID is valid and do not need to
worry about re-allocation. Consequently, we can drop the mm_cpumask check
in (2) and move the prev == next check before the init_mm check, since
if prev == next == init_mm then there's nothing to do.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/mmu_context.h | 6 ++++--
 arch/arm64/mm/context.c              | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index f4c74a951b6c..c0e87898ba96 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -129,6 +129,9 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 	unsigned int cpu = smp_processor_id();
 
+	if (prev == next)
+		return;
+
 	/*
 	 * init_mm.pgd does not contain any user mappings and it is always
 	 * active for kernel addresses in TTBR1. Just set the reserved TTBR0.
@@ -138,8 +141,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		return;
 	}
 
-	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next)
-		check_and_switch_context(next, tsk);
+	check_and_switch_context(next, cpu);
 }
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index e902229b1a3d..4b9ec4484e3f 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -166,10 +166,10 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 		local_flush_tlb_all();
 
 	atomic64_set(&per_cpu(active_asids, cpu), asid);
-	cpumask_set_cpu(cpu, mm_cpumask(mm));
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
 switch_mm_fastpath:
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
 	cpu_switch_mm(mm->pgd, mm);
 }
 
-- 
2.1.4
