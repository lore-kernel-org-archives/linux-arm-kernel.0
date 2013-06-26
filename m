From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Jun 2013 23:17:00 +0200
Subject: [PATCH 7/8] clocksource: sun4i: Cleanup parent clock setup
In-Reply-To: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1372281421-2099-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current bring-up code for the timer was overly complicated. The only
thing we need is actually which clock we want to use as source and
that's pretty much all. Let's keep it that way.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/sun4i_timer.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 912d3e0..98e38a6 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -32,6 +32,9 @@
 #define TIMER_CTL_REG(val)	(0x10 * val + 0x10)
 #define TIMER_CTL_ENABLE		BIT(0)
 #define TIMER_CTL_AUTORELOAD		BIT(1)
+#define TIMER_CTL_CLK_SRC(val)		(((val) & 0x3) << 2)
+#define TIMER_CTL_CLK_SRC_OSC24M		(1)
+#define TIMER_CTL_CLK_PRES(val)		(((val) & 0x7) << 4)
 #define TIMER_CTL_ONESHOT		BIT(7)
 #define TIMER_INTVAL_REG(val)	(0x10 * val + 0x14)
 #define TIMER_CNTVAL_REG(val)	(0x10 * val + 0x18)
@@ -166,16 +169,8 @@ static void __init sun4i_timer_init(struct device_node *node)
 	writel(clk_get_rate(clk) / HZ,
 	       timer_base + TIMER_INTVAL_REG(0));
 
-	/* set clock source to HOSC, 16 pre-division */
-	val = readl(timer_base + TIMER_CTL_REG(0));
-	val &= ~(0x07 << 4);
-	val &= ~(0x03 << 2);
-	val |= (4 << 4) | (1 << 2);
-	writel(val, timer_base + TIMER_CTL_REG(0));
-
-	/* set mode to auto reload */
-	val = readl(timer_base + TIMER_CTL_REG(0));
-	writel(val | TIMER_CTL_AUTORELOAD, timer_base + TIMER_CTL_REG(0));
+	writel(TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M) | TIMER_CTL_AUTORELOAD,
+	       timer_base + TIMER_CTL_REG(0));
 
 	ret = setup_irq(irq, &sun4i_timer_irq);
 	if (ret)
-- 
1.8.3.1
