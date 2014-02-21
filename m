From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Fri, 21 Feb 2014 10:43:49 +0530
Subject: [PATCH 1/1] arm64: enable processor debug state for secondary cpus
Message-ID: <1392959630-31314-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

processor debug state PSTATE.D is unmasked in smp call
clear_os_lock for secondary cpus. So debug state is still
masked in normal kernel context.  With this patch, unmask
debug state on secondary boot for the cpus in normal kernel
context. Now kgdb tests passed with multicore.

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/debug-monitors.c |    7 +++----
 arch/arm64/kernel/smp.c            |    1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 1a8127d..13f87de 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -137,8 +137,6 @@ void disable_debug_monitors(enum debug_el el)
 static void clear_os_lock(void *unused)
 {
 	asm volatile("msr oslar_el1, %0" : : "r" (0));
-	isb();
-	local_dbg_enable();
 }
 
 static int os_lock_notify(struct notifier_block *self,
@@ -157,8 +155,9 @@ static struct notifier_block os_lock_nb = {
 static int debug_monitors_init(void)
 {
 	/* Clear the OS lock. */
-	smp_call_function(clear_os_lock, NULL, 1);
-	clear_os_lock(NULL);
+	on_each_cpu(clear_os_lock, NULL, 1);
+	isb();
+	local_dbg_enable();
 
 	/* Register hotplug handler. */
 	register_cpu_notifier(&os_lock_nb);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 7cfb92a..5070dc3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -160,6 +160,7 @@ asmlinkage void secondary_start_kernel(void)
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
+	local_dbg_enable();
 	local_irq_enable();
 	local_async_enable();
 
-- 
1.7.9.5
