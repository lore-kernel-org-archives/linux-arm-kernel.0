From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:40 -0500
Subject: [PATCH 11/20] ARM: plat-mxc: hook special idle handlers to arm_pm_idle
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-12-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... and remove redundant include of <mach/system.h>.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-imx/mm-imx3.c             |    4 ++--
 arch/arm/mach-imx/pm-imx27.c            |    3 +--
 arch/arm/mach-mx5/mm.c                  |    2 +-
 arch/arm/mach-mxs/pm.c                  |    3 +--
 arch/arm/plat-mxc/include/mach/common.h |    1 -
 arch/arm/plat-mxc/include/mach/system.h |    7 +------
 arch/arm/plat-mxc/system.c              |    1 -
 7 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 9f0e82ec33..e7a14396b2 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -143,8 +143,8 @@ void __init imx31_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX31);
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
-	imx_idle = imx3_idle;
 	imx_ioremap = imx3_ioremap;
+	arm_pm_idle = imx3_idle;
 }
 
 void __init imx35_init_early(void)
@@ -152,8 +152,8 @@ void __init imx35_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX35);
 	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
-	imx_idle = imx3_idle;
 	imx_ioremap = imx3_ioremap;
+	arm_pm_idle = imx3_idle;
 }
 
 void __init mx31_init_irq(void)
diff --git a/arch/arm/mach-imx/pm-imx27.c b/arch/arm/mach-imx/pm-imx27.c
index e455d2f855..6fcffa7db9 100644
--- a/arch/arm/mach-imx/pm-imx27.c
+++ b/arch/arm/mach-imx/pm-imx27.c
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/suspend.h>
 #include <linux/io.h>
-#include <mach/system.h>
 #include <mach/hardware.h>
 
 static int mx27_suspend_enter(suspend_state_t state)
@@ -23,7 +22,7 @@ static int mx27_suspend_enter(suspend_state_t state)
 		cscr &= 0xFFFFFFFC;
 		__raw_writel(cscr, MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
 		/* Executes WFI */
-		arch_idle();
+		cpu_do_idle();
 		break;
 
 	default:
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 26eacc9d0d..65139a60a4 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -89,7 +89,7 @@ void __init imx51_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX51);
 	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
-	imx_idle = imx5_idle;
+	arm_pm_idle = imx5_idle;
 }
 
 void __init imx53_init_early(void)
diff --git a/arch/arm/mach-mxs/pm.c b/arch/arm/mach-mxs/pm.c
index fb042da29b..a9b4bbcdaf 100644
--- a/arch/arm/mach-mxs/pm.c
+++ b/arch/arm/mach-mxs/pm.c
@@ -15,13 +15,12 @@
 #include <linux/kernel.h>
 #include <linux/suspend.h>
 #include <linux/io.h>
-#include <mach/system.h>
 
 static int mxs_suspend_enter(suspend_state_t state)
 {
 	switch (state) {
 	case PM_SUSPEND_MEM:
-		arch_idle();
+		cpu_do_idle();
 		break;
 
 	default:
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 4ee98d56df..ca04e7d6ae 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -85,7 +85,6 @@ enum mxc_cpu_pwr_mode {
 };
 
 extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
-extern void (*imx_idle)(void);
 extern void imx_print_silicon_rev(const char *cpu, int srev);
 
 void avic_handle_irq(struct pt_regs *);
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index b9c71b4090..13ad0df2e8 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -17,14 +17,9 @@
 #ifndef __ASM_ARCH_MXC_SYSTEM_H__
 #define __ASM_ARCH_MXC_SYSTEM_H__
 
-extern void (*imx_idle)(void);
-
 static inline void arch_idle(void)
 {
-	if (imx_idle != NULL)
-		(imx_idle)();
-	else
-		cpu_do_idle();
+	cpu_do_idle();
 }
 
 #endif /* __ASM_ARCH_MXC_SYSTEM_H__ */
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 80de9e24d4..e8f4a5c390 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -28,7 +28,6 @@
 #include <asm/system.h>
 #include <asm/mach-types.h>
 
-void (*imx_idle)(void) = NULL;
 void __iomem *(*imx_ioremap)(unsigned long, size_t, unsigned int) = NULL;
 
 static void __iomem *wdog_base;
-- 
1.7.7.1.431.g10b2a
