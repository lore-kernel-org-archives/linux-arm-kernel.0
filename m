From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Nov 2011 13:09:18 +0800
Subject: [PATCH] arm/imx: remove imx_idle hook and use pm_idle instead
Message-ID: <1320988158-9409-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch removes imx_idle hook and use pm_idle instead to get imx
arch_idle prepared for the cleanup.  It's suggested by Russel King
as below.

> The final removal of mach/system.h depends on getting rid of the arch_idle
> thing.  While going through these headers, I was dismayed to find these:
>
> arch/arm/mach-s3c2410/include/mach/system.h:void (*s3c24xx_idle)(void);
> arch/arm/plat-mxc/include/mach/system.h:extern void (*imx_idle)(void);
>
> when we have a perfectly good pm_idle hook already in place - so there's
> no excuse for these especially when other platforms are already using
> pm_idle to hook their platform specific idle function into.  This is
> something that better be gone at the next merge window!

Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mm-imx3.c             |   53 ++++++++++++++++--------------
 arch/arm/mach-mx5/mm.c                  |    6 ++-
 arch/arm/plat-mxc/include/mach/common.h |    1 -
 arch/arm/plat-mxc/include/mach/system.h |    7 +---
 arch/arm/plat-mxc/system.c              |    1 -
 5 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 9f0e82e..6d01de3 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -33,29 +33,32 @@
 static void imx3_idle(void)
 {
 	unsigned long reg = 0;
-	__asm__ __volatile__(
-		/* disable I and D cache */
-		"mrc p15, 0, %0, c1, c0, 0\n"
-		"bic %0, %0, #0x00001000\n"
-		"bic %0, %0, #0x00000004\n"
-		"mcr p15, 0, %0, c1, c0, 0\n"
-		/* invalidate I cache */
-		"mov %0, #0\n"
-		"mcr p15, 0, %0, c7, c5, 0\n"
-		/* clear and invalidate D cache */
-		"mov %0, #0\n"
-		"mcr p15, 0, %0, c7, c14, 0\n"
-		/* WFI */
-		"mov %0, #0\n"
-		"mcr p15, 0, %0, c7, c0, 4\n"
-		"nop\n" "nop\n" "nop\n" "nop\n"
-		"nop\n" "nop\n" "nop\n"
-		/* enable I and D cache */
-		"mrc p15, 0, %0, c1, c0, 0\n"
-		"orr %0, %0, #0x00001000\n"
-		"orr %0, %0, #0x00000004\n"
-		"mcr p15, 0, %0, c1, c0, 0\n"
-		: "=r" (reg));
+
+	if (!need_resched())
+		__asm__ __volatile__(
+			/* disable I and D cache */
+			"mrc p15, 0, %0, c1, c0, 0\n"
+			"bic %0, %0, #0x00001000\n"
+			"bic %0, %0, #0x00000004\n"
+			"mcr p15, 0, %0, c1, c0, 0\n"
+			/* invalidate I cache */
+			"mov %0, #0\n"
+			"mcr p15, 0, %0, c7, c5, 0\n"
+			/* clear and invalidate D cache */
+			"mov %0, #0\n"
+			"mcr p15, 0, %0, c7, c14, 0\n"
+			/* WFI */
+			"mov %0, #0\n"
+			"mcr p15, 0, %0, c7, c0, 4\n"
+			"nop\n" "nop\n" "nop\n" "nop\n"
+			"nop\n" "nop\n" "nop\n"
+			/* enable I and D cache */
+			"mrc p15, 0, %0, c1, c0, 0\n"
+			"orr %0, %0, #0x00001000\n"
+			"orr %0, %0, #0x00000004\n"
+			"mcr p15, 0, %0, c1, c0, 0\n"
+			: "=r" (reg));
+	local_irq_enable();
 }
 
 static void __iomem *imx3_ioremap(unsigned long phys_addr, size_t size,
@@ -143,7 +146,7 @@ void __init imx31_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX31);
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
-	imx_idle = imx3_idle;
+	pm_idle = imx3_idle;
 	imx_ioremap = imx3_ioremap;
 }
 
@@ -152,7 +155,7 @@ void __init imx35_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX35);
 	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
-	imx_idle = imx3_idle;
+	pm_idle = imx3_idle;
 	imx_ioremap = imx3_ioremap;
 }
 
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 26eacc9..df4a508f 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -23,7 +23,9 @@
 
 static void imx5_idle(void)
 {
-	mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+	if (!need_resched())
+		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+	local_irq_enable();
 }
 
 /*
@@ -89,7 +91,7 @@ void __init imx51_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX51);
 	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
-	imx_idle = imx5_idle;
+	pm_idle = imx5_idle;
 }
 
 void __init imx53_init_early(void)
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 83b745a..7143d52 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -85,7 +85,6 @@ enum mxc_cpu_pwr_mode {
 };
 
 extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
-extern void (*imx_idle)(void);
 extern void imx_print_silicon_rev(const char *cpu, int srev);
 
 void avic_handle_irq(struct pt_regs *);
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index cf88b35..b9895d2 100644
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
 
 void arch_reset(char mode, const char *cmd);
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 9dad8dc..a0bcccf 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -28,7 +28,6 @@
 #include <asm/system.h>
 #include <asm/mach-types.h>
 
-void (*imx_idle)(void) = NULL;
 void __iomem *(*imx_ioremap)(unsigned long, size_t, unsigned int) = NULL;
 
 static void __iomem *wdog_base;
-- 
1.7.4.1
