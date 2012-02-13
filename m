From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 15:43:18 -0600
Subject: [PATCH 05/15] ARM: msm: use runtime ioremap hook
In-Reply-To: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329169408-17253-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert msm platforms to use run-time ioremap hook instead of the compile
time hook.

According to David Brown, only the msm7201 needed the ioremap hook.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-msm/board-halibut.c               |    6 ++++++
 arch/arm/mach-msm/board-trout.c                 |    6 ++++++
 arch/arm/mach-msm/include/mach/io.h             |    5 -----
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |    6 ++++++
 arch/arm/mach-msm/io.c                          |    1 -
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index a60ab6d..b6cff3a 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -68,6 +68,11 @@ static struct platform_device *devices[] __initdata = {
 
 extern struct sys_timer msm_timer;
 
+static void __init halibut_init_early(void)
+{
+	arch_ioremap = __msm_ioremap;
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
index 6b9b227..509d94c 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -43,6 +43,11 @@ static struct platform_device *devices[] __initdata = {
 
 extern struct sys_timer msm_timer;
 
+static void __init trout_init_early(void)
+{
+	arch_ioremap = __msm_ioremap;
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
index 8af4612..c355886 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
@@ -111,5 +111,11 @@
 #define MSM_AD5_PHYS          0xAC000000
 #define MSM_AD5_SIZE          (SZ_1M*13)
 
+#ifndef __ASSEMBLY__
+
+extern void __iomem *
+__msm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype);
+
+#endif
 
 #endif
diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index 578b04e..283cdff 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -187,4 +187,3 @@ __msm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 	return __arm_ioremap_caller(phys_addr, size, mtype,
 		__builtin_return_address(0));
 }
-EXPORT_SYMBOL(__msm_ioremap);
-- 
1.7.5.4
