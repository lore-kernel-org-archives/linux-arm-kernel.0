From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 11 Jan 2011 18:03:33 -0600
Subject: [PATCH] ARM: Thumb-2: Fix out-of-range offset for Thumb-2 in proc-v7.S
Message-ID: <1294790613-17101-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch introduces a pre-increment addressing
offset which is out of range for Thumb-2:
    ARM: pgtable: switch order of Linux vs hardware page tables

162:	str	r3, [r0, #2048]!

Thumb-2 only permits offsets <256 for pre-increment addressing.

This patch replaces the store instruction with a suitable add-str
pair for the Thumb-2 case.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
KernelVersion: v2.6.37

 arch/arm/mm/proc-v7.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b49fab2..0c1172b 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -159,7 +159,9 @@ ENTRY(cpu_v7_set_pte_ext)
 	tstne	r1, #L_PTE_PRESENT
 	moveq	r3, #0
 
-	str	r3, [r0, #2048]!
+ ARM(	str	r3, [r0, #2048]! )
+ THUMB(	add	r0, r0, #2048 )
+ THUMB(	str	r3, [r0] )
 	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
 #endif
 	mov	pc, lr
-- 
1.7.1
