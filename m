From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Sep 2014 22:49:04 +0000
Subject: [PATCH 06/13] arm64: Add new routine read_cpu_properties
In-Reply-To: <cover.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
Message-ID: <b68073fb2e816f97311b9a3547e3656164ae85d0.1410302383.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kexec re-boot support that will be added in a subsequent patch in this
series will need to read the device tree CPU properties, and it is expected
that a rework of the SMP spin table code to handle cpu_die will also need this
functionality, so add two new common arm64 files cpu-properties.h and
cpu-properties.c that define a new structure cpu_properties that hold the
various CPU properties from a device tree, and the new routine
read_cpu_properties() that fills the structure from a device tree CPU node.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/cpu-properties.c | 58 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu-properties.h | 39 +++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 arch/arm64/kernel/cpu-properties.c
 create mode 100644 arch/arm64/kernel/cpu-properties.h

diff --git a/arch/arm64/kernel/cpu-properties.c b/arch/arm64/kernel/cpu-properties.c
new file mode 100644
index 0000000..e64b34b
--- /dev/null
+++ b/arch/arm64/kernel/cpu-properties.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) Linaro.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "cpu-properties.h"
+
+int read_cpu_properties(struct cpu_properties *p, const struct device_node *dn)
+{
+	const u32 *cell;
+
+	memset(p, 0, sizeof(*p));
+	p->hwid = INVALID_HWID;
+	p->cpu_release_addr = INVALID_ADDR;
+
+	cell = of_get_property(dn, "reg", NULL);
+
+	if (!cell) {
+		pr_err("%s: Error: %s: invalid reg property\n",
+		       __func__, dn->full_name);
+		return -1;
+	}
+
+	p->hwid = of_read_number(cell,
+		of_n_addr_cells((struct device_node *)dn)) & MPIDR_HWID_BITMASK;
+
+	p->enable_method = of_get_property(dn, "enable-method", NULL);
+
+	if (!p->enable_method) {
+		pr_err("%s: Error: %s: invalid enable-method\n",
+		       __func__, dn->full_name);
+		return -1;
+	}
+
+	if (!strcmp(p->enable_method, "psci")) {
+		p->type = cpu_enable_method_psci;
+		return 0;
+	}
+
+	if (strcmp(p->enable_method, "spin-table")) {
+		p->type = cpu_enable_method_unknown;
+		return -1;
+	}
+
+	p->type = cpu_enable_method_spin_table;
+
+	if (of_property_read_u64(dn, "cpu-release-addr",
+				 &p->cpu_release_addr)) {
+		pr_err("%s: Error: %s: invalid cpu-return-addr property\n",
+		       __func__, dn->full_name);
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/arch/arm64/kernel/cpu-properties.h b/arch/arm64/kernel/cpu-properties.h
new file mode 100644
index 0000000..b4218ef
--- /dev/null
+++ b/arch/arm64/kernel/cpu-properties.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) Linaro.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#if !defined(__ARM64_CPU_PROPERTIES_H)
+#define __ARM64_CPU_PROPERTIES_H
+
+#include <asm/memory.h>
+#include <asm/cputype.h>
+
+#define INVALID_ADDR UL(~0)
+
+#if !defined(__ASSEMBLY__)
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+enum cpu_enable_method {
+	cpu_enable_method_unknown,
+	cpu_enable_method_psci,
+	cpu_enable_method_spin_table,
+};
+
+struct cpu_properties {
+	u64 hwid;
+	u64 cpu_release_addr;
+	const char *enable_method;
+	enum cpu_enable_method type;
+};
+
+int read_cpu_properties(struct cpu_properties *p, const struct device_node *dn);
+
+#endif /* !defined(__ASSEMBLY__) */
+
+#endif
-- 
1.9.1
