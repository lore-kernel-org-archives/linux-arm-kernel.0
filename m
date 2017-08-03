From: Dave.Martin@arm.com (Dave Martin)
Date: Thu,  3 Aug 2017 17:23:22 +0100
Subject: [PATCH 4/5] arm64: neon: Allow EFI runtime services to use FPSIMD in
 irq context
In-Reply-To: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
References: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1501777403-9782-5-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to cope with kernel-mode NEON being unavailable
in hardirq/nmi context and non-nestable, we need special handling
for EFI runtime service calls that may be made during an interrupt
that interrupted a kernel_neon_begin()..._end() block.  This will
occur if the kernel tries to write diagnostic data to EFI
persistent storage during a panic triggered by an NMI for example.

EFI runtime services specify an ABI that clobbers the FPSIMD state,
rather than being able to use it optionally as an accelerator.
This means that EFI is really a special case and can be handled
specially.

To enable EFI calls from interrupts, this patch creates dedicated
__efi_fpsimd_{begin,end}() helpers solely for this purpose, which
save/restore to a separate percpu buffer if called in a context
where kernel_neon_begin() is not usable.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/efi.h    |  5 ++--
 arch/arm64/include/asm/fpsimd.h |  4 ++++
 arch/arm64/kernel/fpsimd.c      | 52 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 8f3043a..8358222 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -3,6 +3,7 @@
 
 #include <asm/boot.h>
 #include <asm/cpufeature.h>
+#include <asm/fpsimd.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/neon.h>
@@ -20,8 +21,8 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define arch_efi_call_virt_setup()					\
 ({									\
-	kernel_neon_begin();						\
 	efi_virtmap_load();						\
+	__efi_fpsimd_begin();						\
 })
 
 #define arch_efi_call_virt(p, f, args...)				\
@@ -33,8 +34,8 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
+	__efi_fpsimd_end();						\
 	efi_virtmap_unload();						\
-	kernel_neon_end();						\
 })
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 50f559f..5155f21 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -81,6 +81,10 @@ extern void fpsimd_save_partial_state(struct fpsimd_partial_state *state,
 				      u32 num_regs);
 extern void fpsimd_load_partial_state(struct fpsimd_partial_state *state);
 
+/* For use by EFI runtime services calls only */
+extern void __efi_fpsimd_begin(void);
+extern void __efi_fpsimd_end(void);
+
 #endif
 
 #endif
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index d7e5f8a..bcde88e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -21,12 +21,15 @@
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/preempt.h>
 #include <linux/sched/signal.h>
 #include <linux/signal.h>
 #include <linux/hardirq.h>
 
 #include <asm/fpsimd.h>
 #include <asm/cputype.h>
+#include <asm/neon.h>
+#include <asm/simd.h>
 
 #define FPEXC_IOF	(1 << 0)
 #define FPEXC_DZF	(1 << 1)
@@ -276,6 +279,55 @@ void kernel_neon_end(void)
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
+DEFINE_PER_CPU(struct fpsimd_state, efi_fpsimd_state);
+DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
+
+/*
+ * EFI runtime services support functions
+ *
+ * The ABI for EFI runtime services allows EFI to use FPSIMD during the call.
+ * This means that for EFI (and only for EFI), we have to assume that FPSIMD
+ * is always used rather than being an optional accelerator.
+ *
+ * These functions provide the necessary support for ensuring FPSIMD
+ * save/restore in the contexts from which EFI is used.
+ *
+ * Do not use them for any other purpose -- if tempted to do so, you are
+ * either doing something wrong or you need to propose some refactoring.
+ */
+
+/*
+ * __efi_fpsimd_begin(): prepare FPSIMD for making an EFI runtime services call
+ */
+void __efi_fpsimd_begin(void)
+{
+	if (!system_supports_fpsimd())
+		return;
+
+	WARN_ON(preemptible());
+
+	if (may_use_simd())
+		kernel_neon_begin();
+	else {
+		fpsimd_save_state(this_cpu_ptr(&efi_fpsimd_state));
+		__this_cpu_write(efi_fpsimd_state_used, true);
+	}
+}
+
+/*
+ * __efi_fpsimd_end(): clean up FPSIMD after an EFI runtime services call
+ */
+void __efi_fpsimd_end(void)
+{
+	if (!system_supports_fpsimd())
+		return;
+
+	if (__this_cpu_xchg(efi_fpsimd_state_used, false))
+		fpsimd_load_state(this_cpu_ptr(&efi_fpsimd_state));
+	else
+		kernel_neon_end();
+}
+
 #endif /* CONFIG_KERNEL_MODE_NEON */
 
 #ifdef CONFIG_CPU_PM
-- 
2.1.4
