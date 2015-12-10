From: james.morse@arm.com (James Morse)
Date: Thu, 10 Dec 2015 10:22:39 +0000
Subject: [PATCH v8 6/4] arm64: Add this_cpu_ptr() assembler macro for use in
 entry.S
In-Reply-To: <1449742961-11432-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449742961-11432-1-git-send-email-james.morse@arm.com>
Message-ID: <1449742961-11432-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq_stack is a per_cpu variable, that needs to be access from entry.S.
Use an assembler macro instead of the unreadable details.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h | 11 +++++++++++
 arch/arm64/kernel/entry.S          |  4 +---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 12eff928ef8b..bb7b72734c24 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -193,6 +193,17 @@ lr	.req	x30		// link register
 	str	\src, [\tmp, :lo12:\sym]
 	.endm
 
+	/*
+	 * @sym: The name of the per-cpu variable
+	 * @reg: Result of per_cpu(sym, smp_processor_id())
+	 * @tmp: scratch register
+	 */
+	.macro this_cpu_ptr, sym, reg, tmp
+	adr_l	\reg, \sym
+	mrs	\tmp, tpidr_el1
+	add	\reg, \reg, \tmp
+	.endm
+
 /*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 76e803118f57..9a0450344335 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -179,9 +179,7 @@ alternative_endif
 	.macro	irq_stack_entry, dummy_lr
 	mov	x19, sp			// preserve the original sp
 
-	adr_l	x25, irq_stack
-	mrs	x26, tpidr_el1
-	add	x25, x25, x26
+	this_cpu_ptr irq_stack, x25, x26
 
 	/*
 	 * Check the lowest address on irq_stack for the irq_count value,
-- 
2.6.2
