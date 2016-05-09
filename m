From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:02:49 +0930
Subject: [PATCH 4/4] drivers/clocksource/moxart: Add Aspeed support
In-Reply-To: <1462797169-14512-1-git-send-email-joel@jms.id.au>
References: <1462797169-14512-1-git-send-email-joel@jms.id.au>
Message-ID: <1462797169-14512-5-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Aspeed SoC has timer IP with a very similar register layout to the
moxart timer. This patch adds support for the fourth and fifth gen
aspeed SoCs, and has been tested on the ast2400 and ast2500.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../bindings/timer/moxa,moxart-timer.txt           |  4 ++-
 drivers/clocksource/moxart_timer.c                 | 32 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt b/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
index da2d510cae47..e207c11630af 100644
--- a/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
+++ b/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
@@ -2,7 +2,9 @@ MOXA ART timer
 
 Required properties:
 
-- compatible : Must be "moxa,moxart-timer"
+- compatible : Must be one of:
+ 	- "moxa,moxart-timer"
+ 	- "aspeed,ast2400-timer"
 - reg : Should contain registers location and length
 - interrupts : Should contain the timer interrupt number
 - clocks : Should contain phandle for the clock that drives the counter
diff --git a/drivers/clocksource/moxart_timer.c b/drivers/clocksource/moxart_timer.c
index d17e3eface87..83ffa2727699 100644
--- a/drivers/clocksource/moxart_timer.c
+++ b/drivers/clocksource/moxart_timer.c
@@ -56,6 +56,23 @@
 #define MOXART_TIMER1_ENABLE	(MOXART_CR_2_ENABLE | MOXART_CR_1_ENABLE)
 #define MOXART_TIMER1_DISABLE	(MOXART_CR_2_ENABLE)
 
+/*
+ * The ASpeed variant of the IP block has a different layout
+ * for the control register
+ */
+#define ASPEED_CR_1_ENABLE	BIT(0)
+#define ASPEED_CR_1_CLOCK	BIT(1)
+#define ASPEED_CR_1_INT		BIT(2)
+#define ASPEED_CR_2_ENABLE	BIT(4)
+#define ASPEED_CR_2_CLOCK	BIT(5)
+#define ASPEED_CR_2_INT		BIT(6)
+#define ASPEED_CR_3_ENABLE	BIT(8)
+#define ASPEED_CR_3_CLOCK	BIT(9)
+#define ASPEED_CR_3_INT		BIT(10)
+
+#define ASPEED_TIMER1_ENABLE   (ASPEED_CR_2_ENABLE | ASPEED_CR_1_ENABLE)
+#define ASPEED_TIMER1_DISABLE  (ASPEED_CR_2_ENABLE)
+
 struct moxart_timer {
 	void __iomem *base;
 	unsigned int t1_disable_val;
@@ -159,6 +176,9 @@ static void __init moxart_timer_init(struct device_node *node)
 	if (of_device_is_compatible(node, "moxa,moxart-timer")) {
 		timer->t1_enable_val = MOXART_TIMER1_ENABLE;
 		timer->t1_disable_val = MOXART_TIMER1_DISABLE;
+	} else if (of_device_is_compatible(node, "aspeed,ast2400-timer")) {
+		timer->t1_enable_val = ASPEED_TIMER1_ENABLE;
+		timer->t1_disable_val = ASPEED_TIMER1_DISABLE;
 	} else
 		panic("%s: unknown platform\n", node->full_name);
 
@@ -189,6 +209,17 @@ static void __init moxart_timer_init(struct device_node *node)
 	if (ret)
 		panic("%s: setup_irq failed\n", node->full_name);
 
+	/* Clear match registers */
+	writel(0, timer->base + TIMER1_BASE + REG_MATCH1);
+	writel(0, timer->base + TIMER1_BASE + REG_MATCH2);
+	writel(0, timer->base + TIMER2_BASE + REG_MATCH1);
+	writel(0, timer->base + TIMER2_BASE + REG_MATCH2);
+
+	/*
+	 * Start timer 2 rolling as our main wall clock source, keep timer 1
+	 * disabled
+	 */
+	writel(0, timer->base + TIMER_CR);
 	writel(~0, timer->base + TIMER2_BASE + REG_LOAD);
 	writel(timer->t1_disable_val, timer->base + TIMER_CR);
 
@@ -201,3 +232,4 @@ static void __init moxart_timer_init(struct device_node *node)
 	clockevents_config_and_register(&timer->clkevt, pclk, 0x4, 0xfffffffe);
 }
 CLOCKSOURCE_OF_DECLARE(moxart, "moxa,moxart-timer", moxart_timer_init);
+CLOCKSOURCE_OF_DECLARE(aspeed, "aspeed,ast2400-timer", moxart_timer_init);
-- 
2.8.1
