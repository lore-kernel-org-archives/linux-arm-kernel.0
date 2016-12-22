From: bamvor.zhangjian@huawei.com (bamvor.zhangjian at huawei.com)
Date: Thu, 22 Dec 2016 19:35:01 +0800
Subject: [PATCH] arm64: print bad_frame in handle_signal
Message-ID: <20161222113501.17167-1-bamvor.zhangjian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>

Sometims handle_signal will fail due to the bad frame and send to
segfault to process consequently. But there is no information in system
log which lead to hard to debug the root issue.

This patch add as same bad frame print as sys_rt_sigreturn.

Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
---
 arch/arm64/kernel/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index c7b6de6..cd6b81b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -316,6 +316,10 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	if (!ret)
 		user_fastforward_single_step(tsk);
 
+	if (show_unhandled_signals)
+		pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
+				    current->comm, task_pid_nr(current),
+				    __func__, regs->pc, regs->sp);
 	signal_setup_done(ret, ksig, 0);
 }
 
-- 
2.10.2
