From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 31 Mar 2014 15:40:13 -0400
Subject: [PATCH v5 1/3] PSCI: Add initial support for PSCIv0.2 functions
In-Reply-To: <1396294815-12019-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1396294815-12019-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <1396294815-12019-2-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PSCIv0.2 spec defines standard values of function IDs
and introduces a few new functions. Detect version of PSCI
and appropriately select the right PSCI functions.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 arch/arm/include/asm/psci.h |   7 +-
 arch/arm/kernel/psci.c      | 158 ++++++++++++++++++++++++++++++++++--------
 arch/arm64/kernel/psci.c    | 163 ++++++++++++++++++++++++++++++++++++--------
 include/uapi/linux/Kbuild   |   1 +
 include/uapi/linux/psci.h   |  61 +++++++++++++++++
 5 files changed, 330 insertions(+), 60 deletions(-)
 create mode 100644 include/uapi/linux/psci.h

diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index c4ae171..b93e34a 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -29,16 +29,19 @@ struct psci_operations {
 	int (*cpu_off)(struct psci_power_state state);
 	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
 	int (*migrate)(unsigned long cpuid);
+	int (*affinity_info)(unsigned long target_affinity,
+			unsigned long lowest_affinity_level);
+	int (*migrate_info_type)(void);
 };
 
 extern struct psci_operations psci_ops;
 extern struct smp_operations psci_smp_ops;
 
 #ifdef CONFIG_ARM_PSCI
-void psci_init(void);
+int psci_init(void);
 bool psci_smp_available(void);
 #else
-static inline void psci_init(void) { }
+static inline int psci_init(void) { }
 static inline bool psci_smp_available(void) { return false; }
 #endif
 
diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
index 4693188..2b8bca1 100644
--- a/arch/arm/kernel/psci.c
+++ b/arch/arm/kernel/psci.c
@@ -17,6 +17,7 @@
 
 #include <linux/init.h>
 #include <linux/of.h>
+#include <uapi/linux/psci.h>
 
 #include <asm/compiler.h>
 #include <asm/errno.h>
@@ -27,22 +28,20 @@
 struct psci_operations psci_ops;
 
 static int (*invoke_psci_fn)(u32, u32, u32, u32);
+typedef int (*psci_initcall_t)(const struct device_node *);
 
 enum psci_function {
 	PSCI_FN_CPU_SUSPEND,
 	PSCI_FN_CPU_ON,
 	PSCI_FN_CPU_OFF,
 	PSCI_FN_MIGRATE,
+	PSCI_FN_AFFINITY_INFO,
+	PSCI_FN_MIGRATE_INFO_TYPE,
 	PSCI_FN_MAX,
 };
 
 static u32 psci_function_id[PSCI_FN_MAX];
 
-#define PSCI_RET_SUCCESS		0
-#define PSCI_RET_EOPNOTSUPP		-1
-#define PSCI_RET_EINVAL			-2
-#define PSCI_RET_EPERM			-3
-
 static int psci_to_linux_errno(int errno)
 {
 	switch (errno) {
@@ -59,13 +58,6 @@ static int psci_to_linux_errno(int errno)
 	return -EINVAL;
 }
 
-#define PSCI_POWER_STATE_ID_MASK	0xffff
-#define PSCI_POWER_STATE_ID_SHIFT	0
-#define PSCI_POWER_STATE_TYPE_MASK	0x1
-#define PSCI_POWER_STATE_TYPE_SHIFT	16
-#define PSCI_POWER_STATE_AFFL_MASK	0x3
-#define PSCI_POWER_STATE_AFFL_SHIFT	24
-
 static u32 psci_power_state_pack(struct psci_power_state state)
 {
 	return	((state.id & PSCI_POWER_STATE_ID_MASK)
@@ -110,6 +102,14 @@ static noinline int __invoke_psci_fn_smc(u32 function_id, u32 arg0, u32 arg1,
 	return function_id;
 }
 
+static int psci_get_version(void)
+{
+	int err;
+
+	err = invoke_psci_fn(PSCI_ID_VERSION, 0, 0, 0);
+	return err;
+}
+
 static int psci_cpu_suspend(struct psci_power_state state,
 			    unsigned long entry_point)
 {
@@ -153,26 +153,36 @@ static int psci_migrate(unsigned long cpuid)
 	return psci_to_linux_errno(err);
 }
 
-static const struct of_device_id psci_of_match[] __initconst = {
-	{ .compatible = "arm,psci",	},
-	{},
-};
+static int psci_affinity_info(unsigned long target_affinity,
+		unsigned long lowest_affinity_level)
+{
+	int err;
+	u32 fn;
 
-void __init psci_init(void)
+	fn = psci_function_id[PSCI_FN_AFFINITY_INFO];
+	err = invoke_psci_fn(fn, target_affinity, lowest_affinity_level, 0);
+	return err;
+}
+
+static int psci_migrate_info_type(void)
 {
-	struct device_node *np;
-	const char *method;
-	u32 id;
+	int err;
+	u32 fn;
 
-	np = of_find_matching_node(NULL, psci_of_match);
-	if (!np)
-		return;
+	fn = psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE];
+	err = invoke_psci_fn(fn, 0, 0, 0);
+	return err;
+}
 
-	pr_info("probing function IDs from device-tree\n");
+static int get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	pr_info("probing for conduit method from DT.\n");
 
 	if (of_property_read_string(np, "method", &method)) {
-		pr_warning("missing \"method\" property\n");
-		goto out_put_node;
+		pr_warn("missing \"method\" property\n");
+		return -ENXIO;
 	}
 
 	if (!strcmp("hvc", method)) {
@@ -180,10 +190,82 @@ void __init psci_init(void)
 	} else if (!strcmp("smc", method)) {
 		invoke_psci_fn = __invoke_psci_fn_smc;
 	} else {
-		pr_warning("invalid \"method\" property: %s\n", method);
+		pr_warn("invalid \"method\" property: %s\n", method);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * PSCI Function IDs for v0.2+ are well defined so use
+ * standard values.
+ */
+static int psci_0_2_init(struct device_node *np)
+{
+	int err, ver;
+
+	err = get_set_conduit_method(np);
+
+	if (err)
 		goto out_put_node;
+
+	ver = psci_get_version();
+
+	if (ver == PSCI_RET_EOPNOTSUPP) {
+		/* PSCI v0.2 mandates implementation of PSCI_ID_VERSION. */
+		pr_err("PSCI firmware does not comply with the v0.2 spec.\n");
+		err = -EOPNOTSUPP;
+		goto out_put_node;
+	} else {
+		pr_info("PSCIv%d.%d detected in firmware.\n",
+				PSCI_VER_MAJOR(ver), PSCI_VER_MINOR(ver));
+
+		if (PSCI_VER_MAJOR(ver) == 0 && PSCI_VER_MINOR(ver) < 2) {
+			err = -EINVAL;
+			pr_err("Conflicting PSCI version detected.\n");
+			goto out_put_node;
+		}
 	}
 
+	pr_info("Using standard PSCI v0.2 function IDs\n");
+	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_ID_CPU_SUSPEND_32;
+	psci_ops.cpu_suspend = psci_cpu_suspend;
+
+	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_ID_CPU_OFF;
+	psci_ops.cpu_off = psci_cpu_off;
+
+	psci_function_id[PSCI_FN_CPU_ON] = PSCI_ID_CPU_ON_32;
+	psci_ops.cpu_on = psci_cpu_on;
+
+	psci_function_id[PSCI_FN_MIGRATE] = PSCI_ID_CPU_MIGRATE_32;
+	psci_ops.migrate = psci_migrate;
+
+	psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_ID_AFFINITY_INFO_32;
+	psci_ops.affinity_info = psci_affinity_info;
+
+	psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] = PSCI_ID_MIGRATE_INFO_TYPE;
+	psci_ops.migrate_info_type = psci_migrate_info_type;
+
+out_put_node:
+	of_node_put(np);
+	return err;
+}
+
+/*
+ * PSCI < v0.2 get PSCI Function IDs via DT.
+ */
+static int psci_0_1_init(struct device_node *np)
+{
+	u32 id;
+	int err;
+
+	err = get_set_conduit_method(np);
+
+	if (err)
+		goto out_put_node;
+
+	pr_info("Using PSCI v0.1 Function IDs from DT\n");
+
 	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
 		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
 		psci_ops.cpu_suspend = psci_cpu_suspend;
@@ -206,5 +288,25 @@ void __init psci_init(void)
 
 out_put_node:
 	of_node_put(np);
-	return;
+	return err;
+}
+
+static const struct of_device_id psci_of_match[] __initconst = {
+	{ .compatible = "arm,psci", .data = psci_0_1_init},
+	{ .compatible = "arm,psci-0.2", .data = psci_0_2_init},
+	{},
+};
+
+int __init psci_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *matched_np;
+	psci_initcall_t init_fn;
+
+	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
+	if (!np)
+		return -ENODEV;
+
+	init_fn = (psci_initcall_t)matched_np->data;
+	return init_fn(np);
 }
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 4f97db3..8647253 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <uapi/linux/psci.h>
 
 #include <asm/compiler.h>
 #include <asm/cpu_ops.h>
@@ -40,27 +41,28 @@ struct psci_operations {
 	int (*cpu_off)(struct psci_power_state state);
 	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
 	int (*migrate)(unsigned long cpuid);
+	int (*affinity_info)(unsigned long target_affinity,
+			unsigned long lowest_affinity_level);
+	int (*migrate_info_type)(void);
 };
 
 static struct psci_operations psci_ops;
 
 static int (*invoke_psci_fn)(u64, u64, u64, u64);
+typedef int (*psci_initcall_t)(const struct device_node *);
 
 enum psci_function {
 	PSCI_FN_CPU_SUSPEND,
 	PSCI_FN_CPU_ON,
 	PSCI_FN_CPU_OFF,
 	PSCI_FN_MIGRATE,
+	PSCI_FN_AFFINITY_INFO,
+	PSCI_FN_MIGRATE_INFO_TYPE,
 	PSCI_FN_MAX,
 };
 
 static u32 psci_function_id[PSCI_FN_MAX];
 
-#define PSCI_RET_SUCCESS		0
-#define PSCI_RET_EOPNOTSUPP		-1
-#define PSCI_RET_EINVAL			-2
-#define PSCI_RET_EPERM			-3
-
 static int psci_to_linux_errno(int errno)
 {
 	switch (errno) {
@@ -77,13 +79,6 @@ static int psci_to_linux_errno(int errno)
 	return -EINVAL;
 }
 
-#define PSCI_POWER_STATE_ID_MASK	0xffff
-#define PSCI_POWER_STATE_ID_SHIFT	0
-#define PSCI_POWER_STATE_TYPE_MASK	0x1
-#define PSCI_POWER_STATE_TYPE_SHIFT	16
-#define PSCI_POWER_STATE_AFFL_MASK	0x3
-#define PSCI_POWER_STATE_AFFL_SHIFT	24
-
 static u32 psci_power_state_pack(struct psci_power_state state)
 {
 	return	((state.id & PSCI_POWER_STATE_ID_MASK)
@@ -128,6 +123,14 @@ static noinline int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
 	return function_id;
 }
 
+static int psci_get_version(void)
+{
+	int err;
+
+	err = invoke_psci_fn(PSCI_ID_VERSION, 0, 0, 0);
+	return err;
+}
+
 static int psci_cpu_suspend(struct psci_power_state state,
 			    unsigned long entry_point)
 {
@@ -171,28 +174,36 @@ static int psci_migrate(unsigned long cpuid)
 	return psci_to_linux_errno(err);
 }
 
-static const struct of_device_id psci_of_match[] __initconst = {
-	{ .compatible = "arm,psci",	},
-	{},
-};
+static int psci_affinity_info(unsigned long target_affinity,
+		unsigned long lowest_affinity_level)
+{
+	int err;
+	u32 fn;
 
-int __init psci_init(void)
+	fn = psci_function_id[PSCI_FN_AFFINITY_INFO];
+	err = invoke_psci_fn(fn, target_affinity, lowest_affinity_level, 0);
+	return err;
+}
+
+static int psci_migrate_info_type(void)
 {
-	struct device_node *np;
-	const char *method;
-	u32 id;
-	int err = 0;
+	int err;
+	u32 fn;
 
-	np = of_find_matching_node(NULL, psci_of_match);
-	if (!np)
-		return -ENODEV;
+	fn = psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE];
+	err = invoke_psci_fn(fn, 0, 0, 0);
+	return err;
+}
 
-	pr_info("probing function IDs from device-tree\n");
+static int get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	pr_info("probing for conduit method from DT.\n");
 
 	if (of_property_read_string(np, "method", &method)) {
-		pr_warning("missing \"method\" property\n");
-		err = -ENXIO;
-		goto out_put_node;
+		pr_warn("missing \"method\" property\n");
+		return -ENXIO;
 	}
 
 	if (!strcmp("hvc", method)) {
@@ -200,11 +211,82 @@ int __init psci_init(void)
 	} else if (!strcmp("smc", method)) {
 		invoke_psci_fn = __invoke_psci_fn_smc;
 	} else {
-		pr_warning("invalid \"method\" property: %s\n", method);
-		err = -EINVAL;
+		pr_warn("invalid \"method\" property: %s\n", method);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * PSCI Function IDs for v0.2+ are well defined so use
+ * standard values.
+ */
+static int psci_0_2_init(struct device_node *np)
+{
+	int err, ver;
+
+	err = get_set_conduit_method(np);
+
+	if (err)
+		goto out_put_node;
+
+	ver = psci_get_version();
+
+	if (ver == PSCI_RET_EOPNOTSUPP) {
+		/* PSCI v0.2 mandates implementation of PSCI_ID_VERSION. */
+		pr_err("PSCI firmware does not comply with the v0.2 spec.\n");
+		err = -EOPNOTSUPP;
 		goto out_put_node;
+	} else {
+		pr_info("PSCIv%d.%d detected in firmware.\n",
+				PSCI_VER_MAJOR(ver), PSCI_VER_MINOR(ver));
+
+		if (PSCI_VER_MAJOR(ver) == 0 && PSCI_VER_MINOR(ver) < 2) {
+			err = -EINVAL;
+			pr_err("Conflicting PSCI version detected.\n");
+			goto out_put_node;
+		}
 	}
 
+	pr_info("Using standard PSCI v0.2 function IDs\n");
+	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_ID_CPU_SUSPEND_64;
+	psci_ops.cpu_suspend = psci_cpu_suspend;
+
+	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_ID_CPU_OFF;
+	psci_ops.cpu_off = psci_cpu_off;
+
+	psci_function_id[PSCI_FN_CPU_ON] = PSCI_ID_CPU_ON_64;
+	psci_ops.cpu_on = psci_cpu_on;
+
+	psci_function_id[PSCI_FN_MIGRATE] = PSCI_ID_CPU_MIGRATE_64;
+	psci_ops.migrate = psci_migrate;
+
+	psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_ID_AFFINITY_INFO_64;
+	psci_ops.affinity_info = psci_affinity_info;
+
+	psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] = PSCI_ID_MIGRATE_INFO_TYPE;
+	psci_ops.migrate_info_type = psci_migrate_info_type;
+
+out_put_node:
+	of_node_put(np);
+	return err;
+}
+
+/*
+ * PSCI < v0.2 get PSCI Function IDs via DT.
+ */
+static int psci_0_1_init(struct device_node *np)
+{
+	u32 id;
+	int err;
+
+	err = get_set_conduit_method(np);
+
+	if (err)
+		goto out_put_node;
+
+	pr_info("Using PSCI v0.1 Function IDs from DT\n");
+
 	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
 		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
 		psci_ops.cpu_suspend = psci_cpu_suspend;
@@ -230,6 +312,27 @@ out_put_node:
 	return err;
 }
 
+static const struct of_device_id psci_of_match[] __initconst = {
+	{ .compatible = "arm,psci",	.data = psci_0_1_init},
+	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
+	{},
+};
+
+int __init psci_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *matched_np;
+	psci_initcall_t init_fn;
+
+	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
+
+	if (!np)
+		return -ENODEV;
+
+	init_fn = (psci_initcall_t)matched_np->data;
+	return init_fn(np);
+}
+
 #ifdef CONFIG_SMP
 
 static int __init cpu_psci_cpu_init(struct device_node *dn, unsigned int cpu)
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index 3ce25b5..3da5dfe 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -316,6 +316,7 @@ header-y += ppp-ioctl.h
 header-y += ppp_defs.h
 header-y += pps.h
 header-y += prctl.h
+header-y += psci.h
 header-y += ptp_clock.h
 header-y += ptrace.h
 header-y += qnx4_fs.h
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
new file mode 100644
index 0000000..0354bb1
--- /dev/null
+++ b/include/uapi/linux/psci.h
@@ -0,0 +1,61 @@
+/*
+ *	Copyright (C) 2014 Linaro Ltd.
+ *	Author:	Ashwin Chaugule <ashwin.chaugule@linaro.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#ifndef _UAPI_LINUX_PSCI_H
+#define _UAPI_LINUX_PSCI_H
+
+/* PSCI Function IDs as per PSCI spec v0.2 */
+#define PSCI_ID_VERSION					0x84000000
+#define PSCI_ID_CPU_SUSPEND_32			0x84000001
+#define PSCI_ID_CPU_SUSPEND_64			0xc4000001
+#define PSCI_ID_CPU_OFF					0x84000002
+#define PSCI_ID_CPU_ON_32				0x84000003
+#define PSCI_ID_CPU_ON_64				0xC4000003
+#define PSCI_ID_AFFINITY_INFO_32		0x84000004
+#define PSCI_ID_AFFINITY_INFO_64		0xC4000004
+#define PSCI_ID_CPU_MIGRATE_32			0x84000005
+#define PSCI_ID_CPU_MIGRATE_64			0xc4000005
+#define PSCI_ID_MIGRATE_INFO_TYPE		0x84000006
+#define PSCI_ID_MIGRATE_INFO_UP_CPU_32	0x84000007
+#define PSCI_ID_MIGRATE_INFO_UP_CPU_64	0xc4000007
+#define PSCI_ID_SYSTEM_OFF				0x84000008
+#define PSCI_ID_SYSTEM_RESET			0x84000009
+
+#define PSCI_RET_SUCCESS			0
+#define PSCI_RET_EOPNOTSUPP			-1
+#define PSCI_RET_EINVAL				-2
+#define PSCI_RET_EPERM				-3
+#define PSCI_RET_ALREADY_ON			-4
+#define PSCI_RET_ON_PENDING			-5
+#define PSCI_RET_INTERNAL_FAILURE	-6
+#define PSCI_RET_NOT_PRESENT		-7
+#define PSCI_RET_DISABLED			-8
+
+#define PSCI_POWER_STATE_ID_MASK	0xffff
+#define PSCI_POWER_STATE_ID_SHIFT	0
+#define PSCI_POWER_STATE_TYPE_MASK	0x1
+#define PSCI_POWER_STATE_TYPE_SHIFT	16
+#define PSCI_POWER_STATE_AFFL_MASK	0x3
+#define PSCI_POWER_STATE_AFFL_SHIFT	24
+
+#define PSCI_VER_MAJOR_MASK		0xffff0000
+#define PSCI_VER_MINOR_MASK		0x0000ffff
+#define PSCI_VER_MAJOR_SHIFT	16
+#define PSCI_VER_MAJOR(ver)		\
+	((ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT)
+#define PSCI_VER_MINOR(ver)		(ver & PSCI_VER_MINOR_MASK)
+
+#endif /* _UAPI_LINUX_PSCI_H */
-- 
1.8.3.2
