From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  3 Oct 2017 14:10:18 +0900
Subject: [PATCH v4 2/3] arm64: kgdb: prevent kgdb from being invoked
 recursively
In-Reply-To: <20171003051019.29714-1-takahiro.akashi@linaro.org>
References: <20171003051019.29714-1-takahiro.akashi@linaro.org>
Message-ID: <20171003051019.29714-3-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a breakpoint is set in an interrupt-sensitive place,
like gic_handle_irq(), a debug exception can be triggerred recursively.
We will see the following message:

    KGDB: re-enter error: breakpoint removed ffffffc000081258
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 650 at kernel/debug/debug_core.c:435
                                        kgdb_handle_exception+0x1dc/0x1f4()
    Modules linked in:
    CPU: 0 PID: 650 Comm: sh Not tainted 3.17.0-rc2+ #177
    Call trace:
    [<ffffffc000087fac>] dump_backtrace+0x0/0x130
    [<ffffffc0000880ec>] show_stack+0x10/0x1c
    [<ffffffc0004d683c>] dump_stack+0x74/0xb8
    [<ffffffc0000ab824>] warn_slowpath_common+0x8c/0xb4
    [<ffffffc0000ab90c>] warn_slowpath_null+0x14/0x20
    [<ffffffc000121bfc>] kgdb_handle_exception+0x1d8/0x1f4
    [<ffffffc000092ffc>] kgdb_brk_fn+0x18/0x28
    [<ffffffc0000821c8>] brk_handler+0x9c/0xe8
    [<ffffffc0000811e8>] do_debug_exception+0x3c/0xac
    Exception stack(0xffffffc07e027650 to 0xffffffc07e027770)
    ...
    [<ffffffc000083cac>] el1_dbg+0x14/0x68
    [<ffffffc00012178c>] kgdb_cpu_enter+0x464/0x5c0
    [<ffffffc000121bb4>] kgdb_handle_exception+0x190/0x1f4
    [<ffffffc000092ffc>] kgdb_brk_fn+0x18/0x28
    [<ffffffc0000821c8>] brk_handler+0x9c/0xe8
    [<ffffffc0000811e8>] do_debug_exception+0x3c/0xac
    Exception stack(0xffffffc07e027ac0 to 0xffffffc07e027be0)
    ...
    [<ffffffc000083cac>] el1_dbg+0x14/0x68
    [<ffffffc00032e4b4>] __handle_sysrq+0x11c/0x190
    [<ffffffc00032e93c>] write_sysrq_trigger+0x4c/0x60
    [<ffffffc0001e7d58>] proc_reg_write+0x54/0x84
    [<ffffffc000192fa4>] vfs_write+0x98/0x1c8
    [<ffffffc0001939b0>] SyS_write+0x40/0xa0

When some interrupt occurs, a breakpoint at gic_handle_irq() invokes kgdb.
Kgdb then calls kgdb_roundup_cpus() to sync with other cpus. Current
kgdb_roundup_cpus() unmasks interrupts temporarily to use
smp_call_function(). This eventually allows another interrupt to occur and
likely results in hitting a breakpoint at gic_handle_irq() again since
a debug exception is always enabled in el1_irq.

We can avoid this issue by specifying "nokgdbroundup" in a kernel command
line, but this will also leave other cpus be in unknown state in terms of
kgdb, and may result in interfering with kgdb.

This patch re-implements kgdb_roundup_cpus() by using irq_work so that we
won't have to enable interrupts there.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
---
 arch/arm64/kernel/kgdb.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 8d3ec8cf4ec4..508b413a3518 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -20,10 +20,13 @@
  */
 
 #include <linux/bug.h>
+#include <linux/cpumask.h>
 #include <linux/irq.h>
+#include <linux/irq_work.h>
 #include <linux/kdebug.h>
 #include <linux/kgdb.h>
 #include <linux/kprobes.h>
+#include <linux/percpu.h>
 #include <linux/sched/task_stack.h>
 
 #include <asm/debug-monitors.h>
@@ -111,6 +114,8 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{ "fpcr", 4, -1 },
 };
 
+static DEFINE_PER_CPU(struct irq_work, kgdb_irq_work);
+
 char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
 {
 	if (regno >= DBG_MAX_REG_NUM || regno < 0)
@@ -277,16 +282,33 @@ static struct step_hook kgdb_step_hook = {
 	.fn		= kgdb_step_brk_fn
 };
 
-static void kgdb_call_nmi_hook(void *ignored)
+static void kgdb_roundup_hook(struct irq_work *work)
 {
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
 
 void kgdb_roundup_cpus(unsigned long flags)
 {
-	local_irq_enable();
-	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
+	int cpu, this_cpu;
+	struct irq_work *work;
+
+	if (num_online_cpus() == 1)
+		return;
+
+	/*
+	 * We assume that no cpus go up or down here, but we can't guarantee
+	 * this because get_online_cpus() may not be called in an atomic
+	 * context. It is fragile, but kgdb_handle_exception()/
+	 * kgdb_cpu_enter() doesn't deal with this, neither.
+	 */
+	this_cpu = raw_smp_processor_id();
+	for_each_online_cpu(cpu) {
+		if (cpu == this_cpu)
+			continue;
+
+		work = per_cpu_ptr(&kgdb_irq_work, cpu);
+		irq_work_queue_on(work, cpu);
+	}
 }
 
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
@@ -327,6 +349,8 @@ static struct notifier_block kgdb_notifier = {
 int kgdb_arch_init(void)
 {
 	int ret = register_die_notifier(&kgdb_notifier);
+	int cpu;
+	struct irq_work *work;
 
 	if (ret != 0)
 		return ret;
@@ -334,6 +358,12 @@ int kgdb_arch_init(void)
 	register_break_hook(&kgdb_brkpt_hook);
 	register_break_hook(&kgdb_compiled_brkpt_hook);
 	register_step_hook(&kgdb_step_hook);
+
+	for_each_possible_cpu(cpu) {
+		work = per_cpu_ptr(&kgdb_irq_work, cpu);
+		init_irq_work(work, kgdb_roundup_hook);
+	}
+
 	return 0;
 }
 
-- 
2.14.1
