From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jan 2017 16:10:58 +0000
Subject: [PATCH 3/3] arm64: entry-ftrace.S: avoid open-coded {adr,ldr}_l
In-Reply-To: <1484669458-31713-1-git-send-email-mark.rutland@arm.com>
References: <1484669458-31713-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1484669458-31713-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some places in the kernel open-code sequences using ADRP for a symbol
another instruction using a :lo12: relocation for that same symbol.
These sequences are easy to get wrong, and more painful to read than is
necessary. For these reasons, it is preferable to use the
{adr,ldr,str}_l macros for these cases.

This patch makes use of these in entry-ftrace.S, removing open-coded
sequences using adrp. This results in a minor code change, since a
temporary register is not used when generating the address for some
symbols, but this is fine, as the value of the temporary register is not
used elsewhere.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry-ftrace.S | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index aef02d2..8f1905b 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -98,8 +98,7 @@
 ENTRY(_mcount)
 	mcount_enter
 
-	adrp	x0, ftrace_trace_function
-	ldr	x2, [x0, #:lo12:ftrace_trace_function]
+	ldr_l	x2, ftrace_trace_function
 	adr	x0, ftrace_stub
 	cmp	x0, x2			// if (ftrace_trace_function
 	b.eq	skip_ftrace_call	//     != ftrace_stub) {
@@ -115,15 +114,12 @@ skip_ftrace_call:			//   return;
 	mcount_exit			//   return;
 					// }
 skip_ftrace_call:
-	adrp	x1, ftrace_graph_return
-	ldr	x2, [x1, #:lo12:ftrace_graph_return]
+	ldr_l	x2, ftrace_graph_return
 	cmp	x0, x2			//   if ((ftrace_graph_return
 	b.ne	ftrace_graph_caller	//        != ftrace_stub)
 
-	adrp	x1, ftrace_graph_entry	//     || (ftrace_graph_entry
-	adrp	x0, ftrace_graph_entry_stub //     != ftrace_graph_entry_stub))
-	ldr	x2, [x1, #:lo12:ftrace_graph_entry]
-	add	x0, x0, #:lo12:ftrace_graph_entry_stub
+	ldr_l	x2, ftrace_graph_entry	//     || (ftrace_graph_entry
+	adr_l	x0, ftrace_graph_entry_stub //     != ftrace_graph_entry_stub))
 	cmp	x0, x2
 	b.ne	ftrace_graph_caller	//     ftrace_graph_caller();
 
-- 
1.9.1
