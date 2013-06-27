From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 27 Jun 2013 08:09:33 +0200
Subject: [PATCH v2] arm64: add support for kernel mode NEON
Message-ID: <1372313373-30718-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add <asm/neon.h> containing kernel_neon_begin/kernel_neon_end function
declarations and corresponding definitions in fpsimd.c

These are needed to wrap uses of NEON in kernel mode. The names are
identical to the ones used in arm/ so code using intrinsics or
vectorized by GCC can be shared between arm and arm64.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Catalin,

Following a discussion with Will Deacon, I have switched back to just using
preempt_disable, which should spot any violations of the no-sleep rule in a
kernel_neon section in all configurations except non-PREEMPT combined with
!CONFIG_DEBUG_ATOMIC_SLEEP (which probably accounts for all production servers,
unfortunately)

-- 
Ard.

 arch/arm64/Kconfig            |  3 +++
 arch/arm64/include/asm/neon.h | 14 ++++++++++++++
 arch/arm64/kernel/fpsimd.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 arch/arm64/include/asm/neon.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 56b3f6d..46ba680 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -95,6 +95,9 @@ config SWIOTLB
 config IOMMU_HELPER
 	def_bool SWIOTLB
 
+config KERNEL_MODE_NEON
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm64/include/asm/neon.h b/arch/arm64/include/asm/neon.h
new file mode 100644
index 0000000..b0cc58a9
--- /dev/null
+++ b/arch/arm64/include/asm/neon.h
@@ -0,0 +1,14 @@
+/*
+ * linux/arch/arm64/include/asm/neon.h
+ *
+ * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define cpu_has_neon()		(1)
+
+void kernel_neon_begin(void);
+void kernel_neon_end(void);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e8b8357..07641c8 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -19,6 +19,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/preempt.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 
@@ -83,6 +84,37 @@ void fpsimd_flush_thread(void)
 	fpsimd_load_state(&current->thread.fpsimd_state);
 }
 
+#ifdef CONFIG_KERNEL_MODE_NEON
+
+/*
+ * Kernel-side NEON support functions
+ */
+void kernel_neon_begin(void)
+{
+	/*
+	 * Kernel mode NEON is only allowed outside of interrupt context
+	 * with preemption disabled. This will make sure that the kernel
+	 * mode NEON register contents never need to be preserved.
+	 */
+	BUG_ON(in_interrupt());
+	preempt_disable();
+
+	if (current->mm)
+		fpsimd_save_state(&current->thread.fpsimd_state);
+}
+EXPORT_SYMBOL(kernel_neon_begin);
+
+void kernel_neon_end(void)
+{
+	if (current->mm)
+		fpsimd_load_state(&current->thread.fpsimd_state);
+
+	preempt_enable();
+}
+EXPORT_SYMBOL(kernel_neon_end);
+
+#endif /* CONFIG_KERNEL_MODE_NEON */
+
 /*
  * FP/SIMD support code initialisation.
  */
-- 
1.8.1.2
