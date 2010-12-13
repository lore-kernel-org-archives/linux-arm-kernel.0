From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:17:01 +0000
Subject: [PATCH 06/24] ARM: lpc32xx: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDtN-0008Cg-5o@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-lpc32xx/timer.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index 630dd4a..6162ac3 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -38,7 +38,6 @@ static cycle_t lpc32xx_clksrc_read(struct clocksource *cs)
 
 static struct clocksource lpc32xx_clksrc = {
 	.name	= "lpc32xx_clksrc",
-	.shift	= 24,
 	.rating	= 300,
 	.read	= lpc32xx_clksrc_read,
 	.mask	= CLOCKSOURCE_MASK(32),
@@ -171,9 +170,7 @@ static void __init lpc32xx_timer_init(void)
 	__raw_writel(0, LCP32XX_TIMER_MCR(LPC32XX_TIMER1_BASE));
 	__raw_writel(LCP32XX_TIMER_CNTR_TCR_EN,
 		LCP32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
-	lpc32xx_clksrc.mult = clocksource_hz2mult(clkrate,
-		lpc32xx_clksrc.shift);
-	clocksource_register(&lpc32xx_clksrc);
+	clocksource_register_hz(&lpc32xx_clksrc, clkrate);
 }
 
 struct sys_timer lpc32xx_timer = {
-- 
1.6.2.5
