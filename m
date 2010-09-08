From: jonas.aberg@stericsson.com (Jonas Aaberg)
Date: Wed, 8 Sep 2010 15:13:55 +0200
Subject: [PATCH 1/2] plat-nomadik: MTU timer trivial bug fix
Message-ID: <1283951636-7549-1-git-send-email-jonas.aberg@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

timer0 to 3 are all on mtu block 0, so don't calculate the clock event
rate based upon mtu block 1's clock speed.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
---
 arch/arm/plat-nomadik/timer.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index ea3ca86..d673888 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -131,17 +131,12 @@ void __init nmdk_timer_init(void)
 {
 	unsigned long rate;
 	struct clk *clk0;
-	struct clk *clk1;
 	u32 cr;
 
 	clk0 = clk_get_sys("mtu0", NULL);
 	BUG_ON(IS_ERR(clk0));
 
-	clk1 = clk_get_sys("mtu1", NULL);
-	BUG_ON(IS_ERR(clk1));
-
 	clk_enable(clk0);
-	clk_enable(clk1);
 
 	/*
 	 * Tick rate is 2.4MHz for Nomadik and 110MHz for ux500:
@@ -170,15 +165,8 @@ void __init nmdk_timer_init(void)
 		pr_err("timer: failed to initialize clock source %s\n",
 		       nmdk_clksrc.name);
 
-	/* Timer 1 is used for events, fix according to rate */
-	cr = MTU_CRn_32BITS;
-	rate = clk_get_rate(clk1);
-	if (rate > 16 << 20) {
-		rate /= 16;
-		cr |= MTU_CRn_PRESCALE_16;
-	} else {
-		cr |= MTU_CRn_PRESCALE_1;
-	}
+	/* Timer 1 is used for events */
+
 	clockevents_calc_mult_shift(&nmdk_clkevt, rate, MTU_MIN_RANGE);
 
 	writel(cr | MTU_CRn_ONESHOT, mtu_base + MTU_CR(1)); /* off, currently */
-- 
1.6.3.3
