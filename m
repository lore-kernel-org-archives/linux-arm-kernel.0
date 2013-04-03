From: cov@codeaurora.org (Christopher Covington)
Date: Wed,  3 Apr 2013 14:01:01 -0400
Subject: [PATCH] arm64: Fix task tracing
Message-ID: <1365012061-31660-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For accurate accounting call contextidr_thread_switch before a
task is scheduled, rather than after.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0337cdb..c2cc249 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -311,11 +311,11 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	fpsimd_thread_switch(next);
 	tls_thread_switch(next);
 	hw_breakpoint_thread_switch(next);
+	contextidr_thread_switch(next);
 
 	/* the actual thread switch */
 	last = cpu_switch_to(prev, next);
 
-	contextidr_thread_switch(next);
 	return last;
 }
 
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by the Linux Foundation.
