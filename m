From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:34 -0800
Subject: [RFC 15/18] arm: vfp: Add additional vfp interfaces
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-16-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Estes <cestes@quicinc.com>

Refactor common code to vfp_flush_context() and vfp_reinit().  Allow
use by other client beside suspend/resume.  Currently intended for
idle power collapse.

Signed-off-by: Dave Estes <cestes@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/include/asm/vfp.h |    6 ++++++
 arch/arm/vfp/vfpmodule.c   |   37 ++++++++++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
index f4ab34f..ea2e3ac 100644
--- a/arch/arm/include/asm/vfp.h
+++ b/arch/arm/include/asm/vfp.h
@@ -82,3 +82,9 @@
 #define VFPOPDESC_UNUSED_BIT	(24)
 #define VFPOPDESC_UNUSED_MASK	(0xFF << VFPOPDESC_UNUSED_BIT)
 #define VFPOPDESC_OPDESC_MASK	(~(VFPOPDESC_LENGTH_MASK | VFPOPDESC_UNUSED_MASK))
+
+#ifndef __ASSEMBLY__
+int vfp_flush_context(void);
+void vfp_reinit(void);
+#endif
+
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index f60a540..c3a088c 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -370,13 +370,12 @@ static void vfp_enable(void *unused)
 	set_copro_access(access | CPACC_FULL(10) | CPACC_FULL(11));
 }
 
-#ifdef CONFIG_PM
-#include <linux/sysdev.h>
-
-static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
+int vfp_flush_context(void)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 fpexc = fmrx(FPEXC);
+	u32 cpu = ti->cpu;
+	int saved = 0;
 
 	/* if vfp is on, then save state for resumption */
 	if (fpexc & FPEXC_EN) {
@@ -385,7 +384,31 @@ static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
 
 		/* disable, just in case */
 		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+
+		last_VFP_context[cpu] = NULL;
+		saved = 1;
 	}
+	return saved;
+}
+
+void vfp_reinit(void)
+{
+	/* ensure we have access to the vfp */
+	vfp_enable(NULL);
+
+	/* and disable it to ensure the next usage restores the state */
+	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+}
+
+#ifdef CONFIG_PM
+#include <linux/sysdev.h>
+
+static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
+{
+	int saved = vfp_flush_context();
+
+	if (saved)
+		printk(KERN_DEBUG "%s: saved vfp state\n", __func__);
 
 	/* clear any information we had about last context state */
 	memset(last_VFP_context, 0, sizeof(last_VFP_context));
@@ -395,11 +418,7 @@ static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
 
 static int vfp_pm_resume(struct sys_device *dev)
 {
-	/* ensure we have access to the vfp */
-	vfp_enable(NULL);
-
-	/* and disable it to ensure the next usage restores the state */
-	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+	vfp_reinit();
 
 	return 0;
 }
-- 
1.6.3.3
