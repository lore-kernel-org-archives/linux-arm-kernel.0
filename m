From: james.morse@arm.com (James Morse)
Date: Fri, 28 Jul 2017 15:10:10 +0100
Subject: [PATCH v2 07/16] arm64: entry.S: convert elX_irq
In-Reply-To: <20170728141019.9084-1-james.morse@arm.com>
References: <20170728141019.9084-1-james.morse@arm.com>
Message-ID: <20170728141019.9084-8-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following our 'adi' order, Interrupts should be processed with Debug and
SError exceptions unmasked.

Add a helper to unmask these two, (and fiq for good measure).

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h | 10 +++++-----
 arch/arm64/kernel/entry.S          |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6a2512da468a..a013ab05210d 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -56,6 +56,10 @@
 	msr	daif, \tmp
 	.endm
 
+	.macro enable_da_f
+	msr	daifclr, #(8 | 4 | 1)
+	.endm
+
 /*
  * Enable and disable interrupts.
  */
@@ -80,16 +84,12 @@
 	msr	daifclr, #4
 	.endm
 
-	.macro	enable_dbg
-	msr	daifclr, #8
-	.endm
-
 	.macro	disable_step_tsk, flgs, tmp
 	tbz	\flgs, #TIF_SINGLESTEP, 9990f
 	mrs	\tmp, mdscr_el1
 	bic	\tmp, \tmp, #1
 	msr	mdscr_el1, \tmp
-	isb	// Synchronise with enable_dbg
+	isb	// Synchronise with any daif write that enables debug
 9990:
 	.endm
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 51e704e46c29..2fde60f96239 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -477,7 +477,7 @@ ENDPROC(el1_sync)
 	.align	6
 el1_irq:
 	kernel_entry 1
-	enable_dbg
+	enable_da_f
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
@@ -677,7 +677,7 @@ ENDPROC(el0_sync)
 el0_irq:
 	kernel_entry 0
 el0_irq_naked:
-	enable_dbg
+	enable_da_f
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
-- 
2.13.2
