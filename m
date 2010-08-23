From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 23 Aug 2010 11:46:21 +0100
Subject: [PATCH 3/3] sh: Use the perf-events backend for oprofile
In-Reply-To: <1282560381-7700-1-git-send-email-matt@console-pimps.org>
References: <1282560381-7700-1-git-send-email-matt@console-pimps.org>
Message-ID: <1282560381-7700-4-git-send-email-matt@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the perf-events based wrapper for oprofile available in
drivers/oprofile. This allows us to centralise the code to control
performance counters.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/oprofile/Makefile  |    4 ++
 arch/sh/oprofile/common.c  |   95 ++++++-------------------------------------
 arch/sh/oprofile/op_impl.h |   33 ---------------
 3 files changed, 18 insertions(+), 114 deletions(-)
 delete mode 100644 arch/sh/oprofile/op_impl.h

diff --git a/arch/sh/oprofile/Makefile b/arch/sh/oprofile/Makefile
index 4886c5c..00ef946 100644
--- a/arch/sh/oprofile/Makefile
+++ b/arch/sh/oprofile/Makefile
@@ -6,4 +6,8 @@ DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
 		oprofilefs.o oprofile_stats.o \
 		timer_int.o )
 
+ifeq ($(CONFIG_PERF_EVENTS), y)
+DRIVER_OBJS += $(addprefix ../../../drivers/oprofile/, oprofile_perf.o)
+endif
+
 oprofile-y	:= $(DRIVER_OBJS) common.o backtrace.o
diff --git a/arch/sh/oprofile/common.c b/arch/sh/oprofile/common.c
index ac60493..b5b0d5e 100644
--- a/arch/sh/oprofile/common.c
+++ b/arch/sh/oprofile/common.c
@@ -17,73 +17,23 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
+#include <linux/perf_event.h>
 #include <asm/processor.h>
-#include "op_impl.h"
-
-static struct op_sh_model *model;
-
-static struct op_counter_config ctr[20];
 
 extern void sh_backtrace(struct pt_regs * const regs, unsigned int depth);
 
-static int op_sh_setup(void)
-{
-	/* Pre-compute the values to stuff in the hardware registers.  */
-	model->reg_setup(ctr);
-
-	/* Configure the registers on all cpus.  */
-	on_each_cpu(model->cpu_setup, NULL, 1);
-
-        return 0;
-}
-
-static int op_sh_create_files(struct super_block *sb, struct dentry *root)
-{
-	int i, ret = 0;
-
-	for (i = 0; i < model->num_counters; i++) {
-		struct dentry *dir;
-		char buf[4];
-
-		snprintf(buf, sizeof(buf), "%d", i);
-		dir = oprofilefs_mkdir(sb, root, buf);
-
-		ret |= oprofilefs_create_ulong(sb, dir, "enabled", &ctr[i].enabled);
-		ret |= oprofilefs_create_ulong(sb, dir, "event", &ctr[i].event);
-		ret |= oprofilefs_create_ulong(sb, dir, "kernel", &ctr[i].kernel);
-		ret |= oprofilefs_create_ulong(sb, dir, "user", &ctr[i].user);
-
-		if (model->create_files)
-			ret |= model->create_files(sb, dir);
-		else
-			ret |= oprofilefs_create_ulong(sb, dir, "count", &ctr[i].count);
-
-		/* Dummy entries */
-		ret |= oprofilefs_create_ulong(sb, dir, "unit_mask", &ctr[i].unit_mask);
-	}
-
-	return ret;
-}
-
-static int op_sh_start(void)
+static char *op_name_from_perf_name(const char *name)
 {
-	/* Enable performance monitoring for all counters.  */
-	on_each_cpu(model->cpu_start, NULL, 1);
+	if (!strcmp(name, "SH-4A"))
+		return "sh/sh4a";
+	if (!strcmp(name, "SH7750"))
+		return "sh/sh7750";
 
-	return 0;
-}
-
-static void op_sh_stop(void)
-{
-	/* Disable performance monitoring for all counters.  */
-	on_each_cpu(model->cpu_stop, NULL, 1);
+	return NULL;
 }
 
 int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
-	struct op_sh_model *lmodel = NULL;
-	int ret;
-
 	/*
 	 * Always assign the backtrace op. If the counter initialization
 	 * fails, we fall back to the timer which will still make use of
@@ -91,40 +41,23 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	 */
 	ops->backtrace = sh_backtrace;
 
-	/*
-	 * XXX
-	 *
-	 * All of the SH7750/SH-4A counters have been converted to perf,
-	 * this infrastructure hook is left for other users until they've
-	 * had a chance to convert over, at which point all of this
-	 * will be deleted.
-	 */
-
-	if (!lmodel)
-		return -ENODEV;
 	if (!(current_cpu_data.flags & CPU_HAS_PERF_COUNTER))
 		return -ENODEV;
 
-	ret = lmodel->init();
-	if (unlikely(ret != 0))
-		return ret;
-
-	model = lmodel;
+	ops->setup		= op_perf_setup;
+	ops->create_files	= op_perf_create_files;
+	ops->start		= op_perf_start;
+	ops->stop		= op_perf_stop;
+	ops->cpu_type		= op_name_from_perf_name(sh_pmu_name());
 
-	ops->setup		= op_sh_setup;
-	ops->create_files	= op_sh_create_files;
-	ops->start		= op_sh_start;
-	ops->stop		= op_sh_stop;
-	ops->cpu_type		= lmodel->cpu_type;
+	op_perf_set_num_counters(sh_pmu_num_events());
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
-	       lmodel->cpu_type);
+	       ops->cpu_type);
 
 	return 0;
 }
 
 void oprofile_arch_exit(void)
 {
-	if (model && model->exit)
-		model->exit();
 }
diff --git a/arch/sh/oprofile/op_impl.h b/arch/sh/oprofile/op_impl.h
deleted file mode 100644
index 1244479..0000000
--- a/arch/sh/oprofile/op_impl.h
+++ /dev/null
@@ -1,33 +0,0 @@
-#ifndef __OP_IMPL_H
-#define __OP_IMPL_H
-
-/* Per-counter configuration as set via oprofilefs.  */
-struct op_counter_config {
-	unsigned long enabled;
-	unsigned long event;
-
-	unsigned long count;
-
-	/* Dummy values for userspace tool compliance */
-	unsigned long kernel;
-	unsigned long user;
-	unsigned long unit_mask;
-};
-
-/* Per-architecture configury and hooks.  */
-struct op_sh_model {
-	void (*reg_setup)(struct op_counter_config *);
-	int (*create_files)(struct super_block *sb, struct dentry *dir);
-	void (*cpu_setup)(void *dummy);
-	int (*init)(void);
-	void (*exit)(void);
-	void (*cpu_start)(void *args);
-	void (*cpu_stop)(void *args);
-	char *cpu_type;
-	unsigned char num_counters;
-};
-
-/* arch/sh/oprofile/common.c */
-extern void sh_backtrace(struct pt_regs * const regs, unsigned int depth);
-
-#endif /* __OP_IMPL_H */
-- 
1.7.2.1
