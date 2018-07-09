From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  9 Jul 2018 16:45:36 +0100
Subject: [PATCH 2/2] clocksource: arm_arch_timer: set arch_mem_timer cpumask
 to cpu_possible_mask
In-Reply-To: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1531151136-18297-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, arch_mem_timer cpumask is set to cpu_all_mask which should be
fine. However, cpu_possible_mask is more accurate and if there are other
clockevent source in the system which are set to cpu_possible_mask, then
having cpu_all_mask may result in issue.

E.g. on a platform with arm,sp804 timer with rating 300 and
cpu_possible_mask and this arch_mem_timer timer with rating 400 and
cpu_all_mask, tick_check_preferred may choose both preferred as the
cpumasks are not equal though they must be.

This issue was root caused incorrectly initially and a fix was merged as
commit 1332a9055801 ("tick: Prefer a lower rating device only if it's CPU
local device").

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

There are few more drivers that set cpu_all_mask, should they also be
changed ? It should be fine as long as it's not compared against
someother non per-CPU timer with shorter cpumask.

Regards,
Sudeep

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 57cb2f00fc07..d8c7f5750cdb 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -735,7 +735,7 @@ static void __arch_timer_setup(unsigned type,
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
 		clk->rating = 400;
-		clk->cpumask = cpu_all_mask;
+		clk->cpumask = cpu_possible_mask;
 		if (arch_timer_mem_use_virtual) {
 			clk->set_state_shutdown = arch_timer_shutdown_virt_mem;
 			clk->set_state_oneshot_stopped = arch_timer_shutdown_virt_mem;
--
2.7.4
