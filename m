From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Feb 2014 17:42:07 +0000
Subject: [PATCH] irqchip: gic: use dmb ishst instead of dsb when raising a
 softirq
Message-ID: <1392918127-1430-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When sending an SGI to another CPU, we require a barrier to ensure that
any pending stores to normal memory are made visible to the recipient
before the interrupt arrives.

Rather than use a vanilla dsb() (which will soon cause an assembly error
on arm64) before the writel_relaxed, we can instead use dsb(ishst),
since we just need to ensure that any pending normal writes are visible
within the inner-shareable domain before we poke the GIC.

With this observation, we can then further weaken the barrier to a
dmb(ishst), since other CPUs in the inner-shareable domain must observe
the write to the distributor before the SGI is generated.

Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Hi Olof,

Please can you take this via arm-soc for 3.15? That will let me activate
the new barrier options for arm64 at the end of the next merge window
(in the meantime, you can pass them but they are ignored).

Cheers,

Will

 drivers/irqchip/irq-gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 341c6016812d..500e533b9648 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -661,9 +661,9 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 	/*
 	 * Ensure that stores to Normal memory are visible to the
-	 * other CPUs before issuing the IPI.
+	 * other CPUs before they observe us issuing the IPI.
 	 */
-	dsb();
+	dmb(ishst);
 
 	/* this always happens on GIC0 */
 	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
-- 
1.8.2.2
