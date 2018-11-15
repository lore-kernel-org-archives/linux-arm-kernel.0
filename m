From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Nov 2018 22:42:00 +0000
Subject: [PATCH 3/6] arm64: ftrace: enable graph FP test
In-Reply-To: <20181115224203.24847-1-mark.rutland@arm.com>
References: <20181115224203.24847-1-mark.rutland@arm.com>
Message-ID: <20181115224203.24847-4-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core frace code has an optional sanity check on the frame pointer
passed by ftrace_graph_caller and return_to_handler. This is cheap,
useful, and enabled unconditionally on x86, sparc, and riscv.

Let's do the same on arm64, so that we can catch any problems early.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Torsten Duwe <duwe@suse.de>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/ftrace.h  | 1 +
 arch/arm64/kernel/entry-ftrace.S | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index caa955f10e19..6795c147cbcc 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -13,6 +13,7 @@
 
 #include <asm/insn.h>
 
+#define HAVE_FUNCTION_GRAPH_FP_TEST
 #define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index eb4e50d9f75d..7d74b2af6d3b 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -213,8 +213,7 @@ ENDPROC(ftrace_graph_caller)
  * void return_to_handler(void)
  *
  * Run ftrace_return_to_handler() before going back to parent.
- * @fp is checked against the value passed by ftrace_graph_caller()
- * only when HAVE_FUNCTION_GRAPH_FP_TEST is enabled.
+ * @fp is checked against the value passed by ftrace_graph_caller().
  */
 ENTRY(return_to_handler)
 	save_return_regs
-- 
2.11.0
