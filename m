From: ccross@android.com (Colin Cross)
Date: Thu, 10 Feb 2011 13:31:27 -0800
Subject: [RFC PATCH 3/3] ARM: vfp: Use cpu pm notifiers to save vfp state
In-Reply-To: <1297373487-23902-1-git-send-email-ccross@android.com>
References: <1297373487-23902-1-git-send-email-ccross@android.com>
Message-ID: <1297373487-23902-4-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/vfp/vfpmodule.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 0797cb5..8b27c18 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -21,6 +21,7 @@
 #include <asm/cputype.h>
 #include <asm/thread_notify.h>
 #include <asm/vfp.h>
+#include <asm/cpu_pm.h>
 
 #include "vfpinstr.h"
 #include "vfp.h"
@@ -149,6 +150,28 @@ static struct notifier_block vfp_notifier_block = {
 	.notifier_call	= vfp_notifier,
 };
 
+static int vfp_idle_notifier(struct notifier_block *self, unsigned long cmd,
+	void *v)
+{
+	u32 fpexc = fmrx(FPEXC);
+	unsigned int cpu = smp_processor_id();
+
+	if (cmd != CPU_PM_ENTER)
+		return NOTIFY_OK;
+
+	/* The VFP may be reset in idle, save the state */
+	if ((fpexc & FPEXC_EN) && last_VFP_context[cpu]) {
+		vfp_save_state(last_VFP_context[cpu], fpexc);
+		last_VFP_context[cpu]->hard.cpu = cpu;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block vfp_idle_notifier_block = {
+	.notifier_call = vfp_idle_notifier,
+};
+
 /*
  * Raise a SIGFPE for the current process.
  * sicode describes the signal being raised.
@@ -549,6 +572,7 @@ static int __init vfp_init(void)
 		vfp_vector = vfp_support_entry;
 
 		thread_register_notifier(&vfp_notifier_block);
+		cpu_pm_register_notifier(&vfp_idle_notifier_block);
 		vfp_pm_init();
 
 		/*
-- 
1.7.3.1
