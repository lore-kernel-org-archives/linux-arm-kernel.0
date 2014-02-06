From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Feb 2014 11:30:50 +0000
Subject: [PATCH 3/6] irqchip: gic: use writel instead of dsb + writel_relaxed
In-Reply-To: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
Message-ID: <1391686253-13436-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When sending an SGI to another CPU, we require a DSB to ensure that
any pending stores to normal memory are made visible to the recipient
before the interrupt arrives.

Rather than use a dsb() (which will soon cause an assembly error on
arm64) followed by a writel_relaxed, we can use a writel instead, which
will emit a dsb st prior to the str.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/irqchip/irq-gic.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 341c6016812d..03fe5ef3f2fe 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -662,11 +662,10 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	/*
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
+	 *
+	 * This always happens on GIC0.
 	 */
-	dsb();
-
-	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+	writel(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
-- 
1.8.2.2
