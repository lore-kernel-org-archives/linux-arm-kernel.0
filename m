From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 24 May 2018 14:09:30 -0500
Subject: [PATCH 2/4] arm64: kdebugfs: create arm64 debugfs directory
In-Reply-To: <20180524190932.32118-1-mlangsdo@redhat.com>
References: <20180524190932.32118-1-mlangsdo@redhat.com>
Message-ID: <20180524190932.32118-3-mlangsdo@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create debugfs directory for arm64, like the existing one for x86.

Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 arch/arm64/kernel/Makefile   |  3 ++-
 arch/arm64/kernel/kdebugfs.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/kdebugfs.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index bf825f3..a48b298 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,7 +18,8 @@ arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   hyp-stub.o psci.o cpu_ops.o insn.o	\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
-			   smp.o smp_spin_table.o topology.o smccc-call.o
+			   smp.o smp_spin_table.o topology.o smccc-call.o	\
+			   kdebugfs.o
 
 extra-$(CONFIG_EFI)			:= efi-entry.o
 
diff --git a/arch/arm64/kernel/kdebugfs.c b/arch/arm64/kernel/kdebugfs.c
new file mode 100644
index 0000000..e1e3332
--- /dev/null
+++ b/arch/arm64/kernel/kdebugfs.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Architecture specific debugfs files
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/export.h>
+#include <linux/init.h>
+
+struct dentry *arch_debugfs_dir;
+EXPORT_SYMBOL(arch_debugfs_dir);
+
+static int __init arch_kdebugfs_init(void)
+{
+	int error = 0;
+
+	arch_debugfs_dir = debugfs_create_dir("arm64", NULL);
+	if (IS_ERR(arch_debugfs_dir)) {
+		arch_debugfs_dir = NULL;
+		return -ENOMEM;
+	}
+
+	return error;
+}
+postcore_initcall(arch_kdebugfs_init);
-- 
2.9.5
