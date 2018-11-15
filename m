From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Nov 2018 22:41:59 +0000
Subject: [PATCH 2/6] arm64: ftrace: use GLOBAL()
In-Reply-To: <20181115224203.24847-1-mark.rutland@arm.com>
References: <20181115224203.24847-1-mark.rutland@arm.com>
Message-ID: <20181115224203.24847-3-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The global exports of ftrace_call and ftrace_graph_call are somewhat
painful to read. Let's use the generic GLOBAL() macro to ameliorate
matters.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Torsten Duwe <duwe@suse.de>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry-ftrace.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 98f029c7d4f4..eb4e50d9f75d 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -154,14 +154,12 @@ ENTRY(ftrace_caller)
 	mcount_get_pc0	x0		//     function's pc
 	mcount_get_lr	x1		//     function's lr
 
-	.global ftrace_call
-ftrace_call:				// tracer(pc, lr);
+GLOBAL(ftrace_call)			// tracer(pc, lr);
 	nop				// This will be replaced with "bl xxx"
 					// where xxx can be any kind of tracer.
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	.global ftrace_graph_call
-ftrace_graph_call:			// ftrace_graph_caller();
+GLOBAL(ftrace_graph_call)		// ftrace_graph_caller();
 	nop				// If enabled, this will be replaced
 					// "b ftrace_graph_caller"
 #endif
-- 
2.11.0
