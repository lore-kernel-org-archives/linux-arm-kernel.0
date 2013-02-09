From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sat,  9 Feb 2013 23:15:08 +0000
Subject: [PATCH 1/2] ARM: mm: replace direct access to mm->context.id with new
 macro
In-Reply-To: <1360451709-19740-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360451709-19740-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360451709-19740-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmid macro is meant to be used to get the mm->context.id data
from the mm structure, but it seems to have been missed in a cuple
of files.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mm/proc-v6.S        |    2 +-
 arch/arm/mm/proc-v7-2level.S |    2 +-
 arch/arm/mm/proc-v7-3level.S |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 09c5233..bcaaa8d 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -101,7 +101,7 @@ ENTRY(cpu_v6_dcache_clean_area)
 ENTRY(cpu_v6_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
-	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
+	mmid	r1, r1				@ get mm->context.id
 	ALT_SMP(orr	r0, r0, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r0, r0, #TTB_FLAGS_UP)
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 6d98c13..78f520b 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -40,7 +40,7 @@
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
-	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
+	mmid	r1, r1				@ get mm->context.id
 	ALT_SMP(orr	r0, r0, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r0, r0, #TTB_FLAGS_UP)
 #ifdef CONFIG_ARM_ERRATA_430973
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 7b56386..50bf1da 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -47,7 +47,7 @@
  */
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
-	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
+	mmid	r1, r1				@ get mm->context.id
 	and	r3, r1, #0xff
 	mov	r3, r3, lsl #(48 - 32)		@ ASID
 	mcrr	p15, 0, r0, r3, c2		@ set TTB 0
-- 
1.7.10.4
