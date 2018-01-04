From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu,  4 Jan 2018 18:04:05 +0000
Subject: [PATCH] arm: asid: Do not replace active_asids if already 0
Message-ID: <20180104180405.37596-1-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under some uncommon timing conditions, a generation check and
xchg(active_asids, A1) in check_and_switch_context() on P1 can race with
an ASID roll-over on P2. If P2 has not seen the update to
active_asids[P1], it can re-allocate A1 to a new task T2 on P2. P1 ends
up waiting on the spinlock since the xchg() returned 0 while P2 can go
through a second ASID roll-over with (T2,A1,G2) active on P2. This
roll-over copies active_asids[P1] == A1,G1 into reserved_asids[P1] and
active_asids[P2] == A1,G2 into reserved_asids[P2]. A subsequent
scheduling of T1 on P1 and T2 on P2 would match reserved_asids and get
their generation bumped to G3:

P1					P2
--                                      --
TTBR0.BADDR = T0
TTBR0.ASID = A0
asid_generation = G1
check_and_switch_context(T1,A1,G1)
  generation match
					check_and_switch_context(T2,A0,G0)
 				          new_context()
					    ASID roll-over
					    asid_generation = G2
					    flush_context()
					      active_asids[P1] = 0
					      asid_map[A1] = 0
					      reserved_asids[P1] = A0,G0
  xchg(active_asids, A1)
    active_asids[P1] = A1,G1
    xchg returns 0
  spin_lock_irqsave()
					    allocated ASID (T2,A1,G2)
					    asid_map[A1] = 1
					  active_asids[P2] = A1,G2
					...
					check_and_switch_context(T3,A0,G0)
					  new_context()
					    ASID roll-over
					    asid_generation = G3
					    flush_context()
					      active_asids[P1] = 0
					      asid_map[A1] = 1
					      reserved_asids[P1] = A1,G1
					      reserved_asids[P2] = A1,G2
					    allocated ASID (T3,A2,G3)
					    asid_map[A2] = 1
					  active_asids[P2] = A2,G3
  new_context()
    check_update_reserved_asid(A1,G1)
      matches reserved_asid[P1]
      reserved_asid[P1] = A1,G3
  updated T1 ASID to (T1,A1,G3)
					check_and_switch_context(T2,A1,G2)
					  new_context()
					    check_and_switch_context(A1,G2)
					      matches reserved_asids[P2]
					      reserved_asids[P2] = A1,G3
					  updated T2 ASID to (T2,A1,G3)

At this point, we have two tasks, T1 and T2 both using ASID A1 with the
latest generation G3. Any of them is allowed to be scheduled on the
other CPU leading to two different tasks with the same ASID on the same
CPU.

This patch changes the xchg to cmpxchg so that the active_asids is only
updated if non-zero to avoid a race with an ASID roll-over on a
different CPU.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

This is similar to the arm64 patch [1], with the difference that non-relaxed
(cmp)xchg is used as per the existing code.

[1] http://lkml.kernel.org/r/20180104111721.33834-1-catalin.marinas at arm.com

 arch/arm/mm/context.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index c8c8b9ed02e0..3208319d72e7 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -241,7 +241,7 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 {
 	unsigned long flags;
 	unsigned int cpu = smp_processor_id();
-	u64 asid;
+	u64 asid, old_active_asid;
 
 	if (unlikely(mm->context.vmalloc_seq != init_mm.context.vmalloc_seq))
 		__check_vmalloc_seq(mm);
@@ -254,8 +254,17 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 	cpu_set_reserved_ttbr0();
 
 	asid = atomic64_read(&mm->context.id);
-	if (!((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS)
-	    && atomic64_xchg(&per_cpu(active_asids, cpu), asid))
+
+	/*
+	 * If our active_asids is zero, we are racing with an ASID roll-over
+	 * on a different CPU, so skip the update (using cmpxchg if non-zero)
+	 * and take the slow path.
+	 */
+	old_active_asid = atomic64_read(&per_cpu(active_asids, cpu));
+	if (old_active_asid &&
+	    !((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS) &&
+	    atomic64_cmpxchg(&per_cpu(active_asids, cpu),
+				old_active_asid, asid))
 		goto switch_mm_fastpath;
 
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
