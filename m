From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 13 Jul 2015 17:32:46 +0800
Subject: [PATCH 2/5] clocksource: mediatek: Use GPT as sched clock source
In-Reply-To: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1436779969-18610-3-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When cpu is in deep idle, arch timer will stop counting. Setup GPT as
sched clock source so it can keep counting in idle.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/clocksource/mtk_timer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
index 237c20b..ae95b29 100644
--- a/drivers/clocksource/mtk_timer.c
+++ b/drivers/clocksource/mtk_timer.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/sched_clock.h>
 #include <linux/slab.h>
 
 #define GPT_IRQ_EN_REG		0x00
@@ -59,6 +60,13 @@ struct mtk_clock_event_device {
 	struct clock_event_device dev;
 };
 
+static void __iomem *gpt_sched_reg __read_mostly;
+
+static u64 notrace mtk_read_sched_clock(void)
+{
+	return readl_relaxed(gpt_sched_reg);
+}
+
 static inline struct mtk_clock_event_device *to_mtk_clk(
 				struct clock_event_device *c)
 {
@@ -242,6 +250,8 @@ static void __init mtk_timer_init(struct device_node *node)
 	mtk_timer_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN, true);
 	clocksource_mmio_init(evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC),
 			node->name, rate, 300, 32, clocksource_mmio_readl_up);
+	gpt_sched_reg = evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC);
+	sched_clock_register(mtk_read_sched_clock, 32, rate);
 
 	/* Configure clock event */
 	mtk_timer_setup(evt, GPT_CLK_EVT, TIMER_CTRL_OP_REPEAT, false);
-- 
1.8.1.1.dirty
