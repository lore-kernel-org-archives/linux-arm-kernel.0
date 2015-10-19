From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 19 Oct 2015 22:59:20 +0200
Subject: [PATCH 1/9] clockevents/drivers/mtk: Fix spurious interrupt leading
 to crash
In-Reply-To: <56255943.6060807@linaro.org>
References: <56255943.6060807@linaro.org>
Message-ID: <1445288368-6440-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After analysis done by Yingjoe Chen, the timer appears to have a pending
interrupt when it is enabled.

Fix this by acknowledging the pending interrupt when enabling the timer
interrupt.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/clocksource/mtk_timer.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
index 50f0641..c8badc4 100644
--- a/drivers/clocksource/mtk_timer.c
+++ b/drivers/clocksource/mtk_timer.c
@@ -141,14 +141,6 @@ static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void mtk_timer_global_reset(struct mtk_clock_event_device *evt)
-{
-	/* Disable all interrupts */
-	writel(0x0, evt->gpt_base + GPT_IRQ_EN_REG);
-	/* Acknowledge all interrupts */
-	writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);
-}
-
 static void
 mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
 {
@@ -168,6 +160,12 @@ static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
 {
 	u32 val;
 
+	/* Disable all interrupts */
+	writel(0x0, evt->gpt_base + GPT_IRQ_EN_REG);
+
+	/* Acknowledge all spurious pending interrupts */
+	writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);
+
 	val = readl(evt->gpt_base + GPT_IRQ_EN_REG);
 	writel(val | GPT_IRQ_ENABLE(timer),
 			evt->gpt_base + GPT_IRQ_EN_REG);
@@ -220,8 +218,6 @@ static void __init mtk_timer_init(struct device_node *node)
 	}
 	rate = clk_get_rate(clk);
 
-	mtk_timer_global_reset(evt);
-
 	if (request_irq(evt->dev.irq, mtk_timer_interrupt,
 			IRQF_TIMER | IRQF_IRQPOLL, "mtk_timer", evt)) {
 		pr_warn("failed to setup irq %d\n", evt->dev.irq);
-- 
1.9.1
