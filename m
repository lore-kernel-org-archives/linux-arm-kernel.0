From: jld@mozilla.com (Jed Davis)
Date: Thu, 13 Jun 2013 16:21:11 -0700
Subject: [PATCH] perf: ARM: Record the user-mode PC in the call chain.
Message-ID: <20130613232111.GA12536@mozilla.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this change, we no longer lose the innermost entry in the user-mode
part of the call chain.  See also the x86 port, which includes the ip.

It's possible to partially work around this problem by post-processing
the data to use the PERF_SAMPLE_IP value, but this works only if the CPU
wasn't in the kernel when the sample was taken.

Signed-off-by: Jed Davis <jld@mozilla.com>
---
 arch/arm/kernel/perf_event.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 8c3094d..d9f5cd4 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -569,6 +569,7 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 		return;
 	}
 
+	perf_callchain_store(entry, regs->ARM_pc);
 	tail = (struct frame_tail __user *)regs->ARM_fp - 1;
 
 	while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
-- 
1.7.10.4
