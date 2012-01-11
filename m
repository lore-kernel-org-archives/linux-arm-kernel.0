From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 11 Jan 2012 10:04:40 +0100
Subject: [PATCH 1/3] plat-nomadik: get rid of global mtu base pointer
Message-ID: <1326272680-5635-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Pass the base offset to the Nomadik MTU timer in the init call
instead of keeping a global pointer to be assigned.

Cc: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/board-nhk8815.c      |    7 ++-----
 arch/arm/mach-nomadik/include/mach/setup.h |   19 -------------------
 arch/arm/mach-ux500/include/mach/setup.h   |    3 ---
 arch/arm/mach-ux500/timer.c                |    7 ++++---
 arch/arm/plat-nomadik/include/plat/mtu.h   |    4 +---
 arch/arm/plat-nomadik/timer.c              |    6 +++---
 6 files changed, 10 insertions(+), 36 deletions(-)
 delete mode 100644 arch/arm/mach-nomadik/include/mach/setup.h

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 7c878bf..b77cb84 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -27,11 +27,11 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
+#include <asm/mach/time.h>
 
 #include <plat/gpio-nomadik.h>
 #include <plat/mtu.h>
 
-#include <mach/setup.h>
 #include <mach/nand.h>
 #include <mach/fsmc.h>
 
@@ -255,10 +255,7 @@ static void __init nomadik_timer_init(void)
 	src_cr |= SRC_CR_INIT_VAL;
 	writel(src_cr, io_p2v(NOMADIK_SRC_BASE));
 
-	/* Save global pointer to mtu, used by platform timer code */
-	mtu_base = io_p2v(NOMADIK_MTU0_BASE);
-
-	nmdk_timer_init();
+	nmdk_timer_init(io_p2v(NOMADIK_MTU0_BASE));
 }
 
 static struct sys_timer nomadik_timer = {
diff --git a/arch/arm/mach-nomadik/include/mach/setup.h b/arch/arm/mach-nomadik/include/mach/setup.h
deleted file mode 100644
index bcaeaf4..0000000
--- a/arch/arm/mach-nomadik/include/mach/setup.h
+++ /dev/null
@@ -1,19 +0,0 @@
-
-/*
- * These symbols are needed for board-specific files to call their
- * own cpu-specific files
- */
-
-#ifndef __ASM_ARCH_SETUP_H
-#define __ASM_ARCH_SETUP_H
-
-#include <asm/mach/time.h>
-#include <linux/init.h>
-
-#ifdef CONFIG_NOMADIK_8815
-
-extern void nmdk_timer_init(void);
-
-#endif /* NOMADIK_8815 */
-
-#endif /*  __ASM_ARCH_SETUP_H */
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index a7d363f..93d4039 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -27,9 +27,6 @@ extern void __init u5500_sdi_init(void);
 
 extern void __init db5500_dma_init(void);
 
-/* We re-use nomadik_timer for this platform */
-extern void nmdk_timer_init(void);
-
 struct amba_device;
 extern void __init amba_add_devices(struct amba_device *devs[], int num);
 
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index aea467d..fd00024 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -17,19 +17,20 @@
 
 static void __init ux500_timer_init(void)
 {
+	void __iomem *mtu_timer_base;
 	void __iomem *prcmu_timer_base;
 
 	if (cpu_is_u5500()) {
 #ifdef CONFIG_LOCAL_TIMERS
 		twd_base = __io_address(U5500_TWD_BASE);
 #endif
-		mtu_base = __io_address(U5500_MTU0_BASE);
+		mtu_timer_base = __io_address(U5500_MTU0_BASE);
 		prcmu_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
 	} else if (cpu_is_u8500()) {
 #ifdef CONFIG_LOCAL_TIMERS
 		twd_base = __io_address(U8500_TWD_BASE);
 #endif
-		mtu_base = __io_address(U8500_MTU0_BASE);
+		mtu_timer_base = __io_address(U8500_MTU0_BASE);
 		prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
 	} else {
 		ux500_unknown_soc();
@@ -52,7 +53,7 @@ static void __init ux500_timer_init(void)
 	 *
 	 */
 
-	nmdk_timer_init();
+	nmdk_timer_init(mtu_timer_base);
 	clksrc_dbx500_prcmu_init(prcmu_timer_base);
 }
 
diff --git a/arch/arm/plat-nomadik/include/plat/mtu.h b/arch/arm/plat-nomadik/include/plat/mtu.h
index 6508e76..582641f 100644
--- a/arch/arm/plat-nomadik/include/plat/mtu.h
+++ b/arch/arm/plat-nomadik/include/plat/mtu.h
@@ -1,9 +1,7 @@
 #ifndef __PLAT_MTU_H
 #define __PLAT_MTU_H
 
-/* should be set by the platform code */
-extern void __iomem *mtu_base;
-
+void nmdk_timer_init(void __iomem *base);
 void nmdk_clkevt_reset(void);
 void nmdk_clksrc_reset(void);
 
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index ad1b45b..46f50f2 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -66,12 +66,11 @@
 #define MTU_PCELL2	0xff8
 #define MTU_PCELL3	0xffC
 
+static void __iomem *mtu_base;
 static bool clkevt_periodic;
 static u32 clk_prescale;
 static u32 nmdk_cycle;		/* write-once */
 
-void __iomem *mtu_base; /* Assigned by machine code */
-
 #ifdef CONFIG_NOMADIK_MTU_SCHED_CLOCK
 /*
  * Override the global weak sched_clock symbol with this
@@ -183,11 +182,12 @@ void nmdk_clksrc_reset(void)
 	       mtu_base + MTU_CR(0));
 }
 
-void __init nmdk_timer_init(void)
+void __init nmdk_timer_init(void __iomem *base)
 {
 	unsigned long rate;
 	struct clk *clk0;
 
+	mtu_base = base;
 	clk0 = clk_get_sys("mtu0", NULL);
 	BUG_ON(IS_ERR(clk0));
 
-- 
1.7.8
