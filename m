From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 13 Jul 2015 17:32:45 +0800
Subject: [PATCH 1/5] clocksource: mediatek: do not enable GPT_CLK_EVT when
 setup
In-Reply-To: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1436779969-18610-2-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spurious mtk timer interrupt is noticed at boot and cause kernel
crash. It seems if GPT is enabled, it will latch irq status even
when its IRQ is disabled. When irq is enabled afterward, we see
spurious interrupt.
Change init flow to only enable GPT_CLK_SRC at mtk_timer_init.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/clocksource/mtk_timer.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
index 68ab423..237c20b 100644
--- a/drivers/clocksource/mtk_timer.c
+++ b/drivers/clocksource/mtk_timer.c
@@ -156,9 +156,11 @@ static void mtk_timer_global_reset(struct mtk_clock_event_device *evt)
 	writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);
 }
 
-static void
-mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
+static void mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer,
+			    u8 option, bool enable)
 {
+	u32 val;
+
 	writel(TIMER_CTRL_CLEAR | TIMER_CTRL_DISABLE,
 		evt->gpt_base + TIMER_CTRL_REG(timer));
 
@@ -167,8 +169,10 @@ mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
 
 	writel(0x0, evt->gpt_base + TIMER_CMP_REG(timer));
 
-	writel(TIMER_CTRL_OP(option) | TIMER_CTRL_ENABLE,
-			evt->gpt_base + TIMER_CTRL_REG(timer));
+	val = TIMER_CTRL_OP(option);
+	if (enable)
+		val |= TIMER_CTRL_ENABLE;
+	writel(val, evt->gpt_base + TIMER_CTRL_REG(timer));
 }
 
 static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
@@ -235,12 +239,12 @@ static void __init mtk_timer_init(struct device_node *node)
 	evt->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
 
 	/* Configure clock source */
-	mtk_timer_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN);
+	mtk_timer_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN, true);
 	clocksource_mmio_init(evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC),
 			node->name, rate, 300, 32, clocksource_mmio_readl_up);
 
 	/* Configure clock event */
-	mtk_timer_setup(evt, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT);
+	mtk_timer_setup(evt, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT, false);
 	clockevents_config_and_register(&evt->dev, rate, 0x3,
 					0xffffffff);
 
-- 
1.8.1.1.dirty
