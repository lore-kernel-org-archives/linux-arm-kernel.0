From: will.deacon@arm.com (Will Deacon)
Date: Mon,  5 Feb 2018 15:34:20 +0000
Subject: [PATCH 5/9] arm64: entry: Ensure branch through syscall table is
 bounded under speculation
In-Reply-To: <1517844864-15887-1-git-send-email-will.deacon@arm.com>
References: <1517844864-15887-1-git-send-email-will.deacon@arm.com>
Message-ID: <1517844864-15887-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a similar manner to array_index_mask_nospec, this patch introduces an
assembly macro (mask_nospec64) which can be used to bound a value under
speculation. This macro is then used to ensure that the indirect branch
through the syscall table is bounded under speculation, with out-of-range
addresses speculating as calls to sys_io_setup (0).

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 11 +++++++++++
 arch/arm64/kernel/entry.S          |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 709adde9e80f..b709f6aa5d0f 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -123,6 +123,17 @@
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
index 4e2eae8c442e..f4276fa81e02 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -378,6 +378,7 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
  * x7 is reserved for the system call number in 32-bit mode.
  */
 wsc_nr	.req	w25		// number of system calls
+xsc_nr	.req	x25		// number of system calls (zero-extended)
 wscno	.req	w26		// syscall number
 xscno	.req	x26		// syscall number (zero-extended)
 stbl	.req	x27		// syscall table pointer
@@ -935,6 +936,7 @@ el0_svc_naked:					// compat entry point
 	b.ne	__sys_trace
 	cmp     wscno, wsc_nr			// check upper syscall limit
 	b.hs	ni_sys
+	mask_nospec64 xscno, xsc_nr, x19	// enforce bounds for syscall number
 	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
 	blr	x16				// call sys_* routine
 	b	ret_fast_syscall
-- 
2.1.4
