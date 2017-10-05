From: james.morse@arm.com (James Morse)
Date: Thu,  5 Oct 2017 20:18:00 +0100
Subject: [PATCH v3 08/20] arm64: entry.S: convert elX_irq
In-Reply-To: <20171005191812.5678-1-james.morse@arm.com>
References: <20171005191812.5678-1-james.morse@arm.com>
Message-ID: <20171005191812.5678-9-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following our 'dai' order, irqs should be processed with debug and
serror exceptions unmasked.

Add a helper to unmask these two, (and fiq for good measure).

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h | 4 ++++
 arch/arm64/kernel/entry.S          | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index c2a37e2f733c..7ffb2a629dc9 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -54,6 +54,10 @@
 	msr	daif, \tmp
 	.endm
 
+	.macro enable_da_f
+	msr	daifclr, #(8 | 4 | 1)
+	.endm
+
 /*
  * Enable and disable interrupts.
  */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f7dfe5d2b1fb..df085ec003b0 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -557,7 +557,7 @@ ENDPROC(el1_sync)
 	.align	6
 el1_irq:
 	kernel_entry 1
-	enable_dbg
+	enable_da_f
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
@@ -766,7 +766,7 @@ ENDPROC(el0_sync)
 el0_irq:
 	kernel_entry 0
 el0_irq_naked:
-	enable_dbg
+	enable_da_f
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
-- 
2.13.3
