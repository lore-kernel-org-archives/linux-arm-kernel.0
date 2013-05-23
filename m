From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 23 May 2013 09:28:23 +0200
Subject: [PATCH 1/2] ARM: add support for kernel mode NEON/VFP
Message-ID: <1369294104-3849-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to safely support the use of NEON or VFP instructions in
kernel mode, some precautions need to be taken:
- the userland context that may be present in the registers (even
  if the NEON/VFP is currently disabled) must be stored under the
  correct task (which may not be 'current' in the UP case),
- to avoid having to keep track of additional vfpstates for the
  kernel side, disallow the use of NEON/VFP in interrupt context
  and run with preemption disabled,
- after use, re-enable preemption and re-enable the lazy restore
  machinery by disabling the NEON/VFP unit.

This patch adds the functions kernel_vfp_begin() and kernel_vfp_end()
which take care of the above.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/vfp.h |  5 +++++
 arch/arm/vfp/vfpmodule.c   | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
index f4ab34f..a488876 100644
--- a/arch/arm/include/asm/vfp.h
+++ b/arch/arm/include/asm/vfp.h
@@ -82,3 +82,8 @@
 #define VFPOPDESC_UNUSED_BIT	(24)
 #define VFPOPDESC_UNUSED_MASK	(0xFF << VFPOPDESC_UNUSED_BIT)
 #define VFPOPDESC_OPDESC_MASK	(~(VFPOPDESC_LENGTH_MASK | VFPOPDESC_UNUSED_MASK))
+
+#ifndef __ASSEMBLY__
+void kernel_vfp_begin(void);
+void kernel_vfp_end(void);
+#endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 5dfbb0b..ab1eeae 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/uaccess.h>
 #include <linux/user.h>
+#include <linux/export.h>
 
 #include <asm/cp15.h>
 #include <asm/cputype.h>
@@ -649,6 +650,44 @@ static int vfp_hotplug(struct notifier_block *b, unsigned long action,
 }
 
 /*
+ * Kernel-side NEON/VFP support functions
+ */
+void kernel_vfp_begin(void)
+{
+	struct thread_info *thread = current_thread_info();
+	unsigned int cpu;
+	u32 fpexc;
+
+	/* Avoid using the NEON/VFP in interrupt context */
+	might_sleep();
+	cpu = get_cpu();
+
+	fpexc = fmrx(FPEXC) | FPEXC_EN;
+	fmxr(FPEXC, fpexc);
+
+	/*
+	 * Save the userland NEON/VFP state. Under UP, the owner could be a task
+	 * other than 'current'
+	 */
+	if (vfp_state_in_hw(cpu, thread))
+		vfp_save_state(&thread->vfpstate, fpexc);
+#ifndef CONFIG_SMP
+	else if (vfp_current_hw_state[cpu] != NULL)
+		vfp_save_state(vfp_current_hw_state[cpu], fpexc);
+#endif
+	vfp_current_hw_state[cpu] = NULL;
+}
+EXPORT_SYMBOL(kernel_vfp_begin);
+
+void kernel_vfp_end(void)
+{
+	/* Disable the NEON/VFP unit. */
+	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+	put_cpu();
+}
+EXPORT_SYMBOL(kernel_vfp_end);
+
+/*
  * VFP support code initialisation.
  */
 static int __init vfp_init(void)
-- 
1.8.1.2
