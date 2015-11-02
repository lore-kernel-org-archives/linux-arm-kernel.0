From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 3 Nov 2015 02:30:41 +0300
Subject: [PATCH v6 12/17] ilp32: common 32-bit wrappers
In-Reply-To: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1446507046-24604-13-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Dakinevich <jan.dakinevich@gmail.com>

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
Reviewed-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/kernel/Makefile         |  1 +
 arch/arm64/kernel/entry32-common.S | 37 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/entry32.S        | 29 -----------------------------
 3 files changed, 38 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm64/kernel/entry32-common.S

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 1470332..35a59af 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -24,6 +24,7 @@ arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
+arm64-obj-$(CONFIG_COMPAT)		+= entry32-common.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
diff --git a/arch/arm64/kernel/entry32-common.S b/arch/arm64/kernel/entry32-common.S
new file mode 100644
index 0000000..2ad5912
--- /dev/null
+++ b/arch/arm64/kernel/entry32-common.S
@@ -0,0 +1,37 @@
+#include <linux/linkage.h>
+#include <linux/const.h>
+
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/errno.h>
+#include <asm/page.h>
+
+ENTRY(compat_sys_statfs64_wrapper)
+	mov	w3, #84
+	cmp	w1, #88
+	csel	w1, w3, w1, eq
+	b	compat_sys_statfs64
+ENDPROC(compat_sys_statfs64_wrapper)
+
+ENTRY(compat_sys_fstatfs64_wrapper)
+	mov	w3, #84
+	cmp	w1, #88
+	csel	w1, w3, w1, eq
+	b	compat_sys_fstatfs64
+ENDPROC(compat_sys_fstatfs64_wrapper)
+
+/*
+ * Note: off_4k (w5) is always in units of 4K. If we can't do the
+ * requested offset because it is not page-aligned, we return -EINVAL.
+ */
+ENTRY(compat_sys_mmap2_wrapper)
+#if PAGE_SHIFT > 12
+	tst	w5, #~PAGE_MASK >> 12
+	b.ne	1f
+	lsr	w5, w5, #PAGE_SHIFT - 12
+#endif
+	b	sys_mmap_pgoff
+1:	mov	x0, #-EINVAL
+	ret
+ENDPROC(compat_sys_mmap2_wrapper)
+
diff --git a/arch/arm64/kernel/entry32.S b/arch/arm64/kernel/entry32.S
index f332d5d..8026129 100644
--- a/arch/arm64/kernel/entry32.S
+++ b/arch/arm64/kernel/entry32.S
@@ -40,35 +40,6 @@ ENTRY(compat_sys_rt_sigreturn_wrapper)
 	b	compat_sys_rt_sigreturn
 ENDPROC(compat_sys_rt_sigreturn_wrapper)
 
-ENTRY(compat_sys_statfs64_wrapper)
-	mov	w3, #84
-	cmp	w1, #88
-	csel	w1, w3, w1, eq
-	b	compat_sys_statfs64
-ENDPROC(compat_sys_statfs64_wrapper)
-
-ENTRY(compat_sys_fstatfs64_wrapper)
-	mov	w3, #84
-	cmp	w1, #88
-	csel	w1, w3, w1, eq
-	b	compat_sys_fstatfs64
-ENDPROC(compat_sys_fstatfs64_wrapper)
-
-/*
- * Note: off_4k (w5) is always in units of 4K. If we can't do the
- * requested offset because it is not page-aligned, we return -EINVAL.
- */
-ENTRY(compat_sys_mmap2_wrapper)
-#if PAGE_SHIFT > 12
-	tst	w5, #~PAGE_MASK >> 12
-	b.ne	1f
-	lsr	w5, w5, #PAGE_SHIFT - 12
-#endif
-	b	sys_mmap_pgoff
-1:	mov	x0, #-EINVAL
-	ret
-ENDPROC(compat_sys_mmap2_wrapper)
-
 /*
  * Wrappers for AArch32 syscalls that either take 64-bit parameters
  * in registers or that take 32-bit parameters which require sign
-- 
2.1.4
