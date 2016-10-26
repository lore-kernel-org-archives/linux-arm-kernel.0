From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Oct 2016 00:35:50 -0700
Subject: [PATCH v2] clocksource/arm_arch_timer: Map frame with
 of_io_request_and_map()
Message-ID: <20161026073550.22918-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's use the of_io_request_and_map() API so that the frame
region is protected and shows up in /proc/iomem.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v1:
 * Check for IS_ERR instead

 drivers/clocksource/arm_arch_timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 73c487da6d2a..723cc924d8d1 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -964,8 +964,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	}
 
 	ret= -ENXIO;
-	base = arch_counter_base = of_iomap(best_frame, 0);
-	if (!base) {
+	base = arch_counter_base = of_io_request_and_map(best_frame, 0,
+							 "arch_mem_timer");
+	if (IS_ERR(base)) {
 		pr_err("arch_timer: Can't map frame's registers\n");
 		goto out;
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
