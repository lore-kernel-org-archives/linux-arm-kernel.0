From: jonas.aberg@stericsson.com (Jonas Aaberg)
Date: Wed, 8 Sep 2010 15:13:56 +0200
Subject: [PATCH 2/2] plat-nomadik: MTU: Change prescaler limit and comment
	updates
In-Reply-To: <1283951636-7549-1-git-send-email-jonas.aberg@stericsson.com>
References: <1283951636-7549-1-git-send-email-jonas.aberg@stericsson.com>
Message-ID: <1283951636-7549-2-git-send-email-jonas.aberg@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prescaler 16 is now used only when the timer runs at 32 MHz
or more. Some comment updates as well.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
---
 arch/arm/plat-nomadik/timer.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index d673888..aedf9c1 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/mach-nomadik/timer.c
+ *  linux/arch/arm/plat-nomadik/timer.c
  *
  * Copyright (C) 2008 STMicroelectronics
  * Copyright (C) 2010 Alessandro Rubini
@@ -75,7 +75,7 @@ static void nmdk_clkevt_mode(enum clock_event_mode mode,
 		cr = readl(mtu_base + MTU_CR(1));
 		writel(0, mtu_base + MTU_LR(1));
 		writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(1));
-		writel(0x2, mtu_base + MTU_IMSC);
+		writel(1 << 1, mtu_base + MTU_IMSC);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
@@ -131,7 +131,7 @@ void __init nmdk_timer_init(void)
 {
 	unsigned long rate;
 	struct clk *clk0;
-	u32 cr;
+	u32 cr = MTU_CRn_32BITS;
 
 	clk0 = clk_get_sys("mtu0", NULL);
 	BUG_ON(IS_ERR(clk0));
@@ -139,12 +139,15 @@ void __init nmdk_timer_init(void)
 	clk_enable(clk0);
 
 	/*
-	 * Tick rate is 2.4MHz for Nomadik and 110MHz for ux500:
-	 * use a divide-by-16 counter if it's more than 16MHz
+	 * Tick rate is 2.4MHz for Nomadik and 2.4Mhz, 100MHz or 133 MHz
+	 * for ux500.
+	 * Use a divide-by-16 counter if the tick rate is more than 32MHz.
+	 * At 32 MHz, the timer (with 32 bit counter) can be programmed
+	 * to wake-up@a max 127s a head in time. Dividing a 2.4 MHz timer
+	 * with 16 gives too low timer resolution.
 	 */
-	cr = MTU_CRn_32BITS;;
 	rate = clk_get_rate(clk0);
-	if (rate > 16 << 20) {
+	if (rate > 32000000) {
 		rate /= 16;
 		cr |= MTU_CRn_PRESCALE_16;
 	} else {
-- 
1.6.3.3
