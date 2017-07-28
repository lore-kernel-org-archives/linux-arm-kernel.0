From: james.morse@arm.com (James Morse)
Date: Fri, 28 Jul 2017 15:10:07 +0100
Subject: [PATCH v2 04/16] arm64: entry.S: mask all exceptions during
 kernel_exit
In-Reply-To: <20170728141019.9084-1-james.morse@arm.com>
References: <20170728141019.9084-1-james.morse@arm.com>
Message-ID: <20170728141019.9084-5-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a disable_daif call to kernel_exit to mask all exceptions
before restoring registers that are overwritten by an exception.

This should be done before we restore sp_el0, as any exception taken
from EL1 will assume this register is set correctly.

After this patch it is no longer necessary to mask interrupts before
kernel_exit.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index b738880350f9..491182f0abb5 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -207,6 +207,8 @@ alternative_else_nop_endif
 2:
 #endif
 
+	disable_daif
+
 	.if	\el == 0
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
@@ -438,8 +440,6 @@ el1_da:
 	mov	x2, sp				// struct pt_regs
 	bl	do_mem_abort
 
-	// disable interrupts before pulling preserved data off the stack
-	disable_irq
 	kernel_exit 1
 el1_sp_pc:
 	/*
-- 
2.13.2
