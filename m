From: robherring2@gmail.com (Rob Herring)
Date: Mon,  5 Mar 2012 22:02:58 -0600
Subject: [PATCH v4 2/4] ARM: imx: convert to common runtime ioremap hook
In-Reply-To: <1331006580-3579-1-git-send-email-robherring2@gmail.com>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331006580-3579-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331006580-3579-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert i.MX platforms to use the common run-time ioremap hook instead of
the imx specific hook.

Also, move addr_in_module out of io.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx3.c               |   10 +++++-----
 arch/arm/plat-mxc/include/mach/hardware.h |    3 +++
 arch/arm/plat-mxc/include/mach/io.h       |   17 -----------------
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 8404ee7..04be18d 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -59,8 +59,8 @@ static void imx3_idle(void)
 		: "=r" (reg));
 }
 
-static void __iomem *imx3_ioremap(unsigned long phys_addr, size_t size,
-				  unsigned int mtype)
+static void __iomem *imx3_ioremap_caller(unsigned long phys_addr, size_t size,
+					 unsigned int mtype, void *caller)
 {
 	if (mtype == MT_DEVICE) {
 		/*
@@ -73,7 +73,7 @@ static void __iomem *imx3_ioremap(unsigned long phys_addr, size_t size,
 			mtype = MT_DEVICE_NONSHARED;
 	}
 
-	return __arm_ioremap(phys_addr, size, mtype);
+	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
 }
 
 void imx3_init_l2x0(void)
@@ -132,7 +132,7 @@ void __init imx31_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX31);
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
-	imx_ioremap = imx3_ioremap;
+	arch_ioremap_caller = imx3_ioremap_caller;
 	arm_pm_idle = imx3_idle;
 }
 
@@ -196,7 +196,7 @@ void __init imx35_init_early(void)
 	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
 	arm_pm_idle = imx3_idle;
-	imx_ioremap = imx3_ioremap;
+	arch_ioremap_caller = imx3_ioremap_caller;
 }
 
 void __init mx35_init_irq(void)
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index a599f01..ca06a68 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -28,6 +28,9 @@
 #define IOMEM(addr)	((void __force __iomem *)(addr))
 #endif
 
+#define addr_in_module(addr, mod) \
+	((unsigned long)(addr) - mod ## _BASE_ADDR < mod ## _SIZE)
+
 #define IMX_IO_P2V_MODULE(addr, module)					\
 	(((addr) - module ## _BASE_ADDR) < module ## _SIZE ?		\
 	 (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0)
diff --git a/arch/arm/plat-mxc/include/mach/io.h b/arch/arm/plat-mxc/include/mach/io.h
index 338300b..ea9d95e 100644
--- a/arch/arm/plat-mxc/include/mach/io.h
+++ b/arch/arm/plat-mxc/include/mach/io.h
@@ -14,23 +14,6 @@
 /* Allow IO space to be anywhere in the memory */
 #define IO_SPACE_LIMIT 0xffffffff
 
-#define __arch_ioremap __imx_ioremap
-#define __arch_iounmap __iounmap
-
-#define addr_in_module(addr, mod) \
-	((unsigned long)(addr) - mod ## _BASE_ADDR < mod ## _SIZE)
-
-extern void __iomem *(*imx_ioremap)(unsigned long, size_t, unsigned int);
-
-static inline void __iomem *
-__imx_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
-{
-	if (imx_ioremap != NULL)
-		return imx_ioremap(phys_addr, size, mtype);
-	else
-		return __arm_ioremap(phys_addr, size, mtype);
-}
-
 /* io address mapping macro */
 #define __io(a)		__typesafe_io(a)
 
-- 
1.7.5.4
