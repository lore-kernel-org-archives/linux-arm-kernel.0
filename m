From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Nov 2018 22:42:03 +0000
Subject: [PATCH 6/6] arm64: ftrace: always pass instrumented pc in x0
In-Reply-To: <20181115224203.24847-1-mark.rutland@arm.com>
References: <20181115224203.24847-1-mark.rutland@arm.com>
Message-ID: <20181115224203.24847-7-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core ftrace hooks take the instrumented PC in x0, but for some
reason arm64's prepare_ftrace_return() takes this in x1.

For consistency, let's flip the argument order and always pass the
instrumented PC in x0.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Torsten Duwe <duwe@suse.de>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry-ftrace.S | 6 +++---
 arch/arm64/kernel/ftrace.c       | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 6b8230f79a67..7981f18bfe5f 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -182,10 +182,10 @@ ENDPROC(ftrace_stub)
  * and run return_to_handler() later on its exit.
  */
 ENTRY(ftrace_graph_caller)
-	mcount_get_lr_addr	  x0	//     pointer to function's saved lr
-	mcount_get_pc		  x1	//     function's pc
+	mcount_get_pc		  x0	//     function's pc
+	mcount_get_lr_addr	  x1	//     pointer to function's saved lr
 	mcount_get_parent_fp	  x2	//     parent's fp
-	bl	prepare_ftrace_return	// prepare_ftrace_return(&lr, pc, fp)
+	bl	prepare_ftrace_return	// prepare_ftrace_return(pc, &lr, fp)
 
 	mcount_exit
 ENDPROC(ftrace_graph_caller)
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 50986e388d2b..34a80bf0b2ef 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -211,7 +211,7 @@ int __init ftrace_dyn_arch_init(void)
  *
  * Note that @frame_pointer is used only for sanity check later.
  */
-void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 			   unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
-- 
2.11.0
