From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 15:31:12 -0700
Subject: [PATCH 13/18] ARM: u300: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1375309877-16617-14-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-u300/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index b5db207..d23a1f0 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -341,7 +341,7 @@ static struct irqaction u300_timer_irq = {
  * stamp. (Inspired by OMAP implementation.)
  */
 
-static u32 notrace u300_read_sched_clock(void)
+static u64 notrace u300_read_sched_clock(void)
 {
 	return readl(u300_timer_base + U300_TIMER_APP_GPT2CC);
 }
@@ -380,7 +380,7 @@ static void __init u300_timer_init_of(struct device_node *np)
 	clk_prepare_enable(clk);
 	rate = clk_get_rate(clk);
 
-	setup_sched_clock(u300_read_sched_clock, 32, rate);
+	sched_clock_register(u300_read_sched_clock, 32, rate);
 
 	u300_delay_timer.read_current_timer = &u300_read_current_timer;
 	u300_delay_timer.freq = rate;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
