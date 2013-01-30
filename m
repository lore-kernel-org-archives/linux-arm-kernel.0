From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Jan 2013 20:30:14 +0000
Subject: Commit 384a290283fde63ba8dc671fca5420111cdac19a seems to break
 11MPCore boot
In-Reply-To: <alpine.LFD.2.02.1301301223290.6300@xanadu.home>
References: <51093B0B.7010708@arm.com>
 <alpine.LFD.2.02.1301301050230.6300@xanadu.home>
 <20130130162132.GM23505@n2100.arm.linux.org.uk>
 <20130130164535.GN23505@n2100.arm.linux.org.uk>
 <20130130171918.GO23505@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301301223290.6300@xanadu.home>
Message-ID: <20130130203014.GU23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 12:30:06PM -0500, Nicolas Pitre wrote:
> On Wed, 30 Jan 2013, Russell King - ARM Linux wrote:
> 
> > On Wed, Jan 30, 2013 at 04:45:35PM +0000, Russell King - ARM Linux wrote:
> > > What we could do is scan interrupts 0-31 for a non-zero value.  If they're
> > > all zero, we should complain.  Otherwise, we use the first non-zero value
> > > we find and validate it for a single bit set.
> > 
> > And here's a patch to do this - I've not run this but it's just built
> > successfully here.  Anyone want to give it a go?
> > 
> > I've decided that if we do hit the mask==0 case, we should just wail
> > loudly - panic'ing will bring the kernel to a halt right there and then,
> > which may be before any console drivers have been initialized (and the
> > kernel message buffer is no longer easy to read).  Moreover, panic()ing,
> > along with the possibility of rebooting won't really fix this kind of
> > error - it's rather fatal as far as that goes.  So, I think just wailing
> > at CRIT level is fine for this condition that should not occur.
> > 
> >  arch/arm/common/gic.c |   23 +++++++++++++++++++++--
> >  1 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> > index 36ae03a..3bcef49 100644
> > --- a/arch/arm/common/gic.c
> > +++ b/arch/arm/common/gic.c
> > @@ -351,6 +351,23 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
> >  	irq_set_chained_handler(irq, gic_handle_cascade_irq);
> >  }
> >  
> > +static u8 gic_get_cpumask(struct gic_chip_data *gic)
> > +{
> > +	void __iomem *base = gic_data_dist_base(gic);
> > +	u8 mask, i;
> > +
> > +	for (i = mask = 0; i < 32; i++) {
> > +		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> > +		if (mask)
> > +			break;
> > +	}
> 
> That should probably be:
> 
> 	u32 mask;
> 
> 	for (i = 0; i < 32; i += 4) {
> 		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> 		mask |= (mask >> 16);
> 		mask |= (mask >> 8);
> 		if (mask)
> 			return mask;
> 	}
> 
> I know that the spec says that the GIC should accept byte sized 
> accesses, but that too is known not to work on all implementations.

Right... this is what my current set of patches to make things work
again looks like... and still there's more problems to go...

 arch/arm/common/gic.c                         |   25 +++++++++++++++++++++++--
 arch/arm/mach-realview/include/mach/irqs-eb.h |    2 +-
 arch/arm/mm/dma-mapping.c                     |    2 +-
 drivers/dma/amba-pl08x.c                      |    2 ++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 36ae03a..87dfa90 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -351,6 +351,25 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 	irq_set_chained_handler(irq, gic_handle_cascade_irq);
 }
 
+static u8 gic_get_cpumask(struct gic_chip_data *gic)
+{
+	void __iomem *base = gic_data_dist_base(gic);
+	u32 mask, i;
+
+	for (i = mask = 0; i < 32; i += 4) {
+		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
+		mask |= mask >> 16;
+		mask |= mask >> 8;
+		if (mask)
+			break;
+	}
+
+	if (!mask)
+		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
+
+	return mask;
+}
+
 static void __init gic_dist_init(struct gic_chip_data *gic)
 {
 	unsigned int i;
@@ -369,7 +388,9 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 	/*
 	 * Set all global interrupts to this CPU only.
 	 */
-	cpumask = readl_relaxed(base + GIC_DIST_TARGET + 0);
+	cpumask = gic_get_cpumask(gic);
+	cpumask |= cpumask << 8;
+	cpumask |= cpumask << 16;
 	for (i = 32; i < gic_irqs; i += 4)
 		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
 
@@ -400,7 +421,7 @@ static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
 	 * Get what the GIC says our CPU mask is.
 	 */
 	BUG_ON(cpu >= NR_GIC_CPU_IF);
-	cpu_mask = readl_relaxed(dist_base + GIC_DIST_TARGET + 0);
+	cpu_mask = gic_get_cpumask(gic);
 	gic_cpu_map[cpu] = cpu_mask;
 
 	/*
diff --git a/arch/arm/mach-realview/include/mach/irqs-eb.h b/arch/arm/mach-realview/include/mach/irqs-eb.h
index d6b5073..4475423 100644
--- a/arch/arm/mach-realview/include/mach/irqs-eb.h
+++ b/arch/arm/mach-realview/include/mach/irqs-eb.h
@@ -115,7 +115,7 @@
 /*
  * Only define NR_IRQS if less than NR_IRQS_EB
  */
-#define NR_IRQS_EB		(IRQ_EB_GIC_START + 96)
+#define NR_IRQS_EB		(IRQ_EB_GIC_START + 128)
 
 #if defined(CONFIG_MACH_REALVIEW_EB) \
 	&& (!defined(NR_IRQS) || (NR_IRQS < NR_IRQS_EB))
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 076c26d..dda3904 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -640,7 +640,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	if (is_coherent || nommu())
 		addr = __alloc_simple_buffer(dev, size, gfp, &page);
-	else if (gfp & GFP_ATOMIC)
+	else if (!(gfp & __GFP_WAIT))
 		addr = __alloc_from_pool(size, &page);
 	else if (!IS_ENABLED(CONFIG_CMA))
 		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller);
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 7d1f24f..7b1f3b2 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1690,7 +1690,9 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 static void pl08x_timer(unsigned long data)
 {
 	struct pl08x_driver_data *pl08x = (struct pl08x_driver_data *)data;
+	local_irq_disable();
 	pl08x_irq(pl08x->adev->irq[0], pl08x);
+	local_irq_enable();
 	mod_timer(&pl08x->timer, jiffies + 2);
 }
 
