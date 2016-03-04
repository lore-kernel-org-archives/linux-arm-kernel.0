From: geoff@infradead.org (Geoff Levand)
Date: Fri, 04 Mar 2016 23:51:14 +0000
Subject: [PATCH v14 09/20] arm64: Add back cpu_reset routines
In-Reply-To: <cover.1457135058.git.geoff@infradead.org>
References: <cover.1457135058.git.geoff@infradead.org>
Message-ID: <7d632f86b39e901930bdb7b2c4a95302a8a53921.1457135058.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 68234df4ea7939f98431aa81113fbdce10c4a84b (arm64: kill flush_cache_all())
removed the global arm64 routines cpu_reset() and cpu_soft_restart() needed by
the arm64 kexec and kdump support.  Add simplified versions of those two
routines back with some changes needed for kexec in the new files cpu_reset.S,
and cpu_reset.h.

When a CPU is reset it needs to be put into the exception level it had
when it entered the kernel. Update cpu_reset() to accept an argument
which signals if the reset address needs to be entered at EL1 or EL2.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/cpu-reset.S | 57 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu-reset.h | 29 ++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 arch/arm64/kernel/cpu-reset.S
 create mode 100644 arch/arm64/kernel/cpu-reset.h

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
new file mode 100644
index 0000000..f8d00d5
--- /dev/null
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -0,0 +1,57 @@
+/*
+ * CPU reset routines
+ *
+ * Copyright (C) 2001 Deep Blue Solutions Ltd.
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Huawei Futurewei Technologies.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/sysreg.h>
+#include <asm/virt.h>
+
+.text
+.pushsection    .idmap.text, "ax"
+
+/*
+ * __cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2) - Helper for
+ * cpu_soft_restart.
+ *
+ * @el2_switch: Flag to indicate a swich to EL2 is needed.
+ * @entry: Location to jump to for soft reset.
+ * arg0: First argument passed to @entry.
+ * arg1: Second argument passed to @entry.
+ * arg2: Third argument passed to @entry.
+ *
+ * Put the CPU into the same state as it would be if it had been reset, and
+ * branch to what would be the reset vector. It must be executed with the
+ * flat identity mapping.
+ */
+ENTRY(__cpu_soft_restart)
+	/* Clear sctlr_el1 flags. */
+	mrs	x12, sctlr_el1
+	ldr	x13, =SCTLR_ELx_FLAGS
+	bic	x12, x12, x13
+	msr	sctlr_el1, x12
+	isb
+
+	cbz	x0, 1f				// el2_switch?
+	mov	x0, x1				// entry
+	mov	x1, x2				// arg0
+	mov	x2, x3				// arg1
+	mov	x3, x4				// arg2
+	hvc	#HVC_CALL_FUNC			// no return
+
+1:	mov	x18, x1				// entry
+	mov	x0, x2				// arg0
+	mov	x1, x3				// arg1
+	mov	x2, x4				// arg2
+	ret	x18
+ENDPROC(__cpu_soft_restart)
+
+.popsection
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
new file mode 100644
index 0000000..5a5ea0a
--- /dev/null
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -0,0 +1,29 @@
+/*
+ * CPU reset routines
+ *
+ * Copyright (C) 2015 Huawei Futurewei Technologies.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ARM64_CPU_RESET_H
+#define _ARM64_CPU_RESET_H
+
+#include <asm/virt.h>
+
+void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
+	unsigned long arg0, unsigned long arg1, unsigned long arg2);
+
+static inline void __noreturn cpu_soft_restart(unsigned long el2_switch,
+	unsigned long entry, unsigned long arg0, unsigned long arg1,
+	unsigned long arg2)
+{
+	typeof(__cpu_soft_restart) *restart;
+	restart = (void *)virt_to_phys(__cpu_soft_restart);
+	restart(el2_switch, entry, arg0, arg1, arg2);
+	unreachable();
+}
+
+#endif
-- 
2.5.0
