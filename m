From: vincent.cw.yang@gmail.com (Vincent Yang)
Date: Wed,  4 Mar 2015 19:02:28 +0800
Subject: [PATCH v7 3/7] ARM: MB86S7X: Add MCPM support
In-Reply-To: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
Message-ID: <1425466948-30691-1-git-send-email-vincent.yang@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jaswinder.singh@linaro.org>

The remote firmware(SCB) owns the SMP control. This MCPM driver gets
CPU/CLUSTER power up/down done by SCB over mailbox.

Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Vincent Yang <vincent.yang@socionext.com>
Reviewed-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@socionext.com>
---
 arch/arm/mach-mb86s7x/Makefile |   4 +-
 arch/arm/mach-mb86s7x/mcpm.c   | 318 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mb86s7x/smc.S    |  27 ++++
 drivers/soc/mb86s7x/scb_mhu.c  |  14 ++
 include/soc/mb86s7x/scb_mhu.h  |   8 ++
 5 files changed, 370 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-mb86s7x/mcpm.c
 create mode 100644 arch/arm/mach-mb86s7x/smc.S

diff --git a/arch/arm/mach-mb86s7x/Makefile b/arch/arm/mach-mb86s7x/Makefile
index 97640b6..00e843c 100644
--- a/arch/arm/mach-mb86s7x/Makefile
+++ b/arch/arm/mach-mb86s7x/Makefile
@@ -1 +1,3 @@
-obj-$(CONFIG_ARCH_MB86S7X)	+= board.o
+obj-$(CONFIG_ARCH_MB86S7X)	+= board.o mcpm.o smc.o
+CFLAGS_smc.o			+= -march=armv7-a
+CFLAGS_mcpm.o			+= -march=armv7-a
diff --git a/arch/arm/mach-mb86s7x/mcpm.c b/arch/arm/mach-mb86s7x/mcpm.c
new file mode 100644
index 0000000..17803a6
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/mcpm.c
@@ -0,0 +1,318 @@
+/*
+ * arch/arm/mach-mb86s7x/mcpm.c
+ * Copyright:	(C) 2013-2015 Fujitsu Semiconductor Limited
+ * Copyright:	(C) 2015 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/arm-cci.h>
+#include <linux/spinlock.h>
+#include <linux/suspend.h>
+#include <linux/of_device.h>
+#include <linux/irqchip/arm-gic.h>
+#include <linux/platform_device.h>
+
+#include <soc/mb86s7x/scb_mhu.h>
+
+#include <asm/mcpm.h>
+#include <asm/cp15.h>
+#include <asm/cputype.h>
+#include <asm/suspend.h>
+#include <asm/idmap.h>
+
+#define S7X_MAX_CLUSTER	2
+#define S7X_MAX_CPU	2
+
+#define MHU_SHM_OFFSET		0x3800
+#define TRAMPOLINE_OFFSET	0x3c00
+#define RESET_OFFSET		(TRAMPOLINE_OFFSET + 0x3fc)
+
+static arch_spinlock_t mb86s7x_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+static int mb86s7x_pm_use_count[S7X_MAX_CLUSTER][S7X_MAX_CPU];
+
+struct mb86s7x_cpu_gate {
+	u32 payload_size;
+	u32 cluster_class;
+	u32 cluster_id;
+	u32 cpu_id;
+#define SCB_CPU_STATE_OFF	0x0
+#define SCB_CPU_STATE_ON	0x1
+#define SCB_CPU_STATE_SUSP	0x2
+	u32 cpu_state;
+};
+
+static int mb86s7x_pm_power_up(unsigned int cpu, unsigned int cluster)
+{
+	int ret = 0;
+
+	if (cluster >= S7X_MAX_CLUSTER || cpu >= S7X_MAX_CPU)
+		return -EINVAL;
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+
+	local_irq_disable();
+	arch_spin_lock(&mb86s7x_pm_lock);
+
+	mb86s7x_pm_use_count[cluster][cpu]++;
+
+	if (mb86s7x_pm_use_count[cluster][cpu] == 1) {
+		struct mb86s7x_cpu_gate cmd;
+
+		mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_NOTHING);
+		arch_spin_unlock(&mb86s7x_pm_lock);
+		local_irq_enable();
+
+		cmd.payload_size = sizeof(cmd);
+		cmd.cluster_class = 0;
+		cmd.cluster_id = cluster;
+		cmd.cpu_id = cpu;
+		cmd.cpu_state = SCB_CPU_STATE_ON;
+
+		pr_debug("%s:%d CMD Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u}\n",
+			 __func__, __LINE__, cmd.cluster_class,
+			 cmd.cluster_id, cmd.cpu_id, cmd.cpu_state);
+
+		ret = mb86s7x_send_packet(CMD_CPU_CLOCK_GATE_SET_REQ,
+					  &cmd, sizeof(cmd));
+		if (ret < 0) {
+			pr_err("%s:%d failed!\n", __func__, __LINE__);
+			return ret;
+		}
+
+		pr_debug("%s:%d REP Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u}\n",
+			 __func__, __LINE__, cmd.cluster_class,
+			 cmd.cluster_id, cmd.cpu_id, cmd.cpu_state);
+
+		if (cmd.cpu_state != SCB_CPU_STATE_ON)
+			return -ENODEV;
+	} else if (mb86s7x_pm_use_count[cluster][cpu] == 2) {
+		arch_spin_unlock(&mb86s7x_pm_lock);
+		local_irq_enable();
+	} else {
+		/*
+		 * The only possible values are:
+		 * 0 = CPU down
+		 * 1 = CPU (still) up
+		 * 2 = CPU requested to be up before it had a chance
+		 *     to actually make itself down.
+		 * Any other value is a bug.
+		 */
+		BUG();
+	}
+
+	return 0;
+}
+
+static void mb86s7x_pm_suspend(u64 ignored)
+{
+	unsigned int mpidr, cpu, cluster;
+	bool last_man = false, skip_wfi = false;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	__mcpm_cpu_going_down(cpu, cluster);
+
+	arch_spin_lock(&mb86s7x_pm_lock);
+	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
+
+	mb86s7x_pm_use_count[cluster][cpu]--;
+
+	if (mb86s7x_pm_use_count[cluster][cpu] == 0) {
+		if (!mb86s7x_pm_use_count[cluster][0] &&
+		    !mb86s7x_pm_use_count[cluster][1])
+			last_man = true;
+		mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_POWEROFF);
+	} else if (mb86s7x_pm_use_count[cluster][cpu] == 1) {
+		skip_wfi = true; /* Overtaken by a power up */
+	} else {
+		BUG();
+	}
+
+	if (!skip_wfi)
+		gic_cpu_if_down();
+
+	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
+		arch_spin_unlock(&mb86s7x_pm_lock);
+
+		if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
+			/*
+			 * On the Cortex-A15 we need to disable
+			 * L2 prefetching before flushing the cache.
+			 */
+			asm volatile(
+			"mcr p15, 1, %0, c15, c0, 3\n\t"
+			"isb\n\t"
+			"dsb"
+			: : "r" (0x400));
+		}
+
+		v7_exit_coherency_flush(all);
+
+		cci_disable_port_by_cpu(mpidr);
+
+		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
+	} else {
+		arch_spin_unlock(&mb86s7x_pm_lock);
+		v7_exit_coherency_flush(louis);
+	}
+
+	__mcpm_cpu_down(cpu, cluster);
+
+	/* Now we are prepared for power-down, do it: */
+	if (!skip_wfi)
+		wfi();
+}
+
+static void mb86s7x_pm_power_down(void)
+{
+	mb86s7x_pm_suspend(0);
+}
+
+static int mb86s7x_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
+{
+	struct mb86s7x_cpu_gate cmd;
+	int i, ret;
+
+	BUG_ON(cluster >= S7X_MAX_CLUSTER || cpu >= S7X_MAX_CPU);
+
+	cmd.payload_size = sizeof(cmd);
+	cmd.cluster_class = 0;
+	cmd.cluster_id = cluster;
+	cmd.cpu_id = cpu;
+	cmd.cpu_state = SCB_CPU_STATE_ON;
+
+	for (i = 0; i < 50; i++) {
+		ret = mb86s7x_send_packet(CMD_CPU_CLOCK_GATE_GET_REQ,
+					  &cmd, sizeof(cmd));
+		if (ret < 0) {
+			pr_err("%s:%d failed to get CPU status\n",
+			       __func__, __LINE__);
+			return ret;
+		}
+
+		pr_debug("%s:%d Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u\n",
+			 __func__, __LINE__,
+			 cmd.cluster_class, cmd.cluster_id,
+			 cmd.cpu_id, cmd.cpu_state);
+
+		if (cmd.cpu_state == SCB_CPU_STATE_OFF)
+			return 0;
+
+		msleep(20);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void mb86s7x_pm_powered_up(void)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	arch_spin_lock(&mb86s7x_pm_lock);
+	if (!mb86s7x_pm_use_count[cluster][cpu])
+		mb86s7x_pm_use_count[cluster][cpu] = 1;
+	arch_spin_unlock(&mb86s7x_pm_lock);
+}
+
+static const struct mcpm_platform_ops mb86s7x_pm_power_ops = {
+	.power_up		= mb86s7x_pm_power_up,
+	.power_down		= mb86s7x_pm_power_down,
+	.wait_for_powerdown	= mb86s7x_wait_for_powerdown,
+	.suspend		= mb86s7x_pm_suspend,
+	.powered_up		= mb86s7x_pm_powered_up,
+};
+
+/*
+ * Enable cluster-level coherency, in preparation for turning on the MMU.
+ */
+static void __naked mb86s7x_pm_power_up_setup(unsigned int affinity_level)
+{
+	asm volatile ("\n"
+"	cmp	r0, #1\n"
+"	bxne	lr\n"
+"	b	cci_enable_port_for_self");
+}
+
+static void __init mb86s7x_cache_off(void)
+{
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
+		/* disable L2 prefetching on the Cortex-A15 */
+		asm volatile(
+		"mcr	p15, 1, %0, c15, c0, 3\n\t"
+		"isb\n\t"
+		"dsb"
+		: : "r" (0x400));
+	}
+	v7_exit_coherency_flush(all);
+}
+
+struct mb86s7x_scb_version {
+	u32 payload_size;
+	u32 version;
+	u32 config_version;
+};
+
+static int __init mb86s7x_mcpm_init(void)
+{
+	unsigned int mpidr, cpu, cluster;
+	struct mb86s7x_scb_version cmd;
+	struct device_node *np;
+	int ret = -ENODEV;
+
+	np = of_find_compatible_node(NULL, NULL, "fujitsu,mb86s70-scb-1.0");
+	if (!np || !of_device_is_available(np) || !cci_probed())
+		goto exit;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	pr_info("Booting on cpu_%u cluster_%u\n", cpu, cluster);
+	mb86s7x_pm_use_count[cluster][cpu] = 1;
+
+	/* reset the wfi 'color' for primary cpu */
+	mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_NOTHING);
+
+	/* Do SMC to set entry address for CPUs coming online */
+	mb86s7x_cpu_entry(virt_to_phys(mcpm_entry_point));
+
+	cmd.payload_size = sizeof(cmd);
+	cmd.version = 0;
+	cmd.config_version = 0;
+	ret = mb86s7x_send_packet(CMD_SCB_CAPABILITY_GET_REQ,
+				  &cmd, sizeof(cmd));
+	if (ret < 0) /* non fatal */
+		pr_err("%s:%d failed to get SCB version\n",
+		       __func__, __LINE__);
+	else
+		pr_err("MB86S7x SCB version 0x%x:0x%x\n",
+		       cmd.version, cmd.config_version);
+
+	ret = mcpm_platform_register(&mb86s7x_pm_power_ops);
+	if (!ret)
+		ret = mcpm_sync_init(mb86s7x_pm_power_up_setup);
+	if (!ret)
+		ret = mcpm_loopback(mb86s7x_cache_off); /* turn on the CCI */
+	if (!ret)
+		mcpm_smp_set_ops();
+exit:
+	of_node_put(np);
+	return ret;
+}
+early_initcall(mb86s7x_mcpm_init);
diff --git a/arch/arm/mach-mb86s7x/smc.S b/arch/arm/mach-mb86s7x/smc.S
new file mode 100644
index 0000000..3ffe4f7
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/smc.S
@@ -0,0 +1,27 @@
+/*
+ * SMC command interface to set secondary entry point
+ * Copyright: (C) 2013-2015 Fujitsu Semiconductor Limited
+ * Copyright: (C) 2015 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+.arch_extension sec
+
+/* void mb86s7x_cpu_entry(unsigned long secondary_entry); */
+ENTRY(mb86s7x_cpu_entry)
+	stmfd   sp!, {r1-r11, lr}
+	mov r1, r0
+	ldr r0, =1
+	mrc p15, 0, r3, c1, c0, 0
+	mov r4, r3
+	and r3, #0xbfffffff
+	mcr p15, 0, r3, c1, c0, 0
+	smc #0
+	mcr p15, 0, r4, c1, c0, 0
+	ldmfd   sp!, {r1-r11, pc}
+ENDPROC(mb86s7x_cpu_entry)
diff --git a/drivers/soc/mb86s7x/scb_mhu.c b/drivers/soc/mb86s7x/scb_mhu.c
index c1d66f4..7141287 100644
--- a/drivers/soc/mb86s7x/scb_mhu.c
+++ b/drivers/soc/mb86s7x/scb_mhu.c
@@ -89,6 +89,20 @@ static struct mhu_xfer {
 	struct list_head node;
 } *ax; /* stages of xfer */
 
+#define WFI_COLOR_OFFSET	0x3f00
+
+void mb86s7x_set_wficolor(unsigned clstr, unsigned cpu, unsigned clr)
+{
+	u8 val;
+
+	val = readb_relaxed(mb86s7x_shm_base
+			    + WFI_COLOR_OFFSET + clstr * 2 + cpu);
+	val &= ~AT_WFI_COLOR_MASK;
+	val |= clr;
+	writeb_relaxed(val, mb86s7x_shm_base
+		       + WFI_COLOR_OFFSET + clstr * 2 + cpu);
+}
+
 static int mhu_alloc_xfers(int n, struct list_head *list)
 {
 	struct mhu_xfer *x = kcalloc(n, sizeof(struct mhu_xfer), GFP_ATOMIC);
diff --git a/include/soc/mb86s7x/scb_mhu.h b/include/soc/mb86s7x/scb_mhu.h
index 42a1baa..8ee75f2 100644
--- a/include/soc/mb86s7x/scb_mhu.h
+++ b/include/soc/mb86s7x/scb_mhu.h
@@ -87,6 +87,14 @@ enum {
 #define CMD_POWERDOMAIN_SET_REP		ENC_REP(CMD_POWERDOMAIN_SET_REQ)
 #define CMD_STG_BLOCK_ERASE_REP		ENC_REP(CMD_STG_BLOCK_ERASE_REQ)
 
+#define AT_WFI_DO_NOTHING	0x0
+#define AT_WFI_DO_SUSPEND	0x1
+#define AT_WFI_DO_POWEROFF	0x2
+#define AT_WFI_COLOR_MASK	0x3
+
+void mb86s7x_set_wficolor(unsigned clstr, unsigned cpu, unsigned clr);
+void mb86s7x_cpu_entry(unsigned long secondary_entry);
+
 /* Helper functions to talk to remote */
 int mb86s7x_send_packet(u32 code, void *buf, int len);
 
-- 
1.9.0
