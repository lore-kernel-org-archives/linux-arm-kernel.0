From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 7 Oct 2011 10:23:31 +0100
Subject: [PATCH] ARM: gic: allow GIC to support non-banked setups
Message-ID: <mailman.172.1317980680.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC support code is heavily using the fact that hardware
implementations are exposing banked registers. Unfortunately, it
looks like at least one GIC implementation (EXYNOS4) offers both
the distributor and the CPU interfaces at different addresses,
depending on the CPU.

This problem is solved by turning the distributor and CPU interface
addresses into per-cpu variables. The EXYNOS4 code is updated not
to mess with the GIC internals while handling interrupts, and
struct gic_chip_data is back to being private.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/common/gic.c               |   76 +++++++++++++++++++++++++++----=
----
 arch/arm/include/asm/hardware/gic.h |   17 +------
 arch/arm/mach-exynos4/cpu.c         |   14 ------
 arch/arm/mach-exynos4/platsmp.c     |   28 ++-----------
 4 files changed, 66 insertions(+), 69 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index b574931..c7521dd 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -37,6 +37,20 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/gic.h>
=20
+struct gic_chip_data {
+=09unsigned int irq_offset;
+=09void __percpu __iomem **dist_base;
+=09void __percpu __iomem **cpu_base;
+#ifdef CONFIG_CPU_PM
+=09u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
+=09u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
+=09u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
+=09u32 __percpu *saved_ppi_enable;
+=09u32 __percpu *saved_ppi_conf;
+#endif
+=09unsigned int gic_irqs;
+};
+
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
=20
 /* Address of GIC 0 CPU interface */
@@ -61,16 +75,26 @@ struct irq_chip gic_arch_extn =3D {
=20
 static struct gic_chip_data gic_data[MAX_GIC_NR] __read_mostly;
=20
+static inline void __iomem *gic_data_dist_base(struct gic_chip_data *data)
+{
+=09return *__this_cpu_ptr(data->dist_base);
+}
+
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 =09struct gic_chip_data *gic_data =3D irq_data_get_irq_chip_data(d);
-=09return gic_data->dist_base;
+=09return gic_data_dist_base(gic_data);
+}
+
+static inline void __iomem *gic_data_cpu_base(struct gic_chip_data *data)
+{
+=09return *__this_cpu_ptr(data->cpu_base);
 }
=20
 static inline void __iomem *gic_cpu_base(struct irq_data *d)
 {
 =09struct gic_chip_data *gic_data =3D irq_data_get_irq_chip_data(d);
-=09return gic_data->cpu_base;
+=09return gic_data_cpu_base(gic_data);
 }
=20
 static inline unsigned int gic_irq(struct irq_data *d)
@@ -243,7 +267,7 @@ static void gic_handle_cascade_irq(unsigned int irq, st=
ruct irq_desc *desc)
 =09chained_irq_enter(chip, desc);
=20
 =09raw_spin_lock(&irq_controller_lock);
-=09status =3D readl_relaxed(chip_data->cpu_base + GIC_CPU_INTACK);
+=09status =3D readl_relaxed(gic_data_cpu_base(chip_data) + GIC_CPU_INTACK)=
;
 =09raw_spin_unlock(&irq_controller_lock);
=20
 =09gic_irq =3D (status & 0x3ff);
@@ -287,7 +311,7 @@ static void __init gic_dist_init(struct gic_chip_data *=
gic,
 {
 =09unsigned int gic_irqs, irq_limit, i;
 =09u32 cpumask;
-=09void __iomem *base =3D gic->dist_base;
+=09void __iomem *base =3D gic_data_dist_base(gic);
 =09u32 cpu =3D 0;
 =09u32 nrppis =3D 0, ppi_base =3D 0;
=20
@@ -380,8 +404,8 @@ static void __init gic_dist_init(struct gic_chip_data *=
gic,
=20
 static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
 {
-=09void __iomem *dist_base =3D gic->dist_base;
-=09void __iomem *base =3D gic->cpu_base;
+=09void __iomem *dist_base =3D gic_data_dist_base(gic);
+=09void __iomem *base =3D gic_data_cpu_base(gic);
 =09int i;
=20
 =09/*
@@ -418,7 +442,7 @@ static void gic_dist_save(unsigned int gic_nr)
 =09=09BUG();
=20
 =09gic_irqs =3D gic_data[gic_nr].gic_irqs;
-=09dist_base =3D gic_data[gic_nr].dist_base;
+=09dist_base =3D gic_data_dist_base(&gic_data[gic_nr]);
=20
 =09if (!dist_base)
 =09=09return;
@@ -453,7 +477,7 @@ static void gic_dist_restore(unsigned int gic_nr)
 =09=09BUG();
=20
 =09gic_irqs =3D gic_data[gic_nr].gic_irqs;
-=09dist_base =3D gic_data[gic_nr].dist_base;
+=09dist_base =3D gic_data_dist_base(&gic_data[gic_nr]);
=20
 =09if (!dist_base)
 =09=09return;
@@ -489,8 +513,8 @@ static void gic_cpu_save(unsigned int gic_nr)
 =09if (gic_nr >=3D MAX_GIC_NR)
 =09=09BUG();
=20
-=09dist_base =3D gic_data[gic_nr].dist_base;
-=09cpu_base =3D gic_data[gic_nr].cpu_base;
+=09dist_base =3D gic_data_dist_base(&gic_data[gic_nr]);
+=09cpu_base =3D gic_data_cpu_base(&gic_data[gic_nr]);
=20
 =09if (!dist_base || !cpu_base)
 =09=09return;
@@ -515,8 +539,8 @@ static void gic_cpu_restore(unsigned int gic_nr)
 =09if (gic_nr >=3D MAX_GIC_NR)
 =09=09BUG();
=20
-=09dist_base =3D gic_data[gic_nr].dist_base;
-=09cpu_base =3D gic_data[gic_nr].cpu_base;
+=09dist_base =3D gic_data_dist_base(&gic_data[gic_nr]);
+=09cpu_base =3D gic_data_cpu_base(&gic_data[gic_nr]);
=20
 =09if (!dist_base || !cpu_base)
 =09=09return;
@@ -588,12 +612,24 @@ void __init gic_init(unsigned int gic_nr, unsigned in=
t irq_start,
 =09void __iomem *dist_base, void __iomem *cpu_base)
 {
 =09struct gic_chip_data *gic;
+=09int cpu;
=20
 =09BUG_ON(gic_nr >=3D MAX_GIC_NR);
=20
 =09gic =3D &gic_data[gic_nr];
-=09gic->dist_base =3D dist_base;
-=09gic->cpu_base =3D cpu_base;
+=09gic->dist_base =3D alloc_percpu(void __iomem *);
+=09gic->cpu_base =3D alloc_percpu(void __iomem *);
+=09if (WARN_ON(!gic->dist_base || !gic->cpu_base)) {
+=09=09free_percpu(gic->dist_base);
+=09=09free_percpu(gic->cpu_base);
+=09=09return;
+=09}
+
+=09for_each_possible_cpu(cpu) {
+=09=09*per_cpu_ptr(gic->dist_base, cpu) =3D dist_base;
+=09=09*per_cpu_ptr(gic->cpu_base, cpu) =3D cpu_base;
+=09}
+
 =09gic->irq_offset =3D (irq_start - 1) & ~31;
=20
 =09if (gic_nr =3D=3D 0)
@@ -605,11 +641,17 @@ void __init gic_init(unsigned int gic_nr, unsigned in=
t irq_start,
 =09gic_pm_init(gic);
 }
=20
-void __cpuinit gic_secondary_init(unsigned int gic_nr)
+void __cpuinit gic_secondary_init_base(unsigned int gic_nr,
+=09=09=09=09       void __iomem *dist_base,
+=09=09=09=09       void __iomem *cpu_base)
 {
 =09BUG_ON(gic_nr >=3D MAX_GIC_NR);
=20
-=09gic_cpu_init(&gic_data[gic_nr]);
+=09if (dist_base)
+=09=09*__this_cpu_ptr(gic_data[gic_nr].dist_base) =3D dist_base;
+=09if (cpu_base)
+=09=09*__this_cpu_ptr(gic_data[gic_nr].cpu_base) =3D cpu_base;
+=09gic_cpu_init(&gic_data[gic_nr]);=09
 }
=20
 #ifdef CONFIG_SMP
@@ -629,6 +671,6 @@ void gic_raise_softirq(const struct cpumask *mask, unsi=
gned int irq)
 =09dsb();
=20
 =09/* this always happens on GIC0 */
-=09writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTIN=
T);
+=09writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_=
DIST_SOFTINT);
 }
 #endif
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/har=
dware/gic.h
index 2b7ec2b..d45d78b 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -36,24 +36,13 @@
 extern struct irq_chip gic_arch_extn;
=20
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
-void gic_secondary_init(unsigned int);
+void gic_secondary_init_base(unsigned int, void __iomem *, void __iomem *)=
;
 void gic_handle_irq(struct pt_regs *regs);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
=20
-struct gic_chip_data {
-=09unsigned int irq_offset;
-=09void __iomem *dist_base;
-=09void __iomem *cpu_base;
-#ifdef CONFIG_CPU_PM
-=09u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
-=09u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
-=09u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
-=09u32 __percpu *saved_ppi_enable;
-=09u32 __percpu *saved_ppi_conf;
-#endif
-=09unsigned int gic_irqs;
-};
+#define gic_secondary_init(n)=09gic_secondary_init_base((n), NULL, NULL)
+
 #endif
=20
 #endif
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index c682887..09e2760 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -204,17 +204,6 @@ void __init exynos4_init_clocks(int xtal)
 =09exynos4_setup_clocks();
 }
=20
-static void exynos4_gic_irq_fix_base(struct irq_data *d)
-{
-=09struct gic_chip_data *gic_data =3D irq_data_get_irq_chip_data(d);
-
-=09gic_data->cpu_base =3D S5P_VA_GIC_CPU +
-=09=09=09    (gic_bank_offset * smp_processor_id());
-
-=09gic_data->dist_base =3D S5P_VA_GIC_DIST +
-=09=09=09    (gic_bank_offset * smp_processor_id());
-}
-
 void __init exynos4_init_irq(void)
 {
 =09int irq;
@@ -222,9 +211,6 @@ void __init exynos4_init_irq(void)
 =09gic_bank_offset =3D soc_is_exynos4412() ? 0x4000 : 0x8000;
=20
 =09gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
-=09gic_arch_extn.irq_eoi =3D exynos4_gic_irq_fix_base;
-=09gic_arch_extn.irq_unmask =3D exynos4_gic_irq_fix_base;
-=09gic_arch_extn.irq_mask =3D exynos4_gic_irq_fix_base;
=20
 =09for (irq =3D 0; irq < MAX_COMBINER_NR; irq++) {
=20
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsm=
p.c
index 56377d2..76cb2ba 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -67,39 +67,19 @@ static void __iomem *scu_base_addr(void)
=20
 static DEFINE_SPINLOCK(boot_lock);
=20
-static void __cpuinit exynos4_gic_secondary_init(void)
+static void __cpuinit exynos4_secondary_init(unsigned int cpu)
 {
 =09void __iomem *dist_base =3D S5P_VA_GIC_DIST +
-=09=09=09=09(gic_bank_offset * smp_processor_id());
+=09=09=09=09(gic_bank_offset * cpu_logical_map(cpu));
 =09void __iomem *cpu_base =3D S5P_VA_GIC_CPU +
-=09=09=09=09(gic_bank_offset * smp_processor_id());
-=09int i;
-
-=09/*
-=09 * Deal with the banked PPI and SGI interrupts - disable all
-=09 * PPI interrupts, ensure all SGI interrupts are enabled.
-=09 */
-=09__raw_writel(0xffff0000, dist_base + GIC_DIST_ENABLE_CLEAR);
-=09__raw_writel(0x0000ffff, dist_base + GIC_DIST_ENABLE_SET);
+=09=09=09=09(gic_bank_offset * cpu_logical_map(cpu));
=20
 =09/*
-=09 * Set priority on PPI and SGI interrupts
-=09 */
-=09for (i =3D 0; i < 32; i +=3D 4)
-=09=09__raw_writel(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
-
-=09__raw_writel(0xf0, cpu_base + GIC_CPU_PRIMASK);
-=09__raw_writel(1, cpu_base + GIC_CPU_CTRL);
-}
-
-static void __cpuinit exynos4_secondary_init(unsigned int cpu)
-{
-=09/*
 =09 * if any interrupts are already enabled for the primary
 =09 * core (e.g. timer irq), then they will not have been enabled
 =09 * for us: do so
 =09 */
-=09exynos4_gic_secondary_init();
+=09gic_secondary_init_base(0, dist_base, cpu_base);
=20
 =09/*
 =09 * let the primary processor know we're out of the
--=20
1.7.0.4

--------------080509090809010207090900--
