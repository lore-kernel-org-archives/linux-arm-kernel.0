From: geoff@infradead.org (Geoff Levand)
Date: Mon, 19 Oct 2015 23:38:53 +0000
Subject: [PATCH 05/16] arm64: Add back cpu_reset routines
In-Reply-To: <cover.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
Message-ID: <fe7b51091769933f7a3b1a607b712e1275fb0db0.1445297709.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 68234df4ea7939f98431aa81113fbdce10c4a84b (arm64: kill flush_cache_all())
removed the global arm64 routines cpu_reset() and cpu_soft_restart() needed by
the arm64 kexec and kdump support.  Add those two routines back with some minor
simplifications in the new files cpu_reset.S, and cpu_reset.h.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/cpu-reset.S | 60 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu-reset.h | 18 +++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 arch/arm64/kernel/cpu-reset.S
 create mode 100644 arch/arm64/kernel/cpu-reset.h

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
new file mode 100644
index 0000000..64d9d7c
--- /dev/null
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -0,0 +1,60 @@
+/*
+ * cpu reset routines
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
+#include <linux/errno.h>
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/assembler.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative.h>
+
+.text
+.pushsection    .idmap.text, "ax"
+
+.align 5
+
+/*
+ * cpu_reset(addr) - Helper for cpu_soft_restart.
+ *
+ * @addr: Location to jump to for soft reset.
+ */
+
+ENTRY(cpu_reset)
+	mrs	x2, sctlr_el1
+	bic	x2, x2, #1
+	msr	sctlr_el1, x2			// disable the MMU
+	isb
+	ret	x0
+ENDPROC(cpu_reset)
+
+/*
+ * cpu_soft_restart(cpu_reset, addr) - Perform a cpu soft reset.
+ *
+ * @cpu_reset: Physical address of the cpu_reset routine.
+ * @addr: Location to jump to for soft reset, passed to cpu_reset.
+ */
+
+ENTRY(cpu_soft_restart)
+	mov	x19, x0				// cpu_reset
+	mov	x20, x1				// addr
+
+	/* Turn D-cache off */
+	mrs	x0, sctlr_el1
+	bic	x0, x0, #1 << 2			// clear SCTLR.C
+	msr	sctlr_el1, x0
+	isb
+
+	mov	x0, x20
+	ret	x19
+ENDPROC(cpu_soft_restart)
+
+.popsection
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
new file mode 100644
index 0000000..4e16dfe
--- /dev/null
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -0,0 +1,18 @@
+/*
+ * cpu reset routines
+ *
+ * Copyright (C) 2015 Huawei Futurewei Technologies.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#if !defined(_ARM64_CPU_RESET_H)
+#define _ARM64_CPU_RESET_H
+
+void __attribute__((noreturn)) cpu_reset(unsigned long addr);
+void __attribute__((noreturn)) cpu_soft_restart(phys_addr_t cpu_reset,
+	unsigned long addr);
+
+#endif
-- 
2.5.0
