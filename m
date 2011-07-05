From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Jul 2011 09:49:15 +0100
Subject: [PATCH v8 14/14] ARM: gic: add gic_ppi_map_on_cpu()
In-Reply-To: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1309855755-6261-15-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is sometimes usefull to compute the mapping of a PPI on a CPU
that is not the one handling the interrupt (in the probe function
of a driver, for example).

The new gic_ppi_map_on_cpu() function does just that.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/common/gic.c               |    9 +++++++--
 arch/arm/include/asm/hardware/gic.h |    7 +++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 14ab235..70ef6a8 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -269,7 +269,7 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 }
 
 #ifdef CONFIG_ARM_GIC_PPI_MAP
-unsigned int gic_ppi_map(unsigned int irq)
+unsigned int gic_ppi_map_on_cpu(unsigned int irq, int cpu)
 {
 	struct gic_chip_data *chip_data = irq_get_chip_data(irq);
 	unsigned int vppi_irq;
@@ -278,12 +278,17 @@ unsigned int gic_ppi_map(unsigned int irq)
 	WARN_ON(!chip_data->vppi_base);
 
 	ppi = irq - chip_data->ppi_base;
-	vppi_irq = ppi + chip_data->nrppis * smp_processor_id();
+	vppi_irq = ppi + chip_data->nrppis * cpu;
 	vppi_irq += chip_data->vppi_base;
 
 	return vppi_irq;
 }
 
+unsigned int gic_ppi_map(unsigned int irq)
+{
+	return gic_ppi_map_on_cpu(irq, smp_processor_id());
+}
+
 static void gic_handle_ppi(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int vppi_irq;
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index bad26c2..52dc4dd 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -44,11 +44,10 @@ void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 #ifdef CONFIG_ARM_GIC_PPI_MAP
 unsigned int gic_ppi_map(unsigned int irq);
+unsigned int gic_ppi_map_on_cpu(unsigned int irq, int cpu);
 #else
-static inline unsigned int gic_ppi_map(unsigned int irq)
-{
-	return irq;
-}
+#define gic_ppi_map(irq)		(irq)
+#define gic_ppi_map_on_cpu(irq, cpu)	(irq)
 #endif
 
 #endif
-- 
1.7.0.4
