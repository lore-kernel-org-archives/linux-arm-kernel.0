From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:17 +0100
Subject: [PATCH 04/17] ARM: vfp: Use cpu pm notifiers to save vfp state
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-5-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

When the cpu is powered down in a low power mode, the vfp
registers may be reset.

This patch uses CPU_PM_ENTER and CPU_PM_EXIT notifiers to save
and restore the cpu's vfp registers.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/vfp/vfpmodule.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index f25e7ec..6f08dbe 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -21,6 +21,7 @@
 #include <asm/cputype.h>
 #include <asm/thread_notify.h>
 #include <asm/vfp.h>
+#include <asm/cpu_pm.h>
 
 #include "vfpinstr.h"
 #include "vfp.h"
@@ -169,6 +170,44 @@ static struct notifier_block vfp_notifier_block = {
 	.notifier_call	= vfp_notifier,
 };
 
+#ifdef CONFIG_CPU_PM
+static int vfp_cpu_pm_notifier(struct notifier_block *self, unsigned long cmd,
+	void *v)
+{
+	u32 fpexc = fmrx(FPEXC);
+	unsigned int cpu = smp_processor_id();
+
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		if (last_VFP_context[cpu]) {
+			fmxr(FPEXC, fpexc | FPEXC_EN);
+			vfp_save_state(last_VFP_context[cpu], fpexc);
+			/* force a reload when coming back from idle */
+			last_VFP_context[cpu] = NULL;
+			fmxr(FPEXC, fpexc & ~FPEXC_EN);
+		}
+		break;
+	case CPU_PM_ENTER_FAILED:
+	case CPU_PM_EXIT:
+		/* make sure VFP is disabled when leaving idle */
+		fmxr(FPEXC, fpexc & ~FPEXC_EN);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block vfp_cpu_pm_notifier_block = {
+	.notifier_call = vfp_cpu_pm_notifier,
+};
+
+static void vfp_cpu_pm_init(void)
+{
+	cpu_pm_register_notifier(&vfp_cpu_pm_notifier_block);
+}
+#else
+static inline void vfp_cpu_pm_init(void) { }
+#endif
+
 /*
  * Raise a SIGFPE for the current process.
  * sicode describes the signal being raised.
@@ -563,6 +602,7 @@ static int __init vfp_init(void)
 		vfp_vector = vfp_support_entry;
 
 		thread_register_notifier(&vfp_notifier_block);
+		vfp_cpu_pm_init();
 		vfp_pm_init();
 
 		/*
-- 
1.7.4.4
