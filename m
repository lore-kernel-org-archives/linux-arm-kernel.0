From: briannorris@chromium.org (Brian Norris)
Date: Fri, 16 Sep 2016 13:49:17 +0800
Subject: [PATCH] clocksource: arm_arch_timer: Don't assume clock runs in
 suspend
Message-ID: <20160916054917.16930-1-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 4fbcdc813fb9 ("clocksource: arm_arch_timer: Use clocksource
for suspend timekeeping"), this driver assumes that the ARM architected
timer keeps running in suspend. This is not the case for some ARM SoCs,
depending on the HW state used for system suspend. Let's not assume that
all SoCs support this, and instead only support this if the device tree
explicitly tells us it's "always on". In all other cases, just fall back
to the RTC. This should be relatively harmless.

It seems fair to key the system-suspend behavior off the same property
used for C3STOP, since if the timer doesn't keep context for CPU sleep,
it likely doesn't for system sleep either.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/clocksource/arm_arch_timer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 57700541f951..e28677a34f02 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -490,7 +490,7 @@ static struct clocksource clocksource_counter = {
 	.rating	= 400,
 	.read	= arch_counter_read,
 	.mask	= CLOCKSOURCE_MASK(56),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static struct cyclecounter cyclecounter = {
@@ -526,6 +526,8 @@ static void __init arch_counter_register(unsigned type)
 		clocksource_counter.name = "arch_mem_counter";
 	}
 
+	if (!arch_timer_c3stop)
+		clocksource_counter.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 	start_count = arch_timer_read_counter();
 	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
 	cyclecounter.mult = clocksource_counter.mult;
-- 
2.8.1.340.g018a5d0.dirty
