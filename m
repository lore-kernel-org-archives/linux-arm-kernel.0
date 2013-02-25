From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 15:18:07 +0000
Subject: [PATCH 1/2] ARM: mm: fix race updating mm->context.id on ASID rollover
Message-ID: <1361805488-8798-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a thread triggers an ASID rollover, other threads of the same process
must be made to wait until the mm->context.id for the shared mm_struct
has been updated to new generation and associated book-keeping (e.g.
TLB invalidation) has ben performed.

However, there is a *tiny* window where both mm->context.id and the
relevant active_asids entry are updated to the new generation, but the
TLB flush has not been performed, which could allow another thread to
return to userspace with a dirty TLB, potentially leading to data
corruption. In reality this will never occur because one CPU would need
to perform a context-switch in the time it takes another to do a couple
of atomic test/set operations but we should plug the race anyway.

This patch moves the active_asids update until after the potential TLB
flush on context-switch.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 7a05111..03ba181 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -207,11 +207,11 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 	if ((mm->context.id ^ atomic64_read(&asid_generation)) >> ASID_BITS)
 		new_context(mm, cpu);
 
-	atomic64_set(&per_cpu(active_asids, cpu), mm->context.id);
-	cpumask_set_cpu(cpu, mm_cpumask(mm));
-
 	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
 		local_flush_tlb_all();
+
+	atomic64_set(&per_cpu(active_asids, cpu), mm->context.id);
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
 switch_mm_fastpath:
-- 
1.8.0
