From: rabin@rab.in (Rabin Vincent)
Date: Sat, 6 Nov 2010 23:03:53 +0530
Subject: [PATCHv2] ARM: ftrace: enable function graph tracer
Message-ID: <mailman.14.1289310416.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the options to enable the function graph tracer on ARM.  Function
graph tracer support requires frame pointers, so exclude Thumb-2 and
also make sure FRAME_POINTER gets enabled when FUNCTION_GRAPH_TRACER is
used, since FUNCTION_TRACER doesn't "select FRAME_POINTER" when
ARM_UNWIND is used.  Therefore, with GCC 4.4.0+, you get plain function
tracing without frame pointers, but you'll need them if you want
function graph tracing.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/Kconfig       |    1 +
 arch/arm/Kconfig.debug |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a19a526..c5e96ff 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -14,6 +14,7 @@ config ARM
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
+	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 2fd0b99..eac62085 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -23,7 +23,7 @@ config STRICT_DEVMEM
 config FRAME_POINTER
 	bool
 	depends on !THUMB2_KERNEL
-	default y if !ARM_UNWIND
+	default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
 	help
 	  If you say N here, the resulting kernel will be slightly smaller and
 	  faster. However, if neither FRAME_POINTER nor ARM_UNWIND are enabled,
-- 
1.7.2.3
