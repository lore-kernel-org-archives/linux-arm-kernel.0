From: j-keerthy@ti.com (Keerthy)
Date: Wed, 16 May 2018 20:46:59 +0530
Subject: [PATCH 2/4] omap2: clockdomain: Inroduce cpu_pm notifiers for context
 save/restore
In-Reply-To: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
References: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1526483821-25585-3-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inroduce cpu_pm notifiers for context save/restore. This will be
needed for am43xx family in case of rtc only mode with ddr in
self-refresh.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 0906380..6d44fe0 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -23,6 +23,7 @@
 #include <linux/limits.h>
 #include <linux/err.h>
 #include <linux/clk-provider.h>
+#include <linux/cpu_pm.h>
 
 #include <linux/io.h>
 
@@ -31,6 +32,7 @@
 #include "soc.h"
 #include "clock.h"
 #include "clockdomain.h"
+#include "pm.h"
 
 /* clkdm_list contains all registered struct clockdomains */
 static LIST_HEAD(clkdm_list);
@@ -39,6 +41,8 @@
 static struct clkdm_autodep *autodeps;
 
 static struct clkdm_ops *arch_clkdm;
+void clkdm_save_context(void);
+void clkdm_restore_context(void);
 
 /* Private functions */
 
@@ -449,6 +453,22 @@ int clkdm_register_autodeps(struct clkdm_autodep *ia)
 	return 0;
 }
 
+static int cpu_notifier(struct notifier_block *nb, unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if (enable_off_mode)
+			clkdm_save_context();
+		break;
+	case CPU_CLUSTER_PM_EXIT:
+		if (enable_off_mode)
+			clkdm_restore_context();
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 /**
  * clkdm_complete_init - set up the clockdomain layer
  *
@@ -460,6 +480,7 @@ int clkdm_register_autodeps(struct clkdm_autodep *ia)
 int clkdm_complete_init(void)
 {
 	struct clockdomain *clkdm;
+	static struct notifier_block nb;
 
 	if (list_empty(&clkdm_list))
 		return -EACCES;
@@ -474,6 +495,12 @@ int clkdm_complete_init(void)
 		clkdm_clear_all_sleepdeps(clkdm);
 	}
 
+	/* Only AM43XX can lose clkdm context during rtc-ddr suspend */
+	if (soc_is_am43xx()) {
+		nb.notifier_call = cpu_notifier;
+		cpu_pm_register_notifier(&nb);
+	}
+
 	return 0;
 }
 
-- 
1.9.1
