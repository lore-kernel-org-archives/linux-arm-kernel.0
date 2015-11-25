From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:37:51 +0100
Subject: [PATCH 3/7] ARM: mohawk: allow building with MMU disabled
In-Reply-To: <1448465875-435039-1-git-send-email-arnd@arndb.de>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
Message-ID: <1448465875-435039-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is in principle possible to build an MMP kernel for
the mohawk CPU with the MMU code disabled, except for one
simple build error:

proc-mohawk.S:345: Error: invalid operands (*UND* and *UND* sections) for `|'
proc-mohawk.S:345: Error: invalid operands (*ABS* and *UND* sections) for `|'
proc-mohawk.S:345: Error: invalid operands (*UND* and *UND* sections) for `|'
proc-mohawk.S:345: Error: invalid operands (*UND* and *UND* sections) for `|'
proc-mohawk.S:345: Error: undefined symbol L_PTE_USER used as an immediate value

This patch changes the proc-mohawk code to do the same as the
other CPUs and not try to actually do anything for the
cpu_mohawk_set_pte_ext function, which won't be used anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/proc-mohawk.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index d65edf717bf7..6f07d2ef4ff2 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -342,11 +342,13 @@ ENTRY(cpu_mohawk_switch_mm)
  */
 	.align	5
 ENTRY(cpu_mohawk_set_pte_ext)
+#ifdef CONFIG_MMU
 	armv3_set_pte_ext
 	mov	r0, r0
 	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	ret	lr
+#endif
 
 .globl	cpu_mohawk_suspend_size
 .equ	cpu_mohawk_suspend_size, 4 * 6
-- 
2.1.0.rc2
