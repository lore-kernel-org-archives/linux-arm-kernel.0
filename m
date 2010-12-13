From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:23:08 +0000
Subject: [PATCH 24/24] ARM: realview/versatile: update clock source
	registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDzI-0008Dq-9v@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-versatile/timer-sp.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-versatile/timer-sp.c b/arch/arm/plat-versatile/timer-sp.c
index fb0d1c2..f09941b 100644
--- a/arch/arm/plat-versatile/timer-sp.c
+++ b/arch/arm/plat-versatile/timer-sp.c
@@ -46,7 +46,6 @@ static struct clocksource clocksource_sp804 = {
 	.rating		= 200,
 	.read		= sp804_read,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -63,8 +62,7 @@ void __init sp804_clocksource_init(void __iomem *base)
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 		clksrc_base + TIMER_CTRL);
 
-	cs->mult = clocksource_khz2mult(TIMER_FREQ_KHZ, cs->shift);
-	clocksource_register(cs);
+	clocksource_register_khz(cs, TIMER_FREQ_KHZ);
 }
 
 
-- 
1.6.2.5
