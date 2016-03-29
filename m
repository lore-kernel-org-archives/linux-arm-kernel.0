From: jonas.rabenstein@studium.uni-erlangen.de (Jonas Rabenstein)
Date: Tue, 29 Mar 2016 09:37:51 +0200
Subject: [PATCH] arm: remove tautologic #ifdefs in proc-v7-3level.S
Message-ID: <1459237071-13842-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file arch/arm/mm/proc-v7-3level.S is only used by the #include
directive in arch/arm/mm/proc-v7.S:23. This #include is conditional and
depends on  CONFIG_ARM_LPAE (otherwise proc-v7-2level.S is used).
CONFIG_ARM_LPAE has a dependency on CONFIG_MMU defined in Kconfig.
Consequently, checks for CONFIG_MMU in proc-v7-3level.S are superfluous.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 I detected the issue with chimaera, a tool I currently develop for my bachelor
 thesis extending the undertaker tool suite (https://undertaker.cs.fau.de).

 arch/arm/mm/proc-v7-3level.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 5e5720e..6903f34 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -55,13 +55,11 @@
  * the new TTB).
  */
 ENTRY(cpu_v7_switch_mm)
-#ifdef CONFIG_MMU
 	mmid	r2, r2
 	asid	r2, r2
 	orr	rpgdh, rpgdh, r2, lsl #(48 - 32)	@ upper 32-bits of pgd
 	mcrr	p15, 0, rpgdl, rpgdh, c2		@ set TTB 0
 	isb
-#endif
 	ret	lr
 ENDPROC(cpu_v7_switch_mm)
 
@@ -81,7 +79,6 @@ ENDPROC(cpu_v7_switch_mm)
  * - pte - PTE value to store (64-bit in r2 and r3)
  */
 ENTRY(cpu_v7_set_pte_ext)
-#ifdef CONFIG_MMU
 	tst	rl, #L_PTE_VALID
 	beq	1f
 	tst	rh, #1 << (57 - 32)		@ L_PTE_NONE
@@ -97,7 +94,6 @@ ENTRY(cpu_v7_set_pte_ext)
 1:	strd	r2, r3, [r0]
 	ALT_SMP(W(nop))
 	ALT_UP (mcr	p15, 0, r0, c7, c10, 1)		@ flush_pte
-#endif
 	ret	lr
 ENDPROC(cpu_v7_set_pte_ext)
 
-- 
2.7.3
