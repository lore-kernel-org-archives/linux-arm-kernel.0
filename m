From: srinidhi.kasagar@stericsson.com (srinidhi)
Date: Thu, 29 Jul 2010 18:26:16 +0530
Subject: [PATCH 2/2] ux500: make gic_cpu_base_addr visible to entry-macro-gic.S
Message-ID: <1280408176.14531.14.camel@bnru03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the __iomem type gic_cpu_base_addr visible to the new
renamed file entry-macro-gic.S.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/cpu.c                |    7 ++++++-
 arch/arm/mach-ux500/include/mach/setup.h |    1 +
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e0fd747..0a007b8 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -58,10 +58,15 @@ void __init ux500_init_devices(void)
 	amba_add_devices(ux500_amba_devs, ARRAY_SIZE(ux500_amba_devs));
 }
 
+/* used by entry-macro.S */
+void __iomem *gic_cpu_base_addr;
+
 void __init ux500_init_irq(void)
 {
+	gic_cpu_base_addr = __io_address(UX500_GIC_CPU_BASE);
+
 	gic_dist_init(0, __io_address(UX500_GIC_DIST_BASE), 29);
-	gic_cpu_init(0, __io_address(UX500_GIC_CPU_BASE));
+	gic_cpu_init(0, gic_cpu_base_addr);
 
 	/*
 	 * Init clocks here so that they are available for system timer
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index e978dbd..56f81bb 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -30,6 +30,7 @@ extern void __init amba_add_devices(struct amba_device *devs[], int num);
 
 struct sys_timer;
 extern struct sys_timer ux500_timer;
+extern void __iomem *gic_cpu_base_addr;
 
 #define __IO_DEV_DESC(x, sz)	{		\
 	.virtual	= IO_ADDRESS(x),	\
-- 
1.6.3.3
