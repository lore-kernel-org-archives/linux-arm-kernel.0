From: will.deacon@arm.com (Will Deacon)
Date: Tue,  9 Aug 2011 22:42:37 +0100
Subject: [RFC PATCH 3/8] ARM: gic: convert logical CPU numbers into physical
	numbers
In-Reply-To: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
References: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312926162-22469-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC driver must convert logical CPU numbers passed in from Linux
into physical CPU numbers that are understood by the hardware.

This patch uses the new cpu_logical_map macro for performing the
conversion inside the GIC driver.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/common/gic.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 3227ca9..6822c10 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -180,7 +180,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 		return -EINVAL;
 
 	mask = 0xff << shift;
-	bit = 1 << (cpu + shift);
+	bit = 1 << (cpu_logical_map(cpu) + shift);
 
 	spin_lock(&irq_controller_lock);
 	val = readl_relaxed(reg) & ~mask;
@@ -260,7 +260,8 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
 {
 	unsigned int gic_irqs, irq_limit, i;
 	void __iomem *base = gic->dist_base;
-	u32 cpumask = 1 << smp_processor_id();
+	u32 cpu = cpu_logical_map(smp_processor_id());
+	u32 cpumask = 1 << cpu;
 
 	cpumask |= cpumask << 8;
 	cpumask |= cpumask << 16;
@@ -382,7 +383,12 @@ void __cpuinit gic_enable_ppi(unsigned int irq)
 #ifdef CONFIG_SMP
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
-	unsigned long map = *cpus_addr(*mask);
+	int cpu;
+	unsigned long map = 0;
+
+	/* Convert our logical CPU mask into a physical one. */
+	for_each_cpu(cpu, mask)
+		map |= 1 << cpu_logical_map(cpu);
 
 	/*
 	 * Ensure that stores to Normal memory are visible to the
-- 
1.7.0.4
