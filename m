From: alex.shi@linaro.org (Alex Shi)
Date: Thu,  1 Mar 2018 20:53:49 +0800
Subject: [PATCH 12/45] arm64: entry: Ensure branch through syscall table is
 bounded under speculation
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519908862-11425-13-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 6314d90e6493 upstream.

In a similar manner to array_index_mask_nospec, this patch introduces an
assembly macro (mask_nospec64) which can be used to bound a value under
speculation. This macro is then used to ensure that the indirect branch
through the syscall table is bounded under speculation, with out-of-range
addresses speculating as calls to sys_io_setup (0).

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 11 +++++++++++
 arch/arm64/kernel/entry.S          |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ab3a179..a109d30 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -94,6 +94,17 @@
 	.endm
 
 /*
+ * Sanitise a 64-bit bounded index wrt speculation, returning zero if out
+ * of bounds.
+ */
+	.macro	mask_nospec64, idx, limit, tmp
+	sub	\tmp, \idx, \limit
+	bic	\tmp, \tmp, \idx
+	and	\idx, \idx, \tmp, asr #63
+	csdb
+	.endm
+
+/*
  * NOP sequence
  */
 	.macro	nops, num
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 48c41ff..0a27e12 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -233,6 +233,7 @@ alternative_else_nop_endif
  * x7 is reserved for the system call number in 32-bit mode.
  */
 wsc_nr	.req	w25		// number of system calls
+xsc_nr	.req	x25		// number of system calls (zero-extended)
 wscno	.req	w26		// syscall number
 xscno	.req	x26		// syscall number (zero-extended)
 stbl	.req	x27		// syscall table pointer
@@ -754,6 +755,7 @@ el0_svc_naked:					// compat entry point
 	b.ne	__sys_trace
 	cmp     wscno, wsc_nr			// check upper syscall limit
 	b.hs	ni_sys
+	mask_nospec64 xscno, xsc_nr, x19	// enforce bounds for syscall number
 	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
 	blr	x16				// call sys_* routine
 	b	ret_fast_syscall
-- 
2.7.4
