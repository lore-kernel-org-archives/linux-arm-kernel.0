From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 11:41:46 +0000
Subject: [PATCH 19/40] ARM: mxc: update clock source registration
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTYh0-0006is-Mo@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-mxc/epit.c |    5 +----
 arch/arm/plat-mxc/time.c |    5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-mxc/epit.c b/arch/arm/plat-mxc/epit.c
index ee9582f..d69d343 100644
--- a/arch/arm/plat-mxc/epit.c
+++ b/arch/arm/plat-mxc/epit.c
@@ -93,7 +93,6 @@ static struct clocksource clocksource_epit = {
 	.rating		= 200,
 	.read		= epit_read,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -101,9 +100,7 @@ static int __init epit_clocksource_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 
-	clocksource_epit.mult = clocksource_hz2mult(c,
-					clocksource_epit.shift);
-	clocksource_register(&clocksource_epit);
+	clocksource_register_hz(&clocksource_epit, c);
 
 	return 0;
 }
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index f9a1b05..9f0c261 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -120,7 +120,6 @@ static struct clocksource clocksource_mxc = {
 	.rating		= 200,
 	.read		= mx1_2_get_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift 		= 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -131,9 +130,7 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 	if (timer_is_v2())
 		clocksource_mxc.read = v2_get_cycles;
 
-	clocksource_mxc.mult = clocksource_hz2mult(c,
-					clocksource_mxc.shift);
-	clocksource_register(&clocksource_mxc);
+	clocksource_register_hz(&clocksource_mxc, c);
 
 	return 0;
 }
-- 
1.6.2.5
