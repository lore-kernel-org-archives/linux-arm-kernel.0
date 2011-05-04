From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 04 May 2011 16:32:42 +0530
Subject: [PATCH V3] ARM: GIC: Convert GIC library to use the IO relaxed
	operations
In-Reply-To: <4DBFD59D.50008@ti.com>
References: <1304058131-8375-1-git-send-email-santosh.shilimkar@ti.com>
	<1304417481.19196.60.camel@e102109-lin.cambridge.arm.com>
	<4DBFD59D.50008@ti.com>
Message-ID: <4DC13252.2080308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/3/2011 3:44 PM, Santosh Shilimkar wrote:
> On 5/3/2011 3:41 PM, Catalin Marinas wrote:

[...]

>>
>> Otherwise the patch looks fine (I'll add my ack after you fix the above).
>>
> Thanks. Will add above comment, drop the readl and repost with your ack.
>
> Same will push it the patch system
>
Below is the updated version. I didn't push this to patch system because
it is generated on top of Will's GIC series.

Will,
Can you queue this patch part of your series please?

Regards
Santosh

 From 1506abc77b36eb10ae0e3f8711e6ad1b87ca363d Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 28 Mar 2011 19:27:46 +0530
Subject: [PATCH] ARM: GIC: Convert GIC library to use the IO relaxed 
operations

The GIC register accesses today make use of readl()/writel()
which prove to be very expensive when used along with mandatory
barriers. This mandatory barriers also introduces an un-necessary
and expensive l2x0_sync() operation. On Cortex-A9 MP cores, GIC
IO accesses from CPU are direct and doesn't go through L2X0 write
buffer.

A DSB before writel_relaxed() in gic_raise_softirq() is added to be
compliant with the Barrier Litmus document - the mailbox scenario.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
  arch/arm/common/gic.c |   54 
+++++++++++++++++++++++++++---------------------
  1 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index e9c2ff8..4ddd0a6 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -89,7 +89,7 @@ static void gic_mask_irq(struct irq_data *d)
  	u32 mask = 1 << (d->irq % 32);

  	spin_lock(&irq_controller_lock);
-	writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 
32) * 4);
+	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + 
(gic_irq(d) / 32) * 4);
  	if (gic_arch_extn.irq_mask)
  		gic_arch_extn.irq_mask(d);
  	spin_unlock(&irq_controller_lock);
@@ -102,7 +102,7 @@ static void gic_unmask_irq(struct irq_data *d)
  	spin_lock(&irq_controller_lock);
  	if (gic_arch_extn.irq_unmask)
  		gic_arch_extn.irq_unmask(d);
-	writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 
32) * 4);
+	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + 
(gic_irq(d) / 32) * 4);
  	spin_unlock(&irq_controller_lock);
  }

@@ -114,7 +114,7 @@ static void gic_eoi_irq(struct irq_data *d)
  		spin_unlock(&irq_controller_lock);
  	}

-	writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
+	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
  }

  static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -140,7 +140,7 @@ static int gic_set_type(struct irq_data *d, unsigned 
int type)
  	if (gic_arch_extn.irq_set_type)
  		gic_arch_extn.irq_set_type(d, type);

-	val = readl(base + GIC_DIST_CONFIG + confoff);
+	val = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
  	if (type == IRQ_TYPE_LEVEL_HIGH)
  		val &= ~confmask;
  	else if (type == IRQ_TYPE_EDGE_RISING)
@@ -150,15 +150,15 @@ static int gic_set_type(struct irq_data *d, 
unsigned int type)
  	 * As recommended by the spec, disable the interrupt before changing
  	 * the configuration
  	 */
-	if (readl(base + GIC_DIST_ENABLE_SET + enableoff) & enablemask) {
-		writel(enablemask, base + GIC_DIST_ENABLE_CLEAR + enableoff);
+	if (readl_relaxed(base + GIC_DIST_ENABLE_SET + enableoff) & enablemask) {
+		writel_relaxed(enablemask, base + GIC_DIST_ENABLE_CLEAR + enableoff);
  		enabled = true;
  	}

-	writel(val, base + GIC_DIST_CONFIG + confoff);
+	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);

  	if (enabled)
-		writel(enablemask, base + GIC_DIST_ENABLE_SET + enableoff);
+		writel_relaxed(enablemask, base + GIC_DIST_ENABLE_SET + enableoff);

  	spin_unlock(&irq_controller_lock);

@@ -190,8 +190,8 @@ static int gic_set_affinity(struct irq_data *d, 
const struct cpumask *mask_val,

  	spin_lock(&irq_controller_lock);
  	d->node = cpu;
-	val = readl(reg) & ~mask;
-	writel(val | bit, reg);
+	val = readl_relaxed(reg) & ~mask;
+	writel_relaxed(val | bit, reg);
  	spin_unlock(&irq_controller_lock);

  	return 0;
@@ -223,7 +223,7 @@ static void gic_handle_cascade_irq(unsigned int irq, 
struct irq_desc *desc)
  	chained_irq_enter(chip, desc);

  	spin_lock(&irq_controller_lock);
-	status = readl(chip_data->cpu_base + GIC_CPU_INTACK);
+	status = readl_relaxed(chip_data->cpu_base + GIC_CPU_INTACK);
  	spin_unlock(&irq_controller_lock);

  	gic_irq = (status & 0x3ff);
@@ -272,13 +272,13 @@ static void __init gic_dist_init(struct 
gic_chip_data *gic,
  	cpumask |= cpumask << 8;
  	cpumask |= cpumask << 16;

-	writel(0, base + GIC_DIST_CTRL);
+	writel_relaxed(0, base + GIC_DIST_CTRL);

  	/*
  	 * Find out how many interrupts are supported.
  	 * The GIC only supports up to 1020 interrupt sources.
  	 */
-	gic_irqs = readl(base + GIC_DIST_CTR) & 0x1f;
+	gic_irqs = readl_relaxed(base + GIC_DIST_CTR) & 0x1f;
  	gic_irqs = (gic_irqs + 1) * 32;
  	if (gic_irqs > 1020)
  		gic_irqs = 1020;
@@ -287,26 +287,26 @@ static void __init gic_dist_init(struct 
gic_chip_data *gic,
  	 * Set all global interrupts to be level triggered, active low.
  	 */
  	for (i = 32; i < gic_irqs; i += 16)
-		writel(0, base + GIC_DIST_CONFIG + i * 4 / 16);
+		writel_relaxed(0, base + GIC_DIST_CONFIG + i * 4 / 16);

  	/*
  	 * Set all global interrupts to this CPU only.
  	 */
  	for (i = 32; i < gic_irqs; i += 4)
-		writel(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
+		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);

  	/*
  	 * Set priority on all global interrupts.
  	 */
  	for (i = 32; i < gic_irqs; i += 4)
-		writel(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);
+		writel_relaxed(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);

  	/*
  	 * Disable all interrupts.  Leave the PPI and SGIs alone
  	 * as these enables are banked registers.
  	 */
  	for (i = 32; i < gic_irqs; i += 32)
-		writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
+		writel_relaxed(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);

  	/*
  	 * Limit number of interrupts registered to the platform maximum
@@ -324,7 +324,7 @@ static void __init gic_dist_init(struct 
gic_chip_data *gic,
  		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
  	}

-	writel(1, base + GIC_DIST_CTRL);
+	writel_relaxed(1, base + GIC_DIST_CTRL);
  }

  static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
@@ -337,17 +337,17 @@ static void __cpuinit gic_cpu_init(struct 
gic_chip_data *gic)
  	 * Deal with the banked PPI and SGI interrupts - disable all
  	 * PPI interrupts, ensure all SGI interrupts are enabled.
  	 */
-	writel(0xffff0000, dist_base + GIC_DIST_ENABLE_CLEAR);
-	writel(0x0000ffff, dist_base + GIC_DIST_ENABLE_SET);
+	writel_relaxed(0xffff0000, dist_base + GIC_DIST_ENABLE_CLEAR);
+	writel_relaxed(0x0000ffff, dist_base + GIC_DIST_ENABLE_SET);

  	/*
  	 * Set priority on PPI and SGI interrupts
  	 */
  	for (i = 0; i < 32; i += 4)
-		writel(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
+		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);

-	writel(0xf0, base + GIC_CPU_PRIMASK);
-	writel(1, base + GIC_CPU_CTRL);
+	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
+	writel_relaxed(1, base + GIC_CPU_CTRL);
  }

  void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
@@ -391,7 +391,13 @@ void gic_raise_softirq(const struct cpumask *mask, 
unsigned int irq)
  {
  	unsigned long map = *cpus_addr(*mask);

+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before issuing the IPI.
+	 */
+	dsb();
+
  	/* this always happens on GIC0 */
-	writel(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
+	writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
  }
  #endif
-- 
1.6.0.4



-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-ARM-GIC-Convert-GIC-library-to-use-the-IO-relaxed.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110504/1a89444d/attachment.ksh>
