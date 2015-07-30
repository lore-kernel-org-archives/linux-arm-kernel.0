From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 30 Jul 2015 17:26:12 +0100
Subject: [PATCH 1/2] irqchip/gic: Only allow the primary GIC to set the CPU map
Message-ID: <1438273573-27958-1-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gic_init_bases() function initialises an array that stores the mapping
between the GIC and CPUs. This array is a global array that is
unconditionally initialised on every call to gic_init_bases(). Although,
it is not common for there to be more than one GIC instance, there are
some devices that do support nested GIC controllers and gic_init_bases()
can be called more than once.

A 2nd call to gic_init_bases() will clear the previous CPU mapping and
will only setup the mapping again for the CPU calling gic_init_bases().
Fix this by only allowing the CPU map to be configured for the primary GIC.

For secondary GICs the CPU map is not relevant because these GICs do not
directly route the interrupts to the main CPU(s) but to other GICs or
devices.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/irqchip/irq-gic.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a530d9a9b810..7566fe259d27 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -416,19 +416,26 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 	int i;
 
 	/*
-	 * Get what the GIC says our CPU mask is.
+	 * Setting up the CPU map is only relevant for the primary GIC
+	 * because any nested/secondary GICs do not directly interface
+	 * with the CPU(s).
 	 */
-	BUG_ON(cpu >= NR_GIC_CPU_IF);
-	cpu_mask = gic_get_cpumask(gic);
-	gic_cpu_map[cpu] = cpu_mask;
+	if (gic == &gic_data[0]) {
+		/*
+		 * Get what the GIC says our CPU mask is.
+		 */
+		BUG_ON(cpu >= NR_GIC_CPU_IF);
+		cpu_mask = gic_get_cpumask(gic);
+		gic_cpu_map[cpu] = cpu_mask;
 
-	/*
-	 * Clear our mask from the other map entries in case they're
-	 * still undefined.
-	 */
-	for (i = 0; i < NR_GIC_CPU_IF; i++)
-		if (i != cpu)
-			gic_cpu_map[i] &= ~cpu_mask;
+		/*
+		 * Clear our mask from the other map entries in case they're
+		 * still undefined.
+		 */
+		for (i = 0; i < NR_GIC_CPU_IF; i++)
+			if (i != cpu)
+				gic_cpu_map[i] &= ~cpu_mask;
+	}
 
 	gic_cpu_config(dist_base, NULL);
 
@@ -977,13 +984,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	}
 
 	/*
-	 * Initialize the CPU interface map to all CPUs.
-	 * It will be refined as each CPU probes its ID.
-	 */
-	for (i = 0; i < NR_GIC_CPU_IF; i++)
-		gic_cpu_map[i] = 0xff;
-
-	/*
 	 * Find out how many interrupts are supported.
 	 * The GIC only supports up to 1020 interrupt sources.
 	 */
@@ -1028,6 +1028,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		return;
 
 	if (gic_nr == 0) {
+		/*
+		 * Initialize the CPU interface map to all CPUs.
+		 * It will be refined as each CPU probes its ID.
+		 * This is only necessary for the primary GIC.
+		 */
+		for (i = 0; i < NR_GIC_CPU_IF; i++)
+			gic_cpu_map[i] = 0xff;
 #ifdef CONFIG_SMP
 		set_smp_cross_call(gic_raise_softirq);
 		register_cpu_notifier(&gic_cpu_notifier);
-- 
2.1.4
