From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 11:36:40 +0000
Subject: [PATCH 04/40] ARM: integrator: update clock source registration
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTYc4-0006ht-FT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/integrator_ap.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 548208f..2774df8 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -372,7 +372,6 @@ static struct clocksource clocksource_timersp = {
 	.rating		= 200,
 	.read		= timersp_read,
 	.mask		= CLOCKSOURCE_MASK(16),
-	.shift		= 16,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -390,8 +389,7 @@ static void integrator_clocksource_init(u32 khz)
 	writel(ctrl, base + TIMER_CTRL);
 	writel(0xffff, base + TIMER_LOAD);
 
-	cs->mult = clocksource_khz2mult(khz, cs->shift);
-	clocksource_register(cs);
+	clocksource_register_khz(cs, khz);
 }
 
 static void __iomem * const clkevt_base = (void __iomem *)TIMER1_VA_BASE;
-- 
1.6.2.5
