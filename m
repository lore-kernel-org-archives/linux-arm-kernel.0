From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 14 Aug 2011 01:55:05 +0200
Subject: [PATCH] shmobile/sh7372: Add missing CONFIG_PM guards to fix
	build failure
In-Reply-To: <1313274841-8322-1-git-send-email-peterhuewe@gmx.de>
References: <1313274841-8322-1-git-send-email-peterhuewe@gmx.de>
Message-ID: <201108140155.05625.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, August 14, 2011, Peter Huewe wrote:
> This patch fixes a build failure with the ap4evb_defconfig by adding the
> missing #ifdef CONFIG_PM.

This is not the right fix.  Besides, you seem to be testing linux-next
and the build problem is in the linux-pm tree.

Please check if the appended patch fixes the problem for you.

Rafael

---
 arch/arm/mach-shmobile/include/mach/sh7372.h |    3 +++
 arch/arm/mach-shmobile/pm-sh7372.c           |    6 ++++++
 arch/arm/mach-shmobile/setup-sh7372.c        |    2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

Index: linux/arch/arm/mach-shmobile/include/mach/sh7372.h
===================================================================
--- linux.orig/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ linux/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -494,9 +494,12 @@ extern struct sh7372_pm_domain sh7372_a3
 extern void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd);
 extern void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
 					struct platform_device *pdev);
+extern void sh7372_pm_add_subdomain(struct sh7372_pm_domain *sh7372_pd,
+				    struct sh7372_pm_domain *sh7372_sd);
 #else
 #define sh7372_init_pm_domain(pd) do { } while(0)
 #define sh7372_add_device_to_domain(pd, pdev) do { } while(0)
+#define sh7372_pm_add_subdomain(pd, sd) do { } while(0)
 #endif /* CONFIG_PM */
 
 #endif /* __ASM_SH7372_H__ */
Index: linux/arch/arm/mach-shmobile/setup-sh7372.c
===================================================================
--- linux.orig/arch/arm/mach-shmobile/setup-sh7372.c
+++ linux/arch/arm/mach-shmobile/setup-sh7372.c
@@ -849,7 +849,7 @@ void __init sh7372_add_standard_devices(
 	sh7372_init_pm_domain(&sh7372_a3ri);
 	sh7372_init_pm_domain(&sh7372_a3sg);
 
-	pm_genpd_add_subdomain(&sh7372_a4lc.genpd, &sh7372_a3rv.genpd);
+	sh7372_pm_add_subdomain(&sh7372_a4lc, &sh7372_a3rv);
 
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
===================================================================
--- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux/arch/arm/mach-shmobile/pm-sh7372.c
@@ -119,6 +119,12 @@ void sh7372_add_device_to_domain(struct
 		pm_clk_add(dev, NULL);
 }
 
+void sh7372_pm_add_subdomain(struct sh7372_pm_domain *sh7372_pd,
+			     struct sh7372_pm_domain *sh7372_sd)
+{
+	pm_genpd_add_subdomain(&sh7372_pd->genpd, &sh7372_sd->genpd);
+}
+
 struct sh7372_pm_domain sh7372_a4lc = {
 	.bit_shift = 1,
 };
