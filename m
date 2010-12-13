From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:17:42 +0000
Subject: [PATCH 08/24] ARM: MSM: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDu2-0008Co-0D@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-msm/timer.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 950100f..595be7f 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -137,7 +137,6 @@ static struct msm_clock msm_clocks[] = {
 			.rating         = 200,
 			.read           = msm_gpt_read,
 			.mask           = CLOCKSOURCE_MASK(32),
-			.shift          = 17,
 			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 		},
 		.irq = {
@@ -164,7 +163,6 @@ static struct msm_clock msm_clocks[] = {
 			.rating         = 300,
 			.read           = msm_dgt_read,
 			.mask           = CLOCKSOURCE_MASK((32 - MSM_DGT_SHIFT)),
-			.shift          = 24 - MSM_DGT_SHIFT,
 			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 		},
 		.irq = {
@@ -205,8 +203,7 @@ static void __init msm_timer_init(void)
 		ce->min_delta_ns = clockevent_delta2ns(4, ce);
 		ce->cpumask = cpumask_of(0);
 
-		cs->mult = clocksource_hz2mult(clock->freq, cs->shift);
-		res = clocksource_register(cs);
+		res = clocksource_register_hz(cs, clock->freq);
 		if (res)
 			printk(KERN_ERR "msm_timer_init: clocksource_register "
 			       "failed for %s\n", cs->name);
-- 
1.6.2.5
