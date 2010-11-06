From: rabin@rab.in (Rabin Vincent)
Date: Sat,  6 Nov 2010 23:55:54 +0530
Subject: [PATCH 6/6] ARM: ftrace: enable function graph tracer
In-Reply-To: <1289067954-5080-1-git-send-email-rabin@rab.in>
References: <1289067954-5080-1-git-send-email-rabin@rab.in>
Message-ID: <1289067954-5080-6-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the options to enable the function graph tracer on ARM.  Function
graph tracer support requires frame pointers, so exclude Thumb-2 and
also explicitly select FRAME_POINTER in FUNCTION_GRAPH_TRACER since
FUNCTION_TRACER doesn't select FRAME_POINTER when ARM_UNWIND is used
Therefore, with GCC 4.4.0+, you get plain function tracing without frame
pointers, but you'll need them if you want function graph tracing.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/Kconfig     |    1 +
 kernel/trace/Kconfig |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

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
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e04b8bc..ff23dcf 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -141,6 +141,7 @@ config FUNCTION_TRACER
 
 config FUNCTION_GRAPH_TRACER
 	bool "Kernel Function Graph Tracer"
+	select FRAME_POINTER if ARM_UNWIND
 	depends on HAVE_FUNCTION_GRAPH_TRACER
 	depends on FUNCTION_TRACER
 	depends on !X86_32 || !CC_OPTIMIZE_FOR_SIZE
-- 
1.7.2.3
