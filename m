From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Tue,  1 Oct 2013 21:27:57 +0530
Subject: [PATCH RFC v1 2/5] arm64: Kernel code patching support
In-Reply-To: <1380643080-8984-1-git-send-email-sandeepa.prabhu@linaro.org>
References: <1380643080-8984-1-git-send-email-sandeepa.prabhu@linaro.org>
Message-ID: <1380643080-8984-3-git-send-email-sandeepa.prabhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement API for kernel code section. These API supports
modifying kernel text section, one instruction at a time.

This functionality will be used in kprobes handlers to place/replace
software breakpoints, kprobe breakpoints cannot be placed inside these
handlers so will be added under __kprobes section.

Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
---
 arch/arm64/kernel/patch.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/patch.h | 20 ++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 arch/arm64/kernel/patch.c
 create mode 100644 arch/arm64/kernel/patch.h

diff --git a/arch/arm64/kernel/patch.c b/arch/arm64/kernel/patch.c
new file mode 100644
index 0000000..880742d
--- /dev/null
+++ b/arch/arm64/kernel/patch.c
@@ -0,0 +1,58 @@
+/*
+ * arch/arm64/kernel/patch.c
+ *
+ * Copyright (C) 2013 Linaro Limited.
+ * Based on arch/arm/kernel/patch.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/stop_machine.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+
+#include "patch.h"
+
+struct patch {
+	void *addr;
+	unsigned int insn;
+};
+
+/* Patching kernel text -AArch64 mode */
+void __kprobes __patch_text(void *addr, unsigned int insn)
+{
+	int size = sizeof(u32);
+
+	/* AArch64 32-bit alignment check */
+	if ((unsigned long)addr % size)
+		return;
+
+	/* little-endian mode: does it work for big-endian mode? */
+	*(u32 *) addr = insn;
+
+	flush_icache_range((uintptr_t) (addr), (uintptr_t) (addr) + size);
+}
+
+static int __kprobes patch_text_stop_machine(void *data)
+{
+	struct patch *patch = data;
+
+	__patch_text(patch->addr, patch->insn);
+	return 0;
+}
+
+void __kprobes patch_text(void *addr, unsigned int insn)
+{
+	struct patch patch = {
+		.addr = addr,
+		.insn = insn,
+	};
+	stop_machine(patch_text_stop_machine, &patch, cpu_online_mask);
+}
diff --git a/arch/arm64/kernel/patch.h b/arch/arm64/kernel/patch.h
new file mode 100644
index 0000000..e9d5e75
--- /dev/null
+++ b/arch/arm64/kernel/patch.h
@@ -0,0 +1,20 @@
+/*
+ * arch/arm/kernel/patch.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef _AARCH64_KERNEL_PATCH_H
+#define _AARCH64_KERNEL_PATCH_H
+
+void patch_text(void *addr, unsigned int insn);
+void __patch_text(void *addr, unsigned int insn);
+
+#endif /* _AARCH64_KERNEL_PATCH_H */
-- 
1.8.1.2
