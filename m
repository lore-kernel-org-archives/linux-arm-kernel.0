From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Nov 2017 18:21:58 +0000
Subject: [PATCH 15/18] arm64: tls: Avoid unconditional zeroing of tpidrro_el0
 for native tasks
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <1510942921-12564-16-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We zero tpidrro_el0 on return to the exception trampoline since it is
used as a scratch register during exception entry. When the entry
trampoline is being used, we can therefore avoid zeroing tpidrro_el0
in the context-switch for native tasks.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/process.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 2dc0f8482210..c2841bda60be 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -305,16 +305,14 @@ void tls_preserve_current_state(void)
 
 static void tls_thread_switch(struct task_struct *next)
 {
-	unsigned long tpidr, tpidrro;
-
 	tls_preserve_current_state();
 
-	tpidr = *task_user_tls(next);
-	tpidrro = is_compat_thread(task_thread_info(next)) ?
-		  next->thread.tp_value : 0;
+	if (is_compat_thread(task_thread_info(next)))
+		write_sysreg(next->thread.tp_value, tpidrro_el0);
+	else if (arm64_kernel_mapped_at_el0())
+		write_sysreg(0, tpidrro_el0);
 
-	write_sysreg(tpidr, tpidr_el0);
-	write_sysreg(tpidrro, tpidrro_el0);
+	write_sysreg(*task_user_tls(next), tpidr_el0);
 }
 
 /* Restore the UAO state depending on next's addr_limit */
-- 
2.1.4
