From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed, 31 Jan 2018 18:03:42 -0600
Subject: [PATCH] irqchip/gic-v3: Use wmb() instead of smb_wmb() in
 gic_raise_softirq()
Message-ID: <1517443422-30693-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A DMB instruction can be used to ensure the relative order of only
memory accesses before and after the barrier. Since writes to system
registers are not memory operations, barrier DMB is not sufficient
for observability of memory accesses that occur before ICC_SGI1R_EL1
writes.

A DSB instruction ensures that no instructions that appear in program
order after the DSB instruction, can execute until the DSB instruction
has completed.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b56c3e2..980ae8e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -688,7 +688,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	smp_wmb();
+	wmb();
 
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
