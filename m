From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Oct 2012 11:47:07 +0200
Subject: [PATCH 1/2] ARM: SMP_TWD: use DIV_ROUND_CLOSEST() for periodic mode
Message-ID: <1350640027-26216-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The periodic mode is currently calculated by a simple division
but we should pay more attention to our integer arithmetics.
Also delete a comment that does not make any sense.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/smp_twd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index e1f9069..b22d700 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -42,10 +42,10 @@ static void twd_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		/* timer load already set up */
 		ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
 			| TWD_TIMER_CONTROL_PERIODIC;
-		__raw_writel(twd_timer_rate / HZ, twd_base + TWD_TIMER_LOAD);
+		__raw_writel(DIV_ROUND_CLOSEST(twd_timer_rate, HZ),
+			twd_base + TWD_TIMER_LOAD);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* period set, and timer enabled in 'next_event' hook */
-- 
1.7.11.7
