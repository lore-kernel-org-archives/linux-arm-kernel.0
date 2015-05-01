From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 1 May 2015 15:43:24 +0800
Subject: [PATCH 1/7] clocksource: mediatek: Don't run event_handler if it is
 NULL
In-Reply-To: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1430466210-22963-2-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spurious timer interrupt is noticed in mtk timer and cause kernel
crash. In mtk_timer_interrupt(), only run event_handler if it is
not NULL.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/clocksource/mtk_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
index 68ab423..85e0ab5 100644
--- a/drivers/clocksource/mtk_timer.c
+++ b/drivers/clocksource/mtk_timer.c
@@ -143,7 +143,8 @@ static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
 
 	/* Acknowledge timer0 irq */
 	writel(GPT_IRQ_ACK(GPT_CLK_EVT), evt->gpt_base + GPT_IRQ_ACK_REG);
-	evt->dev.event_handler(&evt->dev);
+	if (evt->dev.event_handler)
+		evt->dev.event_handler(&evt->dev);
 
 	return IRQ_HANDLED;
 }
-- 
1.8.1.1.dirty
