From: will.deacon@arm.com (Will Deacon)
Date: Wed,  6 Dec 2017 12:35:34 +0000
Subject: [PATCH v3 15/20] arm64: tls: Avoid unconditional zeroing of
 tpidrro_el0 for native tasks
In-Reply-To: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
Message-ID: <1512563739-25239-16-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When unmapping the kernel at EL0, we use tpidrro_el0 as a scratch register
during exception entry from native tasks and subsequently zero it in
the kernel_ventry macro. We can therefore avoid zeroing tpidrro_el0
in the context-switch path for native tasks using the entry trampoline.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/process.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b2adcce7bc18..aba3a1fb492d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -361,16 +361,14 @@ void tls_preserve_current_state(void)
 
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
+	else if (!arm64_kernel_unmapped_at_el0())
+		write_sysreg(0, tpidrro_el0);
 
-	write_sysreg(tpidr, tpidr_el0);
-	write_sysreg(tpidrro, tpidrro_el0);
+	write_sysreg(*task_user_tls(next), tpidr_el0);
 }
 
 /* Restore the UAO state depending on next's addr_limit */
-- 
2.1.4
