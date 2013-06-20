From: jld@mozilla.com (Jed Davis)
Date: Wed, 19 Jun 2013 20:07:14 -0700
Subject: [PATCH] perf: arm64: Record the user-mode PC in the call chain.
Message-ID: <20130620030713.GA27428@mozilla.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this change, we no longer lose the innermost entry in the user-mode
part of the call chain.  See also the x86 port, which includes the ip,
and the corresponding change in arch/arm.

Signed-off-by: Jed Davis <jld@mozilla.com>
---
 arch/arm64/kernel/perf_event.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 1e49e5eb..9ba33c4 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1336,6 +1336,7 @@ void perf_callchain_user(struct perf_callchain_entry *entry,
 		return;
 	}
 
+	perf_callchain_store(entry, regs->pc);
 	tail = (struct frame_tail __user *)regs->regs[29];
 
 	while (entry->nr < PERF_MAX_STACK_DEPTH &&
-- 
1.7.10.4
