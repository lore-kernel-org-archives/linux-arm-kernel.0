From: jason77.wang@gmail.com (Hui Wang)
Date: Mon, 21 May 2012 17:45:30 +0800
Subject: [PATCH 1/2] ARM: SMP: move mm_cpumask clearing to the  __cpu_die()
In-Reply-To: <1337593531-16191-1-git-send-email-jason77.wang@gmail.com>
References: <1337593531-16191-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <1337593531-16191-2-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__cpu_disable() will run on the dying cpu and the calling context is
irq disabled, this will produce call trace in RT kernel like this:

BUG: sleeping function called from invalid context at linux/kernel/rtmutex.c:707
pcnt: 0 0 in_atomic(): 0, irqs_disabled(): 128, pid: 1652, name: kstop/1
[<800413a0>] (unwind_backtrace+0x0/0xe4) from [<804ff198>] (__rt_spin_lock+0x30/0x5c)
[<804ff198>] (__rt_spin_lock+0x30/0x5c) from [<804ff304>] (rt_read_lock+0x2c/0x3c)
[<804ff304>] (rt_read_lock+0x2c/0x3c) from [<8003f890>] (__cpu_disable+0x50/0xa0)
[<8003f890>] (__cpu_disable+0x50/0xa0) from [<804f5ad4>] (take_cpu_down+0x10/0x54)
[<804f5ad4>] (take_cpu_down+0x10/0x54) from [<800a5ea0>] (stop_cpu+0xb0/0x110)
[<800a5ea0>] (stop_cpu+0xb0/0x110) from [<8007e838>] (worker_thread+0x1bc/0x240)
[<8007e838>] (worker_thread+0x1bc/0x240) from [<80082770>] (kthread+0x7c/0x84)
[<80082770>] (kthread+0x7c/0x84) from [<8003b214>] (kernel_thread_exit+0x0/0x8)

Clearing mm_cpumask for dying cpu is to save tlb/cache flush when
this cpu is online again and needs to flush tlb/cache for the mm area.
That is to say as long as we clear this flag before the cpu is online
again, it will not bring trouble for us.

So move this code from __cpu_disable() to __cpu_die(), since
__cpu_disable() is irq disabled context while __cpu_die() is irq
enabled context, this change will solve the call trace in the
RT kernel.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 arch/arm/kernel/smp.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8f46446..05fed61 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -130,7 +130,6 @@ static void percpu_timer_stop(void);
 int __cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
-	struct task_struct *p;
 	int ret;
 
 	ret = platform_cpu_disable(cpu);
@@ -154,19 +153,12 @@ int __cpu_disable(void)
 	percpu_timer_stop();
 
 	/*
-	 * Flush user cache and TLB mappings, and then remove this CPU
-	 * from the vm mask set of all processes.
+	 * Flush user cache and TLB mappings, and later in the __cpu_die(),
+	 * remove this CPU from the vm mask set of all processes.
 	 */
 	flush_cache_all();
 	local_flush_tlb_all();
 
-	read_lock(&tasklist_lock);
-	for_each_process(p) {
-		if (p->mm)
-			cpumask_clear_cpu(cpu, mm_cpumask(p->mm));
-	}
-	read_unlock(&tasklist_lock);
-
 	return 0;
 }
 
@@ -178,6 +170,15 @@ static DECLARE_COMPLETION(cpu_died);
  */
 void __cpu_die(unsigned int cpu)
 {
+	struct task_struct *p;
+
+	read_lock(&tasklist_lock);
+	for_each_process(p) {
+		if (p->mm)
+			cpumask_clear_cpu(cpu, mm_cpumask(p->mm));
+	}
+	read_unlock(&tasklist_lock);
+
 	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
-- 
1.7.6
