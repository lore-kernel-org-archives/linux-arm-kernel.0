From: chanho.min@lge.com (Chanho Min)
Date: Wed, 17 Sep 2014 09:42:51 +0900
Subject: [PATCH] ARM: timer-sp: ensure interrupt is cleared at
 sp804_clockevents_init
Message-ID: <1410914571-8388-1-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When sp804 is registerd as clock event device, it may not be added to
tick device if the higher rated device is already registerd. In this case,
for uncertan reason, inetrrupt is occured without event_handler it cause
kernel panic. So Interrupt should be cleared before clockevent is registered.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm/common/timer-sp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index fd6bff0..b658873 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -205,6 +205,8 @@ void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struc
 
 	writel(0, base + TIMER_CTRL);
 
+	/* Ensure interrupt is cleared */
+	writel(1, clkevt_base + TIMER_INTCLR);
 	setup_irq(irq, &sp804_timer_irq);
 	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
 }
-- 
1.7.9.5
