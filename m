From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:18:02 +0000
Subject: [PATCH 09/24] ARM: netx: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDuM-0008Cs-Ea@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-netx/time.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-netx/time.c b/arch/arm/mach-netx/time.c
index 82801db..f12f22d 100644
--- a/arch/arm/mach-netx/time.c
+++ b/arch/arm/mach-netx/time.c
@@ -114,7 +114,6 @@ static struct clocksource clocksource_netx = {
 	.rating		= 200,
 	.read		= netx_get_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -151,9 +150,7 @@ static void __init netx_timer_init(void)
 	writel(NETX_GPIO_COUNTER_CTRL_RUN,
 			NETX_GPIO_COUNTER_CTRL(TIMER_CLOCKSOURCE));
 
-	clocksource_netx.mult =
-		clocksource_hz2mult(CLOCK_TICK_RATE, clocksource_netx.shift);
-	clocksource_register(&clocksource_netx);
+	clocksource_register_hz(&clocksource_netx, CLOCK_TICK_RATE);
 
 	netx_clockevent.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC,
 			netx_clockevent.shift);
-- 
1.6.2.5
