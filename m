From: will.deacon@arm.com (Will Deacon)
Date: Fri,  5 Jan 2018 13:12:31 +0000
Subject: [PATCH v2 01/11] arm64: use RET instruction for exiting the trampoline
In-Reply-To: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
Message-ID: <1515157961-20963-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Speculation attacks against the entry trampoline can potentially resteer
the speculative instruction stream through the indirect branch and into
arbitrary gadgets within the kernel.

This patch defends against these attacks by forcing a misprediction
through the return stack: a dummy BL instruction loads an entry into
the stack, so that the predicted program flow of the subsequent RET
instruction is to a branch-to-self instruction which is finally resolved
as a branch to the kernel vectors with speculation suppressed.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 031392ee5f47..71092ee09b6b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1029,6 +1029,14 @@ alternative_else_nop_endif
 	.if	\regsize == 64
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
+	/*
+	 * Defend against branch aliasing attacks by pushing a dummy
+	 * entry onto the return stack and using a RET instruction to
+	 * entr the full-fat kernel vectors.
+	 */
+	bl	2f
+	b	.
+2:
 	tramp_map_kernel	x30
 #ifdef CONFIG_RANDOMIZE_BASE
 	adr	x30, tramp_vectors + PAGE_SIZE
@@ -1041,7 +1049,7 @@ alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
 	isb
-	br	x30
+	ret
 	.endm
 
 	.macro tramp_exit, regsize = 64
-- 
2.1.4
