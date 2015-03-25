From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 25 Mar 2015 11:27:49 +0000
Subject: [PATCH RESEND 4/7] clocksource: dw_apb_timer_of: make IO endian
 agnostic
In-Reply-To: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427282872-10563-5-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dw_apb_timer_of timer is using __raw_readl to access the timer
register, which is causing issues when the system is running in
big endian mode. Fix this by using readl_relaxed() which should
account for the endian settings.

This fixes issues where the time jumps around in the dmesg output
due to returnling __le32 values.

For an example, these two console lines show time running backwards:

[   49.882572] CPU1: failed to come online
[   43.282457] Brought up 1 CPUs

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 drivers/clocksource/dw_apb_timer_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index d305fb0..a19a3f6 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -108,7 +108,7 @@ static void __init add_clocksource(struct device_node *source_timer)
 
 static u64 notrace read_sched_clock(void)
 {
-	return ~__raw_readl(sched_io_base);
+	return ~readl_relaxed(sched_io_base);
 }
 
 static const struct of_device_id sptimer_ids[] __initconst = {
-- 
2.1.4
