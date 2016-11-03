From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  3 Nov 2016 20:23:12 +0000
Subject: [PATCHv2 10/11] arm64: assembler: introduce ldr_this_cpu
In-Reply-To: <1478204593-29145-1-git-send-email-mark.rutland@arm.com>
References: <1478204593-29145-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1478204593-29145-11-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shortly we will want to load a percpu variable in the return from
userspace path. We can save an instruction by folding the addition of
the percpu offset into the load instruction, and this patch adds a new
helper to do so.

At the same time, we clean up this_cpu_ptr for consistency. As with
{adr,ldr,str}_l, we change the template to take the destination register
first, and name this dst. Secondly, we rename the macro to adr_this_cpu,
following the scheme of adr_l, and matching the newly added
ldr_this_cpu.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 19 +++++++++++++++----
 arch/arm64/kernel/entry.S          |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 28bfe61..128a9ca 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -202,14 +202,25 @@ lr	.req	x30		// link register
 	.endm
 
 	/*
+	 * @dst: Result of per_cpu(sym, smp_processor_id())
 	 * @sym: The name of the per-cpu variable
-	 * @reg: Result of per_cpu(sym, smp_processor_id())
 	 * @tmp: scratch register
 	 */
-	.macro this_cpu_ptr, sym, reg, tmp
-	adr_l	\reg, \sym
+	.macro adr_this_cpu, dst, sym, tmp
+	adr_l	\dst, \sym
 	mrs	\tmp, tpidr_el1
-	add	\reg, \reg, \tmp
+	add	\dst, \dst, \tmp
+	.endm
+
+	/*
+	 * @dst: Result of READ_ONCE(per_cpu(sym, smp_processor_id()))
+	 * @sym: The name of the per-cpu variable
+	 * @tmp: scratch register
+	 */
+	.macro ldr_this_cpu dst, sym, tmp
+	adr_l	\dst, \sym
+	mrs	\tmp, tpidr_el1
+	ldr	\dst, [\dst, \tmp]
 	.endm
 
 /*
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 223d54a..2d4c83b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -200,7 +200,7 @@ alternative_else_nop_endif
 	cmp	x25, tsk
 	b.ne	9998f
 
-	this_cpu_ptr irq_stack, x25, x26
+	adr_this_cpu x25, irq_stack, x26
 	mov	x26, #IRQ_STACK_START_SP
 	add	x26, x25, x26
 
-- 
2.7.4
