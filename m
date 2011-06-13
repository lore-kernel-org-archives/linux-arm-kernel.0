From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 18:16:11 +0100
Subject: [PATCH 04/14] ARM: suspend: preserve r4 - r11 across a suspend
In-Reply-To: <20110613171446.GF13643@n2100.arm.linux.org.uk>
References: <20110613171446.GF13643@n2100.arm.linux.org.uk>
Message-ID: <E1QWAkF-0002dv-7i@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make cpu_suspend()..return function preserve r4 to r11 across a suspend
cycle.  This is in preparation of relieving platform support code from
this task.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 0a778c3..8dbca93 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -12,10 +12,11 @@
  *  r1 = v:p offset
  *  r3 = virtual return function
  * Note: sp is decremented to allocate space for CPU state on stack
- * r0-r3,r9,r10,lr corrupted
+ * r0-r3,ip,lr corrupted
  */
 ENTRY(cpu_suspend)
 	stmfd	sp!, {r3}
+	stmfd	sp!, {r4 - r11}
 	mov	r9, lr
 #ifdef MULTI_CPU
 	ldr	r10, =processor
@@ -88,7 +89,7 @@ ENDPROC(cpu_resume_turn_mmu_on)
 cpu_resume_after_mmu:
 	str	r5, [r2, r4, lsl #2]	@ restore old mapping
 	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
-	ldmfd	sp!, {pc}
+	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_resume_after_mmu)
 
 /*
-- 
1.7.4.4
