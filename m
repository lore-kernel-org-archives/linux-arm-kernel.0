From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  6 Jan 2014 14:56:17 -0800
Subject: [PATCH] clocksource: arch_timer: Set dynamic irq affinity on mmio
 clockevent
Message-ID: <1389048977-13502-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the CLOCK_EVT_FEAT_DYNIRQ flag on the memory mapped
clockevent so that we save power by waking up the CPU with the
next event when this timer is used in broadcast mode.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/arm_arch_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 95fb944e15ee..57e823c44d2a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -277,6 +277,7 @@ static void __arch_timer_setup(unsigned type,
 			clk->set_next_event = arch_timer_set_next_event_phys;
 		}
 	} else {
+		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
 		clk->rating = 400;
 		clk->cpumask = cpu_all_mask;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
