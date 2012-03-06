From: robherring2@gmail.com (Rob Herring)
Date: Tue,  6 Mar 2012 15:45:13 -0600
Subject: [PATCH v5 3/7] ARM: msm: use runtime ioremap hook
In-Reply-To: <1331070317-9598-1-git-send-email-robherring2@gmail.com>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331070317-9598-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331070317-9598-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert msm platforms to use run-time ioremap hook instead of the compile
time hook.

According to David Brown, only the msm7201 needed the ioremap hook.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Tested-by: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
---
 arch/arm/mach-msm/board-halibut.c               |    6 ++++++
 arch/arm/mach-msm/board-trout.c                 |    6 ++++++
 arch/arm/mach-msm/include/mach/io.h             |    5 -----
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |    6 ++++++
 arch/arm/mach-msm/io.c                          |    8 +++-----
 5 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index a60ab6d..3698a37 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -68,6 +68,11 @@ static struct platform_device *devices[] __initdata = {
 
 extern struct sys_timer msm_timer;
 
+static void __init halibut_init_early(void)
+{
+	arch_ioremap_caller = __msm_ioremap_caller;
+}
+
 static void __init halibut_init_irq(void)
 {
 	msm_init_irq();
@@ -96,6 +101,7 @@ MACHINE_START(HALIBUT, "Halibut Board (QCT SURF7200A)")
 	.atag_offset	= 0x100,
 	.fixup		= halibut_fixup,
 	.map_io		= halibut_map_io,
+	.init_early	= halibut_init_early,
 	.init_irq	= halibut_init_irq,
 	.init_machine	= halibut_init,
 	.timer		= &msm_timer,
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index 6b9b227..5414f76 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -43,6 +43,11 @@ static struct platform_device *devices[] __initdata = {
 
 extern struct sys_timer msm_timer;
 
+static void __init trout_init_early(void)
+{
+	arch_ioremap_caller = __msm_ioremap_caller;
+}
+
 static void __init trout_init_irq(void)
 {
 	msm_init_irq();
@@ -96,6 +101,7 @@ MACHINE_START(TROUT, "HTC Dream")
 	.atag_offset	= 0x100,
 	.fixup		= trout_fixup,
 	.map_io		= trout_map_io,
+	.init_early	= trout_init_early,
 	.init_irq	= trout_init_irq,
 	.init_machine	= trout_init,
 	.timer		= &msm_timer,
diff --git a/arch/arm/mach-msm/include/mach/io.h b/arch/arm/mach-msm/include/mach/io.h
index dc1b928..c6ff9bb 100644
--- a/arch/arm/mach-msm/include/mach/io.h
+++ b/arch/arm/mach-msm/include/mach/io.h
@@ -18,11 +18,6 @@
 
 #define IO_SPACE_LIMIT 0xffffffff
 
-#define __arch_ioremap __msm_ioremap
-#define __arch_iounmap __iounmap
-
-void __iomem *__msm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype);
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)    (a)
 
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h b/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
index 8af4612..152b3b7 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
@@ -111,5 +111,11 @@
 #define MSM_AD5_PHYS          0xAC000000
 #define MSM_AD5_SIZE          (SZ_1M*13)
 
+#ifndef __ASSEMBLY__
+
+extern void __iomem *__msm_ioremap_caller(unsigned long phys_addr, size_t size,
+					  unsigned int mtype, void *caller);
+
+#endif
 
 #endif
diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index 578b04e..a1e7b11 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -172,8 +172,8 @@ void __init msm_map_msm7x30_io(void)
 }
 #endif /* CONFIG_ARCH_MSM7X30 */
 
-void __iomem *
-__msm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
+void __iomem *__msm_ioremap_caller(unsigned long phys_addr, size_t size,
+				   unsigned int mtype, void *caller)
 {
 	if (mtype == MT_DEVICE) {
 		/* The peripherals in the 88000000 - D0000000 range
@@ -184,7 +184,5 @@ __msm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 			mtype = MT_DEVICE_NONSHARED;
 	}
 
-	return __arm_ioremap_caller(phys_addr, size, mtype,
-		__builtin_return_address(0));
+	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
 }
-EXPORT_SYMBOL(__msm_ioremap);
-- 
1.7.5.4
