From: james.morse@arm.com (James Morse)
Date: Thu,  3 Aug 2017 16:15:31 +0100
Subject: [PATCH 1/3] arm64: entry: Allow SPSR_EL1.SS to be restored
In-Reply-To: <20170803151533.29438-1-james.morse@arm.com>
References: <20170803151533.29438-1-james.morse@arm.com>
Message-ID: <20170803151533.29438-2-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we take an IRQ from the single-step state-machine's active-not-pending
state, the PSTATE.SS bit is saved in SPSR_EL1.SS. This lets us restore the
state machine when we return to the to-be-stepped instruction.

The ARM-ARM has some rules about when ERET will restore this bit, (see
ARM DDI 0487B.a D2.12.4 Entering the active-not-pending state'), in
particular it requires 'debug exceptions are disabled from the current
exception level'. el1_irq unmasks debug exceptions, and continues like this
until ERET. The PSTATE.SS bit is not restored.

Fix this this by masking all exceptions on kernel_exit.

Signed-off-by: James Morse <james.morse@arm.com>
CC: Pratyush Anand <panand@redhat.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>

---
 arch/arm64/include/asm/assembler.h | 4 ++++
 arch/arm64/kernel/entry.S          | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 1b67c3782d00..1c490c578a2e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -31,6 +31,10 @@
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
+	.macro disable_daif
+	msr	daifset, #0xf
+	.endm
+
 /*
  * Enable and disable interrupts.
  */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index b738880350f9..eed2d51e16e6 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -163,6 +163,8 @@ alternative_else_nop_endif
 	.endm
 
 	.macro	kernel_exit, el
+	disable_daif
+
 	.if	\el != 0
 	/* Restore the task's original addr_limit. */
 	ldr	x20, [sp, #S_ORIG_ADDR_LIMIT]
@@ -438,8 +440,6 @@ el1_da:
 	mov	x2, sp				// struct pt_regs
 	bl	do_mem_abort
 
-	// disable interrupts before pulling preserved data off the stack
-	disable_irq
 	kernel_exit 1
 el1_sp_pc:
 	/*
-- 
2.13.3
