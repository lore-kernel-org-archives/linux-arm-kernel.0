From: duwe@lst.de (Torsten Duwe)
Date: Mon,  1 Oct 2018 16:16:43 +0200 (CEST)
Subject: [PATCH v3 1/4] DYNAMIC_FTRACE configurable with and without REGS
In-Reply-To: <20181001140910.086E768BC7@newverein.lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de>
Message-ID: <20181001141643.331EE68BC7@newverein.lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 06aeaaeabf69da4, many ftrace-related config options are
consolidated. By accident, I guess, the choice about DYNAMIC_FTRACE
and DYNAMIC_FTRACE_WITH_REGS is no longer available explicitly but
determined by the sole availability on the architecture.

This makes it hard to introduce DYNAMIC_FTRACE_WITH_REGS if it depends
on new compiler features or other new properties of the toolchain
without breaking existing configurations.

This patch turns the def_bool into an actual choice. Should the toolchain
not meet the requirements for _WITH_REGS it can be turned off.

Signed-off-by: Torsten Duwe <duwe@suse.de>


--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -508,9 +508,15 @@ config DYNAMIC_FTRACE
 	  otherwise has native performance as long as no tracing is active.
 
 config DYNAMIC_FTRACE_WITH_REGS
-	def_bool y
+	bool "Include register content tracking in dynamic ftrace facility"
+	default y
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
+	help
+	  This architecture supports the inspection of register contents,
+	  as passed between functions, at the dynamic ftrace points.
+	  This is also a prerequisite for Kernel Live Patching (KLP).
+	  When in doubt, say Y.
 
 config FUNCTION_PROFILER
 	bool "Kernel function profiler"
