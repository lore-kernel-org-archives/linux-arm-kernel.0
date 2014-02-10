From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Feb 2014 14:22:36 +0000
Subject: [PATCH v2 2/5] irqchip: gic: use writel instead of dsb +
 writel_relaxed
In-Reply-To: <1392042159-11603-1-git-send-email-will.deacon@arm.com>
References: <1392042159-11603-1-git-send-email-will.deacon@arm.com>
Message-ID: <1392042159-11603-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When sending an SGI to another CPU, we require a DSB to ensure that
any pending stores to normal memory are made visible to the recipient
before the interrupt arrives.

Rather than use a vanilla dsb() (which will soon cause an assembly error
on arm64) before the writel_relaxed, we can instead use dsb(ishst),
since we just need to ensure that any pending normal writes are visible
within the inner-shareable domain before we poke the GIC.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v1 => v2: Use dsb ishst instead of writel (which requires an L2 sync)
          since the sync should already have been executed by the caller
	  if required. We *might* be able to relax this further to a dmb
	  but Catalin and I haven't got to the bottom of that yet.

Marc: I dropped your Ack, so could you take another look please?

 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 341c6016812d..26ff83c455f3 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -663,7 +663,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	dsb();
+	dsb(ishst);
 
 	/* this always happens on GIC0 */
 	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
-- 
1.8.2.2
