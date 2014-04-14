From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:54:01 +0200
Subject: [PATCH v3 04/11] irqchip: irq-armada-370-xp: do the
 set_smp_cross_call() in the driver
In-Reply-To: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483648-26611-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having the SoC code in arch/arm/mach-mvebu/platsmp.c do the
set_smp_cross_call() to register the IPI-triggering function, it makes
more sense to do exactly what the GIC driver is doing: let the irqchip
driver do it. This way, it avoids having to expose the
armada_mpic_send_doorbell() function between the irqchip driver and
the SoC code.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.h | 1 -
 arch/arm/mach-mvebu/platsmp.c       | 2 --
 drivers/irqchip/irq-armada-370-xp.c | 6 +++++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index 237c86b..cd57c78 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -20,7 +20,6 @@
 
 #define ARMADA_XP_MAX_CPUS 4
 
-void armada_mpic_send_doorbell(const struct cpumask *mask, unsigned int irq);
 void armada_xp_mpic_smp_cpu_init(void);
 void armada_xp_secondary_startup(void);
 extern struct smp_operations armada_xp_smp_ops;
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index e01ae51..1bc98ce 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -98,8 +98,6 @@ static void __init armada_xp_smp_init_cpus(void)
 
 	if (ncores == 0 || ncores > ARMADA_XP_MAX_CPUS)
 		panic("Invalid number of CPUs in DT\n");
-
-	set_smp_cross_call(armada_mpic_send_doorbell);
 }
 
 static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 41be897..7275662 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -315,7 +315,8 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 }
 
 #ifdef CONFIG_SMP
-void armada_mpic_send_doorbell(const struct cpumask *mask, unsigned int irq)
+static void armada_mpic_send_doorbell(const struct cpumask *mask,
+				      unsigned int irq)
 {
 	int cpu;
 	unsigned long map = 0;
@@ -511,6 +512,9 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 	if (parent_irq <= 0) {
 		irq_set_default_host(armada_370_xp_mpic_domain);
 		set_handle_irq(armada_370_xp_handle_irq);
+#ifdef CONFIG_SMP
+		set_smp_cross_call(armada_mpic_send_doorbell);
+#endif
 	} else {
 		irq_set_chained_handler(parent_irq,
 					armada_370_xp_mpic_handle_cascade_irq);
-- 
1.8.3.2
