From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Jul 2015 15:14:53 +0100
Subject: [PATCH] arm64: switch_to: calculate cpu context pointer using
 separate register
Message-ID: <1437401693-3273-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
moved the thread_struct to the bottom of task_struct. As a result, the
offset is now too large to be used in an immediate add on arm64 with
some kernel configs:

arch/arm64/kernel/entry.S: Assembler messages:
arch/arm64/kernel/entry.S:588: Error: immediate out of range
arch/arm64/kernel/entry.S:597: Error: immediate out of range

This patch calculates the offset using an additional register instead of
an immediate offset.

Fixes: 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f860bfda454a..e16351819fed 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -585,7 +585,8 @@ ENDPROC(el0_irq)
  *
  */
 ENTRY(cpu_switch_to)
-	add	x8, x0, #THREAD_CPU_CONTEXT
+	mov	x10, #THREAD_CPU_CONTEXT
+	add	x8, x0, x10
 	mov	x9, sp
 	stp	x19, x20, [x8], #16		// store callee-saved registers
 	stp	x21, x22, [x8], #16
@@ -594,7 +595,7 @@ ENTRY(cpu_switch_to)
 	stp	x27, x28, [x8], #16
 	stp	x29, x9, [x8], #16
 	str	lr, [x8]
-	add	x8, x1, #THREAD_CPU_CONTEXT
+	add	x8, x1, x10
 	ldp	x19, x20, [x8], #16		// restore callee-saved registers
 	ldp	x21, x22, [x8], #16
 	ldp	x23, x24, [x8], #16
-- 
2.1.4
