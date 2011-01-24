From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Jan 2011 16:39:48 +0000
Subject: [PATCH] arm: Reset SP804 timer when initialising it as a clock events
	device
Message-ID: <1295887188-25924-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SP804 driver resets relevant timer when initialising it as
a clock source, but it doesn't do this for clock event device.

Fixed.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/common/timer-sp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 6ef3342..e64cad3 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -142,6 +142,9 @@ void __init sp804_clockevents_init(void __iomem *base, unsigned int timer_irq)
 
 	clkevt_base = base;
 
+	/* Reset the timer to prevent spurious interrupts */
+	writel(0, clkevt_base + TIMER_CTRL);
+
 	evt->irq = timer_irq;
 	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
 	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
-- 
1.6.3.3
