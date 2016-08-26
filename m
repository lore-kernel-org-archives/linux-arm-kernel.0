From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 26 Aug 2016 16:20:44 +0200
Subject: [PATCH 2/3] drivers/clocksource/pistachio: Fix memory corruption in
 init
In-Reply-To: <1472221245-14265-1-git-send-email-daniel.lezcano@linaro.org>
References: <57C05026.7010905@linaro.org>
 <1472221245-14265-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1472221245-14265-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

Driver init code incorrectly uses the block base address and as a result
clears clocksource structure's fields instead of the hardware registers.

Commit 09a998201649 ("timekeeping: Lift clocksource cacheline
restriction") has changed the offsets within pistachio_clocksource
structure and what has previously gone unnoticed now leads to a kernel
panic during boot.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/time-pistachio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
index a7d9a08..a8e6c7d 100644
--- a/drivers/clocksource/time-pistachio.c
+++ b/drivers/clocksource/time-pistachio.c
@@ -202,10 +202,10 @@ static int __init pistachio_clksrc_of_init(struct device_node *node)
 	rate = clk_get_rate(fast_clk);
 
 	/* Disable irq's for clocksource usage */
-	gpt_writel(&pcs_gpt.base, 0, TIMER_IRQ_MASK, 0);
-	gpt_writel(&pcs_gpt.base, 0, TIMER_IRQ_MASK, 1);
-	gpt_writel(&pcs_gpt.base, 0, TIMER_IRQ_MASK, 2);
-	gpt_writel(&pcs_gpt.base, 0, TIMER_IRQ_MASK, 3);
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 0);
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 1);
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 2);
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 3);
 
 	/* Enable timer block */
 	writel(TIMER_ME_GLOBAL, pcs_gpt.base);
-- 
1.9.1
