From: maninder1.s@samsung.com (Maninder Singh)
Date: Wed, 13 May 2015 05:24:07 +0000 (GMT)
Subject: [EDT][PATCH 1/1] hw_breakpoint.c :cpu hotplug handling
Message-ID: <556690501.99511431494646065.JavaMail.weblogic@ep2mlwas05a>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EP-2DAD0AFA905A4ACB804C4F82A001242F

Subject: [PATCH 1/1] hw_breakpoint.c :cpu hotplug handling

This patch adds support for CPU hotplug, It re-installl all installed watchpoints and breakpoints
back on H/W in case of cpu-hot plug.

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Amit Arora <amit.arora@samsung.com>
Reviewed-by: Ajeet Yadav <ajeet.y@samsung.com>
---
 arch/arm/kernel/hw_breakpoint.c |   56 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index dc7d0a9..172bfa8 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -388,6 +388,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return 0;
 }
 
+/*
+ * reInstall a perf counter breakpoint.
+ */
+void arch_reinstall_hw_breakpoint(int index, int type)
+{
+	struct arch_hw_breakpoint *info;
+	struct perf_event **slots;
+	int ctrl_base, val_base;
+	u32 addr, ctrl;
+	struct perf_event *bp;
+
+	if (type == ARM_ENTRY_BREAKPOINT) {
+		/* Breakpoint */
+		ctrl_base = ARM_BASE_BCR;
+		val_base = ARM_BASE_BVR;
+		slots = (struct perf_event **)__get_cpu_var(bp_on_reg);
+	} else {
+		/* Watchpoint */
+		ctrl_base = ARM_BASE_WCR;
+		val_base = ARM_BASE_WVR;
+		slots = (struct perf_event **)__get_cpu_var(wp_on_reg);
+	}
+
+	bp = slots[index];
+	if (!bp)
+		return;
+
+	info = counter_arch_bp(bp);
+	addr = info->address;
+	ctrl = encode_ctrl_reg(info->ctrl) | 0x1;
+
+
+	/* Override the breakpoint data with the step data. */
+	if (info->step_ctrl.enabled) {
+		addr = info->trigger & ~0x3;
+		ctrl = encode_ctrl_reg(info->step_ctrl);
+		if (info->ctrl.type != ARM_BREAKPOINT_EXECUTE) {
+			index = 0;
+			ctrl_base = ARM_BASE_BCR + core_num_brps;
+			val_base = ARM_BASE_BVR + core_num_brps;
+		}
+	}
+
+	/* Setup the address register. */
+	write_wb_reg(val_base + index, addr);
+
+	/* Setup the control register. */
+	write_wb_reg(ctrl_base + index, ctrl);
+}
+
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
@@ -1019,6 +1069,12 @@ clear_vcr:
 out_mdbgen:
 	if (enable_monitor_mode())
 		cpumask_or(&debug_err_mask, &debug_err_mask, cpumask_of(cpu));
+
+	for (i = 0; i < core_num_brps; ++i)
+		arch_reinstall_hw_breakpoint(i, ARM_ENTRY_BREAKPOINT);
+	for (i = 0; i < core_num_wrps; ++i)
+		arch_reinstall_hw_breakpoint(i, ARM_ENTRY_SYNC_WATCHPOINT);
+
 }
 
 static int dbg_reset_notify(struct notifier_block *self,
-- 
1.7.1


Thanks 
Maninder Singh
