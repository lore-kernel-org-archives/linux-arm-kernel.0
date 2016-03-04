From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  4 Mar 2016 09:56:09 -0800
Subject: [PATCH] clocksource/arm_arch_timer: Map frame with
 of_io_request_and_map()
Message-ID: <1457114169-16301-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Let's use the of_io_request_and_map() API so that the frame
region is protected and shows up in /proc/iomem.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This one seems to have been lost in the replies so I'm sending it
seperately.

 drivers/clocksource/arm_arch_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5152b3898155..9a2c616e08a3 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -827,7 +827,8 @@ static void __init arch_timer_mem_init(struct device_node *np)
 		best_frame = of_node_get(frame);
 	}
 
-	base = arch_counter_base = of_iomap(best_frame, 0);
+	base = arch_counter_base = of_io_request_and_map(best_frame, 0,
+							 "arch_mem_timer");
 	if (!base) {
 		pr_err("arch_timer: Can't map frame's registers\n");
 		goto out;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
