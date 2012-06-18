From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 13:30:04 +0200
Subject: [RFC PATCH 1/8] ARM: gic: Support forcing cpumask for possible cpus
 in the system
In-Reply-To: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
Message-ID: <1340019011-18642-2-git-send-email-monstr@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gic_set_affinity doesn't support force option. Force option
should work with all possible cpus in the system not only with
online cpus.

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/arm/common/gic.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index aa52699..4003cc2 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -235,9 +235,14 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 {
 	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
 	unsigned int shift = (gic_irq(d) % 4) * 8;
-	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	unsigned int cpu;
 	u32 val, mask, bit;
 
+	if (force)
+		cpu = cpumask_any_and(mask_val, cpu_possible_mask);
+	else
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+
 	if (cpu >= 8 || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-- 
1.7.0.4
