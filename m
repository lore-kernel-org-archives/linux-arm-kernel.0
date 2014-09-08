From: rric@kernel.org (Robert Richter)
Date: Mon,  8 Sep 2014 16:11:19 +0200
Subject: [PATCH] GICv3: Fixing 32 bit compatibility
Message-ID: <1410185480-5153-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

Fixing 32 bit compatibility by using ULL for u64 constants.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 57eaa5a0b1e3..9e13c87c7dfe 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -441,7 +441,7 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 
 		mpidr = cpu_logical_map(cpu);
 
-		if (cluster_id != (mpidr & ~0xffUL)) {
+		if (cluster_id != (mpidr & ~0xffULL)) {
 			cpu--;
 			goto out;
 		}
@@ -479,7 +479,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	smp_wmb();
 
 	for_each_cpu_mask(cpu, *mask) {
-		u64 cluster_id = cpu_logical_map(cpu) & ~0xffUL;
+		u64 cluster_id = cpu_logical_map(cpu) & ~0xffULL;
 		u16 tlist;
 
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
-- 
2.0.1
