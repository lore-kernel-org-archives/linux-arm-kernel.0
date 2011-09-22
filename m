From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 22 Sep 2011 15:46:32 +0200
Subject: [PATCH 3/7] ARM: ux500: add support for clocksource DBX500 PRCMU
Message-ID: <1316699192-21326-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mattias Wallin <mattias.wallin@stericsson.com>

This patch adds support for the DBX500 PRCMU clocksource
to ux500 platforms.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.co>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu.c                      |    9 +++++++++
 arch/arm/mach-ux500/include/mach/db5500-regs.h |    2 ++
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    3 +++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 1da23bb..c0e4593 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/mfd/db8500-prcmu.h>
 #include <linux/mfd/db5500-prcmu.h>
+#include <linux/clksrc-dbx500-prcmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -140,7 +141,15 @@ static void __init ux500_timer_init(void)
 	else
 		ux500_unknown_soc();
 
+	if (cpu_is_u8500())
+		clksrc_dbx500_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
+	else if (cpu_is_u5500())
+		clksrc_dbx500_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
+	else
+		ux500_unknown_soc();
+
 	nmdk_timer_init();
+	clksrc_dbx500_prcmu_init();
 }
 
 struct sys_timer ux500_timer = {
diff --git a/arch/arm/mach-ux500/include/mach/db5500-regs.h b/arch/arm/mach-ux500/include/mach/db5500-regs.h
index 6ad9832..994b5fe 100644
--- a/arch/arm/mach-ux500/include/mach/db5500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db5500-regs.h
@@ -61,6 +61,8 @@
 #define U5500_SCR_BASE		(U5500_PER4_BASE + 0x5000)
 #define U5500_DMC_BASE		(U5500_PER4_BASE + 0x6000)
 #define U5500_PRCMU_BASE	(U5500_PER4_BASE + 0x7000)
+#define U5500_PRCMU_TIMER_3_BASE (U5500_PER4_BASE + 0x07338)
+#define U5500_PRCMU_TIMER_4_BASE (U5500_PER4_BASE + 0x07450)
 #define U5500_MSP1_BASE		(U5500_PER4_BASE + 0x9000)
 #define U5500_GPIO2_BASE	(U5500_PER4_BASE + 0xA000)
 #define U5500_CDETECT_BASE	(U5500_PER4_BASE + 0xF000)
diff --git a/arch/arm/mach-ux500/include/mach/db8500-regs.h b/arch/arm/mach-ux500/include/mach/db8500-regs.h
index 0499971..751b0e6 100644
--- a/arch/arm/mach-ux500/include/mach/db8500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db8500-regs.h
@@ -102,10 +102,13 @@
 #define U8500_SCR_BASE		(U8500_PER4_BASE + 0x05000)
 #define U8500_DMC_BASE		(U8500_PER4_BASE + 0x06000)
 #define U8500_PRCMU_BASE	(U8500_PER4_BASE + 0x07000)
+#define U8500_PRCMU_TIMER_3_BASE (U8500_PER4_BASE + 0x07338)
+#define U8500_PRCMU_TIMER_4_BASE (U8500_PER4_BASE + 0x07450)
 #define U8500_PRCMU_TCDM_BASE_V1 (U8500_PER4_BASE + 0x0f000)
 #define U8500_PRCMU_TCDM_BASE	(U8500_PER4_BASE + 0x68000)
 #define U8500_PRCMU_TCPM_BASE   (U8500_PER4_BASE + 0x60000)
 
+
 /* per3 base addresses */
 #define U8500_FSMC_BASE		(U8500_PER3_BASE + 0x0000)
 #define U8500_SSP0_BASE		(U8500_PER3_BASE + 0x2000)
-- 
1.7.3.2
