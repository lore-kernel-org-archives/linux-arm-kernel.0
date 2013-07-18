From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:22 -0700
Subject: [PATCH v4 09/17] clocksource: dw_apb_timer_of: Switch to
 sched_clock_register()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-10-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/dw_apb_timer_of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 4cbae4f..003b230 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -106,7 +106,7 @@ static void add_clocksource(struct device_node *source_timer)
 	sched_rate = rate;
 }
 
-static u32 read_sched_clock(void)
+static u64 read_sched_clock(void)
 {
 	return __raw_readl(sched_io_base);
 }
@@ -128,7 +128,7 @@ static void init_sched_clock(void)
 		of_node_put(sched_timer);
 	}
 
-	setup_sched_clock(read_sched_clock, 32, sched_rate);
+	sched_clock_register(read_sched_clock, 32, sched_rate);
 }
 
 static int num_called;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
