From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:24 -0700
Subject: [PATCH v4 11/17] clocksource: nomadik: Switch to
 sched_clock_register()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-12-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/nomadik-mtu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index 7d2c2c5..2242cd3 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -76,7 +76,7 @@ static struct delay_timer mtu_delay_timer;
  * local implementation which uses the clocksource to get some
  * better resolution when scheduling the kernel.
  */
-static u32 notrace nomadik_read_sched_clock(void)
+static u64 notrace nomadik_read_sched_clock(void)
 {
 	if (unlikely(!mtu_base))
 		return 0;
@@ -230,7 +230,7 @@ static void __init __nmdk_timer_init(void __iomem *base, int irq,
 		       "mtu_0");
 
 #ifdef CONFIG_CLKSRC_NOMADIK_MTU_SCHED_CLOCK
-	setup_sched_clock(nomadik_read_sched_clock, 32, rate);
+	sched_clock_register(nomadik_read_sched_clock, 32, rate);
 #endif
 
 	/* Timer 1 is used for events, register irq and clockevents */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
