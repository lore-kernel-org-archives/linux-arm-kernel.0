From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:36 +0900
Subject: [PATCH 5/9] ARM: shmobile: Cleanup pm-rmobile.o build using Kconfig
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
Message-ID: <abebbc4a026d8cdceb9f65c497b3db445c8ff5e7.1409792454.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a CONFIG_PM_RMOBILE entry and enable it for R-Mobile
SoCs in case CONFIG_PM is set. Consolidate Makefile power
management objects and get rid of #ifdefs in the C code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig      |  4 ++++
 arch/arm/mach-shmobile/Makefile     | 14 ++++++--------
 arch/arm/mach-shmobile/pm-rmobile.c |  2 --
 arch/arm/mach-shmobile/pm-rmobile.h |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index cd13021..9295776 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -4,6 +4,9 @@ config ARCH_SHMOBILE
 config PM_RCAR
 	bool
 
+config PM_RMOBILE
+	bool
+
 config ARCH_RCAR_GEN1
 	bool
 	select PM_RCAR if PM || SMP
@@ -18,6 +21,7 @@ config ARCH_RCAR_GEN2
 
 config ARCH_RMOBILE
 	bool
+	select PM_RMOBILE if PM
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index c9ad169..7b259ce 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -8,10 +8,10 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/incl
 obj-y				:= timer.o console.o
 
 # CPU objects
-obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o
-obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o
+obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o pm-sh7372.o
+obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
-obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o pm-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o pm-r8a7790.o
@@ -52,12 +52,10 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
-obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
-obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
-obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
+obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 
-# IRQ objects
-obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
+# special sh7372 handling for IRQ objects and low level sleep code
+obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o sleep-sh7372.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index ebdd16e..a88079a 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -27,7 +27,6 @@
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
 
-#ifdef CONFIG_PM
 static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 {
 	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
@@ -151,4 +150,3 @@ void rmobile_add_devices_to_domains(struct pm_domain_device data[],
 		rmobile_add_device_to_domain_td(data[j].domain_name,
 						data[j].pdev, &latencies);
 }
-#endif /* CONFIG_PM */
diff --git a/arch/arm/mach-shmobile/pm-rmobile.h b/arch/arm/mach-shmobile/pm-rmobile.h
index 690553a..8f66b34 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.h
+++ b/arch/arm/mach-shmobile/pm-rmobile.h
@@ -36,7 +36,7 @@ struct pm_domain_device {
 	struct platform_device *pdev;
 };
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_RMOBILE
 extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
 extern void rmobile_add_device_to_domain_td(const char *domain_name,
 					    struct platform_device *pdev,
@@ -58,6 +58,6 @@ extern void rmobile_add_devices_to_domains(struct pm_domain_device data[],
 
 static inline void rmobile_add_devices_to_domains(struct pm_domain_device d[],
 						  int size) {}
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_RMOBILE */
 
 #endif /* PM_RMOBILE_H */
-- 
2.0.1
