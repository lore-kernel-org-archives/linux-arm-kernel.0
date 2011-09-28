From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Sep 2011 17:16:07 +0800
Subject: [PATCH 5/6] arm/imx: remove cpu_is_xxx() check from __imx_ioremap()
In-Reply-To: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
References: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317201368-6403-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an ioremap hook imx_ioremap to be called in
__imx_ioremap().  Any soc that needs a customized ioremap other
than __arm_ioremap() can set up this hook in soc specific call.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mm-imx3.c         |   19 +++++++++++++++++++
 arch/arm/plat-mxc/include/mach/io.h |   22 ++++++----------------
 arch/arm/plat-mxc/system.c          |    1 +
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 6fad0d6..9f0e82e 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -58,6 +58,23 @@ static void imx3_idle(void)
 		: "=r" (reg));
 }
 
+static void __iomem *imx3_ioremap(unsigned long phys_addr, size_t size,
+				  unsigned int mtype)
+{
+	if (mtype == MT_DEVICE) {
+		/*
+		 * Access all peripherals below 0x80000000 as nonshared device
+		 * on mx3, but leave l2cc alone.  Otherwise cache corruptions
+		 * can occur.
+		 */
+		if (phys_addr < 0x80000000 &&
+				!addr_in_module(phys_addr, MX3x_L2CC))
+			mtype = MT_DEVICE_NONSHARED;
+	}
+
+	return __arm_ioremap(phys_addr, size, mtype);
+}
+
 void imx3_init_l2x0(void)
 {
 	void __iomem *l2x0_base;
@@ -127,6 +144,7 @@ void __init imx31_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX31);
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
 	imx_idle = imx3_idle;
+	imx_ioremap = imx3_ioremap;
 }
 
 void __init imx35_init_early(void)
@@ -135,6 +153,7 @@ void __init imx35_init_early(void)
 	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
 	imx_idle = imx3_idle;
+	imx_ioremap = imx3_ioremap;
 }
 
 void __init mx31_init_irq(void)
diff --git a/arch/arm/plat-mxc/include/mach/io.h b/arch/arm/plat-mxc/include/mach/io.h
index 4347a87..338300b 100644
--- a/arch/arm/plat-mxc/include/mach/io.h
+++ b/arch/arm/plat-mxc/include/mach/io.h
@@ -14,32 +14,22 @@
 /* Allow IO space to be anywhere in the memory */
 #define IO_SPACE_LIMIT 0xffffffff
 
-#if defined(CONFIG_SOC_IMX31) || defined(CONFIG_SOC_IMX35)
-#include <mach/hardware.h>
-
 #define __arch_ioremap __imx_ioremap
 #define __arch_iounmap __iounmap
 
 #define addr_in_module(addr, mod) \
 	((unsigned long)(addr) - mod ## _BASE_ADDR < mod ## _SIZE)
 
+extern void __iomem *(*imx_ioremap)(unsigned long, size_t, unsigned int);
+
 static inline void __iomem *
 __imx_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 {
-	if (mtype == MT_DEVICE && (cpu_is_mx31() || cpu_is_mx35())) {
-		/*
-		 * Access all peripherals below 0x80000000 as nonshared device
-		 * on mx3, but leave l2cc alone.  Otherwise cache corruptions
-		 * can occur.
-		 */
-		if (phys_addr < 0x80000000 &&
-				!addr_in_module(phys_addr, MX3x_L2CC))
-			mtype = MT_DEVICE_NONSHARED;
-	}
-
-	return __arm_ioremap(phys_addr, size, mtype);
+	if (imx_ioremap != NULL)
+		return imx_ioremap(phys_addr, size, mtype);
+	else
+		return __arm_ioremap(phys_addr, size, mtype);
 }
-#endif
 
 /* io address mapping macro */
 #define __io(a)		__typesafe_io(a)
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 5fa03e7..9dad8dc 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -29,6 +29,7 @@
 #include <asm/mach-types.h>
 
 void (*imx_idle)(void) = NULL;
+void __iomem *(*imx_ioremap)(unsigned long, size_t, unsigned int) = NULL;
 
 static void __iomem *wdog_base;
 
-- 
1.7.4.1
