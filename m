From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 15:18:08 +0000
Subject: [PATCH 2/2] ARM: mm: make mm->context.id an atomic64_t variable
In-Reply-To: <1361805488-8798-1-git-send-email-will.deacon@arm.com>
References: <1361805488-8798-1-git-send-email-will.deacon@arm.com>
Message-ID: <1361805488-8798-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mm->context.id is updated under asid_lock when a new ASID is allocated
to an mm_struct. However, it is also read without the lock when a task
is being scheduled and checking whether or not the current ASID
generation is up-to-date.

If two threads of the same process are being scheduled in parallel and
the bottom bits of the generation in their mm->context.id match the
current generation (that is, the mm_struct has not been used for ~2^24
rollovers) then the non-atomic, lockless access to mm->context.id may
yield the incorrect ASID.

This patch fixes this issue by making mm->context.id and atomic64_t,
ensuring that the generation is always read consistently. For code that
only requires access to the ASID bits (e.g. TLB flushing by mm), then
the value is accessed directly, which GCC converts to an ldrb.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/mmu.h         |  8 ++++----
 arch/arm/include/asm/mmu_context.h |  2 +-
 arch/arm/kernel/asm-offsets.c      |  2 +-
 arch/arm/mm/context.c              | 21 +++++++++++++--------
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 9f77e78..e3d5554 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -5,15 +5,15 @@
 
 typedef struct {
 #ifdef CONFIG_CPU_HAS_ASID
-	u64 id;
+	atomic64_t	id;
 #endif
-	unsigned int vmalloc_seq;
+	unsigned int	vmalloc_seq;
 } mm_context_t;
 
 #ifdef CONFIG_CPU_HAS_ASID
 #define ASID_BITS	8
 #define ASID_MASK	((~0ULL) << ASID_BITS)
-#define ASID(mm)	((mm)->context.id & ~ASID_MASK)
+#define ASID(mm)	((mm)->context.id.counter & ~ASID_MASK)
 #else
 #define ASID(mm)	(0)
 #endif
@@ -26,7 +26,7 @@ typedef struct {
  *  modified for 2.6 by Hyok S. Choi <hyok.choi@samsung.com>
  */
 typedef struct {
-	unsigned long		end_brk;
+	unsigned long	end_brk;
 } mm_context_t;
 
 #endif
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index e1f644b..863a661 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -25,7 +25,7 @@ void __check_vmalloc_seq(struct mm_struct *mm);
 #ifdef CONFIG_CPU_HAS_ASID
 
 void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk);
-#define init_new_context(tsk,mm)	({ mm->context.id = 0; })
+#define init_new_context(tsk,mm)	({ atomic64_set(&mm->context.id, 0); 0; })
 
 #else	/* !CONFIG_CPU_HAS_ASID */
 
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 5ce738b..923eec7 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -110,7 +110,7 @@ int main(void)
   BLANK();
 #endif
 #ifdef CONFIG_CPU_HAS_ASID
-  DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id));
+  DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
   BLANK();
 #endif
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 03ba181..44d4ee5 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -152,9 +152,9 @@ static int is_reserved_asid(u64 asid)
 	return 0;
 }
 
-static void new_context(struct mm_struct *mm, unsigned int cpu)
+static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 {
-	u64 asid = mm->context.id;
+	u64 asid = atomic64_read(&mm->context.id);
 	u64 generation = atomic64_read(&asid_generation);
 
 	if (asid != 0 && is_reserved_asid(asid)) {
@@ -181,13 +181,14 @@ static void new_context(struct mm_struct *mm, unsigned int cpu)
 		cpumask_clear(mm_cpumask(mm));
 	}
 
-	mm->context.id = asid;
+	return asid;
 }
 
 void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 {
 	unsigned long flags;
 	unsigned int cpu = smp_processor_id();
+	u64 asid;
 
 	if (unlikely(mm->context.vmalloc_seq != init_mm.context.vmalloc_seq))
 		__check_vmalloc_seq(mm);
@@ -198,19 +199,23 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 	 */
 	cpu_set_reserved_ttbr0();
 
-	if (!((mm->context.id ^ atomic64_read(&asid_generation)) >> ASID_BITS)
-	    && atomic64_xchg(&per_cpu(active_asids, cpu), mm->context.id))
+	asid = atomic64_read(&mm->context.id);
+	if (!((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS)
+	    && atomic64_xchg(&per_cpu(active_asids, cpu), asid))
 		goto switch_mm_fastpath;
 
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
 	/* Check that our ASID belongs to the current generation. */
-	if ((mm->context.id ^ atomic64_read(&asid_generation)) >> ASID_BITS)
-		new_context(mm, cpu);
+	asid = atomic64_read(&mm->context.id);
+	if ((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS) {
+		asid = new_context(mm, cpu);
+		atomic64_set(&mm->context.id, asid);
+	}
 
 	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
 		local_flush_tlb_all();
 
-	atomic64_set(&per_cpu(active_asids, cpu), mm->context.id);
+	atomic64_set(&per_cpu(active_asids, cpu), asid);
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
-- 
1.8.0
