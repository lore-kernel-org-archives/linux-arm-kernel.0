From: chanho.min@lge.com (Chanho Min)
Date: Wed, 17 Sep 2014 20:34:46 +0900
Subject: [PATCH v2] ARM: timer-sp: ensure interrupt is cleared at sp804_of_init
Message-ID: <1410953686-15072-1-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sp804 may not be added to the tick device if the higher device is
already registered. In this case, If pending interrupt is existed
(usually It will be passed from the boot loader), inetrrupt is occured
without event_handler then it cause kernel panic. So Interrupts
should be cleared before clockevent is registered.

Changes since v1:
 - Move to sp804_of_init
 - Clear TIMER2 interrupt
 - Update commit log

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm/common/timer-sp.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index fd6bff0..e3cc08e 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -226,6 +226,10 @@ static void __init sp804_of_init(struct device_node *np)
 	writel(0, base + TIMER_CTRL);
 	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
 
+	/* Ensure interrupt is cleared */
+	writel(1, base + TIMER_INTCLR);
+	writel(1, base + TIMER_2_BASE + TIMER_INTCLR);
+
 	if (initialized || !of_device_is_available(np))
 		goto err;
 
-- 
1.7.9.5
