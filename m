From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 14 Oct 2009 16:47:12 +0530
Subject: [PATCH] ARM: SMP: Fix the BUG with CONFIG_PREEMPT enabled
Message-ID: <mailman.74.1255519601.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the BUG: using smp_processor_id() in preemptible
Below is the stripped backtrace.

BUG: using smp_processor_id() in preemptible [00000000] code: init/1
caller is flush_tlb_mm+0x44/0x70
Backtrace:
[<c00225c4>] (dump_backtrace+0x0/0x110) from [<c01713a0>] (dump_stack+0x18/=
0x1c)
 r7:00000000 r6:c00234f0 r5:00000001 r4:c7828000
[<c0171388>] (dump_stack+0x0/0x1c) from [<c0135364>] (debug_smp_processor_i=
d+0xc0/0xf0)
[<c01352a4>] (debug_smp_processor_id+0x0/0xf0) from [<c00234f0>] (flush_tlb=
_mm+0x44/0x70)
 r7:00000000 r6:c60b41a0 r5:c60b4154 r4:00000001
[<c00234ac>] (flush_tlb_mm+0x0/0x70) from [<c0039568>] (dup_mm+0x304/0x38c)
 r5:c1f09058 r4:00000000
[<c0039264>] (dup_mm+0x0/0x38c) from [<c0039de4>] (copy_process+0x7b8/0xeb0=
)
[<c003962c>] (copy_process+0x0/0xeb0) from [<c003a638>] (do_fork+0x15c/0x29=
c)
[<c003a4dc>] (do_fork+0x0/0x29c) from [<c0021df0>] (sys_clone+0x34/0x3c)
[<c0021dbc>] (sys_clone+0x0/0x3c) from [<c001efa0>] (ret_fast_syscall+0x0/0=
x2c)

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/tlbflush.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflus=
h.h
index c964f3f..a0abf5c 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -350,7 +350,7 @@ static inline void local_flush_tlb_mm(struct mm_struct =
*mm)
 	if (tlb_flag(TLB_WB))
 		dsb();
=20
-	if (cpu_isset(smp_processor_id(), mm->cpu_vm_mask)) {
+	if (cpu_isset(get_cpu(), mm->cpu_vm_mask)) {
 		if (tlb_flag(TLB_V3_FULL))
 			asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (zero) : "cc");
 		if (tlb_flag(TLB_V4_U_FULL))
@@ -360,6 +360,7 @@ static inline void local_flush_tlb_mm(struct mm_struct =
*mm)
 		if (tlb_flag(TLB_V4_I_FULL))
 			asm("mcr p15, 0, %0, c8, c5, 0" : : "r" (zero) : "cc");
 	}
+	put_cpu();
=20
 	if (tlb_flag(TLB_V6_U_ASID))
 		asm("mcr p15, 0, %0, c8, c7, 2" : : "r" (asid) : "cc");
--=20
1.5.4.7



Regards,
Santosh
