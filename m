From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon,  1 Mar 2010 08:35:46 +0100
Subject: [PATCH] ux500: change the MTU timer frequency to 2.4 MHz
Message-ID: <1267428946-4124-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the files in ux500 state that the instance of the MTU
timer runs at 110 MHz, but actually this is currently either
50 MHz or 100 MHz depending on operating point. By explictly setting
it to 2.4 MHz we get a stable system timer on the MTU.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Alessandro Rubini <rubini@unipv.it>
---
 arch/arm/mach-ux500/cpu-u8500.c             |    3 +++
 arch/arm/mach-ux500/include/mach/hardware.h |    3 +++
 arch/arm/mach-ux500/include/mach/timex.h    |    2 +-
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index 09bcba1..72bb334 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -99,6 +99,9 @@ static void __init u8500_timer_init(void)
 	else
 		mtu_base = __io_address(U8500_MTU0_BASE_V1);
 
+	/* Set MTU timer frequency to 2.4 MHz */
+	writel(0xff, __io_address(U8500_PRCMU_TCR));
+
 	nmdk_timer_init();
 }
 
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index f29a43d..5eb52e8 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -128,6 +128,9 @@
 #define U8500_GPIO1_BASE	(U8500_PER1_BASE + 0xe000)
 #define U8500_CLKRST1_BASE	(U8500_PER1_BASE + 0xf000)
 
+/* PRCMU Timer Register */
+#define U8500_PRCMU_TCR		(U8500_PRCMU_BASE + 0x1c8)
+
 /* ST-Ericsson modified pl022 id */
 #define SSP_PER_ID		0x01080022
 
diff --git a/arch/arm/mach-ux500/include/mach/timex.h b/arch/arm/mach-ux500/include/mach/timex.h
index d0942c1..2353e55 100644
--- a/arch/arm/mach-ux500/include/mach/timex.h
+++ b/arch/arm/mach-ux500/include/mach/timex.h
@@ -1,6 +1,6 @@
 #ifndef __ASM_ARCH_TIMEX_H
 #define __ASM_ARCH_TIMEX_H
 
-#define CLOCK_TICK_RATE		110000000
+#define CLOCK_TICK_RATE		2400000
 
 #endif
-- 
1.6.3.3
