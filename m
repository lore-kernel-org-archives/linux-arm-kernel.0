From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Sat, 16 May 2015 15:58:24 +0800
Subject: [PATCH v2 3/9] clocksource: mediatek: do not enable GPT_CLK_EVT when
 setup
In-Reply-To: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1431763110-443-4-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spurious mtk timer interrupt is noticed at boot and cause kernel
crash. It seems if GPT is enabled, it will latch irq status even
when its IRQ is disabled. When irq is enabled afterward, we see
spurious interrupt.
Change init flow to only enable GPT_CLK_SRC at mtk_timer_init.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/clocksource/mtk_timer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
index 68ab423..91206f9 100644
--- a/drivers/clocksource/mtk_timer.c
+++ b/drivers/clocksource/mtk_timer.c
@@ -157,8 +157,11 @@ static void mtk_timer_global_reset(struct mtk_clock_event_device *evt)
 }
 
 static void
-mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
+mtk_timer_setup(struct mtk_clock_event_device *evt,
+		u8 timer, u8 option, u8 enable)
 {
+	u32 val;
+
 	writel(TIMER_CTRL_CLEAR | TIMER_CTRL_DISABLE,
 		evt->gpt_base + TIMER_CTRL_REG(timer));
 
@@ -167,8 +170,10 @@ mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
 
 	writel(0x0, evt->gpt_base + TIMER_CMP_REG(timer));
 
-	writel(TIMER_CTRL_OP(option) | TIMER_CTRL_ENABLE,
-			evt->gpt_base + TIMER_CTRL_REG(timer));
+	val = TIMER_CTRL_OP(option);
+	if (enable)
+		val |= TIMER_CTRL_ENABLE;
+	writel(val, evt->gpt_base + TIMER_CTRL_REG(timer));
 }
 
 static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
@@ -235,12 +240,12 @@ static void __init mtk_timer_init(struct device_node *node)
 	evt->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
 
 	/* Configure clock source */
-	mtk_timer_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN);
+	mtk_timer_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN, 1);
 	clocksource_mmio_init(evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC),
 			node->name, rate, 300, 32, clocksource_mmio_readl_up);
 
 	/* Configure clock event */
-	mtk_timer_setup(evt, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT);
+	mtk_timer_setup(evt, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT, 0);
 	clockevents_config_and_register(&evt->dev, rate, 0x3,
 					0xffffffff);
 
-- 
1.8.1.1.dirty
