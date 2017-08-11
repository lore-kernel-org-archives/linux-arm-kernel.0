From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Aug 2017 16:17:37 +0200
Subject: [PATCH 1/5] clocksource/drivers/arm_arch_timer: Fix mem frame loop
 initialization
In-Reply-To: <20170811141520.GA795@mai>
References: <20170811141520.GA795@mai>
Message-ID: <1502461061-28065-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Kaehlcke <mka@chromium.org>

The loop to find the best memory frame in arch_timer_mem_acpi_init()
initializes the loop counter with itself ('i = i'), which is suspicious
in the first place and pointed out by clang. The loop condition is
'i < timer_count' and a prior for loop exits when 'i' reaches
'timer_count', therefore the second loop is never executed.

Initialize the loop counter with 0 to iterate over all timers, which
supposedly was the intention before the typo monster attacked.

Fixes: c2743a36765d3 ("clocksource: arm_arch_timer: add GTDT support for memory-mapped timer")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aae87c4..72bbfcc 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1440,7 +1440,7 @@ static int __init arch_timer_mem_acpi_init(int platform_timer_count)
 	 * While unlikely, it's theoretically possible that none of the frames
 	 * in a timer expose the combination of feature we want.
 	 */
-	for (i = i; i < timer_count; i++) {
+	for (i = 0; i < timer_count; i++) {
 		timer = &timers[i];
 
 		frame = arch_timer_mem_find_best_frame(timer);
-- 
2.7.4
