From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  7 Nov 2014 15:12:33 +0100
Subject: [PATCH 1/2] arm64: ftrace: eliminate literal pool entries
Message-ID: <1415369554-7444-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace ldr xN, =<symbol> with adrp/add or adrp/ldr [as appropriate]
in the implementation of _mcount(), which may be called very often.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/entry-ftrace.S | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 38e704e597f7..08cafc518b9a 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -98,8 +98,8 @@
 ENTRY(_mcount)
 	mcount_enter
 
-	ldr	x0, =ftrace_trace_function
-	ldr	x2, [x0]
+	adrp	x0, ftrace_trace_function
+	ldr	x2, [x0, #:lo12:ftrace_trace_function]
 	adr	x0, ftrace_stub
 	cmp	x0, x2			// if (ftrace_trace_function
 	b.eq	skip_ftrace_call	//     != ftrace_stub) {
@@ -115,14 +115,15 @@ skip_ftrace_call:			//   return;
 	mcount_exit			//   return;
 					// }
 skip_ftrace_call:
-	ldr	x1, =ftrace_graph_return
-	ldr	x2, [x1]		//   if ((ftrace_graph_return
-	cmp	x0, x2			//        != ftrace_stub)
-	b.ne	ftrace_graph_caller
-
-	ldr	x1, =ftrace_graph_entry	//     || (ftrace_graph_entry
-	ldr	x2, [x1]		//        != ftrace_graph_entry_stub))
-	ldr	x0, =ftrace_graph_entry_stub
+	adrp	x1, ftrace_graph_return
+	ldr	x2, [x1, #:lo12:ftrace_graph_return]
+	cmp	x0, x2			//   if ((ftrace_graph_return
+	b.ne	ftrace_graph_caller	//        != ftrace_stub)
+
+	adrp	x1, ftrace_graph_entry	//     || (ftrace_graph_entry
+	adrp	x0, ftrace_graph_entry_stub //     != ftrace_graph_entry_stub))
+	ldr	x2, [x1, #:lo12:ftrace_graph_entry]
+	add	x0, x0, #:lo12:ftrace_graph_entry_stub
 	cmp	x0, x2
 	b.ne	ftrace_graph_caller	//     ftrace_graph_caller();
 
-- 
1.8.3.2
