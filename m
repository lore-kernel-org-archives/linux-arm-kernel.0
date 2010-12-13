From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:22:07 +0000
Subject: [PATCH 21/24] ARM: spear: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDyJ-0008De-0L@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-spear/time.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index ab21165..839c88d 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -81,8 +81,6 @@ static struct clocksource clksrc = {
 	.rating = 200,		/* its a pretty decent clock */
 	.read = clocksource_read_cycles,
 	.mask = 0xFFFF,		/* 16 bits */
-	.mult = 0,		/* to be computed */
-	.shift = 0,		/* to be computed */
 	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -105,10 +103,8 @@ static void spear_clocksource_init(void)
 	val |= CTRL_ENABLE ;
 	writew(val, gpt_base + CR(CLKSRC));
 
-	clocksource_calc_mult_shift(&clksrc, tick_rate, SPEAR_MIN_RANGE);
-
 	/* register the clocksource */
-	clocksource_register(&clksrc);
+	clocksource_register_hz(&clksrc, tick_rate);
 }
 
 static struct clock_event_device clkevt = {
-- 
1.6.2.5
