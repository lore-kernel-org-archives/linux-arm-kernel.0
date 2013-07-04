From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Jul 2013 16:02:23 +0100
Subject: [PATCH] ARM: mm: ensure SMP alternates assemble to exactly 4 bytes
 with Thumb-2
Message-ID: <1372950143-12789-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ae8a8b9553bd ("ARM: 7691/1: mm: kill unused TLB_CAN_READ_FROM_L1_CACHE
and use ALT_SMP instead") added early function returns for page table
cache flushing operations on ARMv7 SMP CPUs.

Unfortunately, when targetting Thumb-2, these `mov pc, lr' sequences
assemble to 2 bytes which can lead to corruption of the instruction
stream after code patching.

This patch fixes the alternates to use wide (32-bit) instructions for
Thumb-2, therefore ensuring that the patching code works correctly.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v7-2level.S |  2 +-
 arch/arm/mm/proc-v7-3level.S |  2 +-
 arch/arm/mm/proc-v7.S        | 11 ++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 9704097..b3997c7 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -110,7 +110,7 @@ ENTRY(cpu_v7_set_pte_ext)
  ARM(	str	r3, [r0, #2048]! )
  THUMB(	add	r0, r0, #2048 )
  THUMB(	str	r3, [r0] )
-	ALT_SMP(mov	pc,lr)
+	ALT_SMP(W(nop))
 	ALT_UP (mcr	p15, 0, r0, c7, c10, 1)		@ flush_pte
 #endif
 	mov	pc, lr
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 363027e..6ba4bd9 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -73,7 +73,7 @@ ENTRY(cpu_v7_set_pte_ext)
 	tst	r3, #1 << (55 - 32)		@ L_PTE_DIRTY
 	orreq	r2, #L_PTE_RDONLY
 1:	strd	r2, r3, [r0]
-	ALT_SMP(mov	pc, lr)
+	ALT_SMP(W(nop))
 	ALT_UP (mcr	p15, 0, r0, c7, c10, 1)		@ flush_pte
 #endif
 	mov	pc, lr
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index e35fec3..5fbccee 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -75,13 +75,14 @@ ENTRY(cpu_v7_do_idle)
 ENDPROC(cpu_v7_do_idle)
 
 ENTRY(cpu_v7_dcache_clean_area)
-	ALT_SMP(mov	pc, lr)			@ MP extensions imply L1 PTW
-	ALT_UP(W(nop))
-	dcache_line_size r2, r3
-1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
+	ALT_SMP(W(nop))			@ MP extensions imply L1 PTW
+	ALT_UP_B(1f)
+	mov	pc, lr
+1:	dcache_line_size r2, r3
+2:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
 	add	r0, r0, r2
 	subs	r1, r1, r2
-	bhi	1b
+	bhi	2b
 	dsb
 	mov	pc, lr
 ENDPROC(cpu_v7_dcache_clean_area)
-- 
1.8.2.2
