From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:10:21 +0100
Subject: [PATCH 3/6] ARM: twd: register clockevents device before enabling PPI
In-Reply-To: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
References: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823424-9654-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_twd clockevents driver currently enables the local timer PPI
before the clockevents device is registered. This can lead to a kernel
panic if a spurious timer interrupt is generated before registration
has completed since the kernel will treat it as an IPI timer.

This patch moves the clockevents device registration before the IRQ
unmasking so that we can always handle timer interrupts once they can
occur.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/smp_twd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 2c277d4..01c1862 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -137,8 +137,8 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
 	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
 
+	clockevents_register_device(clk);
+
 	/* Make sure our local interrupt controller has this enabled */
 	gic_enable_ppi(clk->irq);
-
-	clockevents_register_device(clk);
 }
-- 
1.7.0.4
