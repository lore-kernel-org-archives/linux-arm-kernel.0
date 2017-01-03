From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue,  3 Jan 2017 12:32:47 +0000
Subject: [PATCH 1/2] drivers: psci: annotate timer on stack to silence odebug
 messages
Message-ID: <1483446768-26973-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When DEBUG_OBJECTS config is enabled, we get the below odebug warnings:

ODEBUG: object is on stack, but not annotated

WARNING: CPU: 3 PID: 1304 at kernel/lib/debugobjects.c:300 __debug_object_init+0x1f0/0x458
CPU: 3 PID: 1304 Comm: psci_suspend_te Tainted: G W 4.9.0-06564-gf80f3f199260 #284
task: ffffe9e1b55a1600 task.stack: ffffe9e1b51c0000
PC is at __debug_object_init+0x1f0/0x458
LR is at __debug_object_init+0x1ec/0x458
Call trace:
 __debug_object_init+0x1f0/0x458
 debug_object_activate+0x150/0x260
 mod_timer+0xb4/0x4c0
 suspend_test_thread+0x1cc/0x3c0
 kthread+0x110/0x140
 ret_from_fork+0x10/0x40

This patch annotates the timer on the stack using setup_timer_on_stack
function to remove the above warnings.

Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci_checker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci_checker.c
index 44bdb78f837b..29d58feaf675 100644
--- a/drivers/firmware/psci_checker.c
+++ b/drivers/firmware/psci_checker.c
@@ -270,8 +270,7 @@ static int suspend_test_thread(void *arg)
 	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv;
 	/* No need for an actual callback, we just want to wake up the CPU. */
-	struct timer_list wakeup_timer =
-		TIMER_INITIALIZER(dummy_callback, 0, 0);
+	struct timer_list wakeup_timer;
 
 	/* Wait for the main thread to give the start signal. */
 	wait_for_completion(&suspend_threads_started);
@@ -287,6 +286,7 @@ static int suspend_test_thread(void *arg)
 	pr_info("CPU %d entering suspend cycles, states 1 through %d\n",
 		cpu, drv->state_count - 1);
 
+	setup_timer_on_stack(&wakeup_timer, dummy_callback, 0);
 	for (i = 0; i < NUM_SUSPEND_CYCLE; ++i) {
 		int index;
 		/*
-- 
2.7.4
