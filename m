From: eric@anholt.net (Eric Anholt)
Date: Mon,  4 Apr 2016 20:44:18 -0700
Subject: [PATCH 4/4] irqchip: bcm2836: Use a more generic memory barrier call
In-Reply-To: <1459827858-3871-1-git-send-email-eric@anholt.net>
References: <1459827858-3871-1-git-send-email-eric@anholt.net>
Message-ID: <1459827858-3871-5-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dsb() requires an argument on arm64, so we needed to add "sy".
Instead, take this opportunity to switch to the same smp_wmb() call
that gic uses for its IPIs.  This is a less strong barrier than we
were doing before (dmb(ishst) compared to dsb(sy)), but it seems to be
the correct one.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/irqchip/irq-bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index ee62413..a99b630 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -195,7 +195,7 @@ static void bcm2836_arm_irqchip_send_ipi(const struct cpumask *mask,
 	 * Ensure that stores to normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	dsb();
+	smp_wmb();
 
 	for_each_cpu(cpu, mask)	{
 		writel(1 << ipi, mailbox0_base + 16 * cpu);
-- 
2.7.0
