From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Sep 2011 17:16:06 +0800
Subject: [PATCH 4/6] arm/imx: remove cpu_is_xxx() from arch_idle()
In-Reply-To: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
References: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317201368-6403-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an idle hook imx_idle to be called in arch_idle().
Any soc that needs a customized idle implementation other than
cpu_do_idle() can set up this hook in soc specific call.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mm-imx3.c             |   30 ++++++++++++++++++++++++++
 arch/arm/mach-mx5/mm.c                  |    6 +++++
 arch/arm/mach-mx5/pm-imx5.c             |    3 +-
 arch/arm/plat-mxc/include/mach/common.h |    2 +
 arch/arm/plat-mxc/include/mach/system.h |   35 ++----------------------------
 arch/arm/plat-mxc/system.c              |    2 +
 6 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index ffa33b4..6fad0d6 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -30,6 +30,34 @@
 #include <mach/iomux-v3.h>
 #include <mach/irqs.h>
 
+static void imx3_idle(void)
+{
+	unsigned long reg = 0;
+	__asm__ __volatile__(
+		/* disable I and D cache */
+		"mrc p15, 0, %0, c1, c0, 0\n"
+		"bic %0, %0, #0x00001000\n"
+		"bic %0, %0, #0x00000004\n"
+		"mcr p15, 0, %0, c1, c0, 0\n"
+		/* invalidate I cache */
+		"mov %0, #0\n"
+		"mcr p15, 0, %0, c7, c5, 0\n"
+		/* clear and invalidate D cache */
+		"mov %0, #0\n"
+		"mcr p15, 0, %0, c7, c14, 0\n"
+		/* WFI */
+		"mov %0, #0\n"
+		"mcr p15, 0, %0, c7, c0, 4\n"
+		"nop\n" "nop\n" "nop\n" "nop\n"
+		"nop\n" "nop\n" "nop\n"
+		/* enable I and D cache */
+		"mrc p15, 0, %0, c1, c0, 0\n"
+		"orr %0, %0, #0x00001000\n"
+		"orr %0, %0, #0x00000004\n"
+		"mcr p15, 0, %0, c1, c0, 0\n"
+		: "=r" (reg));
+}
+
 void imx3_init_l2x0(void)
 {
 	void __iomem *l2x0_base;
@@ -98,6 +126,7 @@ void __init imx31_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX31);
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
+	imx_idle = imx3_idle;
 }
 
 void __init imx35_init_early(void)
@@ -105,6 +134,7 @@ void __init imx35_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX35);
 	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
+	imx_idle = imx3_idle;
 }
 
 void __init mx31_init_irq(void)
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index fb65339..26eacc9 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -21,6 +21,11 @@
 #include <mach/devices-common.h>
 #include <mach/iomux-v3.h>
 
+static void imx5_idle(void)
+{
+	mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+}
+
 /*
  * Define the MX50 memory map.
  */
@@ -84,6 +89,7 @@ void __init imx51_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX51);
 	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
+	imx_idle = imx5_idle;
 }
 
 void __init imx53_init_early(void)
diff --git a/arch/arm/mach-mx5/pm-imx5.c b/arch/arm/mach-mx5/pm-imx5.c
index be19e9c..98052fc 100644
--- a/arch/arm/mach-mx5/pm-imx5.c
+++ b/arch/arm/mach-mx5/pm-imx5.c
@@ -14,7 +14,8 @@
 #include <linux/err.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
-#include <mach/system.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
 #include "crm_regs.h"
 
 static struct clk *gpc_dvfs_clk;
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 318b995..245fb98 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -73,7 +73,9 @@ extern void mxc_arch_reset_init(void __iomem *);
 extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
+extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
 extern void imx_print_silicon_rev(const char *cpu, int srev);
+extern void (*imx_idle)(void);
 
 void avic_handle_irq(struct pt_regs *);
 void tzic_handle_irq(struct pt_regs *);
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index 51f02a9..cf88b35 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -17,41 +17,12 @@
 #ifndef __ASM_ARCH_MXC_SYSTEM_H__
 #define __ASM_ARCH_MXC_SYSTEM_H__
 
-#include <mach/hardware.h>
-#include <mach/common.h>
-
-extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
+extern void (*imx_idle)(void);
 
 static inline void arch_idle(void)
 {
-	/* fix i.MX31 errata TLSbo65953 and i.MX35 errata ENGcm09472 */
-	if (cpu_is_mx31() || cpu_is_mx35()) {
-		unsigned long reg = 0;
-		__asm__ __volatile__(
-			/* disable I and D cache */
-			"mrc p15, 0, %0, c1, c0, 0\n"
-			"bic %0, %0, #0x00001000\n"
-			"bic %0, %0, #0x00000004\n"
-			"mcr p15, 0, %0, c1, c0, 0\n"
-			/* invalidate I cache */
-			"mov %0, #0\n"
-			"mcr p15, 0, %0, c7, c5, 0\n"
-			/* clear and invalidate D cache */
-			"mov %0, #0\n"
-			"mcr p15, 0, %0, c7, c14, 0\n"
-			/* WFI */
-			"mov %0, #0\n"
-			"mcr p15, 0, %0, c7, c0, 4\n"
-			"nop\n" "nop\n" "nop\n" "nop\n"
-			"nop\n" "nop\n" "nop\n"
-			/* enable I and D cache */
-			"mrc p15, 0, %0, c1, c0, 0\n"
-			"orr %0, %0, #0x00001000\n"
-			"orr %0, %0, #0x00000004\n"
-			"mcr p15, 0, %0, c1, c0, 0\n"
-			: "=r" (reg));
-	} else if (cpu_is_mx51())
-		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+	if (imx_idle != NULL)
+		(imx_idle)();
 	else
 		cpu_do_idle();
 }
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 8024f2a..5fa03e7 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -28,6 +28,8 @@
 #include <asm/system.h>
 #include <asm/mach-types.h>
 
+void (*imx_idle)(void) = NULL;
+
 static void __iomem *wdog_base;
 
 /*
-- 
1.7.4.1
