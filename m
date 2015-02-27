From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Feb 2015 14:29:31 +0100
Subject: [PATCH 4/8] ARM: mohawk: allow building with MMU disabled
In-Reply-To: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
References: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
Message-ID: <1425043775-3106827-5-git-send-email-arnd@arndb.de>
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
index df18dbd88c8a..74c0d0f7f325 100644
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
