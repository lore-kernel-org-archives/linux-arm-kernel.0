From: credmonster@gmail.com (Chris Redmon)
Date: Thu, 16 Mar 2017 18:10:43 -0400
Subject: [PATCH] arm64: struct debug_info: Check CONFIG_HAVE_HW_BREAKPOINT
Message-ID: <20170316221043.GA29802@credmon.mdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check if CONFIG_HAVE_HW_BREAKPOINT is enabled before compiling in extra
data required for hardware breakpoints. Compiling out this code when hw
breakpoints are disabled saves about 272 bytes per struct task_struct.

Signed-off-by: Chris Redmon <credmonster@gmail.com>
---
 arch/arm64/include/asm/processor.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index c97b8bd..9428b93 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -50,6 +50,7 @@
 #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
 
 struct debug_info {
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
 	/* Have we suspended stepping by a debugger? */
 	int			suspended_step;
 	/* Allow breakpoints and watchpoints to be disabled for this thread. */
@@ -58,6 +59,7 @@ struct debug_info {
 	/* Hardware breakpoints pinned to this task. */
 	struct perf_event	*hbp_break[ARM_MAX_BRP];
 	struct perf_event	*hbp_watch[ARM_MAX_WRP];
+#endif
 };
 
 struct cpu_context {
-- 
1.9.3
