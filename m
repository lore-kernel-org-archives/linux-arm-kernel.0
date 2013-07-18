From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:20 -0700
Subject: [PATCH v4 07/17] clocksource: bcm2835: Switch to
 sched_clock_register()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-8-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/bcm2835_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 07ea7ce..26ed331 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -49,7 +49,7 @@ struct bcm2835_timer {
 
 static void __iomem *system_clock __read_mostly;
 
-static u32 notrace bcm2835_sched_read(void)
+static u64 notrace bcm2835_sched_read(void)
 {
 	return readl_relaxed(system_clock);
 }
@@ -110,7 +110,7 @@ static void __init bcm2835_timer_init(struct device_node *node)
 		panic("Can't read clock-frequency");
 
 	system_clock = base + REG_COUNTER_LO;
-	setup_sched_clock(bcm2835_sched_read, 32, freq);
+	sched_clock_register(bcm2835_sched_read, 32, freq);
 
 	clocksource_mmio_init(base + REG_COUNTER_LO, node->name,
 		freq, 300, 32, clocksource_mmio_readl_up);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
