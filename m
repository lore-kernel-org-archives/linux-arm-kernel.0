From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 22 Nov 2016 10:44:23 +0100
Subject: [PATCH 3/4] clocksource/drivers/arm_arch_timer: Map frame with
 of_io_request_and_map()
In-Reply-To: <1479807866-6957-1-git-send-email-daniel.lezcano@linaro.org>
References: <20161122094300.GA2017@mai>
 <1479807866-6957-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1479807866-6957-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

Let's use the of_io_request_and_map() API so that the frame
region is protected and shows up in /proc/iomem.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index a2503db..02fef68 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -971,8 +971,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
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
2.7.4
