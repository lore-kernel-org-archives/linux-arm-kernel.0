From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 06 Nov 2012 11:42:33 +0530
Subject: [PATCH 2/5] ARM: EXYNOS5: Add support for rtc wakeup
In-Reply-To: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
References: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1352182356-28989-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Inderpal Singh <inderpal.singh@samsung.com>

Set the gic arch extension callback to support rtc wakeup.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Inderpal Singh <inderpal.singh@samsung.com>
---
 arch/arm/mach-exynos/common.c           |    2 ++
 arch/arm/plat-samsung/include/plat/pm.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 4e577f6..300c40f 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -631,6 +631,8 @@ void __init exynos5_init_irq(void)
 	 * uses GIC instead of VIC.
 	 */
 	s5p_init_irq(NULL, 0);
+
+	gic_arch_extn.irq_set_wake = s3c_irq_wake;
 }
 
 struct bus_type exynos_subsys = {
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 61fc537..887a0c9 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -107,10 +107,12 @@ extern void s3c_pm_do_restore(struct sleep_save *ptr, int count);
 extern void s3c_pm_do_restore_core(struct sleep_save *ptr, int count);
 
 #ifdef CONFIG_PM
+extern int s3c_irq_wake(struct irq_data *data, unsigned int state);
 extern int s3c_irqext_wake(struct irq_data *data, unsigned int state);
 extern int s3c24xx_irq_suspend(void);
 extern void s3c24xx_irq_resume(void);
 #else
+#define s3c_irq_wake NULL
 #define s3c_irqext_wake NULL
 #define s3c24xx_irq_suspend NULL
 #define s3c24xx_irq_resume  NULL
-- 
1.6.6.1
