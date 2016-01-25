From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 25 Jan 2016 17:05:21 +0000
Subject: [RFC PATCH 2/2] ARM: ftrace: make function graph depend on deprecated
 APCS frame
In-Reply-To: <1453741521-6878-1-git-send-email-jean-philippe.brucker@arm.com>
References: <1453741521-6878-1-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <1453741521-6878-3-git-send-email-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of function graph tracing depends on a
specific frame format, in order to modify the instrumented function's
return address.

That format has now been deprecated, and there isn't any reliable
replacement.
Indeed, recent standard don't define any specific frame format, so GCC
uses a format that isn't defined anywhere, and is subject to change.
Furthermore, this de facto format is different between leaf and non-leaf
functions, making it all the more difficult to adapt the function graph
tracer.

The only documented way to get this information is through unwinding
informations provided by EABI compilers. This solution is painfully slow
and would require substantial rework of the unwinding code.

Until we find a good replacement, make FUNCTION_GRAPH_TRACER depend on
DEPRECATED_APCS_FRAME. To avoid a circular dependency, we allow manual
selection of FRAME_POINTER again.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arch/arm/Kconfig       |    2 +-
 arch/arm/Kconfig.debug |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 34e1569..d4afce7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -48,7 +48,7 @@ config ARM
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
-	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
+	select HAVE_FUNCTION_GRAPH_TRACER if DEPRECATED_APCS_FRAME
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 95b85ee..a0a2a30 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -34,9 +34,9 @@ config STRICT_DEVMEM
 # traces, you can get a slightly smaller kernel by setting this option to
 # n, but then RMK will have to kill you ;).
 config FRAME_POINTER
-	bool
+	bool "Compile the kernel with frame pointers"
 	depends on !THUMB2_KERNEL
-	default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
+	default y if !ARM_UNWIND
 	help
 	  If you say N here, the resulting kernel will be slightly smaller and
 	  faster. When ARM_UNWIND is disabled, enabling FRAME_POINTER alone is
-- 
1.7.9.5
