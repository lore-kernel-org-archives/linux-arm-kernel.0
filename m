From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:54:02 +0200
Subject: [PATCH v3 05/11] irqchip: irq-armada-370-xp: use cpu notifier to
 initialize secondary CPUs
In-Reply-To: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483648-26611-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some irqchip initialization must be done on secondary CPUs. On mvebu
platforms, this is currently achieved by having the
arch/arm/mach-mvebu/platsmp.c code directly call into a function
exported by the irqchip driver, which isn't really nice.

This commit changes this by using the same solution as the one used in
the GIC driver: the irqchip driver registers a CPU notifier, which is
used to do the secondary CPU IRQ initialization. This way, the irqchip
driver is completely autonomous, and the function no longer needs to
be exposed from the irqchip driver to the SoC code.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.h |  1 -
 arch/arm/mach-mvebu/platsmp.c       |  6 ------
 drivers/irqchip/irq-armada-370-xp.c | 18 +++++++++++++++++-
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index cd57c78..c3465f5 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -20,7 +20,6 @@
 
 #define ARMADA_XP_MAX_CPUS 4
 
-void armada_xp_mpic_smp_cpu_init(void);
 void armada_xp_secondary_startup(void);
 extern struct smp_operations armada_xp_smp_ops;
 #endif
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 1bc98ce..32bf78e 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -70,11 +70,6 @@ static void __init set_secondary_cpus_clock(void)
 	}
 }
 
-static void armada_xp_secondary_init(unsigned int cpu)
-{
-	armada_xp_mpic_smp_cpu_init();
-}
-
 static int armada_xp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int ret, hw_cpu;
@@ -130,7 +125,6 @@ static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 struct smp_operations armada_xp_smp_ops __initdata = {
 	.smp_init_cpus		= armada_xp_smp_init_cpus,
 	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
-	.smp_secondary_init	= armada_xp_secondary_init,
 	.smp_boot_secondary	= armada_xp_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= armada_xp_cpu_die,
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 7275662..71f7784 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -336,7 +337,7 @@ static void armada_mpic_send_doorbell(const struct cpumask *mask,
 		ARMADA_370_XP_SW_TRIG_INT_OFFS);
 }
 
-void armada_xp_mpic_smp_cpu_init(void)
+static void armada_xp_mpic_smp_cpu_init(void)
 {
 	/* Clear pending IPIs */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
@@ -348,6 +349,20 @@ void armada_xp_mpic_smp_cpu_init(void)
 	/* Unmask IPI interrupt */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
+
+static int armada_xp_mpic_secondary_init(struct notifier_block *nfb,
+					 unsigned long action, void *hcpu)
+{
+	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
+		armada_xp_mpic_smp_cpu_init();
+	return NOTIFY_OK;
+}
+
+static struct notifier_block armada_370_xp_mpic_cpu_notifier = {
+	.notifier_call = armada_xp_mpic_secondary_init,
+	.priority = 100,
+};
+
 #endif /* CONFIG_SMP */
 
 static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
@@ -514,6 +529,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 		set_handle_irq(armada_370_xp_handle_irq);
 #ifdef CONFIG_SMP
 		set_smp_cross_call(armada_mpic_send_doorbell);
+		register_cpu_notifier(&armada_370_xp_mpic_cpu_notifier);
 #endif
 	} else {
 		irq_set_chained_handler(parent_irq,
-- 
1.8.3.2
