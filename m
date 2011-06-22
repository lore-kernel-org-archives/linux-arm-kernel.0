From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 16:11:53 +0100
Subject: [PATCH 10/25] ARM: pm: sa1100: cleanup sa1100_cpu_suspend
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Message-ID: <E1QZP5t-0002WP-Hf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sa1100_cpu_suspend does not need to save any registers to the stack
with the new cpu_suspend calling convention.  Remove these redundant
instructions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/sleep.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/sleep.S b/arch/arm/mach-sa1100/sleep.S
index 214f4e2..e814b60 100644
--- a/arch/arm/mach-sa1100/sleep.S
+++ b/arch/arm/mach-sa1100/sleep.S
@@ -29,12 +29,12 @@
  */
 
 ENTRY(sa1100_cpu_suspend)
-	stmfd	sp!, {r4 - r12, lr}		@ save registers on stack
+	mov	r9, lr
 	mov	r1, r0
 	adr	r3, BSYM(sa1100_finish_suspend)
 	bl	cpu_suspend
 	mcr	p15, 0, r1, c15, c1, 2		@ enable clock switching
-	ldmfd	sp!, {r4 - r12, pc}		@ return to caller
+	mov	pc, r9				@ return to caller
 
 sa1100_finish_suspend:
 	@ disable clock switching
-- 
1.7.4.4
