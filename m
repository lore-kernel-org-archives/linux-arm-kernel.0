From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Oct 2016 16:45:14 -0700
Subject: [PATCH/RESEND] clocksource/arm_arch_timer: Map frame with
 of_io_request_and_map()
Message-ID: <20161018234514.6175-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's use the of_io_request_and_map() API so that the frame
region is protected and shows up in /proc/iomem.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/arm_arch_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 73c487da6d2a..cbfa3bc5be75 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -964,7 +964,8 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	}
 
 	ret= -ENXIO;
-	base = arch_counter_base = of_iomap(best_frame, 0);
+	base = arch_counter_base = of_io_request_and_map(best_frame, 0,
+							 "arch_mem_timer");
 	if (!base) {
 		pr_err("arch_timer: Can't map frame's registers\n");
 		goto out;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
