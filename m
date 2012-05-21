From: jason77.wang@gmail.com (Hui Wang)
Date: Mon, 21 May 2012 17:45:31 +0800
Subject: [PATCH 2/2] ARM: SMP: use per cpu state to replace
In-Reply-To: <1337593531-16191-2-git-send-email-jason77.wang@gmail.com>
References: <1337593531-16191-1-git-send-email-jason77.wang@gmail.com>
 <1337593531-16191-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <1337593531-16191-3-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU hotplug will bring following call trace in the RT kernel:
BUG: sleeping function called from invalid context at linux/kernel/rtmutex.c:707
pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper
[<800413a0>] (unwind_backtrace+0x0/0xe4) from [<804ff214>] (rt_spin_lock+0x30/0x5c)
[<804ff214>] (rt_spin_lock+0x30/0x5c) from [<8005a848>] (complete+0x1c/0x54)
[<8005a848>] (complete+0x1c/0x54) from [<804f59f8>] (cpu_die+0x34/0x70)
[<804f59f8>] (cpu_die+0x34/0x70) from [<8003b840>] (cpu_idle+0x54/0xd8)
[<8003b840>] (cpu_idle+0x54/0xd8) from [<104f9ecc>] (0x104f9ecc)

To avoid this call trace, we use per cpu variable to replace
completion, and it is safe for this modification since all reference
of per cpu_state variable is in the preempt disabled context.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 arch/arm/kernel/smp.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 05fed61..c63e2ff 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -122,6 +122,9 @@ int __cpuinit __cpu_up(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+/* State of each CPU during hotplug phases */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
 static void percpu_timer_stop(void);
 
 /*
@@ -171,6 +174,7 @@ static DECLARE_COMPLETION(cpu_died);
 void __cpu_die(unsigned int cpu)
 {
 	struct task_struct *p;
+	unsigned long timeout;
 
 	read_lock(&tasklist_lock);
 	for_each_process(p) {
@@ -179,10 +183,16 @@ void __cpu_die(unsigned int cpu)
 	}
 	read_unlock(&tasklist_lock);
 
-	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
-		pr_err("CPU%u: cpu didn't die\n", cpu);
-		return;
-	}
+	timeout = jiffies + msecs_to_jiffies(5000);
+
+	while (per_cpu(cpu_state, cpu) != CPU_DEAD) {
+		if (time_after(jiffies, timeout)) {
+			pr_err("CPU%u: cpu didn't die\n", cpu);
+			return;
+		}
+		cpu_relax();
+ 	}
+
 	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
 
 	if (!platform_cpu_kill(cpu))
@@ -207,7 +217,7 @@ void __ref cpu_die(void)
 	mb();
 
 	/* Tell __cpu_die() that this CPU is now safe to dispose of */
-	complete(&cpu_died);
+	per_cpu(cpu_state, cpu) = CPU_DEAD;
 
 	/*
 	 * actual CPU shutdown procedure is at least platform (if not
@@ -285,6 +295,9 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	 * the CPU migration code to notice that the CPU is online
 	 * before we continue - which happens after __cpu_up returns.
 	 */
+#ifdef CONFIG_HOTPLUG_CPU
+	per_cpu(cpu_state, cpu) = CPU_ONLINE;
+#endif
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
-- 
1.7.6
