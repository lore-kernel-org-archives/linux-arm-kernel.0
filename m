From: janboe.ye@gmail.com (janboe)
Date: Tue, 20 Jul 2010 23:24:31 +0800
Subject: [PATCH] arm: show_regs dump stack when ARM_UNWIND enable
Message-ID: <20100720152431.GA17092@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__backtrace is empty when ARM_UNWIND enable, so instead dump_stack

Signed-off-by: janboe <janboe.ye@gmail.com>
---
 arch/arm/kernel/process.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index acf5e6f..e7ad878 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -271,7 +271,11 @@ void show_regs(struct pt_regs * regs)
 	printk("\n");
 	printk("Pid: %d, comm: %20s\n", task_pid_nr(current), current->comm);
 	__show_regs(regs);
+#ifdef CONFIG_ARM_UNWIND
+	dump_stack();
+#else
 	__backtrace();
+#endif
 }
 
 ATOMIC_NOTIFIER_HEAD(thread_notify_head);
-- 
1.7.1
