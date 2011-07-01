From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Jul 2011 10:57:36 +0900
Subject: [PATCH V2 7/8] ARM: EXYNOS4: Add save/restore for other ARM registers
In-Reply-To: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
References: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1309485457-13305-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

This patch adds save/restore values for Power Control Register and
Diagnostic Register for PM.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/pm.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index a658318..4130e5a 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -238,6 +238,9 @@ static struct sleep_save exynos4_l2cc_save[] = {
 	SAVE_ITEM(S5P_VA_L2CC + L2X0_AUX_CTRL),
 };
 
+/* For Cortex-A9 Diagnostic and Power control register */
+static unsigned int save_arm_register[2];
+
 void exynos4_cpu_suspend(unsigned long arg)
 {
 	outer_flush_all();
@@ -329,6 +332,16 @@ static int exynos4_pm_suspend(void)
 	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
 	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
 
+	/* Save Power control register */
+	asm ("mrc p15, 0, %0, c15, c0, 0"
+	     : "=r" (tmp) : : "cc");
+	save_arm_register[0] = tmp;
+
+	/* Save Diagnostic register */
+	asm ("mrc p15, 0, %0, c15, c0, 1"
+	     : "=r" (tmp) : : "cc");
+	save_arm_register[1] = tmp;
+
 	return 0;
 }
 
@@ -349,6 +362,17 @@ static void exynos4_pm_resume(void)
 		/* No need to perform below restore code */
 		goto early_wakeup;
 	}
+	/* Restore Power control register */
+	tmp = save_arm_register[0];
+	asm volatile ("mcr p15, 0, %0, c15, c0, 0"
+		      : : "r" (tmp)
+		      : "cc");
+
+	/* Restore Diagnostic register */
+	tmp = save_arm_register[1];
+	asm volatile ("mcr p15, 0, %0, c15, c0, 1"
+		      : : "r" (tmp)
+		      : "cc");
 
 	/* For release retention */
 
-- 
1.7.1
