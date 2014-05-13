From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Tue, 13 May 2014 10:46:54 +0100
Subject: [PATCH 3/7] ARM: perf: Make perf use arm_get_current_stackframe
In-Reply-To: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <1399974418-4995-4-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the perf backend use the API so that it correctly references the FP
when in THUMB2 mode

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
---
 arch/arm/kernel/perf_event.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index a6bc431..55353fd 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -621,10 +621,7 @@ perf_callchain_kernel(struct perf_callchain_entry *entry, struct pt_regs *regs)
 		return;
 	}
 
-	fr.fp = regs->ARM_fp;
-	fr.sp = regs->ARM_sp;
-	fr.lr = regs->ARM_lr;
-	fr.pc = regs->ARM_pc;
+	arm_get_current_stackframe(regs, &fr);
 	walk_stackframe(&fr, callchain_trace, entry);
 }
 
-- 
1.8.1.5
