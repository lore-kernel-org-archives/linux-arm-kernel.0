From: sgoel@codeaurora.org (Sameer Goel)
Date: Wed, 18 Apr 2018 20:19:36 -0600
Subject: [PATCH] arm64: kexec: Add machine_kexec_mask_interrupts to kexec path
Message-ID: <1524104376-21902-1-git-send-email-sgoel@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In kdump code path SPIs at GIC level are explicitly cleared by
calling machine_kexec_mask_interrupts. In case of kexec this
functionality is delegated for most part to the device shutdown
functions.
Add machine_kexec_mask_interrupts to machine_shutdown path to
ensure that the irqs are masked at the gic level.

Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
---
Porting code for masking irqs at gic from kdump shutdown to kexec path.

There was discussion about this functionality in [1].

[1] https://patchwork.kernel.org/patch/9817499/

 arch/arm64/include/asm/kexec.h    | 6 ++++++
 arch/arm64/kernel/machine_kexec.c | 2 +-
 arch/arm64/kernel/process.c       | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index e17f052..f9ddb41 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -93,6 +93,12 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#if defined(CONFIG_KEXEC)
+extern void machine_kexec_mask_interrupts(void);
+#else
+static inline void machine_kexec_mask_interrupts(void) {}
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f76ea92..b453180 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -213,7 +213,7 @@ void machine_kexec(struct kimage *kimage)
 	BUG(); /* Should never get here. */
 }
 
-static void machine_kexec_mask_interrupts(void)
+void machine_kexec_mask_interrupts(void)
 {
 	unsigned int i;
 	struct irq_desc *desc;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f08a2ed..9d0337e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -58,6 +58,7 @@
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
+#include <asm/kexec.h>
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -107,6 +108,7 @@ void arch_cpu_idle_dead(void)
 void machine_shutdown(void)
 {
 	disable_nonboot_cpus();
+	machine_kexec_mask_interrupts();
 }
 
 /*
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
