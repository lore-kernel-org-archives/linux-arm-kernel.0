From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:38 +0800
Subject: [PATCH 16/29] arm64: use RET instruction for exiting the trampoline
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-17-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit be04a6d1126b upstream.

Speculation attacks against the entry trampoline can potentially resteer
the speculative instruction stream through the indirect branch and into
arbitrary gadgets within the kernel.

This patch defends against these attacks by forcing a misprediction
through the return stack: a dummy BL instruction loads an entry into
the stack, so that the predicted program flow of the subsequent RET
instruction is to a branch-to-self instruction which is finally resolved
as a branch to the kernel vectors with speculation suppressed.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/entry.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 996c605..c00921e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -902,6 +902,14 @@ __ni_sys_trace:
 	.if	\regsize == 64
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
+	/*
+	 * Defend against branch aliasing attacks by pushing a dummy
+	 * entry onto the return stack and using a RET instruction to
+	 * enter the full-fat kernel vectors.
+	 */
+	bl	2f
+	b	.
+2:
 	tramp_map_kernel	x30
 #ifdef CONFIG_RANDOMIZE_BASE
 	adr	x30, tramp_vectors + PAGE_SIZE
@@ -913,7 +921,7 @@ __ni_sys_trace:
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
 	isb
-	br	x30
+	ret
 	.endm
 
 	.macro tramp_exit, regsize = 64
-- 
2.7.4
