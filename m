From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Nov 2018 13:06:48 +0000
Subject: [PATCH 09/10] arm64: frace: use asm EXPORT_SYMBOL()
In-Reply-To: <20181105130649.29429-1-mark.rutland@arm.com>
References: <20181105130649.29429-1-mark.rutland@arm.com>
Message-ID: <20181105130649.29429-10-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a while now it's been possible to use EXPORT_SYMBOL() in assembly
files, which allows us to place exports immediately after assembly
functions, as we do for C functions.

As a step towards removing arm64ksyms.c, let's move the ftrace exports
to the assembly files the functions are defined in.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c   | 5 -----
 arch/arm64/kernel/entry-ftrace.S | 6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index c142103bc0fe..4ca8d2b245d2 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -28,8 +28,3 @@
 
 #include <asm/checksum.h>
 
-#ifdef CONFIG_FUNCTION_TRACER
-EXPORT_SYMBOL(_mcount);
-NOKPROBE_SYMBOL(_mcount);
-#endif
-
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 1175f5827ae1..98f029c7d4f4 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -10,7 +10,9 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 
@@ -121,6 +123,8 @@ skip_ftrace_call:			// }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 	mcount_exit
 ENDPROC(_mcount)
+EXPORT_SYMBOL(_mcount)
+NOKPROBE(_mcount)
 
 #else /* CONFIG_DYNAMIC_FTRACE */
 /*
@@ -132,6 +136,8 @@ ENDPROC(_mcount)
 ENTRY(_mcount)
 	ret
 ENDPROC(_mcount)
+EXPORT_SYMBOL(_mcount)
+NOKPROBE(_mcount)
 
 /*
  * void ftrace_caller(unsigned long return_address)
-- 
2.11.0
